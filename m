Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8ABC35242
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 23:53:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F6D206DA
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 23:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ocHiQR2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F6D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A1BD7864B2;
	Tue, 11 Feb 2020 23:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6zWkmwic+qAU; Tue, 11 Feb 2020 23:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8E3BE8647A;
	Tue, 11 Feb 2020 23:53:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82120C1D88;
	Tue, 11 Feb 2020 23:53:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CEA0C07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 23:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 56DC485725
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 23:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uvond5NVmoXP for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 23:53:28 +0000 (UTC)
X-Greylist: delayed 00:07:36 by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B02FF85712
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 23:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/63RZIRpBax9M6SO18Oi0fU9+y2EZyC+pNdMvta4lwc=; b=ocHiQR2CMJL+s3EwRYXwd8Zqi
 aeXyyQ9iTiAJjArEuJ8zmPc7aqkYIrxzXp5wPHqGaIdtkusS1Hu6Wm/8W8fheBcAoGZpkpvF1aE75
 QLf2TpYVrQt5dsbCK8DJzzaV4BIkW7f3mclBxeIkDNfGirCPsRyuKenLsghVXIOtj0vJ7BtcmR5P0
 mQg1bbEtmLiYb8sBViWkSj+DrluPEA0Dk7OQkrkJJbjF1ntiEkBNEytB8A4PmJRr6fauaF1NgWGCy
 FbfIt4Cp32XvfOIsmVivqzc++P6S5sAMFfvhqILBW+Uvv23Kn4wxiKbAQCfQDrLSympDvyywPE8y3
 JJDGTRmwA==;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46604)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1j1fDp-0007jp-Ak; Tue, 11 Feb 2020 23:45:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1j1fDk-0000pP-8Y; Tue, 11 Feb 2020 23:45:36 +0000
Date: Tue, 11 Feb 2020 23:45:36 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH] iommu/arm-smmu: fix the module name for disable_bypass
 parameter
Message-ID: <20200211234536.GK25745@shell.armlinux.org.uk>
References: <1581464215-24777-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1581464215-24777-1-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Feb 11, 2020 at 05:36:55PM -0600, Li Yang wrote:
> Since commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module"),
> there is a side effect that the module name is changed from arm-smmu to
> arm-smmu-mod.  So the kernel parameter for disable_bypass need to be
> changed too.  Fix the Kconfig help and error message to the correct
> parameter name.

Hmm, this seems to be a user-visible change - so those of us who have
been booting with "arm-smmu.disable_bypass=0" now need to change that
depending on which kernel is being booted - which is not nice, and
makes the support side on platforms that need this kernel parameter
harder.

> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/Kconfig    | 2 +-
>  drivers/iommu/arm-smmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d2fade984999..fb54be903c60 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -415,7 +415,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>  	  hardcode the bypass disable in the code.
>  
>  	  NOTE: the kernel command line parameter
> -	  'arm-smmu.disable_bypass' will continue to override this
> +	  'arm-smmu-mod.disable_bypass' will continue to override this
>  	  config.
>  
>  config ARM_SMMU_V3
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 16c4b87af42b..2ffe8ff04393 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -512,7 +512,7 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>  		if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
>  		    (gfsr & ARM_SMMU_sGFSR_USF))
>  			dev_err(smmu->dev,
> -				"Blocked unknown Stream ID 0x%hx; boot with \"arm-smmu.disable_bypass=0\" to allow, but this may have security implications\n",
> +				"Blocked unknown Stream ID 0x%hx; boot with \"arm-smmu-mod.disable_bypass=0\" to allow, but this may have security implications\n",
>  				(u16)gfsynr1);
>  		else
>  			dev_err(smmu->dev,
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
