From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Date: Tue, 4 Dec 2018 13:36:14 +0000
Message-ID: <2f2a3bb6b0b9473687628f936db71c4f@AcuMS.aculab.com>
References: <20181130214803.3119-1-cai@gmx.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130214803.3119-1-cai@gmx.us>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Qian Cai' <cai@gmx.us>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
Cc: "yisen.zhuang@huawei.com" <yisen.zhuang@huawei.com>, "salil.mehta@huawei.com" <salil.mehta@huawei.com>, "john.garry@huawei.com" <john.garry@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

From: Qian Cai
> Sent: 30 November 2018 21:48
> To: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com
> Cc: yisen.zhuang@huawei.com; salil.mehta@huawei.com; john.garry@huawei.com; linuxarm@huawei.com;
> iommu@lists.linux-foundation.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Qian Cai
> Subject: [PATCH v2] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
> 
> The amount of DMA mappings from Hisilicon HNS ethernet devices is huge,
> so it could trigger "DMA-API: debugging out of memory - disabling".
> 
> hnae_get_handle [1]
>   hnae_init_queue
>     hnae_init_ring
>       hnae_alloc_buffers [2]
>         debug_dma_map_page
>           dma_entry_alloc
> 
> [1] for (i = 0; i < handle->q_num; i++)
> [2] for (i = 0; i < ring->desc_num; i++)
> 
> Also, "#define HNS_DSAF_MAX_DESC_CNT 1024"
> 
> On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
> already,
> 
> 4 (NICs) x 16 (queues) x 1024 (port descption numbers) = 65536
> 
> Added a Kconfig entry for PREALLOC_DMA_DEBUG_ENTRIES, so make it easier
> for users to deal with special cases like this.

Ugg. That is worse than a module parameter.

The driver needs to automatically reduce the number of mapping requests.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
