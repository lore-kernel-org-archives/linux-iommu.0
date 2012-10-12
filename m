From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH -stable] amd_iommu: attach device fails on the last pci
	device
Date: Fri, 12 Oct 2012 11:28:38 -0600
Message-ID: <1350062918.2112.53.camel@bling.home>
References: <1350059367.2643.17.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1350059367.2643.17.camel@lorien2>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: shuah.khan-VXdhtT5mjnY@public.gmane.org
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2012-10-12 at 10:29 -0600, Shuah Khan wrote:
> amd_iommu_attach_device() checks if device id is within the limits
> of amd_iommu_last_bdf and instead checking if devid > amd_iommu_last_bdf,
> it checks devid >= amd_iommu_last_bdf. As a result the last device attach
> fails because amd_iommu_attach_device() returns an -EINVAL.
> 
> This bug is in linux-2.6.32 and an equivalent fix in linux-2.6.33 and has been
> carried forward to later kernels and is in the upstream kernel. This equivalent
> fix includes restructuring and consolidating device checks into a routine
> check_device(). Instead of back-porting all of that work, spot-fixed the bug in
> amd_iommu_attach_device() for linux-2.6.32.
> 
> Signed-off-by: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
> CC: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> v2.6.32
> ---
>  arch/x86/kernel/amd_iommu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/amd_iommu.c b/arch/x86/kernel/amd_iommu.c
> index 3a44b75..67de7d7 100644
> --- a/arch/x86/kernel/amd_iommu.c
> +++ b/arch/x86/kernel/amd_iommu.c
> @@ -2288,7 +2288,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
>  
>  	devid = calc_devid(pdev->bus->number, pdev->devfn);
>  
> -	if (devid >= amd_iommu_last_bdf ||
> +	if (devid > amd_iommu_last_bdf ||
>  			devid != amd_iommu_alias_table[devid])
>  		return -EINVAL;
>  

Looks correct to me, this case was clearly inconsistent with other users
of amd_iommu_last_bdf.

Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
