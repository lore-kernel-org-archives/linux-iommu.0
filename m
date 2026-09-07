Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C544E66B8
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789330; cv=none; b=D8ICMlZH2eHrZtRiBd27R4TLIlahzbogDlLz5WRuUjONrRdrNM5PExH78FGYILKk9fMuyC326gxuQ58u8T8lLFCcLS9Kw0jyQNevCUEjBKNKpkP2cddohPksaLuzXyrhgCMBkwA8TfeSN0Z8+UjlIJTMwlJhnvBZ2gJ7gdR4Tc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789330; c=relaxed/simple;
	bh=KIUNvPwrGyxsIDRPQXT9srRO+CI5YFjK9h9LJbAruPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uhVMB/S6/V2bfp1BIJ4KzRfQv215GxuvfGqS8BCjE8fDkeYrJFfTg0U66dNAZif0QVVrrkCj21h8hKs+MtQpqwt2B1acTLXlYqVwP87hKkWZ4+w/rN/OuhY6LC5wJg8eKa3wJyL8VXtwK6kRTUdgDlR6GGuU07P4MkCvv+yKtpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlvY0/CU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlvY0/CU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439141F00A3A;
	Mon,  7 Sep 2026 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789328;
	bh=2TwcZ1+U4EkpfoCEwGw6K4Z2pr3uBnAtvvFMpD6NyR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hlvY0/CUYY0egubX++alD4btdyX6+atUB3P+iSRXke3TAweTxb9mzf99QKIz4DYnN
	 LBIoMa3Sk+JOnxX3TzhOI8p0uitysG32KYYyVm44vtdwTf9p38GKas3K6Ofhj/Lp8S
	 5h5fGPhs3NmFadhSQaEuwepXKCGR2GzxgXsnAT5FdxL88Jag8pIg6TXRJgrSljUUaD
	 X+KH4KB50KlLqlvABiXqnOh58fU7nUc6fxc6d3MVGZDz9fd9+n11wq31yBkZzZMeJZ
	 qvpEv8agc7x5kM0SXi471Vgq78jaxw4M8JCj/eE92Y6+L/SGlHLM9jR6a35VoAfr2q
	 6/Jf+sV0CxOLA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, "Deucher,
	Alexander" <Alexander.Deucher@amd.com>,
	Timo Witte <timo.witte@gmail.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Lendacky,
	Thomas" <Thomas.Lendacky@amd.com>, "Hegde,
	Vasant" <Vasant.Hegde@amd.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
 regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit
 8277a12d0d60)
In-Reply-To: <f48c2a3f-38c8-44ab-8352-35ee1874b420@samsung.com>
References: <CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com>
 <yq5ao6egyn5j.fsf@kernel.org>
 <CGME20260902182632eucas1p2d0caf5a54243c630ecbd4844cc278a0d@eucas1p2.samsung.com>
 <BN9PR12MB5146EB49E0988618FBC13515F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
 <f48c2a3f-38c8-44ab-8352-35ee1874b420@samsung.com>
Date: Mon, 07 Sep 2026 19:25:20 +0530
Message-ID: <yq5abja9p3nb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 02.09.2026 20:26, Deucher, Alexander wrote:
>>> -----Original Message-----
>>> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>>> Sent: Wednesday, September 2, 2026 6:16 AM
>>> To: Timo Witte <timo.witte@gmail.com>; iommu@lists.linux.dev
>>> Cc: m.szyprowski@samsung.com; robin.murphy@arm.com;
>>> joro@8bytes.org; Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
>>> regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs
>>> (commit 8277a12d0d60)
>>>
>>> Timo Witte <timo.witte@gmail.com> writes:
>>>
>>>> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and
>>>> select them via attrs") added to iommu_dma_alloc():
>>>>
>>>>     /* Not yet supported */
>>>>     if (is_alloc_cc_shared)
>>>>         return NULL;
>>>>
>>>> dma_alloc_attrs() auto-sets __DMA_ATTR_ALLOC_CC_SHARED whenever
>>>> force_dma_unencrypted() is true. On an SME host (mem_encrypt=on) an
>>>> AMD GPU with a 44-bit DMA mask hits that condition, so every GTT
>>>> (system-RAM) allocation fails with NULL/-ENOMEM, amdgpu init aborts
>>>> and the system boots without a display.
>>>> IOMMU in Translated/DMA-FQ mode (iommu group 29).
>>>>
>>>> Before the mentioned patch it worked: the IOMMU PTE carries the SME
>>>> C-bit, so the memory controller transparently decrypts for the device
>>>> while pages stay encrypted at rest. For IOMMU-backed devices
>>>> force_dma_unencrypted() is a false positive - the device DMA mask does
>>>> not limit addressing once the IOMMU translates, so CC_SHARED should
>>>> not be auto-set for them.
>>>>
>>>
>>> This means that, with host memory encryption, DMA does not need to be
>>> forced unencrypted when the device uses the IOMMU?
>> + Tom and Vasant.
>>
>> Yes, otherwise most devices won't be able to work with encrypted memory since most devices don't support a DMA mask large enough to cover the C bit.
>
> Is this the proper fix/workaround for v7.3-rc? If so, then Aneesh, please
> send it as a complete patch so I will take it to the dma-mapping-fixes.
>


I am still waiting for testing feedback. I sent a reminder on Friday.

-aneesh
