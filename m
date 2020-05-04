Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9652C47259
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:22:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9223D20707
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSM+uzVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9223D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 64225876AA;
	Mon,  4 May 2020 16:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YxrfVuYXHtmh; Mon,  4 May 2020 16:22:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 49B6086DAE;
	Mon,  4 May 2020 16:22:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FB95C088C;
	Mon,  4 May 2020 16:22:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFF15C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CE05387A15
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GVW4a9VY3TTU for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 16:22:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A31D987670
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:22:54 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id 188so154471wmc.2
 for <iommu@lists.linux-foundation.org>; Mon, 04 May 2020 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MCHVg2/8+pArsDEcibsWYzrGnqgIsL6O2tKqGg2boGQ=;
 b=iSM+uzVb/Wm9o2OFV1sl72Hl6D+zeT7joT4vOaOlq68PXnFwe/TAk2ttWj8v9dU1dp
 pnF/omBOpYMJB4/th5D32NG9HLmrLVMes4cCMc8VMzYdg2qLFT6vSgmCDp0Aw1nUm0uZ
 zskO35wWlL+RbvHkboG5mUQ/L/n+3y61s2o0w7CQDO57+OpdcBSazwAbkdt1PSVLTLBo
 UV1pf09sh92pKqxAH7nSVA1ZYxhO3wvKQTlkwY+OI6YzOkNriXNcGNotaZCNb5aVlTZL
 xKffUZeH5WhVXFHQFh1APhUCIeRsfiN64kn4VSmarUHBvmY+F0QmpO3mbkXMwkZKQxvG
 rmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MCHVg2/8+pArsDEcibsWYzrGnqgIsL6O2tKqGg2boGQ=;
 b=KYDV2luEcwe362RzFoHJj793iszyeDjYV+fQA0EdM93OlfbqKyofwu/nDEDXF/s9Yx
 cnzI6tjgUOnU0d9AksWEfKZe9nC5Z2HAXVXXSoSFGBCrHUGEExQS6JyOWUu9qpBVez+5
 oKZEgMQJFsaS8UEMkXUXBsAfDlCNplwb73T8ITfFOIgaS/84pvaIrbfcPsRUD0HiWSCm
 neZ3ahZ9XGPFwvJ/QBxI9rItYxdcVjUaTMSSZSuUyhPygU2I7xMsZrt5scF1iImc9AhM
 L/ugDCemEdxpjRi7P/lAcFTF3BzQFamiIp72SfIdvdkMizZh3zfj+WwNhsnQfdu01I3V
 NRDg==
X-Gm-Message-State: AGi0PuYaHFSX+/hY4Jcdn8qGgKltQ1pnC3pDD4Qh9LWEhBK0+TOF74em
 VOHG5Q5OL/f5scsP5Rk985009g==
X-Google-Smtp-Source: APiQypIIfd6fa9/u+aeLTQxZQ97zHXvpxVqHN8qn939cucwqFuaXUhEBZSvGLYaIJPT3wr7V8s6L9Q==
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr15041535wmi.44.1588609373077; 
 Mon, 04 May 2020 09:22:53 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id s8sm16208905wrt.69.2020.05.04.09.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 09:22:52 -0700 (PDT)
Date: Mon, 4 May 2020 18:22:42 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 04/25] iommu: Add a page fault handler
Message-ID: <20200504162242.GF170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-5-jean-philippe@linaro.org>
 <9a8ec004-0a9c-d772-8e7a-f839002a40b5@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9a8ec004-0a9c-d772-8e7a-f839002a40b5@linux.intel.com>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
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

