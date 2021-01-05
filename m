Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C04C433DB
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 10:21:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D572522288
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 10:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D572522288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5707721503;
	Tue,  5 Jan 2021 10:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPVQeQGMQ8wq; Tue,  5 Jan 2021 10:21:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7F3D5203AB;
	Tue,  5 Jan 2021 10:21:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70604C088B;
	Tue,  5 Jan 2021 10:21:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC1D2C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 10:21:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C1A3A85D68
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 10:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gI8rkWCG_k0W for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 10:21:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 781E485D52
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 10:21:03 +0000 (UTC)
Received: from zn.tnic (p200300ec2f103700ba0c0ccd6fae6c32.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f10:3700:ba0c:ccd:6fae:6c32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31C911EC0324;
 Tue,  5 Jan 2021 11:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1609842060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=EVz+m6gjXCXiRGpAA6hb4FVi0ebUcWmcTwsx9IcT4xo=;
 b=JnGPYAnlDzMEVLWBbPU/lENeQXdyjPwSRwR7qYaKT5NT7lGBIhzD+Bi3NqtG1hbfAnLi40
 cDXVyyU9CJzFP8acQfjIWZmwEsIy3R6NhThLIg4H3556Vqimi+caLoF2c+WoEhdqth6vYg
 UtT01IKy62Nj3CCrnB65BhL6xV4yls0=
Date: Tue, 5 Jan 2021 11:20:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] iommu/amd: Set iommu->int_enabled consistently when
 interrupts are set up
Message-ID: <20210105102056.GA28649@zn.tnic>
References: <20210104132250.GE32151@zn.tnic> <20210104232353.GJ32151@zn.tnic>
 <50cd5f55be8ead0937ac315cd2f5b89364f6a9a5.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50cd5f55be8ead0937ac315cd2f5b89364f6a9a5.camel@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
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

On Tue, Jan 05, 2021 at 01:32:51AM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> When I made the INTCAPXT support stop gratuitously pretending to be MSI,
> I missed the fact that iommu_setup_msi() also sets the ->int_enabled
> flag. I missed this in the iommu_setup_intcapxt() code path, which means
> that a resume from suspend will try to allocate the IRQ domains again,
> accidentally re-enabling interrupts as it does, resulting in much sadness.
> 
> Lift out the bit which sets iommu->int_enabled into the iommu_init_irq()
> function which is also where it gets checked.
> 
> Link: https://lore.kernel.org/r/20210104132250.GE32151@zn.tnic/
> Fixes: d1adcfbb520c ("iommu/amd: Fix IOMMU interrupt generation in X2APIC mode")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> There's a possibility we also need to ensure that the actual
> MMIO_INTCAPXT_xxx_OFFSET registers are restored too. Unless you
> actually trigger something to generate faults, you'll never know.
> I don't see offhand how that was working in the pretend-to-be-MSI case
> either.
> 
>  drivers/iommu/amd/init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f54cd79b43e4..6a1f7048dacc 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1973,8 +1973,6 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
>  		return r;
>  	}
>  
> -	iommu->int_enabled = true;
> -
>  	return 0;
>  }
>  
> @@ -2169,6 +2167,7 @@ static int iommu_init_irq(struct amd_iommu *iommu)
>  	if (ret)
>  		return ret;
>  
> +	iommu->int_enabled = true;
>  enable_faults:
>  	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
>  
> -- 

Tested-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
