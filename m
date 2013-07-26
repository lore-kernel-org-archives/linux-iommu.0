From: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v8 12/12] iommu/exynos: return 0 if iommu_attach_device()
	successes
Date: Fri, 26 Jul 2013 10:23:54 -0700
Message-ID: <CANEJEGs_mVetwzT-_hiWie0uc9cZDgEzUXAVYhOu8eeszvGXOQ@mail.gmail.com>
References: <004201ce89f3$9b849a20$d28dce60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <004201ce89f3$9b849a20$d28dce60$@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Keyyoung Park <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 26, 2013 at 4:31 AM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> iommu_attach_device() against exynos-iommu positive integer on success
> if the caller calls iommu_attach_device() with the same iommu_domain
> multiple times without call to iommu_detach_device() to inform the
> caller how many calls to iommu_detach_device() to really detach iommu.
>
> However the convention of the return value of success of common API is
> zero, this patch makes iommu_attach_device() call against exynos-iommu
> always return zero if the given device is successfully attached to
> the given iommu_domain even though it is already attached to the same
> iommu_domain.
>
> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

cheers,
grant

> ---
>  drivers/iommu/exynos-iommu.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 51e5b35..6eed6d6 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -882,15 +882,16 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
>
>         spin_unlock_irqrestore(&priv->lock, flags);
>
> -       if (ret < 0)
> +       if (ret < 0) {
>                 dev_err(dev, "%s: Failed to attach IOMMU with pgtable %#lx\n",
>                                 __func__, __pa(priv->pgtable));
> -       else
> -               dev_dbg(dev, "%s: Attached IOMMU with pgtable 0x%lx%s\n",
> -                                       __func__, __pa(priv->pgtable),
> -                                       (ret == 0) ? "" : ", again");
> +               return ret;
> +       }
>
> -       return ret;
> +       dev_dbg(dev, "%s: Attached IOMMU with pgtable 0x%lx%s\n",
> +               __func__, __pa(priv->pgtable), (ret == 0) ? "" : ", again");
> +
> +       return 0;
>  }
>
>  static void exynos_iommu_detach_device(struct iommu_domain *domain,
> --
> 1.7.2.5
>
>
