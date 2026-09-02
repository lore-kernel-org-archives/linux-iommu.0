Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7B42379A
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343150; cv=none; b=ghiuSXOdhi53FrLb9p4QoUVc8+v2kFu6rHy73BxX71valCtfq8bB0c4FB36XeAtlkrqmOr/Mpt1jqSCRUC/gHd+LYbywIPOUVgsf+2Nm9YOUg/0DdzNclqM1KGmH0s7J5xt6l0D0qr6l9U+KaS/jKcQuTZDVN/F4wXLGobVSQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343150; c=relaxed/simple;
	bh=J85HAMAqNi17n39O03dkp3947FIlh+7wEj67sZU4iKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tflqsciaeMyyaHjWhMs9OzeVwc5qOD/OdAfRIZ7N0F+ipp5dqIht1js4FUOKUM9Manh5nnk5bQxPU78iJRMtysgcmSCP5Cos+/cFNgAUD4dFHnADtWZefTrkvlJNbNYEfTWIGjzvmgtqssPckXwIlg5+VUDsCeeDdURb3iDjyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2R64CHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2R64CHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142061F000E9;
	Wed,  2 Sep 2026 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788343148;
	bh=IUEw1FOd8zcMeMpMJbYNkq7JQANmfKBQ20pgpZdmY5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=D2R64CHsB+0/08hnvlPkgoAWppFuLcRNOrghJhxEz83smpvAnU3DGYS5I9nKEmbk5
	 7K2TlnjTDQq1pwG7rSRp0QwCj3WH3iyCeSDKNU6MYmYaGBpcYKMga4x1dkwwMIe+n5
	 xhvKH4Id7UCMT265e7BlO9RvqY4J1zIL4VQ/bez9Y39QEkpHTxFA5zt85mmTSreASW
	 HibUdnIFxHo8kOdWKm7YfCl8SDV944U5P0bBlmeH2/kMkU62+G6jUw/eXllwhIbeci
	 8zn2Ab69n4NHPS/dWq1b63wjAgnlx4Zt7IFRKI0M5YL6bURTi1mHY7XM02rdvfTJJi
	 rT0QM0SBMEaNQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Timo Witte <timo.witte@gmail.com>, iommu@lists.linux.dev
Cc: m.szyprowski@samsung.com,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, joro@8bytes.org,
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>
Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
 regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit
 8277a12d0d60)
In-Reply-To: <CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com>
References: <CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com>
Date: Wed, 02 Sep 2026 15:29:04 +0530
Message-ID: <yq5aqzjcynx3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Timo Witte <timo.witte@gmail.com> writes:

> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
> them via attrs") added to iommu_dma_alloc():
>
>     /* Not yet supported */
>     if (is_alloc_cc_shared)
>         return NULL;
>


Is this the only hunk you had to remove?

>
> dma_alloc_attrs() auto-sets __DMA_ATTR_ALLOC_CC_SHARED whenever
> force_dma_unencrypted() is true. On an SME host (mem_encrypt=on) an AMD
> GPU with a 44-bit DMA mask hits that condition, so every GTT (system-RAM)
> allocation fails with NULL/-ENOMEM, amdgpu init aborts and the system
> boots without a display.
> IOMMU in Translated/DMA-FQ mode (iommu group 29).
>
> Before the mentioned patch it worked: the IOMMU PTE carries the SME C-bit,
> so the memory controller transparently decrypts for the device while pages
> stay
> encrypted at rest. For IOMMU-backed devices force_dma_unencrypted() is a
> false positive - the device DMA mask does not limit addressing once the
> IOMMU translates, so CC_SHARED should not be auto-set for them.
>
> When i remove the rejection and clear __DMA_ATTR_ALLOC_CC_SHARED
> in iommu_dma_alloc(), so encrypted pages are mapped with the C-bit and
> everything works again.
>
> Maybe we can implement real CC_SHARED support in the IOMMU path,
> so SEV + IOMMU works on x86?
>

Yes, this should be fixed in the IOMMU path.

>
> I already reported this in the amdgpu driver:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5735
> But i think it should be fixed in the iommu code as it's a regression.

-aneesh
