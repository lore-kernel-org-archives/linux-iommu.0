Received: from mta1.migadu.com (out-109.mta1.migadu.com [95.215.58.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15642E42E
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445028; cv=none; b=UoRlJ76FXRFMKtpDbXZZtKxJIA7pDfxFIm3b0y7ZaR3IB3htWuTVldzvu1FUxsZB3JdZcwcU1BPvztvTACskgsZYlBO8mRy9oWqH5iX/DLceKMdXbbadzTQszwCSrS51Wtci2hjCgl35N6tbTgL3bduI2ilA5uHgtB4yzAkPZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445028; c=relaxed/simple;
	bh=Au5uJpuNuC+CmcOb4NW2/0yrdQgIbuQKXA4utc/zJs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcWYz6g485kFR8JXq6T6ZqPa6JbeuKGhww88LJWyMyT+fSKzUTmG9sbWw4MMPDvaX7msxcpWhYaXmCcswYCpV2i7q0z1iZzh2cupxn8wf2AxpVI2C7vWuF20wgo/ICCo/uxLyLIDr5/DgBhfdxX9ud8RgNhdAca1pTBymf6R9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mz0Lq6QP; arc=none smtp.client-ip=95.215.58.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mz0Lq6QP"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Au5uJpuNuC+CmcOb4NW2/0yrdQgIbuQKXA4utc/zJs8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791445018; v=1; x=1792049818;
 b=mz0Lq6QPBGKMUw5/V3w7HDftEqNcH+CfYZdXQK0hcrUe6kLHZVUR3YH3IVQkfPRSrWHcwgAu
 sggT7YY4n44/A+1m69Vfs6dtiyBSt2IGB9QpC7OGG/Si5+BB+dwOiCcwurdgAg4iJoFshox0bPr
 nIh1ZKDtueA6Ge7HLPJGuGK0=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id 4acdf2f0f9884e32;
	Thu, 08 Oct 2026 07:36:57 +0000
X-Mizu-Trace-ID: 4acdf2f0f9884e32
X-Migadu-Flow: FLOW_OUT
Message-ID: <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
Date: Thu, 8 Oct 2026 08:36:54 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation"
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, ahuang12@lenovo.com
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, sunjw10@lenovo.com,
 iommu@lists.linux.dev
References: <20261006120248.147654-1-hch@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261006120248.147654-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 13:02, Christoph Hellwig wrote:
> This turns down to cause up to 15% performance regressions on standard
> large transfer workloads.  Revert it and hope the IOVA allocator can
> eventually be fixed to remove the need for the original workaround.
> 
> This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.
> 

What was the block size and conditions for the original issue? The 
commit just mentions that mdts=10 and we get a 4096KB max HW sectors.

I can't find the original thread.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5440cf18b55b..82e308fe4f4c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3747,7 +3747,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>   	 */
>   	dev->ctrl.max_hw_sectors = min_t(u32,
>   			NVME_MAX_BYTES >> SECTOR_SHIFT,
> -			dma_opt_mapping_size(&pdev->dev) >> 9);
> +			dma_max_mapping_size(&pdev->dev) >> 9);
>   	dev->ctrl.max_segments = NVME_MAX_SEGS;
>   	dev->ctrl.max_integrity_segments = 1;
>   	return dev;

