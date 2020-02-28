Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01CCC3F2CD
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:44:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8545B246AE
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eyk6vY0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8545B246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 57524833C6;
	Fri, 28 Feb 2020 14:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6moR1lTxg3z8; Fri, 28 Feb 2020 14:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 25D2E826E6;
	Fri, 28 Feb 2020 14:44:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB9BC08A0;
	Fri, 28 Feb 2020 14:44:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8FEDC0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D50C584CBD
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7zQ37WJMZi8B for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 14:44:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DC5D2815BC
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:44:12 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id v2so3162906wrp.12
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QMl+VBaGMao7gyBNUaUbW1tLbhMPTZJMdvofJak/bmM=;
 b=Eyk6vY0Af0pgRHDvnoOLJKEE9DaGoa+4z0NJ0t/WaE+0vf6ERLTI5+gCSTL4JKeEc7
 arJUIl26vcb7lA32WK3mE1Z9pObCrTyBu370u//nTiHn54Qsk9vtBAlncLuZo9K0V9Bo
 few19oXa3fshNwMeLE1X36r0Kl70yyi9UUOxcD7HXOQk57UJt7R/uONrD0jw5QwBKUEP
 XNLUCyENocPiBEBMYBsa65NNpXfx1bwVRSoKhuPD+Y1BFMRjqLFWjj7Bjg+11i79QgS1
 AuuGvqPiln8Z0uHDmfdS0ONpDj/sxIKSFG/mkvrKTjD2nZHB7B4UWE1XulydcVQDQVxM
 5WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QMl+VBaGMao7gyBNUaUbW1tLbhMPTZJMdvofJak/bmM=;
 b=efAZ7VEFxOImM9zXwIqGZZhmJy8XH3/Zop94y9ioo5DEPXrx2JZqPaVuc+o/7CD+2X
 s4O83N1kX9ntSwSn3Hq2YM5cNyJ3rC8Jh5hStdt2njvvcoBCgigbgcbIurM2/i6uxrDF
 24UvsNAKAuJBF5qMCXJLMejnnqd3URpUcXjy5QT6jO0gmcqCmTOgiZIXXZH09kHkhxT3
 6+MbQ30J395ZihqVdx4MEbLWcSfN6YXTLnqJ2HTgMd+1RufVKOJGSTPeWZ1U1kO1Eq7d
 72RKIuiGY5xMp/WI6NCxc3BxCweRffQrO4ALtxHBrP2kLN5zA1q36zz0GIEZUNZpj0II
 fV4Q==
X-Gm-Message-State: APjAAAWRA2PlHKA36Zt9UoHhrT+SU6MaD1FnTt1stue6uyBTtQAXG3Yw
 kqSZ2T0pbtc1fZv6UoOXtBU5qQ==
X-Google-Smtp-Source: APXvYqw6DykiBE32SqEJ+HnRwk8TuEFmQqrz2Fb4Wvuo7oVY88B0FHH4nfUvdWL5pnDIWaqbqIxz+g==
X-Received: by 2002:adf:f648:: with SMTP id x8mr5477186wrp.198.1582901051368; 
 Fri, 28 Feb 2020 06:44:11 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id o27sm13045012wro.27.2020.02.28.06.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 06:44:10 -0800 (PST)
Date: Fri, 28 Feb 2020 15:44:04 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 03/26] iommu: Add a page fault handler
Message-ID: <20200228144404.GD2156@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-4-jean-philippe@linaro.org>
 <20200226135933.000061a0@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200226135933.000061a0@Huawei.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
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

On Wed, Feb 26, 2020 at 01:59:33PM +0000, Jonathan Cameron wrote:
> > +static int iopf_complete(struct device *dev, struct iopf_fault *iopf,
> > +			 enum iommu_page_response_code status)
> 
> This is called once per group.  Should name reflect that?

Ok

