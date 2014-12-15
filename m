From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/3] xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC
	IOMMU driver.
Date: Mon, 15 Dec 2014 22:29:20 +0100
Message-ID: <6441239.m4vUuhaUcX@wuerfel>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
	<1418662523-8458-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418662523-8458-2-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Monday 15 December 2014 22:25:21 Suman Tripathi wrote:
> +       return 0;
> +}
> +
> +static struct of_device_id xgene_ahbc_mmu_of_match[] = {
> +       { .compatible = "apm,xgene-ahbc-iommu"},
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, xgene_ahbc_mmu_of_match);
> +
> +static struct platform_driver xgene_ahbc_mmu_driver = {
> +       .probe          = xgene_ahbc_mmu_probe,
> +       .remove         = xgene_ahbc_mmu_remove,
> +       .driver = {
> +               .owner  = THIS_MODULE,
> +               .name   = "xgene-ahbc",
> +               .of_match_table = of_match_ptr(xgene_ahbc_mmu_of_match),
> +       },
> +};
> +
> +static int xgene_ahbc_mmu_init(void)
> +{
> +       return platform_driver_register(&xgene_ahbc_mmu_driver);
> +}
> +subsys_initcall(xgene_ahbc_mmu_init);
> +
> +static void __exit xgene_ahbc_mmu_exit(void)
> +{
> +       platform_driver_unregister(&xgene_ahbc_mmu_driver);
> +}
> +module_exit(xgene_ahbc_mmu_exit);
> 

This should use the newly added of_iommu infrastructure that we
added for 3.19. Otherwise you are just duplicating common code.

	Arnd
