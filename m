Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502287;
	b=zvMSGxzJB+iJTcRn/hVnCMpDqa3vMJ2wR3Kop8tJ+buSURR9UiIyvzQHXXwmkMHQiFRb
	 MHc7NegsnxSxJ8hW8LwRr5Xf88azyf5nxbvWPVZspv1tKucPFyhmBZN3Vf5nzcn7n69fd
	 DKmvTmcx0wwpT5CggsTALQWoo5cxUnPxapy33Tj+ZqpLne5OsMzWHCRQxAaZjfmaay1Rn
	 T0BmQLIEka0v8/2cFfcN7EQELdgs5su332SzHZb7NR4gu2KxKbRnnkRjkx6Y1tF/L+9iJ
	 4pEDk2RpuPR3uVRoLvZ9iBtaUZ1EPxAfNJ68ZjGm8tn5/dSkAsDntiXGNzvCdjQv7YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502287;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YSV4wnE5JrNZpfy9DXizyOVofgXc49f/P/CmYGZXquc=;
	b=ghX/5rThA4KoyMhjJRtVRX8ImxUcGYlaLrP3qvWCIsiRIWhKYfwqSrI5te6QJYjpzwGk
	 YutxxAHtsO6rM6GobzmEOQECIX+coODchjUceRoL+zg0aVMx7MaUN1Hn0MQYLhDGD33MQ
	 RQToaTHVMJtGmcW11++QhcBKb2z13kgQA++ZhhOQR8Ovj1ZvEEb8PYBoqbOW1Qhb4ySxs
	 9AAqHd94kE/BtP2kxvBaB2jcNQ39iNmJNG2seqohFYbVLl53YWNY85ZbTGIMFm81GZkYL
	 sqqctSD+GU0sD5vvwqlPV2q5TAu4O8Hk/MoX8F53BKII3u0JcVYHU24IwshVJpcGR1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lYu5Ew+C;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2EF606A32D
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 16:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2EF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lYu5Ew+C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47485165C;
	Thu, 12 Nov 2026 08:51:23 -0800 (PST)
Received: from [10.57.89.53] (unknown [10.57.89.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 537BC3F673;
	Thu, 12 Nov 2026 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794502286; bh=gziiyQK1BxD/KktmJz3UhiBC7eUPuphRzNgyTLRGPU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lYu5Ew+C7yrCa7RiggELSeaEVOzRU7KJiR4EJu/2oEpURAFtwE8k67E7Izln+GUfX
	 kfxIZHPbjrHc+L9EPzlccgoH6aIkZj9yt8ONOULn5aeisq6g+1hcsKoEubUszevAlR
	 GEyEiV2XFTVYzg5ptf6a6caWz04aM7qR/SD8rT0o=
Message-ID: <43de98e8-a67d-495a-9315-478acfa18d99@arm.com>
Date: Thu, 12 Nov 2026 16:51:23 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>, m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org
References: <20261106184433.761422-1-kuba@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261106184433.761422-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-06 6:44 pm, Jakub Kicinski wrote:
> Hi!
> 
> On NUMA systems networking drivers want to allocate rings
> and buffers close to the NAPI-handling core rather than
> allocating all from where the device is connected.
> 
> Looks like we have accumulated 6 drivers which do:
> 
>         set_dev_node(dma_dev, numa_node);
>         va = dma_alloc_coherent(...);
>         set_dev_node(dma_dev, old_node);
> 
> Introduce dma_alloc_coherent_node() so that such racy
> hacks are no longer necessary.
> 
> Note that making dma_map_ops->alloc() callbacks explicit-node-aware
> is left for future work.
> 
> Stable tag on top of v7.4-rc1, so that we can also pull this into
> the networking tree:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node
> 
> v1:
>   - add the API first, then wire up the node in dma-direct, iommu-dma
>     and CMA (Robin)
>   - add dma_direct_alloc_node() and keep dma_direct_alloc() as a wrapper,
>     swiotlb-xen uses it as its ->alloc (fixes the build on arm/arm64),
>     arch/x86 no longer needs changes
>   - docs: drop the NUMA_NO_NODE suggestion from dma-api.rst (Björn)
>   - docs: document that CMA does not fall back to other nodes' areas (Björn)
>   - docs: document which allocations ignore the node
>   - explain the separate GPL-only export in the commit message (Marek)
> rfc: https://lore.kernel.org/20261027022528.633359-1-kuba@kernel.org
> 
> Jakub Kicinski (11):
>    dma-mapping: add dma_alloc_attrs_node() and dma_alloc_coherent_node()
>    dma-direct: add dma_direct_alloc_node()
>    iommu/dma: pass the NUMA node to iommu_dma_alloc()
>    dma-contiguous: pass the NUMA node to dma_alloc_contiguous()

The API side of things looks OK to me. For the DMA patches at least,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>    eth: libwx: restore the device's NUMA node after ring allocation
>    eth: libwx: use dma_alloc_coherent_node()
>    eth: ixgbe: use dma_alloc_coherent_node()
>    eth: xgbe: use dma_alloc_coherent_node()
>    eth: fungible: use dma_alloc_coherent_node()
>    eth: mlx5: use dma_alloc_coherent_node()
>    eth: mlx4: use dma_alloc_coherent_node()
> 
>   Documentation/core-api/dma-api.rst            | 17 ++++++++
>   include/linux/dma-direct.h                    | 11 ++++-
>   include/linux/dma-map-ops.h                   |  5 ++-
>   include/linux/dma-mapping.h                   | 14 +++++++
>   include/linux/iommu-dma.h                     |  2 +-
>   include/linux/mlx4/device.h                   |  2 +-
>   include/linux/mlx5/driver.h                   |  2 -
>   drivers/iommu/dma-iommu.c                     | 30 ++++++++------
>   drivers/net/ethernet/amd/xgbe/xgbe-desc.c     |  6 +--
>   .../net/ethernet/fungible/funcore/fun_queue.c |  8 ++--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 +++-------
>   drivers/net/ethernet/mellanox/mlx4/alloc.c    | 12 +++---
>   drivers/net/ethernet/mellanox/mlx4/en_cq.c    |  9 +----
>   .../net/ethernet/mellanox/mlx4/en_netdev.c    |  2 +-
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  5 +--
>   drivers/net/ethernet/mellanox/mlx4/en_tx.c    |  5 +--
>   .../net/ethernet/mellanox/mlx5/core/alloc.c   | 24 ++---------
>   .../net/ethernet/mellanox/mlx5/core/main.c    |  4 --
>   drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 22 ++++------
>   kernel/dma/contiguous.c                       | 12 +++---
>   kernel/dma/direct.c                           | 22 +++++-----
>   kernel/dma/mapping.c                          | 40 +++++++++++++++++--
>   kernel/dma/ops_helpers.c                      |  5 ++-
>   23 files changed, 152 insertions(+), 127 deletions(-)
> 