On Sun, May 03, 2020 at 01:49:01PM +0800, Lu Baolu wrote:
> > +static void iopf_handle_group(struct work_struct *work)
> > +{
> > +	struct iopf_group *group;
> > +	struct iopf_fault *iopf, *next;
> > +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
> > +
> > +	group = container_of(work, struct iopf_group, work);
> > +
> > +	list_for_each_entry_safe(iopf, next, &group->faults, head) {
> > +		/*
> > +		 * For the moment, errors are sticky: don't handle subsequent
> > +		 * faults in the group if there is an error.
> > +		 */
> > +		if (status == IOMMU_PAGE_RESP_SUCCESS)
> > +			status = iopf_handle_single(iopf);
> > +
> > +		if (!(iopf->fault.prm.flags &
> > +		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
> > +			kfree(iopf);
> 
> The iopf is freed,but not removed from the list. This will cause wild
> pointer in code.

We free the list with the group below, so this one is fine.

> 
> > +	}
> > +
> > +	iopf_complete_group(group->dev, &group->last_fault, status);
> > +	kfree(group);
> > +}
> > +
> 
> [...]
> 
> > +/**
> > + * iopf_queue_flush_dev - Ensure that all queued faults have been processed
> > + * @dev: the endpoint whose faults need to be flushed.
> > + * @pasid: the PASID affected by this flush
> > + *
> > + * The IOMMU driver calls this before releasing a PASID, to ensure that all
> > + * pending faults for this PASID have been handled, and won't hit the address
> > + * space of the next process that uses this PASID. The driver must make sure
> > + * that no new fault is added to the queue. In particular it must flush its
> > + * low-level queue before calling this function.
> > + *
> > + * Return: 0 on success and <0 on error.
> > + */
> > +int iopf_queue_flush_dev(struct device *dev, int pasid)
> > +{
> > +	int ret = 0;
> > +	struct iopf_device_param *iopf_param;
> > +	struct dev_iommu *param = dev->iommu;
> > +
> > +	if (!param)
> > +		return -ENODEV;
> > +
> > +	mutex_lock(&param->lock);
> > +	iopf_param = param->iopf_param;
> > +	if (iopf_param)
> > +		flush_workqueue(iopf_param->queue->wq);
> 
> There may be other pasid iopf in the workqueue. Flush all tasks in
> the workqueue will hurt other pasids. I might lose any context.

Granted this isn't optimal because we don't take the PASID argument into
account (I think I'll remove it, don't know how to use it). But I don't
think it affects other PASIDs, because all flush_workqueue() does is wait
until all faults currently in the worqueue are processed. So it only
blocks the current thread, but nothing is lost.

> 
> > +	else
> > +		ret = -ENODEV;
> > +	mutex_unlock(&param->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
> > +
> > +/**
> > + * iopf_queue_discard_partial - Remove all pending partial fault
> > + * @queue: the queue whose partial faults need to be discarded
> > + *
> > + * When the hardware queue overflows, last page faults in a group may have been
> > + * lost and the IOMMU driver calls this to discard all partial faults. The
> > + * driver shouldn't be adding new faults to this queue concurrently.
> > + *
> > + * Return: 0 on success and <0 on error.
> > + */
> > +int iopf_queue_discard_partial(struct iopf_queue *queue)
> > +{
> > +	struct iopf_fault *iopf, *next;
> > +	struct iopf_device_param *iopf_param;
> > +
> > +	if (!queue)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&queue->lock);
> > +	list_for_each_entry(iopf_param, &queue->devices, queue_list) {
> > +		list_for_each_entry_safe(iopf, next, &iopf_param->partial, head)
> > +			kfree(iopf);
> 
> iopf is freed but not removed from the list.

Ouch yes this is wrong, will fix.

> 
> > +	}
> > +	mutex_unlock(&queue->lock);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(iopf_queue_discard_partial);
> > +
> > +/**
> > + * iopf_queue_add_device - Add producer to the fault queue
> > + * @queue: IOPF queue
> > + * @dev: device to add
> > + *
> > + * Return: 0 on success and <0 on error.
> > + */
> > +int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
> > +{
> > +	int ret = -EBUSY;
> > +	struct iopf_device_param *iopf_param;
> > +	struct dev_iommu *param = dev->iommu;
> > +
> > +	if (!param)
> > +		return -ENODEV;
> > +
> > +	iopf_param = kzalloc(sizeof(*iopf_param), GFP_KERNEL);
> > +	if (!iopf_param)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&iopf_param->partial);
> > +	iopf_param->queue = queue;
> > +	iopf_param->dev = dev;
> > +
> > +	mutex_lock(&queue->lock);
> > +	mutex_lock(&param->lock);
> > +	if (!param->iopf_param) {
> > +		list_add(&iopf_param->queue_list, &queue->devices);
> > +		param->iopf_param = iopf_param;
> > +		ret = 0;
> > +	}
> > +	mutex_unlock(&param->lock);
> > +	mutex_unlock(&queue->lock);
> > +
> > +	if (ret)
> > +		kfree(iopf_param);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iopf_queue_add_device);
> > +
> > +/**
> > + * iopf_queue_remove_device - Remove producer from fault queue
> > + * @queue: IOPF queue
> > + * @dev: device to remove
> > + *
> > + * Caller makes sure that no more faults are reported for this device.
> > + *
> > + * Return: 0 on success and <0 on error.
> > + */
> > +int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
> > +{
> > +	int ret = 0;
> > +	struct iopf_fault *iopf, *next;
> > +	struct iopf_device_param *iopf_param;
> > +	struct dev_iommu *param = dev->iommu;
> > +
> > +	if (!param || !queue)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&queue->lock);
> > +	mutex_lock(&param->lock);
> > +	iopf_param = param->iopf_param;
> > +	if (iopf_param && iopf_param->queue == queue) {
> > +		list_del(&iopf_param->queue_list);
> > +		param->iopf_param = NULL;
> > +	} else {
> > +		ret = -EINVAL;
> > +	}
> > +	mutex_unlock(&param->lock);
> > +	mutex_unlock(&queue->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Just in case some faults are still stuck */
> > +	list_for_each_entry_safe(iopf, next, &iopf_param->partial, head)
> > +		kfree(iopf);
> 
> The same here.

Here is fine, we free the iopf_param below

Thanks,
Jean

> 
> > +
> > +	kfree(iopf_param);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(iopf_queue_remove_device);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
