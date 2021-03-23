Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1101AC433C1
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 10:50:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960AC619BA
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 10:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960AC619BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B8E340339;
	Tue, 23 Mar 2021 10:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9tCase4g2nx; Tue, 23 Mar 2021 10:50:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B52FF40226;
	Tue, 23 Mar 2021 10:50:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99EAEC000B;
	Tue, 23 Mar 2021 10:50:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B2F8C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 10:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BB2E82690
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 10:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jigTiSK_CPg3 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 10:50:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9EFD82656
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 10:50:23 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id c8so7349799wrq.11
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 03:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TiNGA0w46W0DjeaRBmIW710uv+94txA6fMa8wJF8/2Q=;
 b=mWO/oC5mO6oGl5TwUc/XE8tIMSX7VxOcDdlbHfhCSBVlbQTybNFD1lCAa8OttR+vqj
 PFUVBAKJyAbA4x8h3Tt3qDHLt0OI6S1dqhKd8ZgufU6mjoQ8V/gHkzBQjlIEJm/BQjBk
 UaPPLrHkri/DbBxUWVBfaQMAS5chdSH5o1eJGj9K+TDYeEn/Pv45cItajIOeWLLSkiyM
 UUQeEi+z5/gxIcg7hcB/clJa1t5RmMt0oslFk1yipoNByc1MBIUxRia7dm3csLQbUdJ4
 4M69TOF0Bs7qIsZDO2KJodBhr1Ug1lQr1oFitpxhpJ8Pzlru/fHMPhInweLjLbjmO5Dj
 VItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TiNGA0w46W0DjeaRBmIW710uv+94txA6fMa8wJF8/2Q=;
 b=OQmzItii8kaeaRlsSj2013LLaHqy6I17fEI4dKet1W7xkU92Q4hxKsAJS7D5o8Dxn3
 cDW+y3hRChCt7L+eTiofRH5oh2KEJeiaONWaiS88otQJ32K87HRn8jJatsn4vEuynbQr
 PtFUsNFKTcW9F188qYpoSpBijx0qoAGb/7ycjVy13y9CCsLVdGHaTzAGtHM/JtDwrW8/
 RqF/dJM9EPXJkCnKemNHKfrX3lKdU8XEFv1FBT0SVGBjOMYc0HVqjyap+Uw6cdDyyI5L
 GywiOFI5j+qpAMGfmmrIa5D59dxfIpkWVF6XAyMc3aVraUTtiBpkqgmY2qvP021i5pFV
 /WKg==
X-Gm-Message-State: AOAM531+FPqGeD1UDHn5sKuBdCBbUJkovwBhvrUogEsEo548ZWKdqOnZ
 ixtML5WaNEnETkfFkmLeNYawGA==
X-Google-Smtp-Source: ABdhPJyOKKIrD/pjZAo/IQd/VFIPF+OXMG0WMUWGBA1d5PjzWwZOVtYOML7nn713yG/tg4OoOLlQ0A==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr3249954wrs.86.1616496622079;
 Tue, 23 Mar 2021 03:50:22 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y18sm23894467wrq.61.2021.03.23.03.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Mar 2021 03:50:21 -0700 (PDT)
Date: Tue, 23 Mar 2021 11:50:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v13 06/10] iommu: Add a page fault handler
Message-ID: <YFnH20Fy31CwEj7n@myrica>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-7-jean-philippe@linaro.org>
 <20210302155957.620db372@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302155957.620db372@jacob-builder>
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, will@kernel.org, "Raj,
 Ashok" <ashok.raj@intel.com>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

On Tue, Mar 02, 2021 at 03:59:57PM -0800, Jacob Pan wrote:
> Hi Jean-Philippe,
> 
> A few comments from the p.o.v of converting VT-d to this framework. Mostly
> about potential optimization. I think VT-d SVA code will be able to use this
> work.
> +Ashok provided many insight.
> 
> FWIW,
> Reviewed-by:Jacob Pan <jacob.jun.pan@linux.intel.com>

Thanks!

