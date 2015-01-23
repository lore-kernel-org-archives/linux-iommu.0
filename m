From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4 18/18] iommu: exynos: add callback for initializing
 devices from device tree
Date: Fri, 23 Jan 2015 14:48:56 +0100
Message-ID: <CABxcv=nX22+1VcA038yyLJz7dUN-tk9-kWTpSB-FeyLxVeRmZA@mail.gmail.com>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
	<1421399592-7482-19-git-send-email-m.szyprowski@samsung.com>
	<CABxcv=nkcY0biXuDH1BHDdOZhrzYWr-YNP13QWzdLfZfQrxouA@mail.gmail.com>
	<54C2415A.3020508@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54C2415A.3020508@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello Marek,

On Fri, Jan 23, 2015 at 1:40 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>>> +
>>> +       list_add_tail(&data->owner_node, &owner->clients);
>>
>> This is the line that causes the kernel to hang, if I comment the
>> list_add_tail() call then the kernel boots.
>>
>> I checked that neither data nor owner are NULL and that the
>> owner->clients list_head is initialized. Do you have any ideas what
>> could be happening?
>
>
> This is really strange. However the hang is definitely not caused by
> adding the controller to the list, but rather the fact that it is later
> being initialized, probably in exynos_iommu_attach_device().
>

Yes, I knew adding to the list was not the issue but a side effect of
being in the list. I'm not familiar with Exynos sysmmu/iommu to figure
out though.

> Just a quick question - does bootloader on Exynos5420 Peach Pit sets
> any image on the display?
>

Yes u-boot does initialize the display, I see the boot messages and
have an u-boot prompt.

> If so then we will get IOMMU page fault on init (DMA engine of FIMD is
> left enabled from bootloader) and such case is not yet handled.
> Besides that I have no idea for any other reason for such failure.
>

I see, that's a reasonable explanation and in fact your patch makes at
least the kernel to start booting.

> To check if this is caused by io page fault, please temporarily add the
> following hack:
> --->8---
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 7864797609b3..5e70cf7eb31b 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2011,6 +2011,9 @@ static bool arm_setup_iommu_dma_ops(struct device
> *dev, u64 dma_base, u64 size,
>          return false;
>      }
>
> +    iommu_map(mapping->domain, 0x40000000, 0x40000000, 0x80000000,
> +          IOMMU_READ | IOMMU_WRITE);
> +
>      if (arm_iommu_attach_device(dev, mapping)) {

The kernel still hangs but the boot does indeed go further. Here is my
boot log [0] although I couldn't find an evident cause.

Best regards,
Javier

[0]: http://paste.debian.net/plain/141968
