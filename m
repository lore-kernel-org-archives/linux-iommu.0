Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E63DC433EF
	for <iommu@archiver.kernel.org>; Sat,  7 May 2022 12:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AB79827C6;
	Sat,  7 May 2022 12:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kh8ZNgPEkHX6; Sat,  7 May 2022 12:40:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E47E482796;
	Sat,  7 May 2022 12:39:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B36EDC0039;
	Sat,  7 May 2022 12:39:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E2E6C002D
 for <iommu@lists.linux-foundation.org>; Sat,  7 May 2022 12:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 150A3404DA
 for <iommu@lists.linux-foundation.org>; Sat,  7 May 2022 12:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XhGU0N-iLM_5 for <iommu@lists.linux-foundation.org>;
 Sat,  7 May 2022 12:39:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 548BA400E7
 for <iommu@lists.linux-foundation.org>; Sat,  7 May 2022 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651927197; x=1683463197;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=YmK2sF5H1jxPtXJwdIL8ZX3BDZKl/eFl1duDkPG7Phk=;
 b=ShNiZGEWwQdlg6jzlxcSM+axDCyWPnBKCn+CLfWS9h1f8npBv1Hmf74/
 vcMK8mz3aCWR7mnDiGYS+rZ0qZlI2lBvP68WdJZKneV9R2SjYrMCUgdmu
 2aS704GuFVZFgD5nm7jmURxkdUsWLiYHeFa4y4tFhMWPBsRgT2eNClBr3
 E5nl8XCGVh6mCouS8mcHY3MAFkX3nm0cN7bKoNYkroT3B9FgC+hqyw6fM
 wZIhdJarIx5TUX9+VD8D03XIjhAGVvFtxiO/cpZ6ZD/3/N5MLJSELYwe1
 yH1SrvR9YGvKL/u2xljqc37tHqx/uS1M3GjuImuqz7DXo5ppE/DiEoIJe Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="249239599"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; d="scan'208";a="249239599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2022 05:39:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; d="scan'208";a="586492100"
Received: from zhuangxi-mobl.ccr.corp.intel.com (HELO [10.255.30.94])
 ([10.255.30.94])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2022 05:39:51 -0700
Message-ID: <86fd8977-1134-02d2-d9e3-19ce58cb9de4@linux.intel.com>
Date: Sat, 7 May 2022 20:39:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 04/12] iommu/sva: Basic data structures for SVA
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-5-baolu.lu@linux.intel.com> <YnFv0ps0Ad8v+7uH@myrica>
 <d490e542-140c-58c3-bb11-9990795272b1@linux.intel.com>
 <669fb111-9821-aadc-acbf-de42bc551fc4@linux.intel.com>
In-Reply-To: <669fb111-9821-aadc-acbf-de42bc551fc4@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Vinod Koul <vkoul@kernel.org>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>
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

