From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Tue, 10 Mar 2015 02:00:44 +0900
Message-ID: <CAAFQd5DpXxyoNiTGC4YYnpXeKo43XXrC+my6KWOV1pGq1jw6Aw@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5AhTe=d9tXN8kaRah_GiZYYxG0cD0up=cbHkSfbBnXmvQ@mail.gmail.com>
	<1425912389.4871.19.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425912389.4871.19.camel@mtksdaap41>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 9, 2015 at 11:46 PM, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> On Mon, 2015-03-09 at 20:11 +0900, Tomasz Figa wrote:
> <...>
>> > +/*
>> > + * pimudev is a global var for dma_alloc_coherent.
>> > + * It is not accepatable, we will delete it if "domain_alloc" is enabled
>> > + */
>> > +static struct device *pimudev;
>>
>> This is indeed not acceptable. Could you replace dma_alloc_coherent()
>> with something that doesn't require device pointer, e.g.
>> alloc_pages()? (Although that would require you to handle cache
>> maintenance in the driver, due to cached memory allocated.) I need to
>> think about a better solution for this.
>
> Hi,
>
> For 2nd level page table, we use cached memory now. Currently we are
> using __dma_flush_range to flush the cache, which is also unacceptable.
>
> For proper cache management, we'll need to use dma_map_single or
> dma_sync_*, which still need a deivce*.

Looking at how already mainlined drivers do this, they either use
dmac_flush_range()
(https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/msm_iommu.c?id=refs/tags/v4.0-rc3#n80)
or directly __cpuc_flush_dcache_area() and outer_flush_range()
(https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/rockchip-iommu.c?id=refs/tags/v4.0-rc3#n93).

Joerg, what's your opinion on this?

Best regards,
Tomasz
