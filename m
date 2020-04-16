Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09930C2BB55
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 01:33:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD27F20725
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 01:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD27F20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9284F86074;
	Thu, 16 Apr 2020 01:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id meIUJcOr2R35; Thu, 16 Apr 2020 01:33:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D1F2485F53;
	Thu, 16 Apr 2020 01:33:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB6FCC089E;
	Thu, 16 Apr 2020 01:33:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27B0BC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1F58C86018
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QRTLOFUsIJqo for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 01:33:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E546485F53
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:33:52 +0000 (UTC)
IronPort-SDR: /ri83IguWrgeCVwhR/rX5PlgZU7Cx5kl2qTOyq3DJFjj76MfVdubPjAg3JlOTtiHhSKu6i2z1s
 dLCoD7HEiZMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 18:33:52 -0700
IronPort-SDR: 4+M6p+ONgA4l+HcL/ZBgvUaMqpO2H8msXWHUYLsuCAusDG+gppCoehsMFGsyAUrdIqA5PPcL61
 iCAcp1pOL8Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; d="scan'208";a="245843851"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.171])
 ([10.254.208.171])
 by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 18:33:50 -0700
Subject: Re: [PATCH v2 4/7] iommu/vt-d: Refactor prq_event_thread()
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-5-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D820761@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0d5a85f5-2d2c-d128-839d-d8b8664d192f@linux.intel.com>
Date: Thu, 16 Apr 2020 09:33:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D820761@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On 2020/4/15 17:15, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 15, 2020 1:26 PM
>>
>> Move the software processing page request descriptors part from
>> prq_event_thread() into a separated function. No any functional
>> changes.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-svm.c | 256 ++++++++++++++++++++------------------
>>   1 file changed, 135 insertions(+), 121 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index 83dc4319f661..a1921b462783 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -722,142 +722,156 @@ static bool is_canonical_address(u64 addr)
>>   	return (((saddr << shift) >> shift) == saddr);
>>   }
>>
>> -static irqreturn_t prq_event_thread(int irq, void *d)
>> +static void process_single_prq(struct intel_iommu *iommu,
>> +			       struct page_req_dsc *req)
>>   {
>> -	struct intel_iommu *iommu = d;
>> -	struct intel_svm *svm = NULL;
>> -	int head, tail, handled = 0;
>> -
>> -	/* Clear PPR bit before reading head/tail registers, to
>> -	 * ensure that we get a new interrupt if needed. */
>> -	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
>> -
>> -	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
>> PRQ_RING_MASK;
>> -	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
>> PRQ_RING_MASK;
>> -	while (head != tail) {
>> -		struct intel_svm_dev *sdev;
>> -		struct vm_area_struct *vma;
>> -		struct page_req_dsc *req;
>> -		struct qi_desc resp;
>> -		int result;
>> -		vm_fault_t ret;
>> -		u64 address;
>> -
>> -		handled = 1;
>> -
>> -		req = &iommu->prq[head / sizeof(*req)];
>> +	int result = QI_RESP_FAILURE;
>> +	struct intel_svm_dev *sdev;
>> +	struct vm_area_struct *vma;
>> +	struct intel_svm *svm;
>> +	struct qi_desc resp;
>> +	vm_fault_t ret;
>> +	u64 address;
>> +
>> +	address = (u64)req->addr << VTD_PAGE_SHIFT;
>> +	if (!req->pasid_present) {
>> +		pr_err("%s: Page request without PASID: %08llx %08llx\n",
>> +		       iommu->name, ((unsigned long long *)req)[0],
>> +		       ((unsigned long long *)req)[1]);
>> +		goto no_pasid;
>> +	}
>>
>> -		result = QI_RESP_FAILURE;
>> -		address = (u64)req->addr << VTD_PAGE_SHIFT;
>> -		if (!req->pasid_present) {
>> -			pr_err("%s: Page request without
>> PASID: %08llx %08llx\n",
>> -			       iommu->name, ((unsigned long long *)req)[0],
>> -			       ((unsigned long long *)req)[1]);
>> -			goto no_pasid;
>> -		}
>> +	rcu_read_lock();
>> +	svm = ioasid_find(NULL, req->pasid, NULL);
>> +	/*
>> +	 * It *can't* go away, because the driver is not permitted
>> +	 * to unbind the mm while any page faults are outstanding.
>> +	 * So we only need RCU to protect the internal idr code.
>> +	 */
>> +	rcu_read_unlock();
>>
>> -		if (!svm || svm->pasid != req->pasid) {
>> -			rcu_read_lock();
>> -			svm = ioasid_find(NULL, req->pasid, NULL);
>> -			/* It *can't* go away, because the driver is not
>> permitted
>> -			 * to unbind the mm while any page faults are
>> outstanding.
>> -			 * So we only need RCU to protect the internal idr
>> code. */
>> -			rcu_read_unlock();
>> -			if (IS_ERR_OR_NULL(svm)) {
>> -				pr_err("%s: Page request for invalid
>> PASID %d: %08llx %08llx\n",
>> -				       iommu->name, req->pasid, ((unsigned
>> long long *)req)[0],
>> -				       ((unsigned long long *)req)[1]);
>> -				goto no_pasid;
>> -			}
>> -		}
>> +	if (IS_ERR_OR_NULL(svm)) {
>> +		pr_err("%s: Page request for invalid
>> PASID %d: %08llx %08llx\n",
>> +		       iommu->name, req->pasid, ((unsigned long long *)req)[0],
>> +		       ((unsigned long long *)req)[1]);
>> +		goto no_pasid;
>> +	}
>>
>> -		result = QI_RESP_INVALID;
>> -		/* Since we're using init_mm.pgd directly, we should never
>> take
>> -		 * any faults on kernel addresses. */
>> -		if (!svm->mm)
>> -			goto bad_req;
>> +	result = QI_RESP_INVALID;
>> +	/* Since we're using init_mm.pgd directly, we should never take
>> +	 * any faults on kernel addresses. */
>> +	if (!svm->mm)
>> +		goto bad_req;
>> +
>> +	/* If address is not canonical, return invalid response */
>> +	if (!is_canonical_address(address))
>> +		goto bad_req;
>> +
>> +	/* If the mm is already defunct, don't handle faults. */
>> +	if (!mmget_not_zero(svm->mm))
>> +		goto bad_req;
>> +
>> +	down_read(&svm->mm->mmap_sem);
>> +	vma = find_extend_vma(svm->mm, address);
>> +	if (!vma || address < vma->vm_start)
>> +		goto invalid;
>> +
>> +	if (access_error(vma, req))
>> +		goto invalid;
>> +
>> +	ret = handle_mm_fault(vma, address,
>> +			      req->wr_req ? FAULT_FLAG_WRITE : 0);
>> +	if (ret & VM_FAULT_ERROR)
>> +		goto invalid;
>> +
>> +	result = QI_RESP_SUCCESS;
>> +invalid:
>> +	up_read(&svm->mm->mmap_sem);
>> +	mmput(svm->mm);
>> +bad_req:
>> +	/* Accounting for major/minor faults? */
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(sdev, &svm->devs, list) {
>> +		if (sdev->sid == req->rid)
>> +			break;
>> +	}
>>
>> -		/* If address is not canonical, return invalid response */
>> -		if (!is_canonical_address(address))
>> -			goto bad_req;
>> +	/* Other devices can go away, but the drivers are not permitted
>> +	 * to unbind while any page faults might be in flight. So it's
>> +	 * OK to drop the 'lock' here now we have it. */
>> +	rcu_read_unlock();
>>
>> -		/* If the mm is already defunct, don't handle faults. */
>> -		if (!mmget_not_zero(svm->mm))
>> -			goto bad_req;
>> +	if (WARN_ON(&sdev->list == &svm->devs))
>> +		sdev = NULL;
>>
>> -		down_read(&svm->mm->mmap_sem);
>> -		vma = find_extend_vma(svm->mm, address);
>> -		if (!vma || address < vma->vm_start)
>> -			goto invalid;
>> +	if (sdev && sdev->ops && sdev->ops->fault_cb) {
>> +		int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
>> +			(req->exe_req << 1) | (req->pm_req);
>> +		sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr,
>> +				    req->priv_data, rwxp, result);
>> +	}
>>
>> -		if (access_error(vma, req))
>> -			goto invalid;
>> +	/* We get here in the error case where the PASID lookup failed,
>> +	   and these can be NULL. Do not use them below this point! */
>> +	sdev = NULL;
>> +	svm = NULL;
>> +no_pasid:
>> +	if (req->lpig || req->priv_data_present) {
>> +		/*
>> +		 * Per VT-d spec. v3.0 ch7.7, system software must
>> +		 * respond with page group response if private data
>> +		 * is present (PDP) or last page in group (LPIG) bit
>> +		 * is set. This is an additional VT-d feature beyond
>> +		 * PCI ATS spec.
>> +		 */
>> +		resp.qw0 = QI_PGRP_PASID(req->pasid) |
>> +			QI_PGRP_DID(req->rid) |
>> +			QI_PGRP_PASID_P(req->pasid_present) |
>> +			QI_PGRP_PDP(req->pasid_present) |
>> +			QI_PGRP_RESP_CODE(result) |
>> +			QI_PGRP_RESP_TYPE;
>> +		resp.qw1 = QI_PGRP_IDX(req->prg_index) |
>> +			QI_PGRP_LPIG(req->lpig);
>> +
>> +		if (req->priv_data_present)
>> +			memcpy(&resp.qw2, req->priv_data,
>> +			       sizeof(req->priv_data));
>> +		resp.qw2 = 0;
>> +		resp.qw3 = 0;
>> +		qi_submit_sync(iommu, &resp, 1, 0);
>> +	}
>> +}
>>
>> -		ret = handle_mm_fault(vma, address,
>> -				      req->wr_req ? FAULT_FLAG_WRITE : 0);
>> -		if (ret & VM_FAULT_ERROR)
>> -			goto invalid;
>> +static void intel_svm_process_prq(struct intel_iommu *iommu,
>> +				  struct page_req_dsc *prq,
>> +				  int head, int tail)
>> +{
>> +	struct page_req_dsc *req;
>>
>> -		result = QI_RESP_SUCCESS;
>> -	invalid:
>> -		up_read(&svm->mm->mmap_sem);
>> -		mmput(svm->mm);
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
>> -		rcu_read_unlock();
>> -
>> -		if (WARN_ON(&sdev->list == &svm->devs))
>> -			sdev = NULL;
>> -
>> -		if (sdev && sdev->ops && sdev->ops->fault_cb) {
>> -			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
>> -				(req->exe_req << 1) | (req->pm_req);
>> -			sdev->ops->fault_cb(sdev->dev, req->pasid, req-
>>> addr,
>> -					    req->priv_data, rwxp, result);
>> -		}
>> -		/* We get here in the error case where the PASID lookup
>> failed,
>> -		   and these can be NULL. Do not use them below this point!
>> */
>> -		sdev = NULL;
>> -		svm = NULL;
>> -	no_pasid:
>> -		if (req->lpig || req->priv_data_present) {
>> -			/*
>> -			 * Per VT-d spec. v3.0 ch7.7, system software must
>> -			 * respond with page group response if private data
>> -			 * is present (PDP) or last page in group (LPIG) bit
>> -			 * is set. This is an additional VT-d feature beyond
>> -			 * PCI ATS spec.
>> -			 */
>> -			resp.qw0 = QI_PGRP_PASID(req->pasid) |
>> -				QI_PGRP_DID(req->rid) |
>> -				QI_PGRP_PASID_P(req->pasid_present) |
>> -				QI_PGRP_PDP(req->pasid_present) |
>> -				QI_PGRP_RESP_CODE(result) |
>> -				QI_PGRP_RESP_TYPE;
>> -			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
>> -				QI_PGRP_LPIG(req->lpig);
>> -
>> -			if (req->priv_data_present)
>> -				memcpy(&resp.qw2, req->priv_data,
>> -				       sizeof(req->priv_data));
>> -			resp.qw2 = 0;
>> -			resp.qw3 = 0;
>> -			qi_submit_sync(iommu, &resp, 1, 0);
>> -		}
>> +	while (head != tail) {
>> +		req = &iommu->prq[head / sizeof(*req)];
>> +		process_single_prq(iommu, req);
>>   		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>>   	}
>> +}
>> +
>> +static irqreturn_t prq_event_thread(int irq, void *d)
>> +{
>> +	struct intel_iommu *iommu = d;
>> +	int head, tail;
>>
>> +	/*
>> +	 * Clear PPR bit before reading head/tail registers, to
>> +	 * ensure that we get a new interrupt if needed.
>> +	 */
>> +	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
>> +
>> +	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
>> PRQ_RING_MASK;
>> +	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
>> PRQ_RING_MASK;
>> +	intel_svm_process_prq(iommu, iommu->prq, head, tail);
>>   	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
>>
>> -	return IRQ_RETVAL(handled);
>> +	return IRQ_RETVAL(1);
> 
> this might be a functional change, since previously (0) could
> be returned when head==tail.

Yes.

I will change it to
	return IRQ_RETVAL(head != tail);

Best regards,
baolu

> 
>>   }
>>
>>   #define to_intel_svm_dev(handle) container_of(handle, struct
>> intel_svm_dev, sva)
>> --
>> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
