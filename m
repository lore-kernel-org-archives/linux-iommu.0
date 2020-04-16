Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E25FC352BE
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:43:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E489B21D92
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QA2fEkLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E489B21D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BE6E9221AF;
	Thu, 16 Apr 2020 10:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I+i+0BvNnuNw; Thu, 16 Apr 2020 10:43:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A7C59221B2;
	Thu, 16 Apr 2020 10:43:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 943F7C1AE8;
	Thu, 16 Apr 2020 10:43:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C41A2C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AF6E986211
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mcxi5QVdVEno for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 10:43:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 36D3F86208
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587033806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blLQ1WG4QlPs2zX6ID3ETpeKHfqZ3lsJYmWuqd70PNY=;
 b=QA2fEkLWM5rCvb6MYCZGCE725CSDWpfrJ4sUvLHLTx0i43GPqB+pEqewiJtpz69q00198K
 u35iyfjZirQQvjGdGSxCYNyot65FCsx612XcCjmC2kcz/mBWMNs0V1MdJDc0i5Lxyqyk3D
 WLJ6/HkhdhmWbzeJbXADcG+2LRnAi/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-rwKejPqMNGKcmQiGmIzdGQ-1; Thu, 16 Apr 2020 06:43:21 -0400
X-MC-Unique: rwKejPqMNGKcmQiGmIzdGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF41C1005509;
 Thu, 16 Apr 2020 10:43:18 +0000 (UTC)
