From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 3/3] Fix compile error in drivers/gpu/drm/msm/msm_drv.c
 with IOMMU disabled
Date: Fri, 27 Sep 2013 11:28:36 -0400
Message-ID: <CAF6AEGsf3eM1pXhgWeiV8kJOQyvhRSmp7RkETRgBWSzBPEwjGQ@mail.gmail.com>
References: <1380120582-9068-1-git-send-email-joro@8bytes.org>
	<1380120582-9068-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380120582-9068-3-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 25, 2013 at 10:49 AM, Joerg Roedel <joro@8bytes.org> wrote:
> The function msm_iommu_get_ctx() is needed buy the MSM-GPU
> driver with and wiithout IOMMU compiled in. Make the
> function available when no IOMMU driver is there.
>

For this one,

Reviewed-by: Rob Clark <robdclark@gmail.com>

But I am not the right one to merge this one.  And, well, if there is
a way to make this work without msm_iommu_get_ctx(), I am interested
in some hints ;-)

Of the other two, 1/3 looks fine and I'll pull that in.  And I'll see
if I can come up with a better way for 2/3

BR,
-R

> Signed-off-by: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/msm_iommu.h |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iommu/msm_iommu.h b/drivers/iommu/msm_iommu.h
> index 5c7c955..da53558 100644
> --- a/drivers/iommu/msm_iommu.h
> +++ b/drivers/iommu/msm_iommu.h
> @@ -108,7 +108,14 @@ struct msm_iommu_ctx_drvdata {
>   * Useful for testing and drivers that do not yet fully have IOMMU stuff in
>   * their platform devices.
>   */
> +#ifdef CONFIG_MSM_IOMMU
>  struct device *msm_iommu_get_ctx(const char *ctx_name);
> +#else
> +static inline struct device *msm_iommu_get_ctx(const char *ctx_name)
> +{
> +       return NULL;
> +}
> +#endif
>
>  /*
>   * Interrupt handler for the IOMMU context fault interrupt. Hooking the
> --
> 1.7.9.5
>
>
