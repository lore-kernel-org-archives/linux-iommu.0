From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFT] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Wed, 16 Mar 2016 09:02:43 +0200
Message-ID: <CAFCwf13RT9VyzhJ4AhAGd1ndd8f=Cd0TRnnRcDwBGHbOzyc5BQ@mail.gmail.com>
References: <1458079926-18716-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1458079926-18716-1-git-send-email-mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 16, 2016 at 12:12 AM, Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> We need to ensure amd iommu v2 initializes before
> driver uses such as drivers/gpu/drm/amd/amdkfd/kfd_module.c,
> to do this make its init routine a subsys_initcall() which
> ensures its load init is called first than modules when
> built-in.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>
> Can someone test if this patch enables both CONFIG_AMD_IOMMU_V2 and
> CONFIG_HSA_AMD to be =y (built-in) without any conflicts ?
>
>  drivers/iommu/amd_iommu_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
> index 56999d2fac07..60df645b9927 100644
> --- a/drivers/iommu/amd_iommu_v2.c
> +++ b/drivers/iommu/amd_iommu_v2.c
> @@ -1004,5 +1004,5 @@ static void __exit amd_iommu_v2_exit(void)
>         destroy_workqueue(iommu_wq);
>  }
>
> -module_init(amd_iommu_v2_init);
> +subsys_initcall(amd_iommu_v2_init);
>  module_exit(amd_iommu_v2_exit);
> --
> 2.7.2
>

fwiw, we currently have this covered by the ugly hack of putting iommu
subsystem in front of gpu subsystem in the main drivers makefile (See
1bacc894c227fad8a727eb99728df708eba57654)

Oded
