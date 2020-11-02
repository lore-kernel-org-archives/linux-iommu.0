Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5291C2D0A3
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 11:53:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EE722226
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 11:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EE722226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 806E6203F0;
	Mon,  2 Nov 2020 11:53:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iOFxl6ZBuRKo; Mon,  2 Nov 2020 11:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0223203D9;
	Mon,  2 Nov 2020 11:53:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D518C088B;
	Mon,  2 Nov 2020 11:53:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F21A5C0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 11:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DC6F587130
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 11:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I9bfK0ArcWwD for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 11:53:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A6F9D81B7B
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 11:53:41 +0000 (UTC)
IronPort-SDR: qVgA7zm6TM9rX213ZPkvMPKlJEPgw8ICiU39ILMdzzp0Qw0WHQjJFzMcd2qONwq5BjFvpTUj66
 mBzEQkby+YFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="155858893"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; d="scan'208";a="155858893"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 03:53:40 -0800
IronPort-SDR: JujtdMfOAx3lNDW4tWz544fQ5QF9JJIDoMZ1lf8+fKS5PmuQGjIhFOcxZTdD/KDiDTP3LzV1Wf
 mgNpMhSxp92w==
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; d="scan'208";a="537991316"
Received: from obarniv1-mobl.ger.corp.intel.com (HELO [10.214.212.214])
 ([10.214.212.214])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 03:53:37 -0800
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu api
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
 <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
 <3f5694f3-62f9-cc2b-1c2b-f9e99a4788c1@linux.intel.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <1ce5b94a-38b3-548e-3b1a-a68390b93953@linux.intel.com>
Date: Mon, 2 Nov 2020 11:52:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3f5694f3-62f9-cc2b-1c2b-f9e99a4788c1@linux.intel.com>
Content-Language: en-US
Cc: Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Ck9uIDAyLzExLzIwMjAgMDI6MDAsIEx1IEJhb2x1IHdyb3RlOgo+IEhpIFR2cnRrbywKPiBPbiAx
MC8xMi8yMCA0OjQ0IFBNLCBUdnJ0a28gVXJzdWxpbiB3cm90ZToKPj4KPj4gT24gMjkvMDkvMjAy
MCAwMToxMSwgTHUgQmFvbHUgd3JvdGU6Cj4+PiBIaSBUdnJ0a28sCj4+Pgo+Pj4gT24gOS8yOC8y
MCA1OjQ0IFBNLCBUdnJ0a28gVXJzdWxpbiB3cm90ZToKPj4+Pgo+Pj4+IE9uIDI3LzA5LzIwMjAg
MDc6MzQsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+PiBIaSwKPj4+Pj4KPj4+Pj4gVGhlIHByZXZpb3Vz
IHBvc3Qgb2YgdGhpcyBzZXJpZXMgY291bGQgYmUgZm91bmQgaGVyZS4KPj4+Pj4KPj4+Pj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMDA5MTIwMzIyMDAuMTE0ODktMS1i
YW9sdS5sdUBsaW51eC5pbnRlbC5jb20vIAo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBUaGlzIHZlcnNpb24g
aW50cm9kdWNlIGEgbmV3IHBhdGNoIFs0LzddIHRvIGZpeCBhbiBpc3N1ZSByZXBvcnRlZCAKPj4+
Pj4gaGVyZS4KPj4+Pj4KPj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUv
NTFhMWJhZWMtNDhkMS1jMGFjLTE4MWItMWZiYTkyYWE0MjhkQGxpbnV4LmludGVsLmNvbS8gCj4+
Pj4+Cj4+Pj4+Cj4+Pj4+IFRoZXJlIGFyZW4ndCBhbnkgb3RoZXIgY2hhbmdlcy4KPj4+Pj4KPj4+
Pj4gUGxlYXNlIGhlbHAgdG8gdGVzdCBhbmQgcmV2aWV3Lgo+Pj4+Pgo+Pj4+PiBCZXN0IHJlZ2Fy
ZHMsCj4+Pj4+IGJhb2x1Cj4+Pj4+Cj4+Pj4+IEx1IEJhb2x1ICgzKToKPj4+Pj4gwqDCoCBpb21t
dTogQWRkIHF1aXJrIGZvciBJbnRlbCBncmFwaGljIGRldmljZXMgaW4gbWFwX3NnCj4+Pj4KPj4+
PiBTaW5jZSBJIGRvIGhhdmUgcGF0Y2hlcyB0byBmaXggaTkxNSB0byBoYW5kbGUgdGhpcywgZG8g
d2Ugd2FudCB0byAKPj4+PiBjby1vcmRpbmF0ZSB0aGUgdHdvIGFuZCBhdm9pZCBoYXZpbmcgdG8g
YWRkIHRoaXMgcXVpcmsgYW5kIHRoZW4gCj4+Pj4gbGF0ZXIgcmVtb3ZlIGl0PyBPciB5b3Ugd2Fu
dCB0byBnbyB0aGUgc3RhZ2VkIGFwcHJvYWNoPwo+Pj4KPj4+IEkgaGF2ZSBubyBwcmVmZXJlbmNl
LiBJdCBkZXBlbmRzIG9uIHdoaWNoIHBhdGNoIGdvZXMgZmlyc3QuIExldCB0aGUKPj4+IG1haW50
YWluZXJzIGhlbHAgaGVyZS4KPj4KPj4gRllJIHdlIGhhdmUgbWVyZ2VkIHRoZSByZXF1aXJlZCBp
OTE1IHBhdGNoZXMgdG8gb3V0IHRyZWUgbGFzdCB3ZWVrIG9yIAo+PiBzby4gSSAqdGhpbmsqIHRo
aXMgbWVhbnMgdGhleSB3aWxsIGdvIGludG8gNS4xMS4gU28gdGhlIGk5MTUgc3BlY2lmaWMgCj4+
IHdvcmthcm91bmQgcGF0Y2ggd2lsbCBub3QgYmUgbmVlZGVkIGluIEludGVsIElPTU1VLgo+IAo+
IERvIHlvdSBtaW5kIHRlbGxpbmcgbWUgd2hhdCdzIHRoZSBzdGF0dXMgb2YgdGhpcyBmaXggcGF0
Y2g/IEkgdHJpZWQgdGhpcwo+IHNlcmllcyBvbiB2NS4xMC1yYzEgd2l0aCB0aGUgZ3JhcGhpYyBx
dWlyayBwYXRjaCBkcm9wcGVkLiBJIGFtIHN0aWxsCj4gc2VlaW5nIGRtYSBmYXVsdHMgZnJvbSBn
cmFwaGljIGRldmljZS4KCkhtbSBiYWNrIHRoZW4gSSB0aG91Z2h0IGk5MTUgZml4ZXMgZm9yIHRo
aXMgd291bGQgbGFuZCBpbiA1LjExIHNvIEkgd2lsbCAKc3RpY2sgd2l0aCB0aGF0LiA6KSAoU2Vl
IG15IHF1b3RlZCB0ZXh0IGEgcGFyYWdyYXBoIGFib3ZlIHlvdXJzLikKClJlZ2FyZHMsCgpUdnJ0
a28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
