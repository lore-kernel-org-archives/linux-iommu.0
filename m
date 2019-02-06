From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Date: Wed, 6 Feb 2019 08:37:17 +0100
Message-ID: <0c7e53b3-c9b8-aa57-0317-dcf7ff522721@samsung.com>
References: <20190205110602.27717-1-thierry.reding@gmail.com>
        <20190205161036.GA782@lst.de> <20190205162057.GA29974@ulmo>
        <20190205163837.GA1222@lst.de> <20190205175611.GA7052@ulmo>
        <20190205180218.GB2882@lst.de>
        <CGME20190205223004epcas1p43c4cc25c1dff610859ee1b1c9fa81f8e@epcas1p4.samsung.com>
        <20190205222912.GC1372@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205222912.GC1372@mithrandir>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On 2019-02-05 23:29, Thierry Reding wrote:
> On Tue, Feb 05, 2019 at 07:02:18PM +0100, Christoph Hellwig wrote:
>> On Tue, Feb 05, 2019 at 06:56:11PM +0100, Thierry Reding wrote:
>>> Sure, here you go:
>>>
>>> 	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/host1x/cdma.c#n106
>> Yes, I think we I can come up with a nicer helper for that.
> One thing I could also try is to remove direct IOMMU API usage at least
> from the host1x driver. I think this might work nowadays.
>
> For Tegra DRM we still need direct IOMMU API usage because we need to be
> able to map into an IOMMU domain without knowing the struct device *
> that we're mapping for (it could be needed by any of up to four display
> controllers). For host1x we always only have one struct device *, so the
> DMA mapping API should be good enough.

In case of Tegra DRM you may try to use Exynos DRM approach. Exynos DRM
also consists of more than one DMA capable device and uses one common
IOMMU address space for them. It is achieved by attaching all those
devices to the IOMMU domain of the first CRTC device that has been
registered. Then that device is used for DMA-mapping calls. It is not
very elegant, but works fine and allows to use standard DMA-mapping calls.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
