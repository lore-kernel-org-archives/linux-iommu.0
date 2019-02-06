From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 17/19] dma-iommu: switch copyright boilerplace to SPDX
Date: Wed, 6 Feb 2019 11:57:44 +0000
Message-ID: <de98a953-954e-cefc-4a0d-91cdedcc16e6@arm.com>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-18-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114094159.27326-18-hch@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Robin Murphy <robin.murphy@arm.com>

> ---
>   drivers/iommu/dma-iommu.c | 13 +------------
>   include/linux/dma-iommu.h | 13 +------------
>   2 files changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e27909771d55..1b76121df94e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * A fairly generic DMA-API to IOMMU-API glue layer.
>    *
> @@ -5,18 +6,6 @@
>    *
>    * based in part on arch/arm/mm/dma-mapping.c:
>    * Copyright (C) 2000-2004 Russell King
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
>   #include <linux/acpi_iort.h>
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 5277aa8782bf..bfe9f19b1171 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -1,17 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * Copyright (C) 2014-2015 ARM Ltd.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   #ifndef __DMA_IOMMU_H
>   #define __DMA_IOMMU_H
> 
