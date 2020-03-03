Return-Path: <SRS0=fiLh=4U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93FFC3F2C6
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 22:18:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEF720870
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 22:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uTllFNEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEF720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1B2152050F;
	Tue,  3 Mar 2020 22:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0byb+ljprZQ; Tue,  3 Mar 2020 22:18:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D675E204FF;
	Tue,  3 Mar 2020 22:18:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B82C4C1AE2;
	Tue,  3 Mar 2020 22:18:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC2B6C013E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 22:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D2FA420516
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 22:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X++G5KLRyHA2 for <iommu@lists.linux-foundation.org>;
 Tue,  3 Mar 2020 22:18:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by silver.osuosl.org (Postfix) with ESMTPS id 55F51204FF
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 22:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vUdS4FZhC6hPgxAjdVTLkMMEUI8Uey7J+vqKnDed7dA=; b=uTllFNEkcC5PpbhQZKI/1RC9u
 n6JvngCRzC8UQ8TyNoXQcSlllqWv4ejiqRtnvE7r3Q/2OfcAXWsgzxZsbsNogZrD+8McoI5wSFOVG
 vM/hWBsdssqq3asxsqPWpwdfpI9iSHer+EYqLMCtBhsEpxcNjL8v2W1KnuMSKfjAn0oTYhF8+2UXc
 uz78mIStKrJTqJm8UoyF56XBeTmXz0MGnm8aIrdYI7/IBrRoVMxxGXMKJEbJo09YkZbxo9YwvUcrp
 0twubE4Tbvcu8om0lo7CSpr5gNloEvJfvqg+z5chmVGcvsCPQYhMYQzAWFQdk2STgZ2PSRr8WLIcm
 pmNMEl+QA==;
Received: from shell.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:48344)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1j9FrL-0002Y2-9M; Tue, 03 Mar 2020 22:17:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1j9FrF-0006HO-Ru; Tue, 03 Mar 2020 22:17:45 +0000
Date: Tue, 3 Mar 2020 22:17:45 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] iommu: silence iommu group prints
Message-ID: <20200303221745.GV25745@shell.armlinux.org.uk>
References: <E1j7Hnc-0004Bm-Kn@rmk-PC.armlinux.org.uk>
 <f0fc4c8c-4475-e77f-da6d-e068e7993568@linux.intel.com>
 <b4029a97-ac80-484f-9d01-d7f4eb174cdd@huawei.com>
 <20200228100644.GT25745@shell.armlinux.org.uk>
 <95af8fc3-d7b1-3b58-afc1-d203d7538b95@arm.com>
 <bcb9fbab-2943-3207-b69d-e7ce9e3e3a8e@nxp.com>
 <20200303154959.GR25745@shell.armlinux.org.uk>
 <ac9dc4b1-e3a4-2b69-7c61-d94e082cef30@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac9dc4b1-e3a4-2b69-7c61-d94e082cef30@nxp.com>
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

On Tue, Mar 03, 2020 at 05:55:05PM +0200, Laurentiu Tudor wrote:
> From c98dc05cdd45ae923654f2427985bd28bcde4bb2 Mon Sep 17 00:00:00 2001
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Date: Thu, 13 Feb 2020 11:59:12 +0200
> Subject: [PATCH 1/4] bus: fsl-mc: add custom .dma_configure implementation
> Content-Type: text/plain; charset="us-ascii"
> 
> The devices on this bus are not discovered by way of device tree
> but by queries to the firmware. It makes little sense to trick the
> generic of layer into thinking that these devices are of related so
> that we can get our dma configuration. Instead of doing that, add
> our custom dma configuration implementation.

Firstly, applying this to v5.5 results in a build failure, due to a
missing linux/iommu.h include.

Secondly, this on its own appears to make the DPAA2 network interfaces
completely disappear.  Looking in /sys/bus/fsl-mc/drivers/*, none of
the DPAA2 drivers are bound to anything, and looking in
/sys/bus/fsl-mc/devices/, there is:

lrwxrwxrwx 1 root root 0 Mar  3 22:06 dprc.1 -> ../../../devices/platform/soc/80c000000.fsl-mc/dprc.1

This is booting with u-boot, so using DT rather than ACPI.

> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 42 ++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 36eb25f82c8e..3df015eedae4 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -132,11 +132,51 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  static int fsl_mc_dma_configure(struct device *dev)
>  {
>  	struct device *dma_dev = dev;
> +	struct iommu_fwspec *fwspec;
> +	const struct iommu_ops *iommu_ops;
> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> +	int ret;
> +	u32 icid;
> +
> +	/* Skip DMA setup for devices that are not DMA masters */
> +	if (dev->type == &fsl_mc_bus_dpmcp_type ||
> +	    dev->type == &fsl_mc_bus_dpbp_type ||
> +	    dev->type == &fsl_mc_bus_dpcon_type ||
> +	    dev->type == &fsl_mc_bus_dpio_type)
> +		return 0;
>  
>  	while (dev_is_fsl_mc(dma_dev))
>  		dma_dev = dma_dev->parent;
>  
> -	return of_dma_configure(dev, dma_dev->of_node, 0);
> +	fwspec = dev_iommu_fwspec_get(dma_dev);
> +	if (!fwspec)
> +		return -ENODEV;

The problem appears to be here - fwspec is NULL for dprc.1.

> +	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
> +	if (!iommu_ops)
> +		return -ENODEV;
> +
> +	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
> +	if (ret)
> +		return ret;
> +
> +	icid = mc_dev->icid;
> +	ret = iommu_fwspec_add_ids(dev, &icid, 1);
> +	if (ret) {
> +		iommu_fwspec_free(dev);
> +		return ret;
> +	}
> +
> +	if (!device_iommu_mapped(dev)) {
> +		ret = iommu_probe_device(dev);
> +		if (ret) {
> +			iommu_fwspec_free(dev);
> +			return ret;
> +		}
> +	}
> +
> +	arch_setup_dma_ops(dev, 0, *dma_dev->dma_mask + 1, iommu_ops, true);
> +
> +	return 0;
>  }
>  
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
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
