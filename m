Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D6CC83006
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 14:12:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBA32083B
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 14:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y16NAWU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBA32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CA128869F5;
	Wed, 29 Apr 2020 14:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gfaz27y-7p_l; Wed, 29 Apr 2020 14:12:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 89C93869C9;
	Wed, 29 Apr 2020 14:12:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 793AFC0865;
	Wed, 29 Apr 2020 14:12:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CFB8C0172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 14:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 559CF88408
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 14:12:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FgWiV9QLUuEn for <iommu@lists.linux-foundation.org>;
 Wed, 29 Apr 2020 14:12:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CB4AA883D6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588169550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5l/dsGX4RHSRd7zx9MPiHkWDn/OF3EPIfoo26HQ4QvQ=;
 b=Y16NAWU4eylp26oD0XREIi5URQB17S0qJmzH4lF4KjPiKuX5shUhDB/wmulX0I7HyW1p+o
 3kLLHU6eDBPXujavXAoxBgVVKRIi4hwIzW7UxlIEdq2QYCKH7NRdiIwQayZPa4g8N3LGP6
 V1qDPRD4ujq5LUXhtvC/V6/DtJKnMzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-03yHP52-OUi3PHJer3vEzQ-1; Wed, 29 Apr 2020 10:12:14 -0400
X-MC-Unique: 03yHP52-OUi3PHJer3vEzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3263818B5FC7;
 Wed, 29 Apr 2020 14:12:12 +0000 (UTC)
