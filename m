Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBF5C433E7
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 00:39:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE5721655
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 00:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE5721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E50722E393;
	Tue, 13 Oct 2020 00:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cKmKMnwlLb4v; Tue, 13 Oct 2020 00:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 19EA12E0E5;
	Tue, 13 Oct 2020 00:39:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88ABBC0052;
	Tue, 13 Oct 2020 00:39:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4811AC0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 00:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 30EA52E0E5
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 00:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pgy+IJDuCV+2 for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 00:39:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 20D042E0D9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 00:39:28 +0000 (UTC)
IronPort-SDR: xlZal0D4F8yw7PdVSTxHt/GKY5cYmtx2DonhR1shAOZzq1/8z1G7fVzXt+cg7m/lXwF6Bt3yPm
 ir71DyhBg9jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165936508"
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; d="scan'208";a="165936508"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 17:39:26 -0700
IronPort-SDR: y5z+hZ5cSYkx8JvU5SikKp8uKnzwJcOTZpQUxSZ2OpbG2uHta4q8jOnZrxRAVQIeMo6nhBc5zd
 USpox1hI//bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; d="scan'208";a="345083735"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2020 17:39:24 -0700
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu api
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
 <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dce088b4-38ab-a540-6ac0-05ecc0b60aae@linux.intel.com>
Date: Tue, 13 Oct 2020 08:32:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, Intel-gfx@lists.freedesktop.org,
 Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org
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

SGkgVHZydGtvLAoKT24gMTAvMTIvMjAgNDo0NCBQTSwgVHZydGtvIFVyc3VsaW4gd3JvdGU6Cj4g
Cj4gT24gMjkvMDkvMjAyMCAwMToxMSwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIFR2cnRrbywKPj4K
Pj4gT24gOS8yOC8yMCA1OjQ0IFBNLCBUdnJ0a28gVXJzdWxpbiB3cm90ZToKPj4+Cj4+PiBPbiAy
Ny8wOS8yMDIwIDA3OjM0LCBMdSBCYW9sdSB3cm90ZToKPj4+PiBIaSwKPj4+Pgo+Pj4+IFRoZSBw
cmV2aW91cyBwb3N0IG9mIHRoaXMgc2VyaWVzIGNvdWxkIGJlIGZvdW5kIGhlcmUuCj4+Pj4KPj4+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIwMDkxMjAzMjIwMC4xMTQ4
OS0xLWJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbS8gCj4+Pj4KPj4+Pgo+Pj4+IFRoaXMgdmVyc2lv
biBpbnRyb2R1Y2UgYSBuZXcgcGF0Y2ggWzQvN10gdG8gZml4IGFuIGlzc3VlIHJlcG9ydGVkIGhl
cmUuCj4+Pj4KPj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS81MWExYmFl
Yy00OGQxLWMwYWMtMTgxYi0xZmJhOTJhYTQyOGRAbGludXguaW50ZWwuY29tLyAKPj4+Pgo+Pj4+
Cj4+Pj4gVGhlcmUgYXJlbid0IGFueSBvdGhlciBjaGFuZ2VzLgo+Pj4+Cj4+Pj4gUGxlYXNlIGhl
bHAgdG8gdGVzdCBhbmQgcmV2aWV3Lgo+Pj4+Cj4+Pj4gQmVzdCByZWdhcmRzLAo+Pj4+IGJhb2x1
Cj4+Pj4KPj4+PiBMdSBCYW9sdSAoMyk6Cj4+Pj4gwqDCoCBpb21tdTogQWRkIHF1aXJrIGZvciBJ
bnRlbCBncmFwaGljIGRldmljZXMgaW4gbWFwX3NnCj4+Pgo+Pj4gU2luY2UgSSBkbyBoYXZlIHBh
dGNoZXMgdG8gZml4IGk5MTUgdG8gaGFuZGxlIHRoaXMsIGRvIHdlIHdhbnQgdG8gCj4+PiBjby1v
cmRpbmF0ZSB0aGUgdHdvIGFuZCBhdm9pZCBoYXZpbmcgdG8gYWRkIHRoaXMgcXVpcmsgYW5kIHRo
ZW4gbGF0ZXIgCj4+PiByZW1vdmUgaXQ/IE9yIHlvdSB3YW50IHRvIGdvIHRoZSBzdGFnZWQgYXBw
cm9hY2g/Cj4+Cj4+IEkgaGF2ZSBubyBwcmVmZXJlbmNlLiBJdCBkZXBlbmRzIG9uIHdoaWNoIHBh
dGNoIGdvZXMgZmlyc3QuIExldCB0aGUKPj4gbWFpbnRhaW5lcnMgaGVscCBoZXJlLgo+IAo+IEZZ
SSB3ZSBoYXZlIG1lcmdlZCB0aGUgcmVxdWlyZWQgaTkxNSBwYXRjaGVzIHRvIG91dCB0cmVlIGxh
c3Qgd2VlayBvciAKPiBzby4gSSAqdGhpbmsqIHRoaXMgbWVhbnMgdGhleSB3aWxsIGdvIGludG8g
NS4xMS4gU28gdGhlIGk5MTUgc3BlY2lmaWMgCj4gd29ya2Fyb3VuZCBwYXRjaCB3aWxsIG5vdCBi
ZSBuZWVkZWQgaW4gSW50ZWwgSU9NTVUuCgpUaGFua3MgZm9yIGxldHRpbmcgdXMga25vdyB0aGlz
LiBJIHdpbGwgZHJvcCB0aGUgd29ya2Fyb3VuZCBwYXRjaCBhbmQKdGVzdCB0aGUgd2hvbGUgc2Vy
aWVzIGFmdGVyIHRoZSBuZXh0IHJjMS4KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
