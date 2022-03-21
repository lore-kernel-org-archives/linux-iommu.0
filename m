Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4892C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 11:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 37879405A6;
	Mon, 21 Mar 2022 11:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6En9yc0B7I3m; Mon, 21 Mar 2022 11:36:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A79D74017A;
	Mon, 21 Mar 2022 11:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B2A3C001A;
	Mon, 21 Mar 2022 11:36:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40C45C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EA3260EB3
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CkO-UkkIoFJq for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 11:36:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BE8A60E9A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:36:05 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 k124-20020a1ca182000000b0038c9cf6e2a6so2115060wme.0
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZVAnw0RzZRCIiVPUEetPfW2YkVPetMxKA7nBTzr+HIw=;
 b=uZLSsmc74Q5/B8CA/4kxhdheuai2ZCTIeNLvbrI84RUpUGdkpG9Cz3bh6BwiqiFrGc
 abtmrsOH9fwm5vPy639n2ou6PTw8ZFqIW64RTcPm98lu0L/zed0WmpJviwfCca8+Unk3
 C9EXmtDr+t01W6DRvP5hL0eZu2UW2nk0/yCPPCd9jKrYkNzq0TLEPZAmrEqNCkIiCi7p
 3lESvWrDt63NMoEKakueosHmptoJJP4QrnSRayS0dFTlfvXq07Q4CeNS9zfCoxNwB3pM
 jl3pheGxMCrUUNTbhcscnRc8DiwTdFAHPu87eokMvgsxJEcKz2Qvo/3U21Wle6Ylwsig
 WYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZVAnw0RzZRCIiVPUEetPfW2YkVPetMxKA7nBTzr+HIw=;
 b=WcljnCwg4RmZuCmyPblXbcFRfecHUAlwlaA5CrnOR4UIeJHGQ3TfQyjKjLACfwAaOO
 S5A+xRg52oYlEi3SMKcZ47s7DnRWp5fjox5nX96UsXqQWOHHXd+wZ2MQIoT0mlF6BMwa
 /DlzWN179Xjsp1GDaLWaTzoRv7Zpzrcj6wqPPBW4jQ4v5Tt3gVsTG/dx2ooyZwv9dTtS
 rYjXOqsD1jNqYZtj2kPdrYhi7bLajldKnepK9NNAOl4/XNMi2YQ2bktpXjKvkKmKJkfs
 PrU7Gl0ucUL+uBQOEVJ8gHJCfAKH1GcGP7aRQ66t9z+98w2tyD0k0cDfYVzGSuM2ShrH
 VyNQ==
X-Gm-Message-State: AOAM530RmfhYJ111LmMq5rUwBX0bEB6uiBqTtjjCfNzc/VnPhvpcTjxd
 dpaPyKjt8n3ZxdwA96laZ2E0ew==
X-Google-Smtp-Source: ABdhPJxo/11Zv/yAVHfSXaiR7imZ5KA75vdgTIy9kESpEDv3hbJqukWEJGk7IKO8XOMkMo70WDkXJQ==
X-Received: by 2002:a05:600c:2e4c:b0:38c:7088:afd0 with SMTP id
 q12-20020a05600c2e4c00b0038c7088afd0mr21171537wmf.70.1647862563546; 
 Mon, 21 Mar 2022 04:36:03 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 w7-20020a1cf607000000b00389a5390180sm13530707wmc.25.2022.03.21.04.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 04:36:03 -0700 (PDT)
Date: Mon, 21 Mar 2022 11:35:38 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 08/11] iommu: Handle IO page faults directly
Message-ID: <YjhjCsrcTNDsFRwm@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-9-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-9-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On Sun, Mar 20, 2022 at 02:40:27PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c0966fc9b686..4f90b71c6f6e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -27,6 +27,8 @@
>  #include <linux/cc_platform.h>
>  #include <trace/events/iommu.h>
>  
> +#include "iommu-sva-lib.h"
> +
>  static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
>  
> @@ -1177,10 +1179,9 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  	if (!param || !evt)
>  		return -EINVAL;
>  
> -	/* we only report device fault if there is a handler registered */
>  	mutex_lock(&param->lock);
>  	fparam = param->fault_param;
> -	if (!fparam || !fparam->handler) {
> +	if (!fparam) {
>  		ret = -EINVAL;
>  		goto done_unlock;
>  	}
> @@ -1198,7 +1199,11 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  		mutex_unlock(&fparam->lock);
>  	}
>  
> -	ret = fparam->handler(&evt->fault, fparam->data);
> +	if (fparam->handler)
> +		ret = fparam->handler(&evt->fault, fparam->data);
> +	else
> +		ret = iommu_queue_iopf(&evt->fault, fparam->data);
> +

I like the change, but we'll need to consolidate this, because now if the
driver registers a fault handler it disables IOPF. We could instead
prevent registration if an IOPF param is present. We could also just merge
fparam->handler but eventually I'd like to make IOPF fall back to the
fault handler registered by device driver, in case of invalid page faults.
I have a couple patches for this but am still missing some bits.

Thanks,
Jean

>  	if (ret && evt_pending) {
>  		mutex_lock(&fparam->lock);
>  		list_del(&evt_pending->list);
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
