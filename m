Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0537CC433F5
	for <iommu@archiver.kernel.org>; Thu,  2 Dec 2021 14:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93A6441D74;
	Thu,  2 Dec 2021 14:39:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xxr2rHIJQ5JR; Thu,  2 Dec 2021 14:39:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5CA6741D75;
	Thu,  2 Dec 2021 14:39:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 357C0C0012;
	Thu,  2 Dec 2021 14:39:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40261C000A
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 14:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 360EA6F47F
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 14:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kKoxchlexNee for <iommu@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 14:39:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBE7B607E6
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 14:39:49 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id v11so60138828wrw.10
 for <iommu@lists.linux-foundation.org>; Thu, 02 Dec 2021 06:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=72a6A507OnldVCWrhDSc/GY7lKjxc4B5WRBxEFXAJ3U=;
 b=nNdTpzDtNEIpIbUIjJCGkVb+Psyrf/HAhrsu4Qgz21dmMofFfD8Dl01EFJPHKD/3Oz
 aKJhnzbs6C/+FtiqbC2SkG3kf4DGKcCyb+NfkXFZ9jXHVmzhtEs0WnrFZTo4KEnPGbxl
 o0BTknS205+SRuCtnqcCeTzkeqcT4VUMV+366kzJjHqzpyl2hgeXCARfomXSCydD9EJP
 EswqFxefTpncqWX0D26TQ3kxannJwG8PTCc05TD5Gz7D/KTE5/CRN8NXFHeHdf9FPAxb
 N7egtWgYZXzmLG/Sr5+CyonaETtNTOVTxbL4Q5sQ6jyyks6DYdmOAutGHi2j749e4ej9
 rTHQ==
X-Gm-Message-State: AOAM5332aRh7skp9ZbQ5vb43HBcgTiR2xwBvonY1MdgsaLwrxe4lxx6o
 o9MzFmV0jhIuBH2/1Iodl6s=
X-Google-Smtp-Source: ABdhPJxPzdtd3RdqIbFdq4J+qJfyoes2s3XiUvAs4cyVDgX4hcthvPCvHGkt6Ry5P/1NlIy3ec+13w==
X-Received: by 2002:adf:d4c2:: with SMTP id w2mr14815368wrk.225.1638455988303; 
 Thu, 02 Dec 2021 06:39:48 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id z5sm2876037wmp.26.2021.12.02.06.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 06:39:47 -0800 (PST)
Date: Thu, 2 Dec 2021 14:39:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V3 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Message-ID: <20211202143946.7o7ncwcjq3t6xcrq@liuwe-devbox-debian-v2>
References: <20211201160257.1003912-1-ltykernel@gmail.com>
 <20211201160257.1003912-3-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211201160257.1003912-3-ltykernel@gmail.com>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, hch@lst.de, hch@infradead.org,
 mingo@redhat.com, kuba@kernel.org, haiyangz@microsoft.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 arnd@arndb.de, konrad.wilk@oracle.com, jejb@linux.ibm.com, bp@alien8.de,
 xen-devel@lists.xenproject.org, tglx@linutronix.de, jgross@suse.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On Wed, Dec 01, 2021 at 11:02:53AM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyper-V provides Isolation VM which has memory encrypt support. Add
> hyperv_cc_platform_has() and return true for check of GUEST_MEM_ENCRYPT
> attribute.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/kernel/cc_platform.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> index 03bb2f343ddb..f3bb0431f5c5 100644
> --- a/arch/x86/kernel/cc_platform.c
> +++ b/arch/x86/kernel/cc_platform.c
> @@ -11,6 +11,7 @@
>  #include <linux/cc_platform.h>
>  #include <linux/mem_encrypt.h>
>  
> +#include <asm/mshyperv.h>
>  #include <asm/processor.h>
>  
>  static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
> @@ -58,9 +59,23 @@ static bool amd_cc_platform_has(enum cc_attr attr)
>  #endif
>  }
>  
> +static bool hyperv_cc_platform_has(enum cc_attr attr)
> +{
> +#ifdef CONFIG_HYPERV
> +	if (attr == CC_ATTR_GUEST_MEM_ENCRYPT)
> +		return true;
> +	else
> +		return false;

This can be simplified as

	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;


Wei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
