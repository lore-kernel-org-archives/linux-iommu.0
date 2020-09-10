Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0619FC433E2
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 04:52:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4CB2076C
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 04:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4CB2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 187978756D;
	Thu, 10 Sep 2020 04:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6dd+4G1oHzIo; Thu, 10 Sep 2020 04:52:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E20CC8742F;
	Thu, 10 Sep 2020 04:52:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA052C0052;
	Thu, 10 Sep 2020 04:52:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42A3DC0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 04:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 26B1786D8F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 04:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e3oBKxteTeA6 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 04:52:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F238E86D8D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 04:52:04 +0000 (UTC)
IronPort-SDR: g0TCNwwDXIB2zZmqTLnGxYlMmpBPsAiTHw/07bj2MQGJ/1ZhH7Ck9B8SkI7KcdKOpl6gIRGgMD
 FHqbn2//lEew==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146175874"
X-IronPort-AV: E=Sophos;i="5.76,411,1592895600"; d="scan'208";a="146175874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2020 21:52:04 -0700
IronPort-SDR: ybM7utIM3tI1zsR/N7KaPzTywMXbChDxWnxcrMYKWOFOf12CYhCA4ultd9N3YBBDyn1MzZJnE4
 0YFzUzU6a+rg==
X-IronPort-AV: E=Sophos;i="5.76,411,1592895600"; d="scan'208";a="344124585"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2020 21:52:04 -0700
Date: Wed, 9 Sep 2020 21:54:02 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 7/9] iommu/vt-d: Listen to IOASID notifications
Message-ID: <20200909215402.03f1b470@jacob-builder>
In-Reply-To: <e9394a9e-c9d0-9ebc-30a7-745e6b6d8fa0@redhat.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-8-git-send-email-jacob.jun.pan@linux.intel.com>
 <e9394a9e-c9d0-9ebc-30a7-745e6b6d8fa0@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Wu Hao <hao.wu@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Tue, 1 Sep 2020 19:03:23 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 8/22/20 6:35 AM, Jacob Pan wrote:
> > On Intel Scalable I/O Virtualization (SIOV) enabled platforms, IOMMU
> > driver is one of the users of IOASIDs. In normal flow, callers will
> > perform IOASID allocation, bind, unbind, and free in order. However, for
> > guest SVA, IOASID free could come before unbind as guest is untrusted.
> > This patch registers IOASID notification handler such that IOMMU driver
> > can perform PASID teardown upon receiving an unexpected IOASID free
> > event.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/svm.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/intel-iommu.h |  2 ++
> >  2 files changed, 75 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index 634e191ca2c3..600e3ae5b656 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -95,6 +95,72 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
> >  	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
> >  }
> >  
> > +#define pasid_lock_held() lock_is_held(&pasid_mutex.dep_map)  
> put after the pasid_mutex definition?
yes,

> > +static DEFINE_MUTEX(pasid_mutex);
> > +
> > +static void intel_svm_free_async_fn(struct work_struct *work)
> > +{
> > +	struct intel_svm *svm = container_of(work, struct intel_svm, work);
> > +	struct intel_svm_dev *sdev;
> > +
> > +	/*
> > +	 * Unbind all devices associated with this PASID which is
> > +	 * being freed by other users such as VFIO.
> > +	 */
> > +	mutex_lock(&pasid_mutex);
> > +	list_for_each_entry_rcu(sdev, &svm->devs, list, pasid_lock_held()) {
> > +		/* Does not poison forward pointer */
> > +		list_del_rcu(&sdev->list);
> > +		spin_lock(&svm->iommu->lock);
> > +		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
> > +					svm->pasid, true);
> > +		spin_unlock(&svm->iommu->lock);
> > +		kfree_rcu(sdev, rcu);
> > +		/*
> > +		 * Free before unbind only happens with guest usaged  
> usaged?
used. I meant host PASID used to back guest PASID. I will reword the comments:
		/*
		 * Free before unbind can only happen with host PASIDs used for
		 * guest SVM. We get here because ioasid_free is called with
		 * outstanding references. So we need to drop the reference
		 * such that the PASID can be reclaimed. Once refcount reaches
		 * zero, IOASID core will detach the private data and erase the
		 * IOASID entry.
		 */

> > +		 * host PASIDs. IOASID free will detach private data
> > +		 * and free the IOASID entry.
> > +		 */
> > +		ioasid_put(NULL, svm->pasid);
> > +		if (list_empty(&svm->devs))
> > +			kfree(svm);
> > +	}
> > +	mutex_unlock(&pasid_mutex);
> > +}
> > +
> > +
> > +static int pasid_status_change(struct notifier_block *nb,
> > +				unsigned long code, void *data)
> > +{
> > +	struct ioasid_nb_args *args = (struct ioasid_nb_args *)data;
> > +	struct intel_svm *svm = (struct intel_svm *)args->pdata;
> > +	int ret = NOTIFY_DONE;
> > +
> > +	if (code == IOASID_FREE) {
> > +		if (!svm)
> > +			goto done;
> > +		if (args->id != svm->pasid) {
> > +			pr_warn("Notify PASID does not match data %d : %d\n",
> > +				args->id, svm->pasid);
> > +			goto done;
> > +		}
> > +		schedule_work(&svm->work);
> > +		return NOTIFY_OK;
> > +	}
> > +done:
> > +	return ret;> +}
> > +
> > +static struct notifier_block pasid_nb = {
> > +	.notifier_call = pasid_status_change,
> > +};
> > +
> > +void intel_svm_add_pasid_notifier(void)
> > +{
> > +	/* Listen to all PASIDs, not specific to a set */
> > +	ioasid_register_notifier(NULL, &pasid_nb);
> > +}
> > +
> >  void intel_svm_check(struct intel_iommu *iommu)
> >  {
> >  	if (!pasid_supported(iommu))
> > @@ -221,7 +287,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
> >  	.invalidate_range = intel_invalidate_range,
> >  };
> >  
> > -static DEFINE_MUTEX(pasid_mutex);
> >  static LIST_HEAD(global_svm_list);
> >  
> >  #define for_each_svm_dev(sdev, svm, d)			\
> > @@ -342,7 +407,14 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
> >  			svm->gpasid = data->gpasid;
> >  			svm->flags |= SVM_FLAG_GUEST_PASID;
> >  		}
> > +		svm->iommu = iommu;
> > +		/*
> > +		 * Set up cleanup async work in case IOASID core notify us PASID
> > +		 * is freed before unbind.
> > +		 */
> > +		INIT_WORK(&svm->work, intel_svm_free_async_fn);
> >  		ioasid_attach_data(data->hpasid, svm);
> > +		ioasid_get(NULL, svm->pasid);
> >  		INIT_LIST_HEAD_RCU(&svm->devs);
> >  		mmput(svm->mm);
> >  	}
> > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > index b1ed2f25f7c0..d36038e6ae0b 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
> >  int intel_svm_get_pasid(struct iommu_sva *handle);
> >  int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
> >  			    struct iommu_page_response *msg);
> > +void intel_svm_add_pasid_notifier(void);
> >  
> >  struct svm_dev_ops;
> >  
> > @@ -770,6 +771,7 @@ struct intel_svm {
> >  	int gpasid; /* In case that guest PASID is different from host PASID */
> >  	struct list_head devs;
> >  	struct list_head list;
> > +	struct work_struct work; /* For deferred clean up */
> >  };
> >  #else
> >  static inline void intel_svm_check(struct intel_iommu *iommu) {}
> >   
> 
> Thanks
> 
> Eric
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
