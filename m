Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB04C56201
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 23:11:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5208020870
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 23:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5208020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D452485D92;
	Wed, 11 Nov 2020 23:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n9rSGZXp0iMv; Wed, 11 Nov 2020 23:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1E40484F35;
	Wed, 11 Nov 2020 23:11:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0343FC088B;
	Wed, 11 Nov 2020 23:11:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF65CC016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 23:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AAB3620395
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 23:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CeuN0U2q-8yw for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 23:11:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id 2A87F2010D
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 23:11:45 +0000 (UTC)
IronPort-SDR: BV9oS2iQStbolQE1dja7KXAPfIKKKhzJU0uWw5MZPZmaT9xYtl8K71g3DOnRUu8k9FsVbrh9Eg
 NBvcEOskfvQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="166724199"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; d="scan'208";a="166724199"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2020 15:11:44 -0800
IronPort-SDR: 2SigUd3RC6BHd0NrZjhiVcNkd4/T5ldcTrknfGqqjnYMA+dH0hh6VxbwKoY75rW1jfqAHhP1bp
 TkxPMdnvvBtw==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; d="scan'208";a="541993746"
Received: from lmwang8-mobl.ccr.corp.intel.com (HELO [10.254.209.85])
 ([10.254.209.85])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2020 15:11:39 -0800
Subject: Re: [PATCH v7 04/24] iommu: Add a page fault handler
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-5-jean-philippe@linaro.org>
 <c840d771-188d-9ee5-d117-e4b91d29b329@linux.intel.com>
 <20201111135740.GA2622074@myrica>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8e630294-8199-68e3-d55a-68e6484d953a@linux.intel.com>
Date: Thu, 12 Nov 2020 07:11:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201111135740.GA2622074@myrica>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

On 2020/11/11 21:57, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> Thanks for the review. I'm only now reworking this and realized I've never
> sent a reply, sorry about that.
> 
> On Wed, May 20, 2020 at 02:42:21PM +0800, Lu Baolu wrote:
>> Hi Jean,
>>
>> On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
>>> Some systems allow devices to handle I/O Page Faults in the core mm. For
>>> example systems implementing the PCIe PRI extension or Arm SMMU stall
>>> model. Infrastructure for reporting these recoverable page faults was
>>> added to the IOMMU core by commit 0c830e6b3282 ("iommu: Introduce device
>>> fault report API"). Add a page fault handler for host SVA.
>>>
>>> IOMMU driver can now instantiate several fault workqueues and link them
>>> to IOPF-capable devices. Drivers can choose between a single global
>>> workqueue, one per IOMMU device, one per low-level fault queue, one per
>>> domain, etc.
>>>
>>> When it receives a fault event, supposedly in an IRQ handler, the IOMMU
>>> driver reports the fault using iommu_report_device_fault(), which calls
>>> the registered handler. The page fault handler then calls the mm fault
>>> handler, and reports either success or failure with iommu_page_response().
>>> When the handler succeeded, the IOMMU retries the access.
>>>
>>> The iopf_param pointer could be embedded into iommu_fault_param. But
>>> putting iopf_param into the iommu_param structure allows us not to care
>>> about ordering between calls to iopf_queue_add_device() and
>>> iommu_register_device_fault_handler().
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [...]
>>> +static enum iommu_page_response_code
>>> +iopf_handle_single(struct iopf_fault *iopf)
>>> +{
>>> +	vm_fault_t ret;
>>> +	struct mm_struct *mm;
>>> +	struct vm_area_struct *vma;
>>> +	unsigned int access_flags = 0;
>>> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>>> +	struct iommu_fault_page_request *prm = &iopf->fault.prm;
>>> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>>> +
>>> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>>> +		return status;
>>> +
>>> +	mm = iommu_sva_find(prm->pasid);
>>> +	if (IS_ERR_OR_NULL(mm))
>>> +		return status;
>>> +
>>> +	down_read(&mm->mmap_sem);
>>> +
>>> +	vma = find_extend_vma(mm, prm->addr);
>>> +	if (!vma)
>>> +		/* Unmapped area */
>>> +		goto out_put_mm;
>>> +
>>> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
>>> +		access_flags |= VM_READ;
>>> +
>>> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>>> +		access_flags |= VM_WRITE;
>>> +		fault_flags |= FAULT_FLAG_WRITE;
>>> +	}
>>> +
>>> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>>> +		access_flags |= VM_EXEC;
>>> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
>>> +	}
>>> +
>>> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>>> +		fault_flags |= FAULT_FLAG_USER;
>>> +
>>> +	if (access_flags & ~vma->vm_flags)
>>> +		/* Access fault */
>>> +		goto out_put_mm;
>>> +
>>> +	ret = handle_mm_fault(vma, prm->addr, fault_flags);
>>> +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>>
>> Do you mind telling why it's IOMMU_PAGE_RESP_INVALID but not
>> IOMMU_PAGE_RESP_FAILURE?
> 
> PAGE_RESP_FAILURE maps to PRI Response code "Response Failure" which
> indicates a catastrophic error and causes the function to disable PRI.
> Instead PAGE_RESP_INVALID maps to PRI Response code "Invalid request",
> which tells the function that the address is invalid and there is no point
> retrying this particular access.

Thanks for the explanation. I am also working on converting Intel VT-d
to use this framework (and the sva helpers). So far so good.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
