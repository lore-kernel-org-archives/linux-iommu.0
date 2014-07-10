From: Khiem Nguyen <khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 01/10] iommu/ipmmu-vmsa: Refactor micro-TLB lookup
Date: Thu, 10 Jul 2014 09:03:26 +0900
Message-ID: <53BDD84E.4090206@renesas.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1400150451-13469-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1400150451-13469-2-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 5/15/2014 7:40 PM, Laurent Pinchart wrote:
> Cache the micro-TLB number in archdata allocated in the .add_device
> handler instead of looking it up when the deviced is attached and
> detached. This simplifies the .attach_dev and .detach_dev operations and
> prepares for DT support.
[snip]
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
[snip]
> +static int ipmmu_find_utlb(struct ipmmu_vmsa_device *mmu, struct device *dev)
> +{
> +	const struct ipmmu_vmsa_master *master = mmu->pdata->masters;
> +	const char *devname = dev_name(dev);
> +	unsigned int i;
> +
> +	for (i = 0; i < mmu->pdata->num_masters; ++i, ++master) {
> +		if (strcmp(master->name, devname) == 0)
> +			return master->utlb;
> +	}
> +
> +	return -1;
> +}
[snip]
>  static int ipmmu_add_device(struct device *dev)
[snip]
>  	list_for_each_entry(mmu, &ipmmu_devices, list) {
> -		master = ipmmu_find_master(mmu, dev);
> -		if (master) {
> +		utlb = ipmmu_find_utlb(mmu, dev);
> +		if (utlb >= 0) {
>  			/*
> -			 * TODO Take a reference to the master to protect
> +			 * TODO Take a reference to the MMU to protect
>  			 * against device removal.
>  			 */
>  			break;
[snip]
> +	archdata->mmu = mmu;
> +	archdata->utlb = utlb;
[snip]

I have one question for ipmmu_add_device().

In my understanding, your code will find utlb for device
base on device name.
For any device, it will /only/ return utlb number of first match.

How about the case that a device name connected with more than 1 utlb ?
e.g DU device (rcar-du-r8a7790) in Lager

Was that case already covered in your code ?

Thanks.

Best regards,
KHIEM Nguyen
