Return-Path: <SRS0=dyvA=XI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07ECC49ED7
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 22:59:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD8C206A5
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 22:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EESddT+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD8C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F3E0FD07;
	Fri, 13 Sep 2019 22:59:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6520DCDF
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 22:59:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F111D82B
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 22:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gz91tcAZKZlGrIVMxlgK2a+6W0NcPe51avZOJKC9IiM=;
	b=EESddT+nZeGoY5ijhPLaGQz43
	toQSQ9Rb93WAHxGS2X5emD7os5LHiK2t4Np5SEKHOgU8UkDqfKw/SL29sNiiQn9wbQFn8Jw9Xl7D8
	5AWioi0fcOUbLhA/O2hq4UsywZ1e5fQ3Isi4s89oGVbdFEbIvSp/hVUkjkiEN7PF3MW6qB9j3ZQQS
	+D8xTM7eRfhNfUkJ/rIdhKcXwHObfLmgdXlIBNI7TFa7XDJPbj+dbUwtg5TEx2v6BIECtvd/3byzM
	GL6g/SRW9HPPQ7TH2e2wwLvHPwItjvBAhDHyaNhhJHAwxXx7M4zB42OaqcrygRz4Rb0bheWQ6Ut6b
	pNzBvyE6Q==;
Received: from shell.armlinux.org.uk
	([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43326)
	by pandora.armlinux.org.uk with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
	(envelope-from <linux@armlinux.org.uk>)
	id 1i8uWy-0005JG-0V; Fri, 13 Sep 2019 23:59:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1i8uWu-0006Dk-Nw; Fri, 13 Sep 2019 23:59:04 +0100
Date: Fri, 13 Sep 2019 23:59:04 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Report USF more clearly
Message-ID: <20190913225904.GC13294@shell.armlinux.org.uk>
References: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: will@kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	Douglas Anderson <dianders@chromium.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Sep 13, 2019 at 12:48:37PM +0100, Robin Murphy wrote:
> Although CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is a welcome tool
> for smoking out inadequate firmware, the failure mode is non-obvious
> and can be confusing for end users. Add some special-case reporting of
> Unidentified Stream Faults to help clarify this particular symptom.

Having encountered this on a board that turned up this week, it may
be better to use the hex representation of the stream ID, especially
as it seems normal for the stream ID to be made up of implementation
defined bitfields.

If we want to stick with decimal, maybe masking the stream ID with
the number of allowable bits would be a good idea, so that the
decimal value remains meaningful should other bits be non-zero?

> CC: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 5 +++++
>  drivers/iommu/arm-smmu.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index b7cf24402a94..76ac8c180695 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -499,6 +499,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>  	dev_err_ratelimited(smmu->dev,
>  		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
>  		gfsr, gfsynr0, gfsynr1, gfsynr2);
> +	if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> +	    (gfsr & sGFSR_USF))
> +		dev_err_ratelimited(smmu->dev,
> +			"Stream ID %hu may not be described by firmware, try booting with \"arm-smmu.disable_bypass=0\"\n",
> +			(u16)gfsynr1);
>  
>  	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sGFSR, gfsr);
>  	return IRQ_HANDLED;
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index c9c13b5785f2..46f7e161e83e 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -79,6 +79,8 @@
>  #define ID7_MINOR			GENMASK(3, 0)
>  
>  #define ARM_SMMU_GR0_sGFSR		0x48
> +#define sGFSR_USF			BIT(2)

I do wonder if this is another instance where writing "(1 << 1)"
would have resulted in less chance of a mistake being made...
wrapping stuff up into macros is not always better!

9.6.15    SMMU_sGFSR, Global Fault Status Register

The SMMU_sGFSR bit assignments are:

USF, bit[1]       Unidentified stream fault. The possible values of this
                  bit are:
                  0          No Unidentified stream fault.
                  1          Unidentified stream fault.

So this wants to be:

#define sGFSR_USF			BIT(1)


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
