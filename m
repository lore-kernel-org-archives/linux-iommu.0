Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E6C388F2
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 03:00:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD9422265
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 03:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD9422265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1775E85E43;
	Tue,  3 Nov 2020 03:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xDeLKDjR95XM; Tue,  3 Nov 2020 03:00:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8012F85E24;
	Tue,  3 Nov 2020 03:00:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C610C088B;
	Tue,  3 Nov 2020 03:00:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0109DC0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 03:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E45F185E35
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 03:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Ec0yo_MX8hH for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 03:00:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0A77185E24
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 03:00:47 +0000 (UTC)
IronPort-SDR: JdbEzfF7n/fbFTUYibSppcEiHvYrxUYt0iuycPdHG3Q4BFWuglLCc6NKft2bE8x9mrbrMbje1q
 M8wilfcv3p5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="155977601"
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; d="scan'208";a="155977601"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 19:00:47 -0800
IronPort-SDR: dGkHC1Tjp9yGTblC2nJZ7Rz2ncLYiT2V3ZvAFrhpWpVYVWS4BDwN2Mr2oC9zGTmjydprL6rDBl
 eR+uf1q7BSPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; d="scan'208";a="426170571"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2020 19:00:44 -0800
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu api
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
 <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
 <3f5694f3-62f9-cc2b-1c2b-f9e99a4788c1@linux.intel.com>
 <1ce5b94a-38b3-548e-3b1a-a68390b93953@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <82dab98e-0761-8946-c31c-92f19a0615b4@linux.intel.com>
Date: Tue, 3 Nov 2020 10:53:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1ce5b94a-38b3-548e-3b1a-a68390b93953@linux.intel.com>
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

