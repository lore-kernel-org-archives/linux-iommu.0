Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2CFC3F2D1
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 14:09:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4816E20848
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 14:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziaLQQMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4816E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DE6FA203B5;
	Wed,  4 Mar 2020 14:09:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N98lhv5rFhwT; Wed,  4 Mar 2020 14:09:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 607F520398;
	Wed,  4 Mar 2020 14:09:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44B6EC1AE2;
	Wed,  4 Mar 2020 14:09:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3E2DC013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 14:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 968DE854C0
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 14:08:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ljaC+0FLCv9g for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 14:08:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9BED5853B9
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 14:08:42 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id y17so2561401wrn.6
 for <iommu@lists.linux-foundation.org>; Wed, 04 Mar 2020 06:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TdUvMeA1bV5hMUNi9Uc9NGFwMrBhsdhhT6ZmBGFQFek=;
 b=ziaLQQMTnCJ7YSxd5sV95qsFJ5sMZH3rtvhOIq0q24OYVAeSN/juNgdJKUXVth7dmC
 +1cTjWWP/8vKz1/4KANL8PnAFbMAGOTkEIQvePO7fVK5ahr5EsdFhICYSslnU6Q/U3YP
 eaY+UNIzqcl1QfHqCD3sojdDlJ5DGbhtfT0Zz1unRHzAIht9z91VeCVs9QSOLqrFrm47
 yYvlbSX/dMxmGH7JaXW06sQkDqq+gICORzdo63QS61gI1f3znBgEbBwZYbXIUzNXW34m
 9I41VXjpTFujhXGbhcU+sCmTSxEf+GPlgeOR7llOnK3kpBjcJOHvuvpYAM84w3umrZVW
 WibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TdUvMeA1bV5hMUNi9Uc9NGFwMrBhsdhhT6ZmBGFQFek=;
 b=A00Enbya/JAOMtitW4Qnis7DxFXC7LQu3CXhl4hry19FouJ/IW3htQemPyPwkedJgG
 nzrjDe99sKpkVE3/dtafZqNxEZsmgp/DDIvVHNFSRRHUrhZhlf44jggssLMR8jaN0gxw
 UBaFsuOaEBnDE32Lumf/MtpxAIHoUmG9C4XyiNDt4KmTn9IfPoC4Hj3f65z105jU5fSC
 T5IlRnmvXmfgyiX6NRg83kPLADymGi0EpbSo7zCOhUQr/LEH5Or1htWcmAF5qVKsx9Qv
 cMUBPrpe6nq3UnXo+RpRVQ170h6s40hPLs/ar69h/bkXfYF3vk7h9+Z5JLMKhdq04+BG
 VXmg==
X-Gm-Message-State: ANhLgQ0ujPhMjUi5PwF4+WVDCe9ilySD2eM7kJFdxtP2pOf8g2RqeWjE
 2NT1v5YASmvFYYSC3Y5xJcVR4A==
X-Google-Smtp-Source: ADFU+vv0sKAwmtjvye94x9YIogv5zw/a9rZvkYsOZEBQWXGc8PUw1JEbwM9HPDBC/WwH/q9h2REFKg==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr4303504wrt.102.1583330920810; 
 Wed, 04 Mar 2020 06:08:40 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p17sm36750450wre.89.2020.03.04.06.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 06:08:39 -0800 (PST)
Date: Wed, 4 Mar 2020 15:08:33 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 23/26] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200304140833.GB646000@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-24-jean-philippe@linaro.org>
 <20200227181726.00007c9a@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200227181726.00007c9a@Huawei.com>
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

On Thu, Feb 27, 2020 at 06:17:26PM +0000, Jonathan Cameron wrote:
> On Mon, 24 Feb 2020 19:23:58 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > The SMMU provides a Stall model for handling page faults in platform
> > devices. It is similar to PCI PRI, but doesn't require devices to have
> > their own translation cache. Instead, faulting transactions are parked and
> > the OS is given a chance to fix the page tables and retry the transaction.
> > 
> > Enable stall for devices that support it (opt-in by firmware). When an
> > event corresponds to a translation error, call the IOMMU fault handler. If
> > the fault is recoverable, it will call us back to terminate or continue
> > the stall.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> One question inline.
> 
> Thanks,
> 
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 271 ++++++++++++++++++++++++++++++++++--
> >  drivers/iommu/of_iommu.c    |   5 +-
> >  include/linux/iommu.h       |   2 +
> >  3 files changed, 269 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 6a5987cce03f..da5dda5ba26a 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -374,6 +374,13 @@
> 
> 
> > +/*
> > + * arm_smmu_flush_evtq - wait until all events currently in the queue have been
> > + *                       consumed.
> > + *
> > + * Wait until the evtq thread finished a batch, or until the queue is empty.
> > + * Note that we don't handle overflows on q->batch. If it occurs, just wait for
> > + * the queue to be empty.
> > + */
> > +static int arm_smmu_flush_evtq(void *cookie, struct device *dev, int pasid)
> > +{
> > +	int ret;
> > +	u64 batch;
> > +	struct arm_smmu_device *smmu = cookie;
> > +	struct arm_smmu_queue *q = &smmu->evtq.q;
> > +
> > +	spin_lock(&q->wq.lock);
> > +	if (queue_sync_prod_in(q) == -EOVERFLOW)
> > +		dev_err(smmu->dev, "evtq overflow detected -- requests lost\n");
> > +
> > +	batch = q->batch;
> 
> So this is trying to be sure we have advanced the queue 2 spots?

So we call arm_smmu_flush_evtq() before decommissioning a PASID, to make
sure that there aren't any pending event for this PASID languishing in the
fault queues.

The main test is queue_empty(). If that succeeds then we know that there
aren't any pending event (and the PASID is safe to reuse). But if new
events are constantly added to the queue then we wait for the evtq thread
to handle a full batch, where one batch corresponds to the queue size. For
that we take the batch number when entering flush(), and wait for the evtq
thread to increment it twice.

> Is there a potential race here?  q->batch could have updated before we take
> a local copy.

Yes we're just checking on the progress of the evtq thread. All accesses
to batch are made while holding the wq lock.

Flush is a rare event so the lock isn't contended, but the wake_up() that
this patch introduces in arm_smmu_evtq_thread() does add some overhead
(0.85% of arm_smmu_evtq_thread(), according to perf). It would be nice to
get rid of it but I haven't found anything clever yet.

Thanks,
Jean

> 
> > +	ret = wait_event_interruptible_locked(q->wq, queue_empty(&q->llq) ||
> > +					      q->batch >= batch + 2);
> > +	spin_unlock(&q->wq.lock);
> > +
> > +	return ret;
> > +}
> > +
> ...
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
