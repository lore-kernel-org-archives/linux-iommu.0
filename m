From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 18/19] arm64: switch copyright boilerplace to SPDX in
 dma-mapping.c
Date: Wed, 6 Feb 2019 12:19:10 +0000
Message-ID: <36d02302-8525-e538-1d9d-3adcc08a01ea@arm.com>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-19-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114094159.27326-19-hch@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Robin Murphy <robin.murphy@arm.com>

> ---
>   arch/arm64/mm/dma-mapping.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index fffba9426ee4..bdfb4e985a69 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -1,20 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
> - * SWIOTLB-based DMA API implementation
> - *
>    * Copyright (C) 2012 ARM Ltd.
>    * Author: Catalin Marinas <catalin.marinas@arm.com>
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
>   #include <linux/gfp.h>
> 