T24gMjAyMi81LzcgMTY6MzIsIEJhb2x1IEx1IHdyb3RlOgo+IEhpIEplYW4sCj4gCj4gT24gMjAy
Mi81LzUgMTQ6NDIsIEJhb2x1IEx1IHdyb3RlOgo+PiBPbiAyMDIyLzUvNCAwMjowOSwgSmVhbi1Q
aGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+Pj4gT24gTW9uLCBNYXkgMDIsIDIwMjIgYXQgMDk6NDg6
MzRBTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6Cj4+Pj4gVXNlIGJlbG93IGRhdGEgc3RydWN0dXJl
cyBmb3IgU1ZBIGltcGxlbWVudGF0aW9uIGluIHRoZSBJT01NVSBjb3JlOgo+Pj4+Cj4+Pj4gLSBz
dHJ1Y3QgaW9tbXVfc3ZhX2lvYXMKPj4+PiDCoMKgIFJlcHJlc2VudCB0aGUgSS9PIGFkZHJlc3Mg
c3BhY2Ugc2hhcmVkIHdpdGggYW4gYXBwbGljYXRpb24gQ1BVIAo+Pj4+IGFkZHJlc3MKPj4+PiDC
oMKgIHNwYWNlLiBUaGlzIHN0cnVjdHVyZSBoYXMgYSAxOjEgcmVsYXRpb25zaGlwIHdpdGggYW4g
bW1fc3RydWN0LiBJdAo+Pj4+IMKgwqAgZ3JhYnMgYSAibW0tPm1tX2NvdW50IiByZWZjb3VudCBk
dXJpbmcgY3JlYXRpb24gYW5kIGRyb3AgaXQgb24gCj4+Pj4gcmVsZWFzZS4KPj4+Cj4+PiBEbyB3
ZSBhY3R1YWxseSBuZWVkIHRoaXMgc3RydWN0dXJlP8KgIEF0IHRoZSBtb21lbnQgaXQgb25seSBr
ZWVwcyAKPj4+IHRyYWNrIG9mCj4+PiBib25kcywgd2hpY2ggd2UgY2FuIG1vdmUgdG8gc3RydWN0
IGRldl9pb21tdS4gUmVwbGFjaW5nIGl0IGJ5IGEgbW0gCj4+PiBwb2ludGVyCj4+PiBpbiBzdHJ1
Y3QgaW9tbXVfZG9tYWluIHNpbXBsaWZpZXMgdGhlIGRyaXZlciBhbmQgc2VlbXMgdG8gd29yawo+
Pgo+PiBGYWlyIGVub3VnaC4KPj4KPj4gK3N0cnVjdCBpb21tdV9zdmFfaW9hcyB7Cj4+ICvCoMKg
wqAgc3RydWN0IG1tX3N0cnVjdCAqbW07Cj4+ICvCoMKgwqAgaW9hc2lkX3QgcGFzaWQ7Cj4+ICsK
Pj4gK8KgwqDCoCAvKiBDb3VudGVyIG9mIGRvbWFpbnMgYXR0YWNoZWQgdG8gdGhpcyBpb2FzLiAq
Lwo+PiArwqDCoMKgIHJlZmNvdW50X3QgdXNlcnM7Cj4+ICsKPj4gK8KgwqDCoCAvKiBBbGwgYmlu
ZGluZ3MgYXJlIGxpbmtlZCBoZXJlLiAqLwo+PiArwqDCoMKgIHN0cnVjdCBsaXN0X2hlYWQgYm9u
ZHM7Cj4+ICt9Owo+Pgo+PiBCeSBtb3ZpbmcgQG1tIHRvIHN0cnVjdCBpb21tdV9kb21haW4gYW5k
IEBib25kcyB0byBzdHJ1Y3QgZGV2X2lvbW11LCB0aGUKPj4gY29kZSBsb29rcyBzaW1wbGVyLiBU
aGUgbW0sIHN2YSBkb21haW4gYW5kIHBlci1kZXZpY2UgZGV2X2lvbW11IGFyZQo+PiBndWFyYW50
ZWVkIHRvIGJlIHZhbGlkIGR1cmluZyBiaW5kKCkgYW5kIHVuYmluZCgpLgo+Pgo+PiBXaWxsIGhl
YWQgdGhpcyBkaXJlY3Rpb24gaW4gdGhlIG5leHQgdmVyc2lvbi4KPiAKPiBJJ20gdHJ5aW5nIHRv
IGltcGxlbWVudCB0aGlzIGlkZWEgaW4gcmVhbCBjb2RlLiBJdCBzZWVtcyB0aGF0IHdlIG5lZWQK
PiBhZGRpdGlvbmFsIGZpZWxkcyBpbiBzdHJ1Y3QgaW9tbXVfZG9tYWluIHRvIHRyYWNrIHdoaWNo
IGRldmljZXMgdGhlIG1tCj4gd2FzIGJvdW5kIHRvLiBJdCBkb2Vzbid0IHNpbXBsaWZ5IHRoZSBj
b2RlIG11Y2guIEFueSB0aG91Z2h0cz8KClNvcnJ5LCBKZWFuLiBUaGlzIGhhcyBiZWVuIGRpc2N1
c3NlZC4gV2UgZG9uJ3QgbmVlZCB0byBzaGFyZSBzdmEgZG9tYWluCmFtb25nIGRldmljZXMgYXQg
dGhpcyBzdGFnZS4gSXQncyBub3QgYSBiaWcgaXNzdWUgdG8gc3ZhIGRvbWFpbiBhcyBpdCdzCmEg
ZHVtYiBkb21haW4gd2hpY2ggaGFzIG5vIHN1cHBvcnQgZm9yIG1hcCgpL3VubWFwKCkgYW5kIHRo
ZSBjYWNoZQptYW5pcHVsYXRpb24uCgpJIHdpbGwgc3RpbGwgaGVhZCB0aGlzIGRpcmVjdGlvbi4g
U29ycnkgZm9yIHRoZSBub2lzZS4KCkJlc3QgcmVnYXJkcywKYmFvbHUKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
