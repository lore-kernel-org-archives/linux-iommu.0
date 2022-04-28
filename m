Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC713C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83D5483E08;
	Thu, 28 Apr 2022 14:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jg_6lCUI2FFd; Thu, 28 Apr 2022 14:57:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A4AA82F8A;
	Thu, 28 Apr 2022 14:57:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D159C0032;
	Thu, 28 Apr 2022 14:57:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3A56C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E8D040887
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:57:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zXrkqYT6iPl1 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:57:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A85004150F
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:57:43 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id kq17so10113693ejb.4
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+Oatp214EwoNcQfNGb/ga75M/gnCMQvp4FQ1OdCp+0E=;
 b=XGccVBbYbqQHavxmDFlET858W8/jpfKwAvu1iXwcz1UiPEkSDm4RDz9Eu5dw1AhpzT
 S18Q+f+L9h8jeW7AaNE5yH9d0DBvna/nIClQHP/oUVdE+fveKG2Vo8Vjkb65yaiY2lDo
 GLFbb4SKTTewbGyXbWZvT/y+IZobtPOV7LtbOmSSHyGh+hgJLcUX7gA6jWZVdcLut3Hg
 doYBJ9b573W3HowU4BG64IaVxziqIeSesfP2EGnXBsVwNoBgibOfC9ADDsLCWsF89YbO
 h3SVONb7e6Cl7zhLd0ruB5rns3Zc3vA90/KYWaMMtxMpPlkIv8cNVK2RsrBJorLEFytG
 lbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+Oatp214EwoNcQfNGb/ga75M/gnCMQvp4FQ1OdCp+0E=;
 b=QnMmwOPTYsLYj7TbcS/qquNUnnpU2z9HuTrDwFdscTTNvF4tYS+ZQInVoYhhDViyUE
 P068FURnaAZcOlTCqQJBPAJzdRaKs9S7DfCK38azVZyM94AAy1eXPX0vUAA/vh610yNd
 +ty0ETKNQn63rfUr17q2YlHgeenZsb2V7NlAu/KupbNV1iBy2ms2GLm+fSW4C+Pq8rEy
 pti+8x+gcivr2e7hbhRB3PZUFZutwTPNxuNqgz/dhTpi2YhTK9x860c/h+lyHG/cYVCP
 +pBVaoYdcq6vgViHqZ6Jb3p8Xhcs0MUsuV4qR31IfbjjYmgRq4S0ABkZeJffmkRGbaS4
 dDSg==
X-Gm-Message-State: AOAM5319POwIaiaQVsxMjGqvXQOmnC+b1swW2rpaex3kwU5Pf4qhAxDk
 tnsP7QCU9NzUq64W/PqTq5stTA==
X-Google-Smtp-Source: ABdhPJyCs5GoHd6/3JIGfBLDqAf/IOHLs+yHhomAVfDQjADxQpL1I8V6bW4kdozw9pGdsWMQrdIGew==
X-Received: by 2002:a17:907:6d17:b0:6f3:e4ef:cd4a with SMTP id
 sa23-20020a1709076d1700b006f3e4efcd4amr2947973ejc.646.1651157861714; 
 Thu, 28 Apr 2022 07:57:41 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 l21-20020a056402345500b0042617ba6393sm1706454edc.29.2022.04.28.07.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 07:57:41 -0700 (PDT)
Date: Thu, 28 Apr 2022 15:57:16 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 11/12] iommu: Per-domain I/O page fault handling
Message-ID: <YmqrTGcHotvhhaT2@myrica>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-12-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220421052121.3464100-12-baolu.lu@linux.intel.com>
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

On Thu, Apr 21, 2022 at 01:21:20PM +0800, Lu Baolu wrote:
>  static void iopf_handle_group(struct work_struct *work)
>  {
>  	struct iopf_group *group;
> @@ -134,12 +78,23 @@ static void iopf_handle_group(struct work_struct *work)
>  	group = container_of(work, struct iopf_group, work);
>  
>  	list_for_each_entry_safe(iopf, next, &group->faults, list) {
> +		struct iommu_domain *domain;
> +
> +		domain = iommu_get_domain_for_dev_pasid_async(group->dev,
> +				iopf->fault.prm.pasid);

Reading the PCIe spec again (v6.0 10.4.1.1 PASID Usage), all faults within
the group have the same PASID so we could move the domain fetch out of the
loop. It does deviate from the old behavior, though, so we could change
it later.

Thanks,
Jean

> +		if (!domain || !domain->iopf_handler)
> +			status = IOMMU_PAGE_RESP_INVALID;
> +
>  		/*
>  		 * For the moment, errors are sticky: don't handle subsequent
>  		 * faults in the group if there is an error.
>  		 */
>  		if (status == IOMMU_PAGE_RESP_SUCCESS)
> -			status = iopf_handle_single(iopf);
> +			status = domain->iopf_handler(&iopf->fault,
> +						      domain->fault_data);
> +
> +		if (domain)
> +			iommu_domain_put_async(domain);
>  
>  		if (!(iopf->fault.prm.flags &
>  		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
