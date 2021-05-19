Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59571C433ED
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 19:14:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CA46135A
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 19:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CA46135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9D4D40664;
	Wed, 19 May 2021 19:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XCbrMlMAAh5F; Wed, 19 May 2021 19:14:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 715A340659;
	Wed, 19 May 2021 19:14:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32BA5C000E;
	Wed, 19 May 2021 19:14:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02A36C0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 19:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7E2E40664
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 19:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aeVRa-zaoUk0 for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 19:14:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC1B540659
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 19:14:53 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 80-20020a9d08560000b0290333e9d2b247so2182720oty.7
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 12:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=izYVo1pODY59TvGRJ6tr5HWEWAw6nNqCoxBw5MFLCwg=;
 b=iXQ4YFiAEgBej6x+VTOdgPhpZ+2mtQNjSTzZ6bBHsc17dNZuhlBwK/8Q7MEzrbBrh1
 ot6KS3WvWyioD738PlSeaff0sk1fr+uNJq7vy6wEMYMWUmfhT6WFWMbHgMaXKaLWUeP6
 h3nxHywd8OD9yR2YFn0PzGbdPxlvpfnAyaJLWQhqiHK6uyEjGJN+xtfpHByB9bY+1mgK
 TyZAd3+mEk+xXSuc1aXxYlhpFWWHNvqwnVEibrkf03tMViK2RGq0r5beHwUIcpk+nAbv
 vGRU7LaVzMLd6TPLFHF6RWfSj75awNnHgZhPFFLTCvNjmx31J8Uy7hUc2zjzuGfTvbaO
 LqHA==
X-Gm-Message-State: AOAM533ZMcwEnVUncixv2pyAKVdTWbTbvFksMf1aOD5wz1Qk0koAzkXw
 nHgQff6SjA6m6sRx4HHZeg==
X-Google-Smtp-Source: ABdhPJzJMP2S9PPrAcuHOCF1RfGVRc+VX3tuXr42FGFEFyyuPTnPSurDFrey1rgenAPAQXKp9XlYaw==
X-Received: by 2002:a9d:7f1a:: with SMTP id j26mr810672otq.244.1621451692875; 
 Wed, 19 May 2021 12:14:52 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id h9sm53703oor.16.2021.05.19.12.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 12:14:51 -0700 (PDT)
Received: (nullmailer pid 3479665 invoked by uid 1000);
 Wed, 19 May 2021 19:14:50 -0000
Date: Wed, 19 May 2021 14:14:50 -0500
From: Rob Herring <robh@kernel.org>
To: Wang Xingang <wangxingang5@huawei.com>
Subject: Re: [PATCH v2] iommu/of: Fix pci_request_acs() before enumerating
 PCI devices
Message-ID: <20210519191450.GA3469078@robh.at.kernel.org>
References: <1621257425-37856-1-git-send-email-wangxingang5@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1621257425-37856-1-git-send-email-wangxingang5@huawei.com>
Cc: xieyingtai@huawei.com, devicetree@vger.kernel.org, will@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, helgaas@kernel.org,
 gregkh@linuxfoundation.org, frowand.list@gmail.com
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

On Mon, May 17, 2021 at 01:17:05PM +0000, Wang Xingang wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
> 
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. This patch add check for IOMMU in of_core_init(), and call
> pci_request_acs() when iommu is detected, making sure that the ACS will
> be enabled.
> 
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> ---
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/of/base.c        | 9 ++++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> Change log:
> v1->v2:
>  - remove pci_request_acs() in of_iommu_configure
>  - check and call pci_request_acs() in of_core_init()
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a9d2df001149..54a14da242cc 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  			.np = master_np,
>  		};
>  
> -		pci_request_acs();
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     of_pci_iommu_init, &info);
>  	} else {
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 48e941f99558..95cd8f0e5435 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -24,6 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>
> +#include <linux/pci.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -166,7 +167,7 @@ void __of_phandle_cache_inv_entry(phandle handle)
>  void __init of_core_init(void)
>  {
>  	struct device_node *np;
> -
> +	bool of_iommu_detect = false;
>  
>  	/* Create the kset, and register existing nodes */
>  	mutex_lock(&of_mutex);
> @@ -180,6 +181,12 @@ void __init of_core_init(void)
>  		__of_attach_node_sysfs(np);
>  		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
>  			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
> +
> +		/* Detect IOMMU and make sure ACS will be enabled */
> +		if (!of_iommu_detect && of_get_property(np, "iommu-map", NULL)) {
> +			of_iommu_detect = true;
> +			pci_request_acs();
> +		}

Private DT internal init code doesn't seem like the right place for 
this. If this needs to be ordered WRT PCI device enumeration, then 
somewhere in the PCI host bridge or bus init code seems like the right 
place to me.

Also, shouldn't this be conditional on 'iommu-map' being in the host 
bridge or a parent or ??? rather than just any iommu-map anywhere in the 
DT.

>  	}
>  	mutex_unlock(&of_mutex);
>  
> -- 
> 2.19.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
