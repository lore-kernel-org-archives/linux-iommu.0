Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E3C3F2CD
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 10:07:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC47521741
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 10:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TAzhEew6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC47521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 97D692047E;
	Wed,  4 Mar 2020 10:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9HCU3LK6Xm2O; Wed,  4 Mar 2020 10:07:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C2B322041E;
	Wed,  4 Mar 2020 10:07:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8C30C1AE2;
	Wed,  4 Mar 2020 10:07:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 780C0C013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6729986CB6
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g+K1hcNJpJou for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 10:07:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D5A7D86C66
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T41evhb7stRS8ClLLTGa765XhThIdIDWFHQHc66aD+k=; b=TAzhEew63HzMyUPfvHzcIu3KJ
 dVU8bC2mrmH5Qa4LUkljNs41zk1kK68/XeMX6ybjao3YSSuCFtud5DZ5yL5BfyBzQxqBssoRcgLWu
 xaVlr0tChVcOG/syn/wA/J+4URRduIY36VzxOpFqnrJULiquKz5wkz08hEUvlVay1yKBvdvmDsslJ
 yk86awclyVZOplHRdQVet16uCcFRNXddit3TX6PoGsTeGSZvviL2jk3yihACzVrpNj4awiwCSuRmC
 ZD5hGi+uf4uJrTeGTPgtKe5ELV4R7WzBCNa8Sca3mwxa1MqNUydpsElCkE6b+1XZdr9FV5IReupnX
 iRVBX3XTQ==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60234)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1j9Qvt-0005kj-Cu; Wed, 04 Mar 2020 10:07:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1j9Qvp-0006p8-UX; Wed, 04 Mar 2020 10:07:13 +0000
Date: Wed, 4 Mar 2020 10:07:13 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] iommu: silence iommu group prints
Message-ID: <20200304100713.GZ25745@shell.armlinux.org.uk>
References: <95af8fc3-d7b1-3b58-afc1-d203d7538b95@arm.com>
 <bcb9fbab-2943-3207-b69d-e7ce9e3e3a8e@nxp.com>
 <20200303154959.GR25745@shell.armlinux.org.uk>
 <ac9dc4b1-e3a4-2b69-7c61-d94e082cef30@nxp.com>
 <20200303221745.GV25745@shell.armlinux.org.uk>
 <62b3d48a-af5f-b44b-07cd-83aa7663c45f@nxp.com>
 <20200304093330.GX25745@shell.armlinux.org.uk>
 <78f175be-0701-b6cd-8feb-1343f9982d4c@nxp.com>
 <20200304095112.GY25745@shell.armlinux.org.uk>
 <b9f4e9ad-033f-b5cf-9578-38f8367ef8cd@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9f4e9ad-033f-b5cf-9578-38f8367ef8cd@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Mar 04, 2020 at 11:56:53AM +0200, Laurentiu Tudor wrote:
> From 44ae46501b5379bd0890df87fd3827248626ed03 Mon Sep 17 00:00:00 2001
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Date: Tue, 1 Oct 2019 16:22:48 +0300
> Subject: [PATCH 1/6] bus: fsl-mc: make mc work with smmu disable bypass on
> Content-Type: text/plain; charset="us-ascii"
> 
> Since this commit [1] booting kernel on MC based chips started to
> fail because this firmware starts before the kernel and as soon as
> SMMU is probed it starts to trigger contiguous faults.

I think you mean "continuous" here.

> This is a workaround that allows MC firmware to run with SMMU
> in disable bypass mode. It consists of the following steps:
>  1. pause the firmware at early boot to get a chance to setup SMMU
>  2. request direct mapping for MC device
>  3. resume the firmware
> The workaround relies on the fact that no state is lost when
> pausing / resuming firmware, as per the docs.
> With this patch, platforms with MC firmware can now boot without
> having to change the default config to set:
>   CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=n

This alone is a definite improvement, and has been needed for a while.
Please submit this patch with an appropriate Fixes: tag so stable trees
can pick it up.

> [1] 954a03be033 ("iommu/arm-smmu: Break insecure users by disabling bypass by default")

