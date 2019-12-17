Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D81AC43603
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 02:04:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D3B206CB
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 02:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D3B206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B864022720;
	Tue, 17 Dec 2019 02:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDzrKiCHGnA2; Tue, 17 Dec 2019 02:04:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 26E2520463;
	Tue, 17 Dec 2019 02:04:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 085BCC1AE8;
	Tue, 17 Dec 2019 02:04:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4B84C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 02:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A8875869EC
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 02:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EqeXU3uSkkB1 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 02:04:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D2CCB869E2
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 02:04:35 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 18:04:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; d="scan'208";a="227326453"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 16 Dec 2019 18:04:32 -0800
Subject: Re: [PATCH v3 4/6] iommu/vt-d: Setup pasid entries for iova over
 first level
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191211021219.8997-1-baolu.lu@linux.intel.com>
 <20191211021219.8997-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A1309A9@SHSMSX104.ccr.corp.intel.com>
 <acb93807-7a78-b81a-3b27-fde9ee4d7edb@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A132C9A@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b883602c-ecdf-11ea-c26c-4b221bf7634d@linux.intel.com>
Date: Tue, 17 Dec 2019 10:03:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A132C9A@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>
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

SGkgWWksCgpPbiAxMi8xNS8xOSA1OjM3IFBNLCBMaXUsIFlpIEwgd3JvdGU6Cj4+IFhEIChiaXQg
NjMpIGlzIG9ubHkgZm9yIHRoZSBmaXJzdCBsZXZlbCwgYW5kIFNOUCAoYml0IDExKSBpcyBvbmx5
IGZvciBzZWNvbmQgbGV2ZWwsIHJpZ2h0PyBJCj4+IHRoaW5rIHdlIG5lZWQgdG8gYWx3YXlzIHNl
dCBYRCBiaXQgZm9yIElPVkEgb3ZlciBGTCBjYXNlLiB0aG91Z2h0cz8KPiBPb3BzLCBJIG1hZGUg
YSBtaXN0YWtlIGhlcmUuIFBsZWFzZSBmb3JnZXQgU05QIGJpdCwgdGhlcmUgaXMgbm8gd2F5IHRv
IGNvbnRyb2wgU05QCj4gd2l0aCBmaXJzdCBsZXZlbCBwYWdlIHRhYmxlLjotKQo+IAo+IEFjdHVh
bGx5LCBpdCBpcyBleGVjdXRlIChiaXQgMSkgb2Ygc2Vjb25kIGxldmVsIHBhZ2UgdGFibGUgd2hp
Y2ggSSB3YW50ZWQgdG8gc2F5Lgo+IElmIHNvZnR3YXJlIHNldHMgUi9XL1ggcGVybWlzc2lvbiB0
byBhbiBJT1ZBLCB3aXRoIElPVkEgb3ZlciBzZWNvbmQgbGV2ZWwKPiBwYWdlIHRhYmxlLCBpdCB3
aWxsIHNldCBiaXQgMS4gSG93ZXZlciwgaWYgSU9WQSBpcyBvdmVyIGZpcnN0IGxldmVsIHBhZ2Ug
dGFibGUsIGl0Cj4gbWF5IG5lZWQgdG8gY2xlYXIgWEQgYml0LiBUaGlzIGlzIHdoYXQgSSB3YW50
IHRvIHNheSBoZXJlLiBJZiBJT1ZBIGRvZXNu4oCZdCBhbGxvdwo+IGV4ZWN1dGUgcGVybWlzc2lv
biwgaXQncyBvayB0byBhbHdheXMgc2V0IFhEIGJpdCBmb3IgSU9WQSBvdmVyIEZMIGNhc2UuIEJ1
dCBJCj4gd291bGQgbGlrZSB0byBkbyBpdCBqdXN0IGFzIHdoYXQgd2UgZGlkIGZvciBSL1cgcGVy
bWlzc2lvbi4gUi9XIHBlcm1pc3Npb24KPiByZWxpZXMgb24gdGhlIHBlcm1pc3Npb24gY29uZmln
dXJlZCBieSB0aGUgcGFnZSBtYXAgY2FsbGVyLiByaWdodD8KCkdvdCB5b3VyIHBvaW50LgoKQ3Vy
cmVudCBkcml2ZXIgYWx3YXlzIGNsZWFyZCBYIChiaXQgMikgaW4gdGhlIHNlY29uZCBsZXZlbCBw
YWdlIHRhYmxlLgpTbyB3ZSB3aWxsIGFsd2F5cyBzZXQgWEQgYml0IChiaXQgNjMpIGluIHRoZSBm
aXJzdCBsZXZlbCBwYWdlIHRhYmxlLgpJZiB3ZSBkZWNpZGUgdG8gdXNlIHRoZSBYIHBlcm1pc3Np
b24sIHdlIG5lZWQgYSBzZXBhcmF0ZWQgcGF0Y2gsIHJpZ2h0PwoKQmVzdCByZWdhcmRzLApiYW9s
dQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
