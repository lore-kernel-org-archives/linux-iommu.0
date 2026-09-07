Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4F43DA2C
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769555; cv=none; b=dDRFRlDH7zkSQkGZN94OjSw1OpEagTC6i44aQA7ijmu1nESiq5UXhbN2pP8UWVn9O/R0rYWChETW7nNVS/jvAJE6mQCeDxq8iVrCLDKNvZ1l5DCVJBfmdVAn47ROH8bqFTvXVuYatn4U+YsxC4yq/bJPDWpwjyXGcBDwoyVjJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769555; c=relaxed/simple;
	bh=RZt2HxwrlC7uM1wf0OZHImMU77vwR9/ueHK3GkdCeIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rtj2aN2gxNLCCwobToQDQcPsNeEXGUjOdgiXo7OjClXmbxN18JeKeR2Ht06VeVTRPIShBgYC6QVyhHjeaMyjK1Ds83tiIg+7amWno2penxFDqFUAscKWhJ/dhm0aVa0jbYwYDKsFYRQIg/rs3bRkl1q2VirZ1oYOBwh7aa8AA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GBRixlW/; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GBRixlW/"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260907082550euoutp015cbcad5d5f3337ab2e0fdc513c1cb573~S-G3autfy1005510055euoutp01S
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 08:25:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260907082550euoutp015cbcad5d5f3337ab2e0fdc513c1cb573~S-G3autfy1005510055euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788769550;
	bh=w+8hDv++QER8tTjVBYnJIRDhbNZxRtLnMUyxOZM4uAY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=GBRixlW/RfPkYfMKb7gsx8Yyyc3F/rIpyVrStQX+0vQqoi0jjngN0GGr+VuOZ5bqd
	 qfa8tkj077rIwjX0jJV82Bt2Faa99pGEpeTPob5E66ucqEBZGX1RqrL2Sq+D+VBpTB
	 cS78SJXZ3dmT2rft6BWK6nqR3oDswrlSHdvi2P8E=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260907082550eucas1p1df7edf0bbcda200a8b4700bdd6d459bf~S-G3M2bFq1513915139eucas1p1m;
	Mon,  7 Sep 2026 08:25:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260907082550eusmtip11ff6e8f686a5255952ae24f85591701c~S-G2vcEC_1356513565eusmtip1i;
	Mon,  7 Sep 2026 08:25:49 +0000 (GMT)
Message-ID: <f48c2a3f-38c8-44ab-8352-35ee1874b420@samsung.com>
Date: Mon, 7 Sep 2026 10:25:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
 regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit
 8277a12d0d60)
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>, Timo Witte <timo.witte@gmail.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "Hegde, Vasant" <Vasant.Hegde@amd.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <BN9PR12MB5146EB49E0988618FBC13515F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260907082550eucas1p1df7edf0bbcda200a8b4700bdd6d459bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260902182632eucas1p2d0caf5a54243c630ecbd4844cc278a0d
X-EPHeader: CA
X-CMS-RootMailID: 20260902182632eucas1p2d0caf5a54243c630ecbd4844cc278a0d
References: <CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com>
	<yq5ao6egyn5j.fsf@kernel.org>
	<CGME20260902182632eucas1p2d0caf5a54243c630ecbd4844cc278a0d@eucas1p2.samsung.com>
	<BN9PR12MB5146EB49E0988618FBC13515F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>

On 02.09.2026 20:26, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>> Sent: Wednesday, September 2, 2026 6:16 AM
>> To: Timo Witte <timo.witte@gmail.com>; iommu@lists.linux.dev
>> Cc: m.szyprowski@samsung.com; robin.murphy@arm.com;
>> joro@8bytes.org; Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
>> regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs
>> (commit 8277a12d0d60)
>>
>> Timo Witte <timo.witte@gmail.com> writes:
>>
>>> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and
>>> select them via attrs") added to iommu_dma_alloc():
>>>
>>>     /* Not yet supported */
>>>     if (is_alloc_cc_shared)
>>>         return NULL;
>>>
>>> dma_alloc_attrs() auto-sets __DMA_ATTR_ALLOC_CC_SHARED whenever
>>> force_dma_unencrypted() is true. On an SME host (mem_encrypt=on) an
>>> AMD GPU with a 44-bit DMA mask hits that condition, so every GTT
>>> (system-RAM) allocation fails with NULL/-ENOMEM, amdgpu init aborts
>>> and the system boots without a display.
>>> IOMMU in Translated/DMA-FQ mode (iommu group 29).
>>>
>>> Before the mentioned patch it worked: the IOMMU PTE carries the SME
>>> C-bit, so the memory controller transparently decrypts for the device
>>> while pages stay encrypted at rest. For IOMMU-backed devices
>>> force_dma_unencrypted() is a false positive - the device DMA mask does
>>> not limit addressing once the IOMMU translates, so CC_SHARED should
>>> not be auto-set for them.
>>>
>>
>> This means that, with host memory encryption, DMA does not need to be
>> forced unencrypted when the device uses the IOMMU?
> + Tom and Vasant.
>
> Yes, otherwise most devices won't be able to work with encrypted memory since most devices don't support a DMA mask large enough to cover the C bit.
Is this the proper fix/workaround for v7.3-rc? If so, then Aneesh, please
send it as a complete patch so I will take it to the dma-mapping-fixes.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

