Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969D74A99DF
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877933; cv=none; b=q7pnf7LvYsNk65xm6onUE8eKwXVBOUSEnj9yQd2SSsSAcSr1XUTDwD1FGjZG/TS3HaG0xa7/ZwTfiYwkOzt/yBjn4W4oS9NZ8bZUhh1aIMw6xIVPEed9IfMJzCJ8Ll88UwSlEhTbrr9wyg0tjXXhsLY4Etu+SkAhydhTzk9O6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877933; c=relaxed/simple;
	bh=sGPpsw82Ut1ivvODV3WzDRDtKI8Iqx39jJUwTNNuOXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ogZIIxS6d+8puFmydplq5Dj0+/vDT0499PkbnZJVAbazhJCUj4uoqSBDZsFTefiFEsjRkcBYICnSER7M7iD0izdOzOmsZwJHDPWH5vD+V83MguDcXLDFj9S6hnEVNCQX0/+HX7kDx1QqXBzf2z0ev44fVblbWtS9xvqI6UaIf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i0LGIgBk; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i0LGIgBk"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260908143200euoutp028f21af66d100054676f6941e85ed30b5~TXv214FNt3127931279euoutp02h
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 14:32:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260908143200euoutp028f21af66d100054676f6941e85ed30b5~TXv214FNt3127931279euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788877920;
	bh=lxtxfoc1BqZ88KyMks903H98cbnt9NYyBmm/eirjOBE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=i0LGIgBk76feutSX6aONa1B0ZMfdK9tjEzLqFCPaCYHK9M/5WEYFL9oExD6BAI7+2
	 IK36iKanvR7tQcjUwH1W/V8CLNb8Jk3LoOwyA2CWXBFEaqO+EspLK6Ps72+a4Oc1zc
	 t2z9LF9ASNWtdnCfciz5bNxbUSmO/ZaWBryxjk+8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260908143200eucas1p2f8f2902d780e0d3eaf96c351854b9124~TXv2PhgXT1078710787eucas1p27;
	Tue,  8 Sep 2026 14:32:00 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260908143158eusmtip194054021f33b6656c3f5ba4327c89852~TXv0uyMB30480504805eusmtip19;
	Tue,  8 Sep 2026 14:31:58 +0000 (GMT)
Message-ID: <fc0bc0c2-59ca-40b9-9d98-d5aebebeb4a3@samsung.com>
Date: Tue, 8 Sep 2026 16:31:57 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed
 devices
To: Michael Kelley <mhklinux@outlook.com>, "Aneesh Kumar K.V (Arm)"
	<aneesh.kumar@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Mostafa Saleh
	<smostafa@google.com>, "Alexander.Deucher@amd.com"
	<Alexander.Deucher@amd.com>, "Thomas.Lendacky@amd.com"
	<Thomas.Lendacky@amd.com>, "Vasant.Hegde@amd.com" <Vasant.Hegde@amd.com>,
	Timo Witte <timo.witte@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <SN6PR02MB41571F1762544B6157C475BFD4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260908143200eucas1p2f8f2902d780e0d3eaf96c351854b9124
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260908142502eucas1p10e6dff3598a25b81016dbc981b80c288
X-EPHeader: CA
X-CMS-RootMailID: 20260908142502eucas1p10e6dff3598a25b81016dbc981b80c288
References: <20260908113232.247457-1-aneesh.kumar@kernel.org>
	<CGME20260908142502eucas1p10e6dff3598a25b81016dbc981b80c288@eucas1p1.samsung.com>
	<SN6PR02MB41571F1762544B6157C475BFD4B12@SN6PR02MB4157.namprd02.prod.outlook.com>

On 08.09.2026 16:24, Michael Kelley wrote:
> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> Sent: Tuesday, September 8, 2026 4:33 AM
>> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
>> them via attrs") exposed an issue with force_dma_unencrypted() on
>> systems using host memory encryption.
>>
>> force_dma_unencrypted() checks whether the device DMA mask can address
>> the encryption bit and, if not, requires DMA allocations to use
>> unencrypted memory. However, this check is not applicable when the
>> device is using the IOMMU. In that case, the device DMA mask constrains
>> the IOVA seen by the device, not the backing physical address, so it
>> does not need to cover the C-bit.
>>
>> This currently causes dma_alloc_attrs() to set
>> __DMA_ATTR_ALLOC_CC_SHARED for such devices. iommu_dma_alloc() does not
>> support that attribute and rejects the allocation, causing DMA
>> allocations to fail.
>>
>> Do not force DMA allocations to be unencrypted when the device is using
>> the IOMMU. This allows the IOMMU to map the encrypted physical pages as
>> before and avoids incorrectly requesting CC_SHARED allocations.
>>
>> Fixes: 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select them via attrs")
>> Reported-by: Timo Witte <timo.witte@gmail.com>
>> Link: https://lore.kernel.org/all/CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com
> There seems to be something wrong with this link. Just viewing the
> email thread in lore.kernel.org shows a [not found] error in the thread.

Indeed, this one works better:

https://lore.kernel.org/all/CANB4YXS=Nf-co3t8eMHtqrW4sn=1BDcP6o=EoTrgZm0WYMYTyw@mail.gmail.com/

I will amend it while applying, but I want give everyone some time for comments.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

