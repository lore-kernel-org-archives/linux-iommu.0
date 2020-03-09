Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A93C10F27
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 10:48:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AE820674
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 10:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AE820674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D6115250D0;
	Mon,  9 Mar 2020 10:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wc4kyMV3LumC; Mon,  9 Mar 2020 10:48:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 199DE250B5;
	Mon,  9 Mar 2020 10:48:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE98AC18D3;
	Mon,  9 Mar 2020 10:48:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02734C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 10:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DF05987747
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 10:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PVIQTonZJZdk for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 10:48:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 58FEA8772C
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 10:48:43 +0000 (UTC)
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id E289F9BDFECA97C73EEA;
 Mon,  9 Mar 2020 10:48:39 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 10:48:39 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 9 Mar 2020
 10:48:39 +0000
Date: Mon, 9 Mar 2020 10:48:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 23/26] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200309104826.000052c1@Huawei.com>
In-Reply-To: <20200304140833.GB646000@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-24-jean-philippe@linaro.org>
 <20200227181726.00007c9a@Huawei.com>
 <20200304140833.GB646000@myrica>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
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

On Wed, 4 Mar 2020 15:08:33 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Thu, Feb 27, 2020 at 06:17:26PM +0000, Jonathan Cameron wrote:
> > On Mon, 24 Feb 2020 19:23:58 +0100
> > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> >   
> > > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > > 
> > > The SMMU provides a Stall model for handling page faults in platform
> > > devices. It is similar to PCI PRI, but doesn't require devices to have
> > > their own translation cache. Instead, faulting transactions are parked and
> > > the OS is given a chance to fix the page tables and retry the transaction.
> > > 
> > > Enable stall for devices that support it (opt-in by firmware). When an
> > > event corresponds to a translation error, call the IOMMU fault handler. If
> > > the fault is recoverable, it will call us back to terminate or continue
> > > the stall.
> > > 
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>  
> > One question inline.
> > 
> > Thanks,
> >   
> > > ---
> > >  drivers/iommu/arm-smmu-v3.c | 271 ++++++++++++++++++++++++++++++++++--
> > >  drivers/iommu/of_iommu.c    |   5 +-
> > >  include/linux/iommu.h       |   2 +
> > >  3 files changed, 269 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > > index 6a5987cce03f..da5dda5ba26a 100644
> > > --- a/drivers/iommu/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > @@ -374,6 +374,13 @@  
> > 
> >   
> > > +/*
> > > + * arm_smmu_flush_evtq - wait until all events currently in the queue have been
> > > + *                       consumed.
> > > + *
> > > + * Wait until the evtq thread finished a batch, or until the queue is empty.
> > > + * Note that we don't handle overflows on q->batch. If it occurs, just wait for
> > > + * the queue to be empty.
> > > + */
> > > +static int arm_smmu_flush_evtq(void *cookie, struct device *dev, int pasid)
> > > +{
> > > +	int ret;
> > > +	u64 batch;
> > > +	struct arm_smmu_device *smmu = cookie;
> > > +	struct arm_smmu_queue *q = &smmu->evtq.q;
> > > +
> > > +	spin_lock(&q->wq.lock);
> > > +	if (queue_sync_prod_in(q) == -EOVERFLOW)
> > > +		dev_err(smmu->dev, "evtq overflow detected -- requests lost\n");
> > > +
> > > +	batch = q->batch;  
> > 
> > So this is trying to be sure we have advanced the queue 2 spots?  
> 
> So we call arm_smmu_flush_evtq() before decommissioning a PASID, to make
> sure that there aren't any pending event for this PASID languishing in the
> fault queues.
> 
> The main test is queue_empty(). If that succeeds then we know that there
> aren't any pending event (and the PASID is safe to reuse). But if new
> events are constantly added to the queue then we wait for the evtq thread
> to handle a full batch, where one batch corresponds to the queue size. For
> that we take the batch number when entering flush(), and wait for the evtq
> thread to increment it twice.
> 
> > Is there a potential race here?  q->batch could have updated before we take
> > a local copy.  
> 
> Yes we're just checking on the progress of the evtq thread. All accesses
> to batch are made while holding the wq lock.
> 
> Flush is a rare event so the lock isn't contended, but the wake_up() that
> this patch introduces in arm_smmu_evtq_thread() does add some overhead
> (0.85% of arm_smmu_evtq_thread(), according to perf). It would be nice to
> get rid of it but I haven't found anything clever yet.
> 

Thanks.  Maybe worth a few comments in the code as this is a bit esoteric.

Thanks,

Jonathan

> Thanks,
> Jean
> 
> >   
> > > +	ret = wait_event_interruptible_locked(q->wq, queue_empty(&q->llq) ||
> > > +					      q->batch >= batch + 2);
> > > +	spin_unlock(&q->wq.lock);
> > > +
> > > +	return ret;
> > > +}
> > > +  
> > ...
> >   


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
