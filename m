From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Mon, 9 Mar 2015 20:16:26 +0800
Message-ID: <1425903386.13300.33.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
	<vnkwwq2unj2y.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <vnkwwq2unj2y.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Dear Mitchel,
     Thanks very much for your review.

On Fri, 2015-03-06 at 09:15 -0800, Mitchel Humpherys wrote:
> On Fri, Mar 06 2015 at 02:48:17 AM, <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >
> > This patch adds support for mediatek m4u (MultiMedia Memory Management Unit).
> > Currently this only supports m4u gen 2 with 2 levels of page table on mt8173.
> 
> [...]
> 
> > +static int mtk_iommu_invalidate_tlb(const struct mtk_iommu_info *piommu,
> > +				    int isinvall, unsigned int iova_start,
> > +				    unsigned int iova_end)
> > +{
> > +	void __iomem *m4u_base = piommu->m4u_base;
> > +	u32 val;
> > +	u64 start, end;
> > +
> > +	start = sched_clock();
> > +
> > +	if (!isinvall) {
> > +		iova_start = round_down(iova_start, SZ_4K);
> > +		iova_end = round_up(iova_end, SZ_4K);
> > +	}
> > +
> > +	val = F_MMU_INV_EN_L2 | F_MMU_INV_EN_L1;
> > +
> > +	writel(val, m4u_base + REG_INVLID_SEL);
> > +
> > +	if (isinvall) {
> > +		writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);
> > +	} else {
> > +		writel(iova_start, m4u_base + REG_MMU_INVLD_SA);
> > +		writel(iova_end, m4u_base + REG_MMU_INVLD_EA);
> > +		writel(F_MMU_INV_RANGE, m4u_base + REG_MMU_INVLD);
> > +
> > +		while (!readl(m4u_base + REG_MMU_CPE_DONE)) {
> > +			end = sched_clock();
> > +			if (end - start >= 100000000ULL) {
> > +				dev_warn(piommu->dev, "invalid don't done\n");
> > +				writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);
> > +			}
> > +		};
> 
> Superfluous `;'.  Also, maybe you should be using readl_poll_timeout?
   Thanks.
   For the "readl_poll_timeout", My base is 3.19-rc7 and robin's patch.
it don't have this interface.  I will try to add it in the next version.
> 
> > +		writel(0, m4u_base + REG_MMU_CPE_DONE);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> 
> 
> -Mitch
> 
