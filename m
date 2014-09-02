From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC PATCH 1/7] iommu: provide early initialisation hook for
	IOMMU drivers
Date: Tue, 2 Sep 2014 14:47:54 +0000
Message-ID: <04b313674bc14231a47570f91336c6e6@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409327670-3495-2-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Friday, August 29, 2014 9:24 PM
> To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: arnd-r2nGTMty4D4@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org;
> hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; Sethi Varun-B16395; thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org; Will Deacon
> Subject: [RFC PATCH 1/7] iommu: provide early initialisation hook for IOMMU
> drivers
> 
> IOMMU drivers must be initialised before any of their upstream devices,
> otherwise the relevant iommu_ops won't be configured for the bus in
> question. To solve this, a number of IOMMU drivers use initcalls to
> initialise the driver before anything has a chance to be probed.
> 
> Whilst this solves the immediate problem, it leaves the job of probing
> the IOMMU completely separate from the iommu_ops to configure the
> IOMMU,
> which are called on a per-bus basis and require the driver to figure out
> exactly which instance of the IOMMU is being requested. In particular,
> the add_device callback simply passes a struct device to the driver,
> which then has to parse firmware tables or probe buses to identify the
> relevant IOMMU instance.
> 
> This patch takes the first step in addressing this problem by adding an
> early initialisation pass for IOMMU drivers, giving them the ability to
> set some per-instance data on their of_node. This data can then be
> passed back to a new add_device function (added in a later patch) to
> identify the IOMMU instance in question.
> 
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/of_iommu.c          | 14 ++++++++++++++
>  include/asm-generic/vmlinux.lds.h |  2 ++
>  include/linux/of_iommu.h          | 21 +++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e550ccb7634e..f9209666157c 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -89,3 +89,17 @@ int of_get_dma_window(struct device_node *dn, const
> char *prefix, int index,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_get_dma_window);
> +
> +void __init of_iommu_init(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *match, *matches = &__iommu_of_table;
> +
> +	for_each_matching_node_and_match(np, matches, &match) {
> +		const int (*init_fn)(struct device_node *) = match->data;

Is the init function also responsible for setting iommu_ops (per bus)? We need to take in to consideration that iommu API (iommu.c) initialization happens during  "arch_init". When we setup bus iommu ops add_device would be called for devices which have already been probed. Also, as I can see from the code we have of_platform_populate which gets called right after of_iommu_init, which would in turn also lead to add_device invocation (after add_device_master_ids). I believe this would happen before iommu API initialization which would cause issues.

-Varun
