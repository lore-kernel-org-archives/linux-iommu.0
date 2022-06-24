Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DC8C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 06:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A152848B6;
	Fri, 24 Jun 2022 06:55:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A152848B6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UaL5ewun
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0Ut5l_0kiBf; Fri, 24 Jun 2022 06:55:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 33B47848B0;
	Fri, 24 Jun 2022 06:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33B47848B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 072DBC0039;
	Fri, 24 Jun 2022 06:55:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F610C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED8BA61302
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:55:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED8BA61302
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UaL5ewun
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hNp81Q_6e1wo for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 06:54:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9403961221
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9403961221
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656053699; x=1687589699;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tUfVqitwWT7IxzeayDpvJgY6hbjhnF7E+9OjmKkDvuQ=;
 b=UaL5ewun1u1YhuohCnQJHt4W51zFgaRHMC2WjwmhhnKhM3Up07xHnsiR
 0uAwn7qD+vu2L5lb+khU1WQQfJ7Lg89+kEoWNP75kmFDjVWWZYrFYw9/q
 NCEz3AeUxeDjeUIsKWT88psC9/MQRIzcwCHTdziK8gpVuI3ffKfBKWXKq
 T98cgOIqsUuzUHSt+DAq4SinxB2bR3TpEqjryG415z/Mq5cVjvh5R+Upw
 E7R7cIZUZKAA3jL6MYJ3lTpTGmHNWeKMg0TNANZCDxML+UoJKKcL0Yf70
 Hl/XA6It/vrwdlrjxF2OKEiw5howYViwg6ZY+VDy473bhElSbXluxitpH g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261364260"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="261364260"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 23:54:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="915563576"
Received: from rwang105-mobl4.ccr.corp.intel.com (HELO [10.249.168.100])
 ([10.249.168.100])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 23:54:55 -0700
Message-ID: <b8a7ab77-935d-459c-7f65-628fcf828fad@linux.intel.com>
Date: Fri, 24 Jun 2022 14:54:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Fix RID2PASID setup/teardown failure
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
References: <20220623065720.727849-1-baolu.lu@linux.intel.com>
 <eb2257b1-1213-1001-74bd-085af5d50dad@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <eb2257b1-1213-1001-74bd-085af5d50dad@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org,
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

T24gMjAyMi82LzI0IDE0OjAyLCBFdGhhbiBaaGFvIHdyb3RlOgo+IOWcqCAyMDIyLzYvMjMgMTQ6
NTcsIEx1IEJhb2x1IOWGmemBkzoKPj4gVGhlIElPTU1VIGRyaXZlciBzaGFyZXMgdGhlIHBhc2lk
IHRhYmxlIGZvciBQQ0kgYWxpYXMgZGV2aWNlcy4gV2hlbiB0aGUKPj4gUklEMlBBU0lEIGVudHJ5
IG9mIHRoZSBzaGFyZWQgcGFzaWQgdGFibGUgaGFzIGJlZW4gZmlsbGVkIGJ5IHRoZSBmaXJzdAo+
PiBkZXZpY2UsIHRoZSBzdWJzZXF1ZW50IGRldmljZSB3aWxsIGVuY291bnRlciB0aGUgIkRNQVI6
IFNldHVwIFJJRDJQQVNJRAo+PiBmYWlsZWQiIGZhaWx1cmUgYXMgdGhlIHBhc2lkIGVudHJ5IGhh
cyBhbHJlYWR5IGJlZW4gbWFya2VkIGFzIHByZXNlbnQuCj4+IEFzIHRoZSByZXN1bHQsIHRoZSBJ
T01NVSBwcm9iaW5nIHByb2Nlc3Mgd2lsbCBiZSBhYm9ydGVkLgo+Pgo+PiBPbiB0aGUgY29udHJh
cnksIHdoZW4gYW55IGFsaWFzIGRldmljZSBpcyBob3QtcmVtb3ZlZCBmcm9tIHRoZSBzeXN0ZW0s
Cj4+IGZvciBleGFtcGxlLCBieSB3cml0aW5nIHRvIC9zeXMvYnVzL3BjaS9kZXZpY2VzLy4uLi9y
ZW1vdmUsIHRoZSBzaGFyZWQKPj4gUklEMlBBU0lEIHdpbGwgYmUgY2xlYXJlZCB3aXRob3V0IGFu
eSBub3RpZmljYXRpb25zIHRvIG90aGVyIGRldmljZXMuCj4+IEFzIHRoZSByZXN1bHQsIGFueSBE
TUFzIGZyb20gdGhvc2UgcmVzdCBkZXZpY2VzIGFyZSBibG9ja2VkLgo+Pgo+PiBTaGFyaW5nIHBh
c2lkIHRhYmxlIGFtb25nIFBDSSBhbGlhcyBkZXZpY2VzIGNvdWxkIHNhdmUgdHdvIG1lbW9yeSBw
YWdlcwo+PiBmb3IgZGV2aWNlcyB1bmRlcm5lYXRoIHRoZSBQQ0llLXRvLVBDSSBicmlkZ2VzLiBB
bnl3YXksIGNvbnNpZGVyaW5nIHRoYXQKPj4gdGhvc2UgZGV2aWNlcyBhcmUgcmFyZSBvbiBtb2Rl
cm4gcGxhdGZvcm1zIHRoYXQgc3VwcG9ydCBWVC1kIGluIHNjYWxhYmxlCj4+IG1vZGUgYW5kIHRo
ZSBzYXZlZCBtZW1vcnkgaXMgbmVnbGlnaWJsZSwgaXQncyByZWFzb25hYmxlIHRvIHJlbW92ZSB0
aGlzCj4+IHBhcnQgb2YgaW1tYXR1cmUgY29kZSB0byBtYWtlIHRoZSBkcml2ZXIgZmVhc2libGUg
YW5kIHN0YWJsZS4KPiBJbiBteSB1bmRlcnN0YW5kaW5nLCB0aHVzIGNsZWFubmluZyB3aWxsIG1h
a2UgdGhlIHBhc2lkIHRhYmxlIGJlY29tZQo+IHBlci1kZXYgZGF0YXN0cnVjdHVyZSB3aGF0ZXZl
ciB0aGUgZGV2IGlzIHBjaS1hbGlhcyBvciBub3QsIGFuZCB0aGUKPiBwYXNpZF9wdGVfaXNfcHJl
c2VudChwdGUpd2lsbCBvbmx5IGNoZWNrIGFnYWluc3QgZXZlcnkgcGNpLWFsaWFzJyBvd24KPiBw
cml2YXRlIHBhc2lkIHRhYmxlLHRoZSBzZXR1cCBzdGFnZXdvdWxkbid0IGJyZWFrLCBzbyBkb2Vz
IHRoZQo+IGRldGFjaC9yZWxlYXNlIHBhdGgsIGFuZCBsaXR0bGUgdmFsdWUgdG8gY29kZSBvdGhl
cnJlZmVyZW5jZSBjb3VudGVyCj4gbGlrZSBjb21wbGV4IGltcGxlbm1hdGFpb24sIGxvb2tzIGdv
b2QgdG8gbWUgIQoKVGhhbmtzISBDYW4gSSBhZGQgYSBSZXZpZXdkLWJ5IGZyb20geW91PwoKQmVz
dCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