Received: from [10.36.113.114] (ovpn-113-114.ams2.redhat.com [10.36.113.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A2B11001281;
 Wed, 29 Apr 2020 14:12:04 +0000 (UTC)
Subject: Re: [PATCH v12 4/8] iommu/vt-d: Add bind guest PASID support
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <1587495165-80096-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1587495165-80096-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8A0D03@SHSMSX104.ccr.corp.intel.com>
 <20200427133409.47ba22b2@jacob-builder>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <72d52eba-8c78-9d99-2537-b03dbfb3b543@redhat.com>
Date: Wed, 29 Apr 2020 16:12:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200427133409.47ba22b2@jacob-builder>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jonathan Cameron <jic23@kernel.org>
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

Hi,

On 4/27/20 10:34 PM, Jacob Pan wrote:
> On Fri, 24 Apr 2020 10:47:45 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Sent: Wednesday, April 22, 2020 2:53 AM
>>>
>>> When supporting guest SVA with emulated IOMMU, the guest PASID
>>> table is shadowed in VMM. Updates to guest vIOMMU PASID table
>>> will result in PASID cache flush which will be passed down to
>>> the host as bind guest PASID calls.  
>>
>> Above description is not accurate. Guest PASID table updates don't
>> 'result in' PASID cache flush automatically. What about:
>> --
>> The guest needs to invalidate the PASID cache for any update to
>> guest PASID table. Those invalidation requests are intercepted
>> by the VMM and passed down to the host as binding guest PASID
>> calls.
>> --
> It is good to add more details, thanks.
> 
>>>
>>> For the SL page tables, it will be harvested from device's
>>> default domain (request w/o PASID), or aux domain in case of
>>> mediated device.
>>>
>>>     .-------------.  .---------------------------.
>>>     |   vIOMMU    |  | Guest process CR3, FL only|
>>>     |             |  '---------------------------'
>>>     .----------------/
>>>     | PASID Entry |--- PASID cache flush -
>>>     '-------------'                       |
>>>     |             |                       V
>>>     |             |                CR3 in GPA
>>>     '-------------'
>>> Guest
>>> ------| Shadow |--------------------------|--------
>>>       v        v                          v
>>> Host
>>>     .-------------.  .----------------------.
>>>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>>>     |             |  '----------------------'
>>>     .----------------/  |
>>>     | PASID Entry |     V (Nested xlate)
>>>     '----------------\.------------------------------.
>>>     |             |   |SL for GPA-HPA, default domain|
>>>     |             |   '------------------------------'
>>>     '-------------'
>>> Where:
>>>  - FL = First level/stage one page tables
>>>  - SL = Second level/stage two page tables
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>>> ---
>>>  drivers/iommu/intel-iommu.c |   4 +
>>>  drivers/iommu/intel-svm.c   | 204
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/intel-iommu.h |   8 +-
>>>  include/linux/intel-svm.h   |  17 ++++
>>>  4 files changed, 232 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c
>>> b/drivers/iommu/intel-iommu.c index 9c01e391a931..8862d6b0ef21
>>> 100644 --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -6179,6 +6179,10 @@ const struct iommu_ops intel_iommu_ops = {
>>>  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>>>  	.is_attach_deferred	=
>>> intel_iommu_is_attach_deferred, .pgsize_bitmap		=
>>> INTEL_IOMMU_PGSIZES, +#ifdef CONFIG_INTEL_IOMMU_SVM
>>> +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
>>> +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
>>> +#endif
>>>  };
>>>
>>>  static void quirk_iommu_igfx(struct pci_dev *dev)
>>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>>> index 2998418f0a38..69b2070b843d 100644
>>> --- a/drivers/iommu/intel-svm.c
>>> +++ b/drivers/iommu/intel-svm.c
>>> @@ -226,6 +226,210 @@ static LIST_HEAD(global_svm_list);
>>>  	list_for_each_entry((sdev), &(svm)->devs, list)	\
>>>  		if ((d) != (sdev)->dev) {} else
>>>
>>> +static inline void intel_svm_free_if_empty(struct intel_svm *svm,
>>> u64 pasid) +{
>>> +	if (list_empty(&svm->devs)) {
>>> +		ioasid_set_data(pasid, NULL);
>>> +		kfree(svm);
>>> +	}
>>> +}  
>>
>> Do we really need a function form instead of putting the 4 lines
>> directly after the 'out' label?
>>
> it is more readable and good for code sharing.
That's my fault: I suggested to add this helper because I noticed this
was repeated several times in the code. But adding a new goto label to
handle that job is identical.


> 
>>> +
>>> +int intel_svm_bind_gpasid(struct iommu_domain *domain, struct
>>> device *dev,
>>> +			  struct iommu_gpasid_bind_data *data)
>>> +{
>>> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>>> +	struct dmar_domain *dmar_domain;
>>> +	struct intel_svm_dev *sdev;
>>> +	struct intel_svm *svm;
>>> +	int ret = 0;
>>> +
>>> +	if (WARN_ON(!iommu) || !data)
>>> +		return -EINVAL;  
>>
>> well, why not checking !dev together?
> This is kernel API, unlike iommu and data caller fills in dev directly.
> 
>>
>>> +
>>> +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
>>> +	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
>>> +		return -EINVAL;
>>> +
>>> +	if (dev_is_pci(dev)) {
>>> +		/* VT-d supports devices with full 20 bit PASIDs
>>> only */
>>> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
>>> +			return -EINVAL;
>>> +	} else {
>>> +		return -ENOTSUPP;
>>> +	}
>>> +
>>> +	/*
>>> +	 * We only check host PASID range, we have no knowledge to
>>> check
>>> +	 * guest PASID range.
>>> +	 */
>>> +	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
>>> +		return -EINVAL;
>>> +
>>> +	dmar_domain = to_dmar_domain(domain);
>>> +
>>> +	mutex_lock(&pasid_mutex);
>>> +	svm = ioasid_find(NULL, data->hpasid, NULL);
>>> +	if (IS_ERR(svm)) {
>>> +		ret = PTR_ERR(svm);
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (svm) {
>>> +		/*
>>> +		 * If we found svm for the PASID, there must be at
>>> +		 * least one device bond, otherwise svm should be
>>> freed.
>>> +		 */
>>> +		if (WARN_ON(list_empty(&svm->devs))) {
>>> +			ret = -EINVAL;
>>> +			goto out;
>>> +		}
>>> +
>>> +		for_each_svm_dev(sdev, svm, dev) {
>>> +			/* In case of multiple sub-devices of the
>>> same pdev
>>> +			 * assigned, we should allow multiple bind
>>> calls with
>>> +			 * the same PASID and pdev.
>>> +			 */
>>> +			sdev->users++;
>>> +			goto out;  
>>
>> in last review Eric raised the open about what about binding the same
>> PASID to the same pdev multiple times. We discussed that should be
>> disallowed. Here can you check whether aux_domain is enabled on pdev
>> to restrict multiple-binding only for sub-devices?
> Why aux_domain is sufficient? A pdev could have aux_domain enabled but
> still bind pdev many times more than its mdevs.
> 
> Either we allow multiple bind or not.

I tried to figure out whether binding the same PASID to the same pdev
was meaningful. I understood it is not. If this case can be detected at
VFIO level I am fine as well.

Thanks

Eric
> 
>>
>>> +		}
>>> +	} else {
>>> +		/* We come here when PASID has never been bond to a
>>> device. */
>>> +		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
>>> +		if (!svm) {
>>> +			ret = -ENOMEM;
>>> +			goto out;
>>> +		}
>>> +		/* REVISIT: upper layer/VFIO can track host
>>> process that bind
>>> +		 * the PASID. ioasid_set = mm might be sufficient
>>> for vfio to
>>> +		 * check pasid VMM ownership. We can drop the
>>> following line
>>> +		 * once VFIO and IOASID set check is in place.
>>> +		 */  
>>
>> there is no check below this comment. Following lines are simply
>> initializing the svm fields.
>>
> What it meant to say is that once IOASID set is checked in VFIO layer,
> we can drop the assignment of svm->mm, IOMMU driver will not check.
> 
> You are right, this is just a place holder to help handle many moving
> pieces.
> 
>>> +		svm->mm = get_task_mm(current);
>>> +		svm->pasid = data->hpasid;
>>> +		if (data->flags & IOMMU_SVA_GPASID_VAL) {
>>> +			svm->gpasid = data->gpasid;
>>> +			svm->flags |= SVM_FLAG_GUEST_PASID;
>>> +		}
>>> +		ioasid_set_data(data->hpasid, svm);
>>> +		INIT_LIST_HEAD_RCU(&svm->devs);
>>> +		mmput(svm->mm);
>>> +	}
>>> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
>>> +	if (!sdev) {
>>> +		/*
>>> +		 * If this is a new PASID that never bond to a
>>> device, then
>>> +		 * the device list must be empty which indicates
>>> struct svm
>>> +		 * was allocated in this function.
>>> +		 */
>>> +		intel_svm_free_if_empty(svm, data->hpasid);
>>> +		ret = -ENOMEM;
>>> +		goto out;
>>> +	}
>>> +	sdev->dev = dev;
>>> +	sdev->users = 1;
>>> +
>>> +	/* Set up device context entry for PASID if not enabled
>>> already */
>>> +	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
>>> +	if (ret) {
>>> +		dev_err_ratelimited(dev, "Failed to enable PASID
>>> capability\n");  
>>
>> print hpasid 
> 
> OK, sounds good.
>>
>>> +		kfree(sdev);
>>> +		intel_svm_free_if_empty(svm, data->hpasid);
>>> +		goto out;
>>> +	}
>>> +
>>> +	/*
>>> +	 * PASID table is per device for better security.
>>> Therefore, for
>>> +	 * each bind of a new device even with an existing PASID,
>>> we need to
>>> +	 * call the nested mode setup function here.
>>> +	 */
>>> +	spin_lock(&iommu->lock);
>>> +	ret = intel_pasid_setup_nested(iommu,
>>> +				       dev,
>>> +				       (pgd_t *)data->gpgd,
>>> +				       data->hpasid,
>>> +				       &data->vtd,
>>> +				       dmar_domain,
>>> +				       data->addr_width);
>>> +	if (ret) {
>>> +		dev_err_ratelimited(dev, "Failed to set up PASID
>>> %llu in nested mode, Err %d\n",
>>> +				    data->hpasid, ret);
>>> +		/*
>>> +		 * PASID entry should be in cleared state if
>>> nested mode
>>> +		 * set up failed. So we only need to clear IOASID
>>> tracking
>>> +		 * data such that free call will succeed.
>>> +		 */
>>> +		kfree(sdev);
>>> +		intel_svm_free_if_empty(svm, data->hpasid);
>>> +		spin_unlock(&iommu->lock);
>>> +		goto out;
>>> +	}
>>> +	spin_unlock(&iommu->lock);  
>>
>> spin_unlock can be moved before if(ret)?
> Yes, good point. We can combine the unlock.
> 
>>
>>> +	svm->flags |= SVM_FLAG_GUEST_MODE;
>>> +
>>> +	init_rcu_head(&sdev->rcu);
>>> +	list_add_rcu(&sdev->list, &svm->devs);
>>> + out:
>>> +	mutex_unlock(&pasid_mutex);
>>> +	return ret;
>>> +}
>>> +
>>> +int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>>> +{
>>> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>>> +	struct intel_svm_dev *sdev;
>>> +	struct intel_svm *svm;
>>> +	int ret = -EINVAL;
>>> +
>>> +	if (WARN_ON(!iommu))
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&pasid_mutex);
>>> +	svm = ioasid_find(NULL, pasid, NULL);
>>> +	if (!svm) {
>>> +		ret = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (IS_ERR(svm)) {
>>> +		ret = PTR_ERR(svm);
>>> +		goto out;
>>> +	}
>>> +
>>> +	for_each_svm_dev(sdev, svm, dev) {
>>> +		ret = 0;
>>> +		sdev->users--;
>>> +		if (!sdev->users) {
>>> +			list_del_rcu(&sdev->list);
>>> +			intel_pasid_tear_down_entry(iommu, dev,
>>> svm-  
>>>> pasid);  
>>> +			intel_flush_svm_range_dev(svm, sdev, 0,
>>> -1, 0);
>>> +			/* TODO: Drain in flight PRQ for the PASID
>>> since it
>>> +			 * may get reused soon, we don't want to
>>> +			 * confuse with its previous life.
>>> +			 * intel_svm_drain_prq(dev, pasid);
>>> +			 */
>>> +			kfree_rcu(sdev, rcu);
>>> +
>>> +			if (list_empty(&svm->devs)) {
>>> +				/*
>>> +				 * We do not free the IOASID here
>>> in that
>>> +				 * IOMMU driver did not allocate
>>> it.
>>> +				 * Unlike native SVM, IOASID for
>>> guest use was
>>> +				 * allocated prior to the bind
>>> call.
>>> +				 * In any case, if the free call
>>> comes before
>>> +				 * the unbind, IOMMU driver will
>>> get notified
>>> +				 * and perform cleanup.
>>> +				 */
>>> +				ioasid_set_data(pasid, NULL);
>>> +				kfree(svm);
>>> +			}  
>>
>> is it safer moving above empty check outside of the loop?
> why? could you explain.
> 
> Note that this is not a loop.
> 
>>
>>> +		}
>>> +		break;
>>> +	}
>>> +out:
>>> +	mutex_unlock(&pasid_mutex);
>>> +	return ret;
>>> +}
>>> +
>>>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
>>> struct svm_dev_ops *ops)
>>>  {
>>>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>>> diff --git a/include/linux/intel-iommu.h
>>> b/include/linux/intel-iommu.h index 6da03f627ba3..c8ce2336f8d8
>>> 100644 --- a/include/linux/intel-iommu.h
>>> +++ b/include/linux/intel-iommu.h
>>> @@ -706,7 +706,9 @@ struct dmar_domain *find_domain(struct device
>>> *dev);
>>>  extern void intel_svm_check(struct intel_iommu *iommu);
>>>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>>>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>>> -
>>> +int intel_svm_bind_gpasid(struct iommu_domain *domain, struct
>>> device *dev,
>>> +			  struct iommu_gpasid_bind_data *data);
>>> +int intel_svm_unbind_gpasid(struct device *dev, int pasid);
>>>  struct svm_dev_ops;
>>>
>>>  struct intel_svm_dev {
>>> @@ -723,9 +725,13 @@ struct intel_svm_dev {
>>>  struct intel_svm {
>>>  	struct mmu_notifier notifier;
>>>  	struct mm_struct *mm;
>>> +
>>>  	struct intel_iommu *iommu;
>>>  	int flags;
>>>  	int pasid;
>>> +	int gpasid; /* Guest PASID in case of vSVA bind with
>>> non-identity host
>>> +		     * to guest PASID mapping.
>>> +		     */  
>>
>> /* in case that guest PASID is different from host PASID */
> OK, will do.
> 
>>
>>>  	struct list_head devs;
>>>  	struct list_head list;
>>>  };
>>> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
>>> index d7c403d0dd27..c19690937540 100644
>>> --- a/include/linux/intel-svm.h
>>> +++ b/include/linux/intel-svm.h
>>> @@ -44,6 +44,23 @@ struct svm_dev_ops {
>>>   * do such IOTLB flushes automatically.
>>>   */
>>>  #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
>>> +/*
>>> + * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind
>>> to a device.
>>> + * In this case the mm_struct is in the guest kernel or userspace,
>>> its life  
>>
>> this statement is confusing. We still have mm_struct in the host side
>> to claim the ownership of a PASID.
>>
> How about this:
> /*
>  * The SVM_FLAG_GUEST_MODE flag is used when a PASID bind is for guest
>  * processes. Compared to the host bind, the primary differences are:
>  * 1. mm life cycle management
>  * 2. fault reporting
>  */
> 
>>> + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this
>>> API  
>>
>> why is a flag becoming an API?
>>
> will refer as flag.
> 
>>> provides
>>> + * means to bind/unbind guest CR3 with PASIDs allocated for a
>>> device.
>>> + */
>>> +#define SVM_FLAG_GUEST_MODE	(1<<2)
>>> +/*
>>> + * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own
>>> PASID space,
>>> + * which requires guest and host PASID translation at both
>>> directions. We keep
>>> + * track of guest PASID in order to provide lookup service to
>>> device drivers.
>>> + * One such example is a physical function (PF) driver that
>>> supports mediated
>>> + * device (mdev) assignment. Guest programming of mdev
>>> configuration space can
>>> + * only be done with guest PASID, therefore PF driver needs to
>>> find the matching
>>> + * host PASID to program the real hardware.  
>>
>> I feel such example doesn't belong here, which is purely userspace
>> policy. Here just describe what the flag is for should be sufficient.
>>
> Will remove the example. How about this?
> 
> /*
>  * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own PASID space,
>  * which requires guest and host PASID translation at both directions.
>  */
> 
> 
>>> + */
>>> +#define SVM_FLAG_GUEST_PASID	(1<<3)
>>>
>>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>>
>>> --
>>> 2.7.4  
>>
>> Thanks
>> Kevin
>>
> 
> [Jacob Pan]
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
