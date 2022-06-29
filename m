Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09F8C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 06:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4645A4058E;
	Wed, 29 Jun 2022 06:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4645A4058E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MY/2R8fO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CM8p6GW8jO9K; Wed, 29 Jun 2022 06:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C5DF400A6;
	Wed, 29 Jun 2022 06:15:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C5DF400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00785C0032;
	Wed, 29 Jun 2022 06:15:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B00ECC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 06:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 750B04058E
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 06:15:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 750B04058E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QcveplGVpLXf for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:15:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4793B400A6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4793B400A6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 06:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656483340; x=1688019340;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MIRJXsI3AGI9TOUBaCXQFdgFRZepMITCdgAbqxVUet0=;
 b=MY/2R8fO8KF4PxFaSouucgfYq9NyLGuO1meX1PFfWcM+stoqP1g7fY+p
 sOkVjXQi+g7B2Tvycw5T09K+aUz+xaY1qgVaq1K1a/Q71uquDIK9/PJ7I
 dA185Nh9KagMXLrVkJ3PeRxq+04g4FeV9JIjcbKm536PRvPUtRWOpfkvO
 1Rje1QyjUkhwAuyg/YnVMVA8/cHPcXZz8Cf23Th1//Lk2ef7YG2D17ArT
 OlbOoZGIJv1w0ak9PwSs/MOgW7TElEYVApiN7L5cbqYUYleJ33qlbQccy
 HgZIBWOVn5HAO8d6u4konawg+HP6aurTzN5GhdSSPPvj5i6/JHY/x4t6L Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282669503"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="282669503"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 23:15:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="595103334"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.214.131])
 ([10.254.214.131])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 23:15:30 -0700
Message-ID: <2e99710b-becc-1e03-fa10-ad5f2dd06802@linux.intel.com>
Date: Wed, 29 Jun 2022 14:15:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Baolu Lu <baolu.lu@linux.intel.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
 <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
 <YrsOO9E+j+CMgKMA@myrica>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <YrsOO9E+j+CMgKMA@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

CuWcqCAyMDIyLzYvMjggMjI6MjAsIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciDlhpnpgZM6Cj4gT24g
VHVlLCBKdW4gMjgsIDIwMjIgYXQgMDc6NTM6MzlQTSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6Cj4+
Pj4+IE9uY2UgdGhlIGlvcGZfaGFuZGxlX3NpbmdsZSgpIGlzIHJlbW92ZWQsIHRoZSBuYW1lIG9m
Cj4+Pj4+IGlvcGZfaGFuZGxlX2dyb3VwKCkgbG9va3MgYSBsaXR0bGUgd2VpcmVkCj4+Pj4+Cj4+
Pj4+IGFuZCBjb25mdXNlZCwgZG9lcyB0aGlzIGdyb3VwIG1lYW4gdGhlIGlvbW11IGdyb3VwIChk
b21haW4pID8KPj4+Pj4gd2hpbGUgSSB0YWtlIHNvbWUgbWludXRlcyB0bwo+Pj4+IE5vLiBUaGlz
IGlzIG5vdCB0aGUgaW9tbXUgZ3JvdXAuIEl0J3MgcGFnZSByZXF1ZXN0IGdyb3VwIGRlZmluZWQg
YnkgdGhlCj4+Pj4gUENJIFNJRyBzcGVjLiBNdWx0aXBsZSBwYWdlIHJlcXVlc3RzIGNvdWxkIGJl
IHB1dCBpbiBhIGdyb3VwIHdpdGggYQo+Pj4+IHNhbWUgZ3JvdXAgaWQuIEFsbCBwYWdlIHJlcXVl
c3RzIGluIGEgZ3JvdXAgY291bGQgYmUgcmVzcG9uZGVkIHRvIGRldmljZQo+Pj4+IGluIG9uZSBz
aG90Lgo+Pj4gVGhhbmtzIHlvdXIgZXhwbGFpbmF0aW9uLCB1bmRlcnN0YW5kIHRoZSBjb25jZXB0
IG9mIFBDSWUgUFJHLsKgIEkgbWVhbnQKPj4+Cj4+PiBkbyB3ZSBzdGlsbCBoYXZlIHRoZSBuZWNl
c3NpdHkgdG8gbWVudGlvbiB0aGUgImdyb3VwIiBoZXJlIGluIHRoZSBuYW1lCj4+Pgo+Pj4gaW9w
Zl9oYW5kbGVfZ3JvdXAoKSzCoCB3aGljaCBvbmUgaXMgYmV0dGVyID8gaW9wZl9oYW5kbGVfcHJn
KCkgb3IKPj4+Cj4+PiBpb3BmX2hhbmRsZXIoKSzCoCBwZXJoYXBzIG5vbmUgb2YgdGhlbSA/IDop
Cj4+IE9oISBTb3JyeSBmb3IgdGhlIG1pc3VuZGVyc3RhbmRpbmcuCj4+Cj4+IEkgaGF2ZSBubyBz
dHJvbmcgZmVlbGluZyB0byBjaGFuZ2UgdGhpcyBuYW1pbmcuIDotKSBBbGwgdGhlIG5hbWVzCj4+
IGV4cHJlc3Mgd2hhdCB0aGUgaGVscGVyIGRvZXMuIEplYW4gaXMgdGhlIGF1dGhvciBvZiB0aGlz
IGZyYW1ld29yay4gSWYKPj4gaGUgaGFzIHRoZSBzYW1lIGlkZWEgYXMgeW91LCBJIGRvbid0IG1p
bmQgcmVuYW1pbmcgaXQgaW4gdGhpcyBwYXRjaC4KPiBJJ20gbm90IGF0dGFjaGVkIHRvIHRoZSBu
YW1lLCBhbmQgSSBzZWUgaG93IGl0IGNvdWxkIGJlIGNvbmZ1c2luZy4gR2l2ZW4KPiB0aGF0IGlv
LXBnZmF1bHQgaXMgbm90IG9ubHkgZm9yIFBDSWUsICdwcmcnIGlzIG5vdCB0aGUgYmVzdCBoZXJl
IGVpdGhlci4KPiBpb3BmX2hhbmRsZV9mYXVsdHMoKSwgb3IganVzdCBpb3BmX2hhbmRsZXIoKSwg
c2VlbSBtb3JlIHN1aXRhYmxlLgoKQm90aCBpb3BmX2hhbmRsZV9mYXVsdHMoKSBhbmQgaW9wZl9o
YW5kbGVyKCkgbG9va3Mgc3RyYWlnaHQsIGlvcGZfaGFuZGxlcigpCgpzYXZlcyBvbmUgd29yZCAn
ZmF1bHRzJywgaW9wZiBhbHJlYWR5IGhhcyB0aGUgbWVhbmluZyAnaW8gcGFnZSBmYXVsdCcgLCBz
bwoKaW9wZl9oYW5kbGVyKCkgaXMgY2xlYXIgZW5vdWdoIEkgdGhpbmsuCgoKVGhhbmtzLAoKRXRo
YW4KCj4KPiBUaGFua3MsCj4gSmVhbgoKLS0gCiJmaXJtLCBlbmR1cmluZywgc3Ryb25nLCBhbmQg
bG9uZy1saXZlZCIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
