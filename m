Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E2FC433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 07:37:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DC720724
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 07:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DC720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DD793884DD;
	Mon,  6 Jul 2020 07:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uIjomh-rY+WS; Mon,  6 Jul 2020 07:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D8DAE88263;
	Mon,  6 Jul 2020 07:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF8D9C0888;
	Mon,  6 Jul 2020 07:37:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 327CBC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 07:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 18BB68832D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 07:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hFEEt6gjjg0V for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 07:37:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 35E1A88263
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 07:37:54 +0000 (UTC)
IronPort-SDR: 0C63BhRLkmAEepCosCgakpU5JGDo2udf0XGKE4d2To4TP8cJ+I4ynqIs+CSUumPiGIgLtr7JFx
 xMCGVHzZWVlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="147374757"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="147374757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 00:37:54 -0700
IronPort-SDR: SlAGU413MyPcArQKxFAkeu8yJ69f/QyGqY9EQKtgHwJWmecCWSKutcU9H9iwcaUkjOScMmbTOo
 A4x514GdG0BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="456610146"
Received: from xiaoranf-mobl2.ccr.corp.intel.com (HELO [10.255.28.11])
 ([10.255.28.11])
 by orsmga005.jf.intel.com with ESMTP; 06 Jul 2020 00:37:51 -0700
Subject: Re: [PATCH v2 3/4] iommu/vt-d: Report page request faults for guest
 SVA
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
 <20200706002535.9381-4-baolu.lu@linux.intel.com>
 <MWHPR11MB1645466566F629CE524ED9C58C690@MWHPR11MB1645.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9559521a-7d69-e937-bcbc-e96a7d8fef8b@linux.intel.com>
Date: Mon, 6 Jul 2020 15:37:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1645466566F629CE524ED9C58C690@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Kevin,

On 2020/7/6 9:29, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, July 6, 2020 8:26 AM
>>
>> A pasid might be bound to a page table from a VM guest via the iommu
>> ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
>> on the physical IOMMU, we need to inject the page fault request into
>> the guest. After the guest completes handling the page fault, a page
>> response need to be sent back via the iommu ops.page_response().
>>
>> This adds support to report a page request fault. Any external module
>> which is interested in handling this fault should regiester a notifier
>> callback.
> 
> be specific on which notifier to be registered...

Sure.

