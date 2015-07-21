From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Tue, 21 Jul 2015 15:59:10 +0100
Message-ID: <20150721145910.GG31095@arm.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	<1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437037475-9065-6-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel@pen>
List-Id: iommu@lists.linux-foundation.org

Hi Yong Wu,

On Thu, Jul 16, 2015 at 10:04:34AM +0100, Yong Wu wrote:
> This patch adds support for mediatek m4u (MultiMedia Memory Management
> Unit).

[...]

> +static void mtk_iommu_tlb_flush_all(void *cookie)
> +{
> +       struct mtk_iommu_domain *domain = cookie;
> +       void __iomem *base;
> +
> +       base = domain->data->base;
> +       writel(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> +       writel(F_ALL_INVLD, base + REG_MMU_INVALIDATE);

This needs to be synchronous, so you probably want to call
mtk_iommu_tlb_sync at the end.

> +}
> +
> +static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> +                                   bool leaf, void *cookie)
> +{
> +       struct mtk_iommu_domain *domain = cookie;
> +       void __iomem *base = domain->data->base;
> +       unsigned int iova_start = iova, iova_end = iova + size - 1;
> +
> +       writel(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> +
> +       writel(iova_start, base + REG_MMU_INVLD_START_A);
> +       writel(iova_end, base + REG_MMU_INVLD_END_A);
> +       writel(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);

Why are you using writel instead of writel_relaxed? I asked this before
but I don't think you replied.

Will
