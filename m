Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C2FC433E0
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 08:51:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BB220739
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 08:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BB220739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5EA7B86747;
	Fri, 22 Jan 2021 08:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jf9kRPrZvSCV; Fri, 22 Jan 2021 08:51:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 667DB86059;
	Fri, 22 Jan 2021 08:51:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D3FBC088B;
	Fri, 22 Jan 2021 08:51:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A090C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 08:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EA71D86E55
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 08:51:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xHPW7yn7SuTp for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 08:51:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1866F86DD9
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 08:51:42 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id u14so3636416wmq.4
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 00:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vrASp/RtgpnkhA58OvyJAdDc1T+gTz0RiPx6wduZk8c=;
 b=up1a2h2iDNc3JdPf9XWIf2bOEaBA5o+PTzwpwYGlMWM3ZPj/bERowdcDTXhk7MzMw/
 0IFYO6oW0pkXjX1cb3hU7fdkG5CpEdf5p2OrQuENFNur3mXO1UNPNNoA78V26IXInBoj
 TajCQT15iimZzsSU1SJAar/pCn1bCAmu7IeSTP9dwglQQsZGde0nTViozhqrE/WuU4wa
 gbsoMIH3ZTkUTJskvTs16R6tGViSYH17JSudaIueKcawYY5Tbj2U9x+w96OIJ1XQBqcy
 tHESxQyCoAjop66UARHym1LLJEipIIbc8xAb1bYp5sSgO+3CD+f4WOOCCsBpjXXfzNH9
 O73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vrASp/RtgpnkhA58OvyJAdDc1T+gTz0RiPx6wduZk8c=;
 b=njRdtnODZLzqM+InmPN9yyz3NVJZxmlyiZMHXNSeJLCgs6bJ+myGfxrihyBazXeBZ6
 xYcbJmWXkvImtGzcPqMPIg5CT/Aj8IYFxuRvQTkRO81VdXxH5DtNSKmmRJFU7MMPuH/4
 5FdoBTDrVlGQNpQJRASxGtYf5EC1QDGFTaoTB60+h/F0DjM/+jia04KpQiwQ95o5y/f5
 8LlAmSROq3stXawxLpfG3QA801Qrc5efCTwqvyxRo4XLhDkSu7k9ZpPXMbESpq6dAXkZ
 EX94fmaITKea6gp3v4qL+XoKHjLg9YVwrLyGpJG+vPIL+GpmOOU2zuetGEBL+MsWqssZ
 9tgQ==
X-Gm-Message-State: AOAM532V4Q2+6XcdFNacMYxr86sZe3gBPGU0ztLPKm/ba1U6HJ0Il7Yl
 A8F8dHiITkyifaGP5yx/XM730w==
X-Google-Smtp-Source: ABdhPJwPXJQhdUZQz8TZ2CsHYCjCHXTUgo1cueUoveXyLgzD7Ys+eUwGva42rD/7MMLN1jYZ/pNjIQ==
X-Received: by 2002:a1c:1d12:: with SMTP id d18mr2803870wmd.121.1611305500497; 
 Fri, 22 Jan 2021 00:51:40 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id l5sm11088232wrv.44.2021.01.22.00.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 00:51:39 -0800 (PST)
Date: Fri, 22 Jan 2021 09:51:20 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v10 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YAqSCKeN2o+GsISZ@myrica>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
 <20210121123623.2060416-11-jean-philippe@linaro.org>
 <20210121191236.00000103@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121191236.00000103@Huawei.com>
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, will@kernel.org,
 linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org, lenb@kernel.org,
 devicetree@vger.kernel.org, kevin.tian@intel.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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

On Thu, Jan 21, 2021 at 07:12:36PM +0000, Jonathan Cameron wrote:
> > @@ -2502,6 +2647,7 @@ static void arm_smmu_release_device(struct device *dev)
> >  
> >  	master = dev_iommu_priv_get(dev);
> >  	WARN_ON(arm_smmu_master_sva_enabled(master));
> > +	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> >  	arm_smmu_detach_dev(master);
> >  	arm_smmu_disable_pasid(master);
> >  	arm_smmu_remove_master(master);
> 
> The lack of symmetry here bothers me a bit, but it's already true, so I guess
> this case is fine as well.

Normally the device driver calls iommu_dev_feat_disable(SVA) which does
iopf_queue_remove_device(). This is just a safety net in case the device
gets removed without the driver properly cleaning up (which will WARN as
well) 

> 
> ...
> >  
> > @@ -2785,6 +2946,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
> >  static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> >  {
> >  	int ret;
> > +	bool sva = smmu->features & ARM_SMMU_FEAT_STALLS;
> 
> FEAT_SVA?

Ugh yes, thanks. I left this as a bool instead of moving into the test
below because the PRI patch reuses it, but I think I'll just move it down
when resending.

Thanks,
Jean

> 
> >  
> >  	/* cmdq */
> >  	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
> > @@ -2804,6 +2966,12 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (sva && smmu->features & ARM_SMMU_FEAT_STALLS) {
> 
> Isn't this checking same thing twice?
> 
> > +		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
> > +		if (!smmu->evtq.iopf)
> > +			return -ENOMEM;
> > +	}
> > +
> >  	/* priq */
> >  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
> >  		return 0;
> > @@ -3718,6 +3886,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >  	iommu_device_unregister(&smmu->iommu);
> >  	iommu_device_sysfs_remove(&smmu->iommu);
> >  	arm_smmu_device_disable(smmu);
> > +	iopf_queue_free(smmu->evtq.iopf);
> >  
> >  	return 0;
> >  }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
