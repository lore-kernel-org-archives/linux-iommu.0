From: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] iommu/exynos: remove dead code (set_prefbuf)
Date: Mon, 5 Aug 2013 09:39:45 -0700
Message-ID: <CANEJEGu2B9FUDLn5EOPm1hOau1Y+s6rFZy3WVFQCO=3T6acgmg@mail.gmail.com>
References: <1372781307-7906-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1372781307-7906-1-git-send-email-grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Ping?

Adding linux-iommu ML.

thanks,
grant

On Tue, Jul 2, 2013 at 9:08 AM, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> exynos_sysmmu_set_prefbuf() is not called any where.
>
> Signed-off-by: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c | 44 --------------------------------------------
>  1 file changed, 44 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 3f32d64..0740189 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -247,50 +247,6 @@ static void __sysmmu_set_prefbuf(void __iomem *sfrbase, unsigned long base,
>         __raw_writel(size - 1 + base,  sfrbase + REG_PB0_EADDR + idx * 8);
>  }
>
> -void exynos_sysmmu_set_prefbuf(struct device *dev,
> -                               unsigned long base0, unsigned long size0,
> -                               unsigned long base1, unsigned long size1)
> -{
> -       struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
> -       unsigned long flags;
> -       int i;
> -
> -       BUG_ON((base0 + size0) <= base0);
> -       BUG_ON((size1 > 0) && ((base1 + size1) <= base1));
> -
> -       read_lock_irqsave(&data->lock, flags);
> -       if (!is_sysmmu_active(data))
> -               goto finish;
> -
> -       for (i = 0; i < data->nsfrs; i++) {
> -               if ((readl(data->sfrbases[i] + REG_MMU_VERSION) >> 28) == 3) {
> -                       if (!sysmmu_block(data->sfrbases[i]))
> -                               continue;
> -
> -                       if (size1 == 0) {
> -                               if (size0 <= SZ_128K) {
> -                                       base1 = base0;
> -                                       size1 = size0;
> -                               } else {
> -                                       size1 = size0 -
> -                                               ALIGN(size0 / 2, SZ_64K);
> -                                       size0 = size0 - size1;
> -                                       base1 = base0 + size0;
> -                               }
> -                       }
> -
> -                       __sysmmu_set_prefbuf(
> -                                       data->sfrbases[i], base0, size0, 0);
> -                       __sysmmu_set_prefbuf(
> -                                       data->sfrbases[i], base1, size1, 1);
> -
> -                       sysmmu_unblock(data->sfrbases[i]);
> -               }
> -       }
> -finish:
> -       read_unlock_irqrestore(&data->lock, flags);
> -}
> -
>  static void __set_fault_handler(struct sysmmu_drvdata *data,
>                                         sysmmu_fault_handler_t handler)
>  {
> --
> 1.8.3
>