Please put this where you're referencing it above - it's fine to wrap
the description of the commit when using it in the body of the commit
message.  However, that should _never_ when providing a Fixes: tag
(linux-next has a script which will detect and complain about broken
Fixes: tags.)

Thanks.

> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 53 +++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index a0f8854acb3a..683a6401ffe8 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -18,6 +18,8 @@
>  #include <linux/bitops.h>
>  #include <linux/msi.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iommu.h>
> +#include <linux/io.h>
>  
>  #include "fsl-mc-private.h"
>  
> @@ -889,6 +891,12 @@ static int get_mc_addr_translation_ranges(struct device *dev,
>  	return 0;
>  }
>  
> +#define FSL_MC_GCR1	0x0
> +#define GCR1_P1_STOP	BIT(31)
> +
> +static u32 boot_gcr1;
> +static void __iomem *fsl_mc_regs;
> +
>  /**
>   * fsl_mc_bus_probe - callback invoked when the root MC bus is being
>   * added
> @@ -906,6 +914,21 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>  	struct mc_version mc_version;
>  	struct resource res;
>  
> +	/*
> +	 * The MC firmware requires full access to the whole address space plus
> +	 * it has no way of dealing with any kind of address translation, so
> +	 * request direct mapping for it.
> +	 */
> +	error = iommu_request_dm_for_dev(&pdev->dev);
> +	if (error)
> +		dev_warn(&pdev->dev, "iommu_request_dm_for_dev() failed: %d\n",
> +			 error);
> +
> +	if (fsl_mc_regs) {
> +		/* Resume the firmware */
> +		writel(boot_gcr1 & ~GCR1_P1_STOP, fsl_mc_regs + FSL_MC_GCR1);
> +	}
> +
>  	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
>  	if (!mc)
>  		return -ENOMEM;
> @@ -990,6 +1013,13 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
>  	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
>  		return -EINVAL;
>  
> +	/*
> +	 * Pause back the firmware so that it doesn't trigger faults by the
> +	 * time SMMU gets brought down.
> +	 */
> +	writel(boot_gcr1 | GCR1_P1_STOP, fsl_mc_regs + FSL_MC_GCR1);
> +	iounmap(fsl_mc_regs);
> +
>  	fsl_mc_device_remove(mc->root_mc_bus_dev);
>  
>  	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
> @@ -1018,6 +1048,8 @@ static struct platform_driver fsl_mc_bus_driver = {
>  static int __init fsl_mc_bus_driver_init(void)
>  {
>  	int error;
> +	struct device_node *np;
> +	struct resource res;
>  
>  	error = bus_register(&fsl_mc_bus_type);
>  	if (error < 0) {
> @@ -1039,9 +1071,30 @@ static int __init fsl_mc_bus_driver_init(void)
>  	if (error < 0)
>  		goto error_cleanup_dprc_driver;
>  
> +	np = of_find_matching_node(NULL, fsl_mc_bus_match_table);
> +	if (np && of_device_is_available(np)) {
> +		error = of_address_to_resource(np, 1, &res);
> +		if (error)
> +			goto error_cleanup_dprc_driver;
> +		fsl_mc_regs = ioremap(res.start, resource_size(&res));
> +		if (!fsl_mc_regs) {
> +			error = -ENXIO;
> +			goto error_cleanup_dprc_driver;
> +		}
> +
> +		boot_gcr1 = readl(fsl_mc_regs + FSL_MC_GCR1);
> +		/*
> +		 * If found running, pause MC firmware in order to get a chance
> +		 * to setup SMMU for it.
> +		 */
> +		if (!(boot_gcr1 & GCR1_P1_STOP))
> +			writel(boot_gcr1 | GCR1_P1_STOP,  fsl_mc_regs + FSL_MC_GCR1);
> +	}
> +
>  	return 0;
>  
>  error_cleanup_dprc_driver:
> +	iounmap(fsl_mc_regs);
>  	dprc_driver_exit();
>  
>  error_cleanup_driver:
> -- 
> 2.17.1
> 


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
