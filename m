From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] vfio: Allow No-IOMMU mode without checking
	iommu_present()
Date: Mon, 24 Jul 2017 11:24:06 -0600
Message-ID: <20170724112406.42b69c8b@w520.home>
References: <1500525154-5200-1-git-send-email-anup.patel@broadcom.com>
	<1500525154-5200-2-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1500525154-5200-2-git-send-email-anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 20 Jul 2017 10:02:33 +0530
Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:

> Not allowing No-IOMMU mode for devices already having
> iommu_ops on their bus is very conservative.
> 
> We now have IOMMU (such as ARM SMMU) which can bypass
> transcations when IOMMU is not configured for a given
> device. In addition, it is not necessary to have all
> devices on bus to be upstream to an IOMMU on that bus.
> 
> Due above reasons, having iommu_present() check for
> VFIO No-IOMMU mode is not appropriate.
> 
> Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/vfio/vfio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 330d505..9d90de7 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -124,11 +124,10 @@ struct iommu_group *vfio_iommu_group_get(struct device *dev)
>  #ifdef CONFIG_VFIO_NOIOMMU
>  	/*
>  	 * With noiommu enabled, an IOMMU group will be created for a device
> -	 * that doesn't already have one and doesn't have an iommu_ops on their
> -	 * bus.  We set iommudata simply to be able to identify these groups
> -	 * as special use and for reclamation later.
> +	 * that doesn't already have one.  We set iommudata simply to be able
> +	 * to identify these groups as special use and for reclamation later.
>  	 */
> -	if (group || !noiommu || iommu_present(dev->bus))
> +	if (group || !noiommu)
>  		return group;
>  
>  	group = iommu_group_alloc();

Nak, no-iommu is intentionally conservative.  How do we tell the
difference between the iommu_ops available to us with a fake group vs
a proper group created by the iommu if we ignore iommu_present()?  If
an iommu exists, use it.  Thanks,

Alex
