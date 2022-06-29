Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6EAC43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 00:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B275409F4;
	Wed, 29 Jun 2022 00:25:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B275409F4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHUlByxt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oq4cEpq-kXcm; Wed, 29 Jun 2022 00:24:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 92F5F409E8;
	Wed, 29 Jun 2022 00:24:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92F5F409E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D282C0039;
	Wed, 29 Jun 2022 00:24:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E120C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 00:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 581DA60BA4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 00:24:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 581DA60BA4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eHUlByxt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZ0wqC6jB29n for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 00:24:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03F8D60B60
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03F8D60B60
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 00:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656462296; x=1687998296;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gNrBHCQAvCRcX09U/UlWMcKB1+tzLb4/Y4Z/doplvUA=;
 b=eHUlByxtGBuVoFhS/+wN3WdRyKAmBpke3Fgj7C71No/XgIVZFkKsX+uY
 JlcfszFXCIdqBcOlwcDaw+Fux8ZvORsQJC8GL0AMsx6lQVW063Uo0bdsU
 7yGPCcqKJOoFk4BiqQMwKF4m8mn47TW4Ck8qfsAqXwl279Gdkoh8PX0SS
 JSxE7JqwPVq1oKBZ5ipCcq4D5R9GL7wBLSY6rTrIJZgRZj7S2weiNM6GR
 IXV/wJbj580YcnYzo6wp+wn3X2BD00sqNIUs2WAF+e4pmTEK84mITcqFe
 SpGFEM+tMEQhNAm5OxbEXhC691NV5Ul0ruD+990H8koAJuq20qkRq1Kev w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="345876687"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="345876687"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 17:24:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="647142607"
Received: from xuepengx-mobl1.ccr.corp.intel.com (HELO [10.255.29.216])
 ([10.255.29.216])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 17:24:51 -0700
Message-ID: <bf2ae213-b938-2550-b367-f548fc755e99@linux.intel.com>
Date: Wed, 29 Jun 2022 08:24:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
 <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
 <YrsOO9E+j+CMgKMA@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YrsOO9E+j+CMgKMA@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Ethan Zhao <haifeng.zhao@linux.intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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

T24gMjAyMi82LzI4IDIyOjIwLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4gT24gVHVl
LCBKdW4gMjgsIDIwMjIgYXQgMDc6NTM6MzlQTSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6Cj4+Pj4+
IE9uY2UgdGhlIGlvcGZfaGFuZGxlX3NpbmdsZSgpIGlzIHJlbW92ZWQsIHRoZSBuYW1lIG9mCj4+
Pj4+IGlvcGZfaGFuZGxlX2dyb3VwKCkgbG9va3MgYSBsaXR0bGUgd2VpcmVkCj4+Pj4+Cj4+Pj4+
IGFuZCBjb25mdXNlZCwgZG9lcyB0aGlzIGdyb3VwIG1lYW4gdGhlIGlvbW11IGdyb3VwIChkb21h
aW4pID8KPj4+Pj4gd2hpbGUgSSB0YWtlIHNvbWUgbWludXRlcyB0bwo+Pj4+Cj4+Pj4gTm8uIFRo
aXMgaXMgbm90IHRoZSBpb21tdSBncm91cC4gSXQncyBwYWdlIHJlcXVlc3QgZ3JvdXAgZGVmaW5l
ZCBieSB0aGUKPj4+PiBQQ0kgU0lHIHNwZWMuIE11bHRpcGxlIHBhZ2UgcmVxdWVzdHMgY291bGQg
YmUgcHV0IGluIGEgZ3JvdXAgd2l0aCBhCj4+Pj4gc2FtZSBncm91cCBpZC4gQWxsIHBhZ2UgcmVx
dWVzdHMgaW4gYSBncm91cCBjb3VsZCBiZSByZXNwb25kZWQgdG8gZGV2aWNlCj4+Pj4gaW4gb25l
IHNob3QuCj4+Pgo+Pj4gVGhhbmtzIHlvdXIgZXhwbGFpbmF0aW9uLCB1bmRlcnN0YW5kIHRoZSBj
b25jZXB0IG9mIFBDSWUgUFJHLsKgIEkgbWVhbnQKPj4+Cj4+PiBkbyB3ZSBzdGlsbCBoYXZlIHRo
ZSBuZWNlc3NpdHkgdG8gbWVudGlvbiB0aGUgImdyb3VwIiBoZXJlIGluIHRoZSBuYW1lCj4+Pgo+
Pj4gaW9wZl9oYW5kbGVfZ3JvdXAoKSzCoCB3aGljaCBvbmUgaXMgYmV0dGVyID8gaW9wZl9oYW5k
bGVfcHJnKCkgb3IKPj4+Cj4+PiBpb3BmX2hhbmRsZXIoKSzCoCBwZXJoYXBzIG5vbmUgb2YgdGhl
bSA/IDopCj4+Cj4+IE9oISBTb3JyeSBmb3IgdGhlIG1pc3VuZGVyc3RhbmRpbmcuCj4+Cj4+IEkg
aGF2ZSBubyBzdHJvbmcgZmVlbGluZyB0byBjaGFuZ2UgdGhpcyBuYW1pbmcuIDotKSBBbGwgdGhl
IG5hbWVzCj4+IGV4cHJlc3Mgd2hhdCB0aGUgaGVscGVyIGRvZXMuIEplYW4gaXMgdGhlIGF1dGhv
ciBvZiB0aGlzIGZyYW1ld29yay4gSWYKPj4gaGUgaGFzIHRoZSBzYW1lIGlkZWEgYXMgeW91LCBJ
IGRvbid0IG1pbmQgcmVuYW1pbmcgaXQgaW4gdGhpcyBwYXRjaC4KPiAKPiBJJ20gbm90IGF0dGFj
aGVkIHRvIHRoZSBuYW1lLCBhbmQgSSBzZWUgaG93IGl0IGNvdWxkIGJlIGNvbmZ1c2luZy4gR2l2
ZW4KPiB0aGF0IGlvLXBnZmF1bHQgaXMgbm90IG9ubHkgZm9yIFBDSWUsICdwcmcnIGlzIG5vdCB0
aGUgYmVzdCBoZXJlIGVpdGhlci4KPiBpb3BmX2hhbmRsZV9mYXVsdHMoKSwgb3IganVzdCBpb3Bm
X2hhbmRsZXIoKSwgc2VlbSBtb3JlIHN1aXRhYmxlLgoKT2theSwgc28gSSB3aWxsIHJlbmFtZSBp
dCB0byBpb3BmX2hhbmRsZV9mYXVsdHMoKSBpbiB0aGlzIHBhdGNoLgoKQmVzdCByZWdhcmRzLApi
YW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