[...]
> > +/**
> > + * iommu_queue_iopf - IO Page Fault handler
> > + * @evt: fault event
> > + * @cookie: struct device, passed to iommu_register_device_fault_handler.
> > + *
> > + * Add a fault to the device workqueue, to be handled by mm.
> > + *
> > + * Return: 0 on success and <0 on error.
> > + */
> > +int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> > +{
> > +	int ret;
> > +	struct iopf_group *group;
> > +	struct iopf_fault *iopf, *next;
> > +	struct iopf_device_param *iopf_param;
> > +
> > +	struct device *dev = cookie;
> > +	struct iommu_param *param = dev->iommu_param;
> > +
> > +	if (WARN_ON(!mutex_is_locked(&param->lock)))
> > +		return -EINVAL;
> 
> Just curious...
> 
> Why do we always need a runtime check on this rather than say,
> using lockdep_assert_held or similar?

I probably didn't know about lockdep_assert at the time :)

> > +	/*
> > +	 * It is incredibly easy to find ourselves in a deadlock situation if
> > +	 * we're not careful, because we're taking the opposite path as
> > +	 * iommu_queue_iopf:
> > +	 *
> > +	 *   iopf_queue_flush_dev()   |  PRI queue handler
> > +	 *    lock(&param->lock)      |   iommu_queue_iopf()
> > +	 *     queue->flush()         |    lock(&param->lock)
> > +	 *      wait PRI queue empty  |
> > +	 *
> > +	 * So we can't hold the device param lock while flushing. Take a
> > +	 * reference to the device param instead, to prevent the queue from
> > +	 * going away.
> > +	 */
> > +	mutex_lock(&param->lock);
> > +	iopf_param = param->iopf_param;
> > +	if (iopf_param) {
> > +		queue = param->iopf_param->queue;
> > +		iopf_param->busy = true;
> 
> Describing this as taking a reference is not great...
> I'd change the comment to set a flag or something like that.
> 
> Is there any potential of multiple copies of this running against
> each other?  I've not totally gotten my head around when this
> might be called yet.

Yes it's allowed, this should be a refcount

[...]
> > +int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
> > +{
> > +	int ret = -EINVAL;
> > +	struct iopf_fault *iopf, *next;
> > +	struct iopf_device_param *iopf_param;
> > +	struct iommu_param *param = dev->iommu_param;
> > +
> > +	if (!param || !queue)
> > +		return -EINVAL;
> > +
> > +	do {
> > +		mutex_lock(&queue->lock);
> > +		mutex_lock(&param->lock);
> > +		iopf_param = param->iopf_param;
> > +		if (iopf_param && iopf_param->queue == queue) {
> > +			if (iopf_param->busy) {
> > +				ret = -EBUSY;
> > +			} else {
> > +				list_del(&iopf_param->queue_list);
> > +				param->iopf_param = NULL;
> > +				ret = 0;
> > +			}
> > +		}
> > +		mutex_unlock(&param->lock);
> > +		mutex_unlock(&queue->lock);
> > +
> > +		/*
> > +		 * If there is an ongoing flush, wait for it to complete and
> > +		 * then retry. iopf_param isn't going away since we're the only
> > +		 * thread that can free it.
> > +		 */
> > +		if (ret == -EBUSY)
> > +			wait_event(iopf_param->wq_head, !iopf_param->busy);
> > +		else if (ret)
> > +			return ret;
> > +	} while (ret == -EBUSY);
> 
> I'm in two minds about the next comment (so up to you)...
> 
> Currently this looks a bit odd.  Would you be better off just having a separate
> parameter for busy and explicit separate handling for the error path?
> 
> 	bool busy;
> 	int ret = 0;
> 
> 	do {
> 		mutex_lock(&queue->lock);
> 		mutex_lock(&param->lock);
> 		iopf_param = param->iopf_param;
> 		if (iopf_param && iopf_param->queue == queue) {
> 			busy = iopf_param->busy;
> 			if (!busy) {
> 				list_del(&iopf_param->queue_list);
> 				param->iopf_param = NULL;
> 			}
> 		} else {
> 			ret = -EINVAL;
> 		}
> 		mutex_unlock(&param->lock);
> 		mutex_unlock(&queue->lock);
> 		if (ret)
> 			return ret;
> 		if (busy)
> 			wait_event(iopf_param->wq_head, !iopf_param->busy);
> 		
> 	} while (busy);
> 
> 	..

Sure, I think it looks better

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
