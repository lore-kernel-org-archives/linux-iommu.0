Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18126C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABE8960A88;
	Thu, 28 Apr 2022 14:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwHWqYv4wF8R; Thu, 28 Apr 2022 14:48:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E7B86079E;
	Thu, 28 Apr 2022 14:48:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D087C0032;
	Thu, 28 Apr 2022 14:48:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2F8EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B94C040155
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DSfMndGdkCAY for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:48:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA41E400BF
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:48:19 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 bi24-20020a05600c3d9800b00393ff664705so3158291wmb.4
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gXcgGcE+u9ZZ2nNfuMlJwxFYwU47p+7KJbt/dJsKH2k=;
 b=WoXhKzVCsdlC5PUxXMPtuzO6MyUVEwuQIKmv3o0Fq3J+OB+PULeTKG9nBT0FsElq8U
 tzXFIdRn+O/epPEH8lcBtwL/GVklJeA53TSIHwe5JEFkgzt3FWfHSVPcu/d1ivseCBdC
 187xbW/KsmiQt3bJ42HIUc3A8B7TJhiyNI6coYwMWaWUJ8ScACpCjTavoLRReuX7Av/P
 upuWvJBiL/cRfcv/AopQLXAlHMuHbLE1xNpqMx7hel3CxHW+vEgAmL0GJT+zRJ4osRJY
 PoIwgAmvExzt9jf52TXT8RVwRA+GB5mapKcp8fPjbI5HrsmWMCOPbCSmK6+ErdA5r+gc
 Uncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gXcgGcE+u9ZZ2nNfuMlJwxFYwU47p+7KJbt/dJsKH2k=;
 b=Z9cyrTnNWB7+Y9G6adk904ZzsbcRA5xQRcamsN/Duq3SCJ7I/pWfpLCb7nwMhJOVnm
 2MbAMDxkwEXEIBcBWKJGwDuNgmAdfIwS2j6EBJiA8kA8YvryQ7nT1LY7V/S0aJdWUKCD
 VCexXHeyRYHEHKl/kdEYq8vqLZN5eireqhb+KkdEH6nLiHgvAswETD4onQagewn3unl9
 wJhlMb75LB8uVFVOt2A5ah6K/inT2PUZkUpag6S72tljO6Rj0W7q1Afr/zCR9lw8y1ln
 PMC0mcjX/gZpTMISCRyHGagXfvbRE4qlrtshMAAqDQI1ISlABNL06Dsc5ff313foZBrG
 Ylrw==
X-Gm-Message-State: AOAM532+FJVEB20zv2S1SVOPyegzuN3bk72miroae1jXnrfciYxNaxbQ
 N7w/JV+ESV2JjgDErKoEf0emQw==
X-Google-Smtp-Source: ABdhPJxNWPXTUPDxwHrxcCJa+urJQ5WdUNKsvAt695sYRfcOhAF31zd2EOk9mXufDDPQiUwFCynz5Q==
X-Received: by 2002:a7b:cb48:0:b0:394:b64:8b88 with SMTP id
 v8-20020a7bcb48000000b003940b648b88mr5166056wmj.183.1651157298179; 
 Thu, 28 Apr 2022 07:48:18 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 p3-20020adfaa03000000b00207a1db96cfsm60631wrd.71.2022.04.28.07.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 07:48:17 -0700 (PDT)
Date: Thu, 28 Apr 2022 15:47:52 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 10/12] iommu: Prepare IOMMU domain for IOPF
Message-ID: <YmqpGFzMZn7ZMzsQ@myrica>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-11-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220421052121.3464100-11-baolu.lu@linux.intel.com>
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

Hi Baolu,

On Thu, Apr 21, 2022 at 01:21:19PM +0800, Lu Baolu wrote:
> +/*
> + * Get the attached domain for asynchronous usage, for example the I/O
> + * page fault handling framework. The caller get a reference counter
> + * of the domain automatically on a successful return and should put
> + * it with iommu_domain_put() after usage.
> + */
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	if (!pasid_valid(pasid))
> +		return NULL;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
> +
> +	mutex_lock(&group->mutex);

There is a possible deadlock between unbind() and the fault handler:

 unbind()                            iopf_handle_group()
  mutex_lock(&group->mutex)
  iommu_detach_device_pasid()
   iopf_queue_flush_dev()             iommu_get_domain_for_dev_pasid_async()
    ... waits for IOPF work            mutex_lock(&group->mutex)

I was wrong in my previous review: we do have a guarantee that the SVA
domain does not go away during IOPF handling, because unbind() waits for
pending faults with iopf_queue_flush_dev() before freeing the domain (or
for Arm stall, knows that there are no pending faults). So we can just get
rid of domain->async_users and the group->mutex in IOPF, I think?

Thanks,
Jean

> +	domain = xa_load(&group->pasid_array, pasid);
> +	if (domain)
> +		refcount_inc(&domain->async_users);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return domain;
> +}
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
