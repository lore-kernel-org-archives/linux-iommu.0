From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Date: Wed, 18 Jul 2018 14:55:59 -0700
Message-ID: <ac14e13b-82fb-c623-6dcb-4c944120eb24@infradead.org>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de> <20180715122826.GB2342@localhost.localdomain>
 <20180717145725.GA22109@lst.de> <20180717163330.GE2342@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717163330.GE2342@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fredrik Noring <noring@nocrew.org>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, JuergenUrban@gmx.de
List-Id: iommu@lists.linux-foundation.org

Hi,

On 07/17/2018 09:33 AM, Fredrik Noring wrote:
>>> Here are three other regressions related to the coherent mask WARN_ON_ONCE:
>>
>> They are a pretty strong indication that yes, you should really set
>> the coherent mask if you ever do coherent allocations..
> 
> I'm unfortunately unfamiliar with the USB drivers for the PS3. Geoff, what
> do you think about setting a coherent mask?

I guess we need to add a dma_set_coherent_mask() call in the driver
probe routines.  I'll send out a patch.

-Geoff