Received: from [10.36.115.53] (ovpn-115-53.ams2.redhat.com [10.36.115.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F1531001925;
 Thu, 16 Apr 2020 10:43:11 +0000 (UTC)
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
 <20200410124557.4012b99b@jacob-builder>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6d9721a8-2198-5ecd-6c8b-fc43ff2ad7e1@redhat.com>
Date: Thu, 16 Apr 2020 12:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200410124557.4012b99b@jacob-builder>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
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

Hi Jacob,

On 4/10/20 9:45 PM, Jacob Pan wrote:
> Hi Eric,
> 
> On Thu, 9 Apr 2020 09:41:32 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>>
>> On 4/3/20 8:42 PM, Jacob Pan wrote:
>>> When supporting guest SVA with emulated IOMMU, the guest PASID
>>> table is shadowed in VMM. Updates to guest vIOMMU PASID table
>>> will result in PASID cache flush which will be passed down to
>>> the host as bind guest PASID calls.
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
>>> ---
>>> v11: Fixed locking, avoid duplicated paging mode check, added
>>> helper to free svm if device list is empty. Use rate limited error
>>> message since the bind gpasid call comes from user space.
>>> ---
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>>> ---
>>>  drivers/iommu/intel-iommu.c |   4 +
>>>  drivers/iommu/intel-svm.c   | 206
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>> include/linux/intel-iommu.h |   8 +- include/linux/intel-svm.h   |
>>> 17 ++++ 4 files changed, 234 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c
>>> b/drivers/iommu/intel-iommu.c index c0dadec5a6b3..94c7993dac6a
>>> 100644 --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -6178,6 +6178,10 @@ const struct iommu_ops intel_iommu_ops = {
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
>>> index d7f2a5358900..7cf711318b87 100644
>>> --- a/drivers/iommu/intel-svm.c
>>> +++ b/drivers/iommu/intel-svm.c
>>> @@ -226,6 +226,212 @@ static LIST_HEAD(global_svm_list);
>>>  	list_for_each_entry((sdev), &(svm)->devs, list)	\
>>>  		if ((d) != (sdev)->dev) {} else
>>>  
>>> +
>>> +static inline void intel_svm_free_if_empty(struct intel_svm *svm,
>>> u64 pasid) +{
>>> +	if (list_empty(&svm->devs)) {
>>> +		ioasid_set_data(pasid, NULL);
>>> +		kfree(svm);
>>> +	}
>>> +}
>>> +
>>> +int intel_svm_bind_gpasid(struct iommu_domain *domain,
>>> +			struct device *dev,
>>> +			struct iommu_gpasid_bind_data *data)
>>> +{
>>> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>>> +	struct dmar_domain *dmar_domain;
>>> +	struct intel_svm_dev *sdev;
>>> +	struct intel_svm *svm;
>>> +	int ret = 0;
>>> +
>>> +	if (WARN_ON(!iommu) || !data)
>>> +		return -EINVAL;
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
>> What if this is not an mdev device. Is it also allowed?
> Yes. IOMMU and VT-d driver is not mdev aware. Here mdev is just an
> example of normal use case. You can bind the same PCI device (PF or
> SRIOV VF) more than once to the same PASID. Just need to unbind also.

I don't get the point of binding a non mdev device several times with
the same PASID. Do you intend to allow that at userspace level or
prevent this from happening in VFIO?

Besides, the comment is a bit misleading as it gives the impression it
is only true for mdev and there is no associated check.
> 
> Do you see any issues?
no I don't
> 
>>> +			goto out;
>>> +		}
>>> +	} else {
>>> +		/* We come here when PASID has never been bond to
>>> a device. */
>>> +		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
>>> +		if (!svm) {
>>> +			ret = -ENOMEM;
>>> +			goto out;
>>> +		}
>>> +		/* REVISIT: upper layer/VFIO can track host
>>> process that bind the PASID.
>>> +		 * ioasid_set = mm might be sufficient for vfio to
>>> check pasid VMM
>>> +		 * ownership. We can drop the following line once
>>> VFIO and IOASID set
>>> +		 * check is in place.
>>> +		 */
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
>>> +			data->hpasid, ret);
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
>> This function's code looks very very similar to intel_svm_unbind_mm()
>> besides to the mmu_notifier_unregister and the ioasid_free(). Don't we
>> have means to factorize the code by checking the SVM_FLAG_GUEST_MODE
>> flag?
>>
> Yes, I agree there is room to consolidate. But the same time there are
> two potential changes coming:
> 1. I also try to consolidate with Jean's generic sva_bind_device() for
> native bind.
> https://lkml.org/lkml/2020/2/24/1351
> 2. Support enqcmd and lazy PASID free.
> https://lkml.org/lkml/2020/3/30/910
> 
> Perhaps we can revisit after those get resolved?
yep
> 
>> Please could you explain again what does happen if the guest process
>> dies/VM dies. How do we make sure the svm get freed. I fail to
>> understand the whole picture at the moment as you cannot fully rely on
>> the userspace to call unbind_gpasid.
> 
> The fault handling needs to be better documented. Here is the
> current plan as I proposed in the IOASID extension set with IOASID
> notifier.
> https://lkml.org/lkml/2020/3/25/874
> I will do a document in the next version. In short On VT-d, IOASID has
> the following subscribers:
> 1. IOMMU driver, when free comes before unbind, since there is no way
> to hook up with guest mmu_notifier directly.
> 2. KVM, needs to update VMCS PASID translation table. This is needed
> when we support non-identity G-H PASID mapping.
> 3. VDCM (Virtual device composition module), similar to SRIOV PF
> driver, also needs G-H PASID translation.
> 
> So when a guest goes away, based on FD close VFIO needs to free all
> the PASIDs belong to the guest. The proposal is to call
> ioasid_free_set() where the ioasid_set contains all the IOASIDs
> for the VM.
> A blocking notifier will be called, IOMMU gets notified and performs
> all the clean up on IOMMU side as follows:
> 1.clear PASID table entry, flush PASID and IOTLB, devTLB. Drain page
> requests for the PASID. The same thing you would do during unbind.
> 2.mark PASID defunct such that we can drop further DMA faults and PRQ
> 
> For individual guest PASID, the normal order is 
> 1. alloc (via virtual cmd)
> 2. bind_gpasid
> 3. unbind_gpasid
> 4. free (via virtual cmd)
> 
> If 4 comes before 3, free will call ioasid notifier. IOMMU gets
> notified and perform cleanup as above. When unbind comes, there is no
> PASID entry then exit.
[*] could you detail when the free comes before unbind and the opposite?
> 
> One challenge is the cleanup can be lengthy and requires thread
> context. SVA code needed to call ioasid_free in atomic context
> (mmu_notifier release, SRCU callback). This might be changing with
> Jean's patch to defer ioasid_free, this restriction may go away.
> https://www.spinics.net/lists/iommu/msg43065.html
> 
> I still feel the clean up work in notifier handler is too heavy.
> Two options I can think of:
> 1. let VFIO enforce the unbind->free order
depends on [*]
> 2. introduce some reclaim phase for IOASID instead of putting the
> IOASID back to the pool immediately.
what do you mean by reclain phase?

Thanks

Eric
> 
> Any suggestions?

> 
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
>> As per the discussion on the VFIO series, shall we return an error in
>> that case? Same below?
> You mean make unbind a void function? I agree, there is really no way
> to recover. Same for invalidate, which cannot fail.
> Perhaps another series?
> 
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
>>> svm->pasid);  
>> intel_svm_unbind_mm() calls intel_flush_svm_range_dev(svm, sdev, 0,
>> -1, 0); Don't we need to flush the (DEV-)IOTLBs as well?
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
>> s/in/as?
>>> +				 * Unlike native SVM, IOASID for
>>> guest use was
>>> +				 * allocated prior to the bind
>>> call.> +				 * In any case, if the free
>>> call comes before
>>> +				 * the unbind, IOMMU driver will
>>> get notified
>>> +				 * and perform cleanup.
>>> +				 */
>>> +				ioasid_set_data(pasid, NULL);
>>> +				kfree(svm);
>>> +			}  
>> nit: you may use intel_svm_free_if_empty()
>>> +		}
>>> +		break;
>>> +	}
>>> +out:
>>> +	mutex_unlock(&pasid_mutex);
>>> +  
>> nit : spare new line
> Sounds good.
> 
>>> +	return ret;
>>> +}
>>> +
>>>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
>>> struct svm_dev_ops *ops) {
>>>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>>> diff --git a/include/linux/intel-iommu.h
>>> b/include/linux/intel-iommu.h index 6da03f627ba3..a5bd53cf190c
>>> 100644 --- a/include/linux/intel-iommu.h
>>> +++ b/include/linux/intel-iommu.h
>>> @@ -706,7 +706,9 @@ struct dmar_domain *find_domain(struct device
>>> *dev); extern void intel_svm_check(struct intel_iommu *iommu);
>>>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>>>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>>> -
>>> +extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
>>> +		struct device *dev, struct iommu_gpasid_bind_data
>>> *data); +extern int intel_svm_unbind_gpasid(struct device *dev, int
>>> pasid); struct svm_dev_ops;
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
>>> + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this
>>> API provides
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
>>> + */
>>> +#define SVM_FLAG_GUEST_PASID	(1<<3)
>>>  
>>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>>  
>>>   
>> Thanks
>>
>> Eric
>>
> 
> [Jacob Pan]
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