> 
>>
>> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/svm.c | 99 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 81 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index c23167877b2b..08c58c2b1a06 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -815,6 +815,57 @@ static void intel_svm_drain_prq(struct device *dev,
>> int pasid)
>>   	}
>>   }
>>
>> +static int prq_to_iommu_prot(struct page_req_dsc *req)
>> +{
>> +	int prot = 0;
>> +
>> +	if (req->rd_req)
>> +		prot |= IOMMU_FAULT_PERM_READ;
>> +	if (req->wr_req)
>> +		prot |= IOMMU_FAULT_PERM_WRITE;
>> +	if (req->exe_req)
>> +		prot |= IOMMU_FAULT_PERM_EXEC;
>> +	if (req->pm_req)
>> +		prot |= IOMMU_FAULT_PERM_PRIV;
>> +
>> +	return prot;
>> +}
>> +
>> +static int
>> +intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
>> +{
>> +	struct iommu_fault_event event;
>> +	u8 bus, devfn;
>> +
>> +	memset(&event, 0, sizeof(struct iommu_fault_event));
>> +	bus = PCI_BUS_NUM(desc->rid);
>> +	devfn = desc->rid & 0xff;
> 
> not required.

Yes. Will remove them.

> 
>> +
>> +	/* Fill in event data for device specific processing */
>> +	event.fault.type = IOMMU_FAULT_PAGE_REQ;
>> +	event.fault.prm.addr = desc->addr;
>> +	event.fault.prm.pasid = desc->pasid;
>> +	event.fault.prm.grpid = desc->prg_index;
>> +	event.fault.prm.perm = prq_to_iommu_prot(desc);
>> +
>> +	/*
>> +	 * Set last page in group bit if private data is present,
>> +	 * page response is required as it does for LPIG.
>> +	 */
> 
> move to priv_data_present check?

Yes.

> 
>> +	if (desc->lpig)
>> +		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
>> +	if (desc->pasid_present)
>> +		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
>> +	if (desc->priv_data_present) {
>> +		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
>> +		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
>> +		memcpy(event.fault.prm.private_data, desc->priv_data,
>> +		       sizeof(desc->priv_data));
>> +	}
>> +
>> +	return iommu_report_device_fault(dev, &event);
>> +}
>> +
>>   static irqreturn_t prq_event_thread(int irq, void *d)
>>   {
>>   	struct intel_iommu *iommu = d;
>> @@ -828,7 +879,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
>> PRQ_RING_MASK;
>>   	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
>> PRQ_RING_MASK;
>>   	while (head != tail) {
>> -		struct intel_svm_dev *sdev;
>> +		struct intel_svm_dev *sdev = NULL;
> 
> move to outside of the loop, otherwise later check always hit "if (!sdev)"

Yes, good catch!

> 
>>   		struct vm_area_struct *vma;
>>   		struct page_req_dsc *req;
>>   		struct qi_desc resp;
>> @@ -864,6 +915,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   			}
>>   		}
>>
>> +		if (!sdev || sdev->sid != req->rid) {
>> +			struct intel_svm_dev *t;
>> +
>> +			sdev = NULL;
>> +			rcu_read_lock();
>> +			list_for_each_entry_rcu(t, &svm->devs, list) {
>> +				if (t->sid == req->rid) {
>> +					sdev = t;
>> +					break;
>> +				}
>> +			}
>> +			rcu_read_unlock();
>> +		}
>> +
>>   		result = QI_RESP_INVALID;
>>   		/* Since we're using init_mm.pgd directly, we should never
>> take
>>   		 * any faults on kernel addresses. */
>> @@ -874,6 +939,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   		if (!is_canonical_address(address))
>>   			goto bad_req;
>>
>> +		/*
>> +		 * If prq is to be handled outside iommu driver via receiver of
>> +		 * the fault notifiers, we skip the page response here.
>> +		 */
>> +		if (svm->flags & SVM_FLAG_GUEST_MODE) {
>> +			if (sdev && !intel_svm_prq_report(sdev->dev, req))
>> +				goto prq_advance;
>> +			else
>> +				goto bad_req;
>> +		}
>> +
>>   		/* If the mm is already defunct, don't handle faults. */
>>   		if (!mmget_not_zero(svm->mm))
>>   			goto bad_req;
>> @@ -892,24 +968,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   			goto invalid;
>>
>>   		result = QI_RESP_SUCCESS;
>> -	invalid:
>> +invalid:
>>   		mmap_read_unlock(svm->mm);
>>   		mmput(svm->mm);
>> -	bad_req:
>> -		/* Accounting for major/minor faults? */
>> -		rcu_read_lock();
>> -		list_for_each_entry_rcu(sdev, &svm->devs, list) {
>> -			if (sdev->sid == req->rid)
>> -				break;
>> -		}
>> -		/* Other devices can go away, but the drivers are not
>> permitted
>> -		 * to unbind while any page faults might be in flight. So it's
>> -		 * OK to drop the 'lock' here now we have it. */
> 
> should we keep and move this comment to earlier sdev lookup? and

I thought this comment explained why rcu_read_unlock() before the next
checking. In the new lookup code, we don't need to check, hence I
removed the comments.

> regarding to guest unbind, ae we preventing the fault owner (outside
> of iommu driver) to unbind against in-flight fault request?

Yes. We always wait until all prq with the same pasid completes in
gpasid_unbind().

> 
>> -		rcu_read_unlock();
>> -
>> -		if (WARN_ON(&sdev->list == &svm->devs))
>> -			sdev = NULL;
> 
> similarly should we keep the WARN_ON check here?

Yes, agreed. We can keep a WARN_ON() here.

> 
>> -
>> +bad_req:
>>   		if (sdev && sdev->ops && sdev->ops->fault_cb) {
>>   			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
>>   				(req->exe_req << 1) | (req->pm_req);
>> @@ -920,7 +982,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   		   and these can be NULL. Do not use them below this point!
>> */
>>   		sdev = NULL;
>>   		svm = NULL;
>> -	no_pasid:
>> +no_pasid:
>>   		if (req->lpig || req->priv_data_present) {
>>   			/*
>>   			 * Per VT-d spec. v3.0 ch7.7, system software must
>> @@ -945,6 +1007,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   			resp.qw3 = 0;
>>   			qi_submit_sync(iommu, &resp, 1, 0);
>>   		}
>> +prq_advance:
>>   		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>>   	}
>>
>> --
>> 2.17.1
> 
> Thanks
> Kevin
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
