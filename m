Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CC7C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ABB1B40569;
	Tue, 14 Dec 2021 15:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cVYjAL5Vsjmz; Tue, 14 Dec 2021 15:33:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8FC0A40564;
	Tue, 14 Dec 2021 15:33:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E743C002F;
	Tue, 14 Dec 2021 15:33:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 383CFC0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2327440302
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gDYOj2W_HYW for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:33:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B2BF40281
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:33:07 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 p3-20020a05600c1d8300b003334fab53afso16528782wms.3
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 07:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gGTASyVvn36rhQtSc7TEVERHcrRg+7y0+ImLAER1pZU=;
 b=ElFUS+8NdkRiKzfHKkNOk9Cm/X1IqVxKkdwxa8tXgoj2vq7DoDTLi2z/TNsNwlK6WX
 dHzcJAmw91QCfnhZQr6+2U81QF2hykWuD7NkmbDzRwlFs4thEfjWA2gLMS4WmqrsSD16
 Kpnb0hM4q66maXaOHpdfqMvCDnNazDpL50YhUeuRAxkskcahHjfm+oMCa6wV/cBBNjlw
 M0IABeC4pSGxlz51D6kOEzFnB4MH/Rlbt20+7zswUJHYci157i4RuxU7eyKMQLqY9/ye
 4Ljgh5rz/7RzXs7Kzcj+lNUmb4ntbIkVRr6dGWJmsORoizYVOJbdcrVUmLP6w3nG3TJy
 EARg==
X-Gm-Message-State: AOAM531//tNp6iUx7abJ0wYUB4g0oFVThfcY0Obo3CM74F4ce9uFYC2b
 gfVZohLb6KZZnoBgZQej8bM=
X-Google-Smtp-Source: ABdhPJxHhur3wQN8WmEyNxA+W1/sE24M3nO1TWjo2rJ0GnYL+t3NixDhtMD6glLsTC6egs0Kn3Dhjw==
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr8027105wmj.30.1639495985661; 
 Tue, 14 Dec 2021 07:33:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id a198sm118170wmd.42.2021.12.14.07.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Dec 2021 07:33:05 -0800 (PST)
Date: Tue, 14 Dec 2021 15:33:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V7 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Message-ID: <20211214153303.qmhowu4lfpcp4gej@liuwe-devbox-debian-v2>
References: <20211213071407.314309-1-ltykernel@gmail.com>
 <20211213071407.314309-3-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213071407.314309-3-ltykernel@gmail.com>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, hch@lst.de, linux-arch@vger.kernel.org, hch@infradead.org,
 wei.liu@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, michael.h.kelley@microsoft.com,
 mingo@redhat.com, kuba@kernel.org, jejb@linux.ibm.com, parri.andrea@gmail.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, bp@alien8.de,
 tglx@linutronix.de, martin.petersen@oracle.com, netdev@vger.kernel.org,
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

On Mon, Dec 13, 2021 at 02:14:03AM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyper-V provides Isolation VM for confidential computing support and
> guest memory is encrypted in it. Places checking cc_platform_has()
> with GUEST_MEM_ENCRYPT attr should return "True" in Isolation vm. e.g,
> swiotlb bounce buffer size needs to adjust according to memory size
> in the sev_setup_arch(). Add GUEST_MEM_ENCRYPT check for Hyper-V Isolation
> VM.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

x86 maintainers, any comment on this patch?

> ---
> Change since v6:
> 	* Change the order in the cc_platform_has() and check sev first.
> 
> Change since v3:
> 	* Change code style of checking GUEST_MEM attribute in the
> 	  hyperv_cc_platform_has().
> ---
>  arch/x86/kernel/cc_platform.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> index 03bb2f343ddb..6cb3a675e686 100644
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
> @@ -58,12 +59,19 @@ static bool amd_cc_platform_has(enum cc_attr attr)
>  #endif
>  }
>  
> +static bool hyperv_cc_platform_has(enum cc_attr attr)
> +{
> +	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
> +}
>  
>  bool cc_platform_has(enum cc_attr attr)
>  {
>  	if (sme_me_mask)
>  		return amd_cc_platform_has(attr);
>  
> +	if (hv_is_isolation_supported())
> +		return hyperv_cc_platform_has(attr);
> +
>  	return false;
>  }
>  EXPORT_SYMBOL_GPL(cc_platform_has);
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
