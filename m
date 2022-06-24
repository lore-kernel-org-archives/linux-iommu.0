Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4976C43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 07:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D0EF61442;
	Fri, 24 Jun 2022 07:56:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D0EF61442
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OyBmGLD/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5fgq9WZIC_TJ; Fri, 24 Jun 2022 07:56:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EF6C961342;
	Fri, 24 Jun 2022 07:56:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF6C961342
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0DE5C0032;
	Fri, 24 Jun 2022 07:56:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83A9FC002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 07:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56F6C418FC
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 07:56:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56F6C418FC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OyBmGLD/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y_mhUmlvye7e for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 07:56:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A5A541862
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A5A541862
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 07:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656057394; x=1687593394;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vztMzndG2ocVKYEbsSlsSSVXFya6CxLdUL/XzbaI5lY=;
 b=OyBmGLD/jKczzepsatLYiask6kWn2mPduOm8mHsaLLnrogHYswG8wHcH
 G/EsomU9hFiOLZnxILXCQUVRNNh61aK9EN+9ZCLXqKRmt5Kn3cRoxzlSU
 n0yNP8P3RZBZqnZgCBs5id4XeBrTtdXvTP3TSescOKsIUpCUNPeu00Vtm
 4bsRqmJcc8Az46Y+IX4L0RIUJDR3p++dqhD/FT+P4BCD8tr+/VLnNojcY
 jf5iFPdis+3N05CDxCudXgf9UG0GwfdMiMN6C9giwQas1PLqoGY/6Yvst
 FTcRZgadCzFSN1nzw+QMZAj7gqAEnxSLsBq9y5dQwZIMktJEi4zXDL8B4 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="278497061"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="278497061"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2022 00:56:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="593114566"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.209.161])
 ([10.254.209.161])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2022 00:56:22 -0700
Message-ID: <6ef6c341-924c-57a6-154e-b804d8b0f2c7@linux.intel.com>
Date: Fri, 24 Jun 2022 15:56:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Fix RID2PASID setup/teardown failure
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220623065720.727849-1-baolu.lu@linux.intel.com>
 <eb2257b1-1213-1001-74bd-085af5d50dad@linux.intel.com>
 <b8a7ab77-935d-459c-7f65-628fcf828fad@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <b8a7ab77-935d-459c-7f65-628fcf828fad@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzYvMjQgMTQ6NTQsIEJhb2x1IEx1IOWGmemBkzoKPiBPbiAyMDIyLzYvMjQgMTQ6
