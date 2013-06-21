From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC 0/3] How to pass IOMMU map attr via DMA API?
Date: Fri, 21 Jun 2013 09:17:59 +0200
Message-ID: <51C3FE27.5070702@samsung.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1371707384-30037-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 6/20/2013 7:49 AM, Hiroshi Doyu wrote:
> In Tegra SoC, IOMMU can set some mapping attribute for each page, for
> exmaple, READable, and WRITEable. We'd like to use this feature
> *newly* for robustness, where read-only pages can be protected from
> being overwritten by wrong operation. We have been using IOMMU via DMA
> mapping API(ARM). DMA mapping API currently doesn't use "prot"
> parameter when calling IOMMU API. So this series tries to pass "struct
> dma_attrs *attrs" via "int prot" in IOMMU API. I'm not so sure if this
> implementation is right or not because:
>
> - Casting (struct dma_attrs *) to (int) in DMA API doesn't look nice.
> - IOMMU layer needs to cast (int) back to (struct dma_attrs *) again,
>    which can be considered as violation of layers.
>
> If you have any implementations/suggestions, it would be really helpful.
>
> This series isn't applied cleanly but this is posted to request for
> comments.

Using DMA attributes for this seems to be a bad idea. The dma direction
parameter is much more appropriate. Will Deacon recently posted a patch
which does it right, see:

https://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=commit;h=8fc3749bd31d139db58f874e093255fe62505968


> Hiroshi Doyu (3):
>    common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
>    ARM: dma-mapping: Pass DMA attrs as IOMMU prot
>    iommu/tegra: smmu: Support read-only mapping
>
>   arch/arm/mm/dma-mapping.c  | 34 +++++++++++++++++++++-------------
>   drivers/iommu/tegra-smmu.c | 41 +++++++++++++++++++++++++++++------------
>   include/linux/dma-attrs.h  |  1 +
>   3 files changed, 51 insertions(+), 25 deletions(-)
>

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