T24gMTEvMi8yMCA3OjUyIFBNLCBUdnJ0a28gVXJzdWxpbiB3cm90ZToKPiAKPiBPbiAwMi8xMS8y
MDIwIDAyOjAwLCBMdSBCYW9sdSB3cm90ZToKPj4gSGkgVHZydGtvLAo+PiBPbiAxMC8xMi8yMCA0
OjQ0IFBNLCBUdnJ0a28gVXJzdWxpbiB3cm90ZToKPj4+Cj4+PiBPbiAyOS8wOS8yMDIwIDAxOjEx
LCBMdSBCYW9sdSB3cm90ZToKPj4+PiBIaSBUdnJ0a28sCj4+Pj4KPj4+PiBPbiA5LzI4LzIwIDU6
NDQgUE0sIFR2cnRrbyBVcnN1bGluIHdyb3RlOgo+Pj4+Pgo+Pj4+PiBPbiAyNy8wOS8yMDIwIDA3
OjM0LCBMdSBCYW9sdSB3cm90ZToKPj4+Pj4+IEhpLAo+Pj4+Pj4KPj4+Pj4+IFRoZSBwcmV2aW91
cyBwb3N0IG9mIHRoaXMgc2VyaWVzIGNvdWxkIGJlIGZvdW5kIGhlcmUuCj4+Pj4+Pgo+Pj4+Pj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMDA5MTIwMzIyMDAuMTE0ODkt
MS1iYW9sdS5sdUBsaW51eC5pbnRlbC5jb20vIAo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBUaGlzIHZl
cnNpb24gaW50cm9kdWNlIGEgbmV3IHBhdGNoIFs0LzddIHRvIGZpeCBhbiBpc3N1ZSByZXBvcnRl
ZCAKPj4+Pj4+IGhlcmUuCj4+Pj4+Pgo+Pj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtaW9tbXUvNTFhMWJhZWMtNDhkMS1jMGFjLTE4MWItMWZiYTkyYWE0MjhkQGxpbnV4LmludGVs
LmNvbS8gCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IFRoZXJlIGFyZW4ndCBhbnkgb3RoZXIgY2hhbmdl
cy4KPj4+Pj4+Cj4+Pj4+PiBQbGVhc2UgaGVscCB0byB0ZXN0IGFuZCByZXZpZXcuCj4+Pj4+Pgo+
Pj4+Pj4gQmVzdCByZWdhcmRzLAo+Pj4+Pj4gYmFvbHUKPj4+Pj4+Cj4+Pj4+PiBMdSBCYW9sdSAo
Myk6Cj4+Pj4+PiDCoMKgIGlvbW11OiBBZGQgcXVpcmsgZm9yIEludGVsIGdyYXBoaWMgZGV2aWNl
cyBpbiBtYXBfc2cKPj4+Pj4KPj4+Pj4gU2luY2UgSSBkbyBoYXZlIHBhdGNoZXMgdG8gZml4IGk5
MTUgdG8gaGFuZGxlIHRoaXMsIGRvIHdlIHdhbnQgdG8gCj4+Pj4+IGNvLW9yZGluYXRlIHRoZSB0
d28gYW5kIGF2b2lkIGhhdmluZyB0byBhZGQgdGhpcyBxdWlyayBhbmQgdGhlbiAKPj4+Pj4gbGF0
ZXIgcmVtb3ZlIGl0PyBPciB5b3Ugd2FudCB0byBnbyB0aGUgc3RhZ2VkIGFwcHJvYWNoPwo+Pj4+
Cj4+Pj4gSSBoYXZlIG5vIHByZWZlcmVuY2UuIEl0IGRlcGVuZHMgb24gd2hpY2ggcGF0Y2ggZ29l
cyBmaXJzdC4gTGV0IHRoZQo+Pj4+IG1haW50YWluZXJzIGhlbHAgaGVyZS4KPj4+Cj4+PiBGWUkg
d2UgaGF2ZSBtZXJnZWQgdGhlIHJlcXVpcmVkIGk5MTUgcGF0Y2hlcyB0byBvdXQgdHJlZSBsYXN0
IHdlZWsgb3IgCj4+PiBzby4gSSAqdGhpbmsqIHRoaXMgbWVhbnMgdGhleSB3aWxsIGdvIGludG8g
NS4xMS4gU28gdGhlIGk5MTUgc3BlY2lmaWMgCj4+PiB3b3JrYXJvdW5kIHBhdGNoIHdpbGwgbm90
IGJlIG5lZWRlZCBpbiBJbnRlbCBJT01NVS4KPj4KPj4gRG8geW91IG1pbmQgdGVsbGluZyBtZSB3
aGF0J3MgdGhlIHN0YXR1cyBvZiB0aGlzIGZpeCBwYXRjaD8gSSB0cmllZCB0aGlzCj4+IHNlcmll
cyBvbiB2NS4xMC1yYzEgd2l0aCB0aGUgZ3JhcGhpYyBxdWlyayBwYXRjaCBkcm9wcGVkLiBJIGFt
IHN0aWxsCj4+IHNlZWluZyBkbWEgZmF1bHRzIGZyb20gZ3JhcGhpYyBkZXZpY2UuCj4gCj4gSG1t
IGJhY2sgdGhlbiBJIHRob3VnaHQgaTkxNSBmaXhlcyBmb3IgdGhpcyB3b3VsZCBsYW5kIGluIDUu
MTEgc28gSSB3aWxsIAo+IHN0aWNrIHdpdGggdGhhdC4gOikgKFNlZSBteSBxdW90ZWQgdGV4dCBh
IHBhcmFncmFwaCBhYm92ZSB5b3Vycy4pCgpXaGF0IHNpemUgYXJlIHRob3NlIGZpeGVzPyBJIGFt
IGNvbnNpZGVyaW5nIHB1c2hpbmcgdGhpcyBzZXJpZXMgZm9yCnY1LjExLiBJcyBpdCBwb3NzaWJs
ZSB0byBnZXQgc29tZSBhY2tzIGZvciB0aG9zZSBwYXRjaGVzIGFuZCBsZXQgdGhlbQpnbyB0byBM
aW51cyB0aHJvdWdoIGlvbW11IHRyZWU/CgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
