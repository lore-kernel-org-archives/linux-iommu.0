Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E4DC433EF
	for <iommu@archiver.kernel.org>; Thu, 31 Mar 2022 21:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94A5F61370;
	Thu, 31 Mar 2022 21:20:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7J58GKgnXpvK; Thu, 31 Mar 2022 21:20:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7270060AB0;
	Thu, 31 Mar 2022 21:20:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4311FC002C;
	Thu, 31 Mar 2022 21:20:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54044C0012
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 21:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C7C5424B4
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 21:20:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=baylibre-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kabAuB2uJr1h for <iommu@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 21:20:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E58D4243B
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 21:20:44 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id bo5so783726pfb.4
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=svILDDP1tn6CI+Hh0Pw/4JOxvuo1xmY6BRPzOQqbKnA=;
 b=2dfB71F+F3N1BfKx9Kxqczba2opQxpo/zINYmDd4Z6PXHpdG5z2OzDAKxa1LzSAN2o
 NZLwgyOtjG/8lurrH8qFyWYJV/Pg95fgv1vkBH2wPWnMFodh1pxrb7sCjZ6AMm0C2V7O
 z/1UUrjoDa0wF4nnzTPdb0nvS31OJRD1YTaLoQdKSVtJ4JIXkbY9xXcNpR1d6bHeYUPT
 7xvX+7bMr+eTg1335pFdVFu79Vct8E2pml6eurl7lCseWgAjgQT4KckXOOq2T42BOX2U
 gIADtfu8r/GOugPUZh0BI1NVBb2CplcsFq3nFEC1dAZBfPu07+6dfq8NJx6JOwT3NRTv
 4HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=svILDDP1tn6CI+Hh0Pw/4JOxvuo1xmY6BRPzOQqbKnA=;
 b=6II9bcycz14g0UcDof9v965ITuU9B+5RgsaMpGKlilIey54nbNroKYdoLAPKiQ0obQ
 H+RQigbld2LEnZemTtuX42QITezXhwxUDvCqePGw7LqwBvSWaq7IYtgWfQCFEiSLlLIo
 V/To++HF4RLxb9N0A6M7C3VggL5d4j4V5J4OxLh1PAwWaAur+MjwuvQJ+jerc2Dh6hug
 Y89eXo7vrSI25VBX+fBsL/p7wrS5qFMegzgyi6rjjnVK+iPDVMl0a71d/3MuraJivM1Q
 GAwqNJsoWeBiwwDI0ust1jQBcBTMsrsztNB7B/OFsht2Ms0HRgIjSuNn0DhfLCPx/2/R
 LnSw==
X-Gm-Message-State: AOAM5302D17LZirguxq/SFHGgZvB5cGvgBRn4cBJl8ht65b9C0orEFrW
 /Fzid6CLjRrjhcEHSAat/2svvg==
X-Google-Smtp-Source: ABdhPJzbez47Mwv9eEJvyiKoQURSHppbrNG51hRYs1H49hqvBOEANdZiWlr9GFjGFb4JMXLR453jBA==
X-Received: by 2002:a63:fb01:0:b0:398:bb8b:5796 with SMTP id
 o1-20020a63fb01000000b00398bb8b5796mr5246092pgh.351.1648761643753; 
 Thu, 31 Mar 2022 14:20:43 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:d825:f497:99ce:fdac])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a056a0010d200b004fa2e13ce80sm405829pfu.76.2022.03.31.14.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 14:20:43 -0700 (PDT)
Date: Thu, 31 Mar 2022 14:21:30 -0700
From: Drew Fustini <dfustini@baylibre.com>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] iommu/omap: Fix regression in probe for NULL pointer
 dereference
Message-ID: <YkYbWiKH1bSu2VkR@x1>
References: <20220331062301.24269-1-tony@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220331062301.24269-1-tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
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

On TLhu, Mar 31, 2022 at 09:23:01AM +0300, Tony Lindgren wrote:
> Commit 3f6634d997db ("iommu: Use right way to retrieve iommu_ops") started
> triggering a NULL pointer dereference for some omap variants:
> 
> __iommu_probe_device from probe_iommu_group+0x2c/0x38
> probe_iommu_group from bus_for_each_dev+0x74/0xbc
> bus_for_each_dev from bus_iommu_probe+0x34/0x2e8
> bus_iommu_probe from bus_set_iommu+0x80/0xc8
> bus_set_iommu from omap_iommu_init+0x88/0xcc
> omap_iommu_init from do_one_initcall+0x44/0x24
> 
> This is caused by omap iommu probe returning 0 instead of ERR_PTR(-ENODEV)
> as noted by Jason Gunthorpe <jgg@ziepe.ca>.
> 
> Looks like the regression already happened with an earlier commit
> 6785eb9105e3 ("iommu/omap: Convert to probe/release_device() call-backs")
> that changed the function return type and missed converting one place.
> 
> Cc: Drew Fustini <dfustini@baylibre.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Suman Anna <s-anna@ti.com>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 6785eb9105e3 ("iommu/omap: Convert to probe/release_device() call-backs")
> Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1661,7 +1661,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
>  	num_iommus = of_property_count_elems_of_size(dev->of_node, "iommus",
>  						     sizeof(phandle));
>  	if (num_iommus < 0)
> -		return 0;
> +		return ERR_PTR(-ENODEV);
>  
>  	arch_data = kcalloc(num_iommus + 1, sizeof(*arch_data), GFP_KERNEL);
>  	if (!arch_data)
> -- 
> 2.35.1

Mainline with omap2plus_defconfig now boots ok on my BeagleBoard-X15
with the TI AM5728 SoC after this patch is applied.

Tested-by: Drew Fustini <dfustini@baylibre.com>

thanks,
drew
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
