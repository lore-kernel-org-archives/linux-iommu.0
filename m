Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8867BC433F5
	for <iommu@archiver.kernel.org>; Thu,  2 Dec 2021 14:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 291DB80DDB;
	Thu,  2 Dec 2021 14:43:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cw2w_HDMxmI9; Thu,  2 Dec 2021 14:43:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AC5480D81;
	Thu,  2 Dec 2021 14:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAC10C0012;
	Thu,  2 Dec 2021 14:43:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 094CDC000A
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 14:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC36A400F7
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 14:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d5P7vUUPIelx for <iommu@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 14:43:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBC70400E5
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 14:43:40 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 n33-20020a05600c502100b0032fb900951eso2492304wmr.4
 for <iommu@lists.linux-foundation.org>; Thu, 02 Dec 2021 06:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ngfxfU8cMx05IJ2GEXLujweygC6BKjS+/TEJnexPuyU=;
 b=dOkTRIpNAFxiu2I5COfv9IaRYk4qb6NRkLzKuIW7Ue+61SCTNs9el3yqopoC8gy2pZ
 T/Xv40u5qJBxY5r01MdKfIIcYrzTLIXXuBZYhcwc+Omm1gVJ+0xwXy9+lUk/0ZHuS5N3
 RMIIfFhNiD7A0MDTRmaAREaQG2TEt9Yah3iW4IXtwZPFoauartKr0Oof5gWF2XZu4ZdI
 NzCKmFPY4vY+BtcaIiuh5QXJ7rOXVWjSyxbyxZKsfTt7FSvQyJx1Q5VXHoaUJizWogfl
 khQCZXzSpmyLg1HrlnPYojxljyF3sAf2Cz2dNLjCaVkeMRyx1k/T2sE/9WJPkJmvhDHg
 OgmQ==
X-Gm-Message-State: AOAM531uTGVqxjS9yvguPcA2YqO0GEvmrDtJRuKyy43LxjN8SjmX4HPQ
 OzoaCeD8X0mo3Z8a2GL4aGk=
X-Google-Smtp-Source: ABdhPJzcC/sLI+YXsme26UERQHG8ONsijhz0w3mw0YtYq520oHvctN0qsFmSNBM5FNo5EKfA2KQfgA==
X-Received: by 2002:a1c:ed18:: with SMTP id l24mr7167526wmh.99.1638456219030; 
 Thu, 02 Dec 2021 06:43:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id b15sm3831942wri.62.2021.12.02.06.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 06:43:38 -0800 (PST)
Date: Thu, 2 Dec 2021 14:43:36 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V3 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Message-ID: <20211202144336.z2sfs6kw5kdsfqgv@liuwe-devbox-debian-v2>
References: <20211201160257.1003912-1-ltykernel@gmail.com>
 <20211201160257.1003912-4-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211201160257.1003912-4-ltykernel@gmail.com>
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

On Wed, Dec 01, 2021 at 11:02:54AM -0500, Tianyu Lan wrote:
[...]
> diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
> index 46df59aeaa06..30fd0600b008 100644
> --- a/arch/x86/xen/pci-swiotlb-xen.c
> +++ b/arch/x86/xen/pci-swiotlb-xen.c
> @@ -4,6 +4,7 @@
>  
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
> +#include <linux/hyperv.h>
>  #include <xen/swiotlb-xen.h>
>  
>  #include <asm/xen/hypervisor.h>
> @@ -91,6 +92,6 @@ int pci_xen_swiotlb_init_late(void)
>  EXPORT_SYMBOL_GPL(pci_xen_swiotlb_init_late);
>  
>  IOMMU_INIT_FINISH(pci_xen_swiotlb_detect,
> -		  NULL,
> +		  hyperv_swiotlb_detect,

It is not immediately obvious why this is needed just by reading the
code. Please consider copying some of the text in the commit message to
a comment here.

Thanks,
Wei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