> On Tue,  2 Mar 2021 10:26:42 +0100, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> > +int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> > +{
> > +	int ret;
> > +	struct iopf_group *group;
> > +	struct iopf_fault *iopf, *next;
> > +	struct iopf_device_param *iopf_param;
> > +
> > +	struct device *dev = cookie;
> > +	struct dev_iommu *param = dev->iommu;
> > +
> > +	lockdep_assert_held(&param->lock);
> > +
> > +	if (fault->type != IOMMU_FAULT_PAGE_REQ)
> > +		/* Not a recoverable page fault */
> > +		return -EOPNOTSUPP;
> > +
> > +	/*
> > +	 * As long as we're holding param->lock, the queue can't be
> > unlinked
> > +	 * from the device and therefore cannot disappear.
> > +	 */
> > +	iopf_param = param->iopf_param;
> > +	if (!iopf_param)
> > +		return -ENODEV;
> > +
> > +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> > +		iopf = kzalloc(sizeof(*iopf), GFP_KERNEL);
> > +		if (!iopf)
> > +			return -ENOMEM;
> > +
> > +		iopf->fault = *fault;
> > +
> > +		/* Non-last request of a group. Postpone until the last
> > one */
> Would be nice to have an option here to allow non-deferred handle_mm_fault.
> Some devices may have a large group.
> 
> FYI, VT-d also needs to send page response before the last one (LPIG).
> "A Page Group Response Descriptor is issued by software in response to a
> page request with data or a page request (with or without data) that
> indicated that it was the last request in a group."
> 
> But I think we deal with that when we convert. Perhaps just treat the
> request with data as LPIG.

Sure that seems fine. Do you mean that the vt-d driver will set the
IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE flag for PR-with-data?  Otherwise we
could introduce a new flag. I prefer making it explicit rather than having
IOPF consumers infer that a response is needed when seeing
IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA set, because private_data wouldn't be
reusable by other architectures.

> Also adding a trace event would be nice, similar to CPU page fault.

Agreed, the tracepoints in my development tree (along with the lower-level
page_request/response tracepoints) have been indispensable for debugging
hardware and SVA applications

> > +		list_add(&iopf->list, &iopf_param->partial);
> > +
> > +		return 0;
> > +	}
> > +
> > +	group = kzalloc(sizeof(*group), GFP_KERNEL);
> > +	if (!group) {
> > +		/*
> > +		 * The caller will send a response to the hardware. But
> > we do
> > +		 * need to clean up before leaving, otherwise partial
> > faults
> > +		 * will be stuck.
> > +		 */
> > +		ret = -ENOMEM;
> > +		goto cleanup_partial;
> > +	}
> > +
> > +	group->dev = dev;
> > +	group->last_fault.fault = *fault;
> > +	INIT_LIST_HEAD(&group->faults);
> > +	list_add(&group->last_fault.list, &group->faults);
> > +	INIT_WORK(&group->work, iopf_handle_group);
> > +
> > +	/* See if we have partial faults for this group */
> > +	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list)
> > {
> > +		if (iopf->fault.prm.grpid == fault->prm.grpid)
> Just curious, the iopf handler is registered per arm_smmu_master dev. Is
> the namespace of group ID also within an arm_smmu_master?

Yes for both PCIe PRI and SMMU stall, the namespace is within one device
(one RequesterID or StreamID)

> Can one arm_smmu_master support multiple devices?

No, it's a single device

> 
> For VT-d, group ID is per PCI device.
> 
> > +			/* Insert *before* the last fault */
> > +			list_move(&iopf->list, &group->faults);
> > +	}
> > +
> This is fine with devices supports small number of outstanding PRQs.
> VT-d is setting the limit to 32. But the incoming DSA device will support
> 512.
> 
> So if we pre-sort IOPF by group ID and put them in a per group list, would
> it be faster? I mean once the LPIG comes in, we just need to search the
> list of groups instead of all partial faults. I am not against what is done
> here, just exploring optimization.

Yes I think that's worth exploring, keeping the groups in a rb_tree or something
like that, for easy access and update. Note that I don't have a system
with non-LPIG faults, so I can't test any of this at the moment

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