MDIsIEV0aGFuIFpoYW8gd3JvdGU6Cj4+IOWcqCAyMDIyLzYvMjMgMTQ6NTcsIEx1IEJhb2x1IOWG
memBkzoKPj4+IFRoZSBJT01NVSBkcml2ZXIgc2hhcmVzIHRoZSBwYXNpZCB0YWJsZSBmb3IgUENJ
IGFsaWFzIGRldmljZXMuIFdoZW4gdGhlCj4+PiBSSUQyUEFTSUQgZW50cnkgb2YgdGhlIHNoYXJl
ZCBwYXNpZCB0YWJsZSBoYXMgYmVlbiBmaWxsZWQgYnkgdGhlIGZpcnN0Cj4+PiBkZXZpY2UsIHRo
ZSBzdWJzZXF1ZW50IGRldmljZSB3aWxsIGVuY291bnRlciB0aGUgIkRNQVI6IFNldHVwIFJJRDJQ
QVNJRAo+Pj4gZmFpbGVkIiBmYWlsdXJlIGFzIHRoZSBwYXNpZCBlbnRyeSBoYXMgYWxyZWFkeSBi
ZWVuIG1hcmtlZCBhcyBwcmVzZW50Lgo+Pj4gQXMgdGhlIHJlc3VsdCwgdGhlIElPTU1VIHByb2Jp
bmcgcHJvY2VzcyB3aWxsIGJlIGFib3J0ZWQuCj4+Pgo+Pj4gT24gdGhlIGNvbnRyYXJ5LCB3aGVu
IGFueSBhbGlhcyBkZXZpY2UgaXMgaG90LXJlbW92ZWQgZnJvbSB0aGUgc3lzdGVtLAo+Pj4gZm9y
IGV4YW1wbGUsIGJ5IHdyaXRpbmcgdG8gL3N5cy9idXMvcGNpL2RldmljZXMvLi4uL3JlbW92ZSwg
dGhlIHNoYXJlZAo+Pj4gUklEMlBBU0lEIHdpbGwgYmUgY2xlYXJlZCB3aXRob3V0IGFueSBub3Rp
ZmljYXRpb25zIHRvIG90aGVyIGRldmljZXMuCj4+PiBBcyB0aGUgcmVzdWx0LCBhbnkgRE1BcyBm
cm9tIHRob3NlIHJlc3QgZGV2aWNlcyBhcmUgYmxvY2tlZC4KPj4+Cj4+PiBTaGFyaW5nIHBhc2lk
IHRhYmxlIGFtb25nIFBDSSBhbGlhcyBkZXZpY2VzIGNvdWxkIHNhdmUgdHdvIG1lbW9yeSBwYWdl
cwo+Pj4gZm9yIGRldmljZXMgdW5kZXJuZWF0aCB0aGUgUENJZS10by1QQ0kgYnJpZGdlcy4gQW55
d2F5LCBjb25zaWRlcmluZyAKPj4+IHRoYXQKPj4+IHRob3NlIGRldmljZXMgYXJlIHJhcmUgb24g
bW9kZXJuIHBsYXRmb3JtcyB0aGF0IHN1cHBvcnQgVlQtZCBpbiAKPj4+IHNjYWxhYmxlCj4+PiBt
b2RlIGFuZCB0aGUgc2F2ZWQgbWVtb3J5IGlzIG5lZ2xpZ2libGUsIGl0J3MgcmVhc29uYWJsZSB0
byByZW1vdmUgdGhpcwo+Pj4gcGFydCBvZiBpbW1hdHVyZSBjb2RlIHRvIG1ha2UgdGhlIGRyaXZl
ciBmZWFzaWJsZSBhbmQgc3RhYmxlLgo+PiBJbiBteSB1bmRlcnN0YW5kaW5nLCB0aHVzIGNsZWFu
bmluZyB3aWxsIG1ha2UgdGhlIHBhc2lkIHRhYmxlIGJlY29tZQo+PiBwZXItZGV2IGRhdGFzdHJ1
Y3R1cmUgd2hhdGV2ZXIgdGhlIGRldiBpcyBwY2ktYWxpYXMgb3Igbm90LCBhbmQgdGhlCj4+IHBh
c2lkX3B0ZV9pc19wcmVzZW50KHB0ZSl3aWxsIG9ubHkgY2hlY2sgYWdhaW5zdCBldmVyeSBwY2kt
YWxpYXMnIG93bgo+PiBwcml2YXRlIHBhc2lkIHRhYmxlLHRoZSBzZXR1cCBzdGFnZXdvdWxkbid0
IGJyZWFrLCBzbyBkb2VzIHRoZQo+PiBkZXRhY2gvcmVsZWFzZSBwYXRoLCBhbmQgbGl0dGxlIHZh
bHVlIHRvIGNvZGUgb3RoZXJyZWZlcmVuY2UgY291bnRlcgo+PiBsaWtlIGNvbXBsZXggaW1wbGVu
bWF0YWlvbiwgbG9va3MgZ29vZCB0byBtZSAhCj4KPiBUaGFua3MhIENhbiBJIGFkZCBhIFJldmll
d2QtYnkgZnJvbSB5b3U/ClN1cmUgIQo+Cj4gQmVzdCByZWdhcmRzLAo+IGJhb2x1CgotLSAKImZp
cm0sIGVuZHVyaW5nLCBzdHJvbmcsIGFuZCBsb25nLWxpdmVkIgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
