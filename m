From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 20/21] arm64: switch copyright boilerplace to SPDX in
 dma-mapping.c
Date: Mon, 1 Apr 2019 10:39:18 +0100
Message-ID: <caa88042-6338-43c1-960c-293a617ea194@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-21-hch@lst.de>
 <872c92d0-53cd-a5e1-13ee-f2f715d017b4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <872c92d0-53cd-a5e1-13ee-f2f715d017b4@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Mukesh Ojha <mojha@codeaurora.org>, Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 01/04/2019 07:28, Mukesh Ojha wrote:
> 
> On 3/27/2019 1:34 PM, Christoph Hellwig wrote:
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Acked-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   arch/arm64/mm/dma-mapping.c | 15 +--------------
>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index bf49e982c978..ad46594b3799 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -1,20 +1,7 @@
>> +// SPDX-License-Identifier: GPL-2.0
> /* SPDX-License-Identifier: GPL-2.0   */
> 
> 
> Can we do this way as discussed in
> https://lkml.org/lkml/2019/2/13/570

But this isn't a header file... :/

Robin.

[FYI Christoph, this series is now at the top of my review pile and I 
promise I'll get it done by the end of this week :)]

> Once you fix it you can take mine review in all your this kind of patches.
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> 
> Cheers,
> Mukesh
> 
>>   /*
>> - * SWIOTLB-based DMA API implementation
>> - *
>>    * Copyright (C) 2012 ARM Ltd.
>>    * Author: Catalin Marinas <catalin.marinas@arm.com>
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>>   #include <linux/gfp.h>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
