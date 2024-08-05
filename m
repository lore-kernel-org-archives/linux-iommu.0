Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F51547F1
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860008; cv=none; b=ql0RGaLwMNEfmV8cYtT6EG2Gz1QXXsRcdu0pw+J0ebsbaKSHQbSkbgWFIJjhh+QJthdT30S3CSu6phybjBRNMet/hOzWQP7DNMqBygHjDLWW4BOjPDkgIBd7w2XKuHsq6swT5v0oy0L9Acn6PbbY30Y/RmHG1SGi3PaDQtjOWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860008; c=relaxed/simple;
	bh=xDfcxY/ms6YBxFl6JZriXdo+9JcnpiGfry0Ktt/nnMI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y42cIHfr+r67FkWpYbkc4Jn8cH9rzbNiM7IstRH4DJuijm+5V1fqcNf7TFrGg7gfHW2ttSAFK9WYqu9F1vxdw7P6iEhJxoki5WRiaOTI4HAsC+k9T6DV+3iJ2TCPR/JAQopq7eBn47QaC0MifOxywyKQhGJ9AkdQ5d9tC7mvsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WcwJx0TdCzfZmw;
	Mon,  5 Aug 2024 20:11:29 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id F37C8140109;
	Mon,  5 Aug 2024 20:13:21 +0800 (CST)
Received: from [10.174.176.125] (10.174.176.125) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 20:13:20 +0800
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
To: Pranjal Shrivastava <praan@google.com>, Baolu Lu
	<baolu.lu@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
	<nicolinc@nvidia.com>, Michael Shavit <mshavit@google.com>, Mostafa Saleh
	<smostafa@google.com>, "moderated list:ARM SMMU DRIVERS"
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
	<yuzenghui@huawei.com>, <tangnianyao@huawei.com>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
From: Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
Date: Mon, 5 Aug 2024 20:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Hi,

On 2024/8/2 22:38, Pranjal Shrivastava wrote:
> Hey,
> On Mon, Jul 29, 2024 at 11:02 AM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>> On 2024/7/24 18:24, Will Deacon wrote:
>>> On Wed, Jul 24, 2024 at 05:22:59PM +0800, Kunkun Jiang wrote:
>>>> On 2024/7/24 9:42, Kunkun Jiang wrote:
>>>>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> 1797                 while (!queue_remove_raw(q, evt)) {
>>>>> 1798                         u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
>>>>> 1799
>>>>> 1800                         ret = arm_smmu_handle_evt(smmu, evt);
>>>>> 1801                         if (!ret || !__ratelimit(&rs))
>>>>> 1802                                 continue;
>>>>> 1803
>>>>> 1804                         dev_info(smmu->dev, "event 0x%02x
>>>>> received:\n", id);
>>>>> 1805                         for (i = 0; i < ARRAY_SIZE(evt); ++i)
>>>>> 1806                                 dev_info(smmu->dev, "\t0x%016llx\n",
>>>>> 1807                                          (unsigned long
>>>>> long)evt[i]);
>>>>> 1808
>>>>> 1809                         cond_resched();
>>>>> 1810                 }
>>>>>
>>>>> The smmu-v3 driver cannot print event information when "ret" is 0.
>>>>> Unfortunately due to commit 3dfa64aecbaf
>>>>> ("iommu: Make iommu_report_device_fault() return void"), the default
>>>>> return value in arm_smmu_handle_evt() is 0. Maybe a trace should
>>>>> be added here?
>>>> Additional explanation. Background introduction:
>>>> 1.A device(VF) is passthrough(VFIO-PCI) to a VM.
>>>> 2.The SMMU has the stall feature.
>>>> 3.Modified guest device driver to generate an event.
>>>>
>>>> This event handling process is as follows:
>>>> arm_smmu_evtq_thread
>>>>       ret = arm_smmu_handle_evt
>>>>           iommu_report_device_fault
>>>>               iopf_param = iopf_get_dev_fault_param(dev);
>>>>               // iopf is not enabled.
>>>> // No RESUME will be sent!
>>>>               if (WARN_ON(!iopf_param))
>>>>                   return;
>>>>       if (!ret || !__ratelimit(&rs))
>>>>           continue;
>>>>
>>>> In this scenario, the io page-fault capability is not enabled.
>>>> There are two problems here:
>>>> 1. The event information is not printed.
>>>> 2. The entire device(PF level) is stalled,not just the current
>>>> VF. This affects other normal VFs.
>>> Oh, so that stall is probably also due to b554e396e51c ("iommu: Make
>>> iopf_group_response() return void"). I agree that we need a way to
>>> propagate error handling back to the driver in the case that
>>> 'iopf_param' is NULL, otherwise we're making the unexpected fault
>>> considerably more problematic than it needs to be.
>>>
>>> Lu -- can we add the -ENODEV return back in the case that
>>> iommu_report_device_fault() doesn't even find a 'iommu_fault_param' for
>>> the device?
>> Yes, of course. The commit b554e396e51c was added to consolidate the
>> drivers' auto response code in the core with the assumption that driver
>> only needs to call iommu_report_device_fault() for reporting an iopf.
>>
> I had a go at taking Jason's diff and implementing the suggestions in
> this thread.
> Kunkun -- please can you see if this fixes the problem for you?
Okay, I'll test it as soon as I can.

Thanks,
Kunkun Jiang
> Lu -- it looks like the intel ->page_response callback doesn't expect
> a NULL event
> pointer, so for now I return immediately in that case as we did in v6.7.
>
>> Thanks,
>> baolu
>>
> Thanks,
> Pranjal
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a31460f9f3d4..ed2b106e02dd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct
> arm_smmu_device *smmu, u64 *evt)
>    goto out_unlock;
>    }
>
> - iommu_report_device_fault(master->dev, &fault_evt);
> + ret = iommu_report_device_fault(master->dev, &fault_evt);
>   out_unlock:
>    mutex_unlock(&smmu->streams_mutex);
>    return ret;
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 0e3a9b38bef2..7684e7562584 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -532,6 +532,9 @@ void intel_svm_page_response(struct device *dev,
> struct iopf_fault *evt,
>    bool last_page;
>    u16 sid;
>
> + if (!evt)
> + return;
> +
>    prm = &evt->fault.prm;
>    sid = PCI_DEVID(bus, devfn);
>    pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 7c9011992d3f..0c3b2125563e 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -113,6 +113,57 @@ static struct iopf_group *iopf_group_alloc(struct
> iommu_fault_param *iopf_param,
>    return group;
>   }
>
> +static struct iommu_attach_handle *find_fault_handler(struct device *dev,
> +                                                     struct iopf_fault *evt)
> +{
> +       struct iommu_fault *fault = &evt->fault;
> +       struct iommu_attach_handle *attach_handle;
> +
> +       if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> +               attach_handle = iommu_attach_handle_get(dev->iommu_group,
> +                                                       fault->prm.pasid, 0);
> +               if (IS_ERR(attach_handle)) {
> +                       const struct iommu_ops *ops = dev_iommu_ops(dev);
> +
> +                       if (!ops->user_pasid_table)
> +                               return NULL;
> +
> +                       /*
> +                        * The iommu driver for this device supports user-
> +                        * managed PASID table. Therefore page faults for
> +                        * any PASID should go through the NESTING domain
> +                        * attached to the device RID.
> +                        */
> +                       attach_handle = iommu_attach_handle_get(
> +                               dev->iommu_group, IOMMU_NO_PASID,
> +                               IOMMU_DOMAIN_NESTED);
> +                       if (IS_ERR(attach_handle))
> +                               return NULL;
> +               }
> +       } else {
> +               attach_handle = iommu_attach_handle_get(dev->iommu_group,
> +                                                       IOMMU_NO_PASID, 0);
> +               if (IS_ERR(attach_handle))
> +                       return NULL;
> +       }
> +
> +       if (!attach_handle->domain->iopf_handler)
> +               return NULL;
> +       return attach_handle;
> +}
> +
> +static void iopf_error_response(struct device *dev, struct iommu_fault *fault)
> +{
> + const struct iommu_ops *ops = dev_iommu_ops(dev);
> + struct iommu_page_response resp = {
> + .pasid = fault->prm.pasid,
> + .grpid = fault->prm.grpid,
> + .code = IOMMU_PAGE_RESP_INVALID
> + };
> +
> + ops->page_response(dev, NULL, &resp);
> +}
> +
>   /**
>    * iommu_report_device_fault() - Report fault event to device driver
>    * @dev: the device
> @@ -153,16 +204,25 @@ static struct iopf_group
> *iopf_group_alloc(struct iommu_fault_param *iopf_param,
>    * hardware has been set to block the page faults) and the pending page faults
>    * have been flushed.
>    */
> -void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> +int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>   {
> + struct iommu_attach_handle *attach_handle;
>    struct iommu_fault *fault = &evt->fault;
>    struct iommu_fault_param *iopf_param;
>    struct iopf_group abort_group = {};
>    struct iopf_group *group;
>
> + attach_handle = find_fault_handler(dev, evt);
> + if (!attach_handle)
> + goto err_bad_iopf;
> +
> + /*
> + * Something has gone wrong if a fault capable domain is attached but no
> + * iopf_param is setup
> + */
>    iopf_param = iopf_get_dev_fault_param(dev);
>    if (WARN_ON(!iopf_param))
> - return;
> + goto err_bad_iopf;
>
>    if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
>    report_partial_fault(iopf_param, fault);
> @@ -182,38 +242,7 @@ void iommu_report_device_fault(struct device
> *dev, struct iopf_fault *evt)
>    if (group == &abort_group)
>    goto err_abort;
>
> - if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> - group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
> -       fault->prm.pasid,
> -       0);
> - if (IS_ERR(group->attach_handle)) {
> - const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> - if (!ops->user_pasid_table)
> - goto err_abort;
> -
> - /*
> - * The iommu driver for this device supports user-
> - * managed PASID table. Therefore page faults for
> - * any PASID should go through the NESTING domain
> - * attached to the device RID.
> - */
> - group->attach_handle =
> - iommu_attach_handle_get(dev->iommu_group,
> - IOMMU_NO_PASID,
> - IOMMU_DOMAIN_NESTED);
> - if (IS_ERR(group->attach_handle))
> - goto err_abort;
> - }
> - } else {
> - group->attach_handle =
> - iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
> - if (IS_ERR(group->attach_handle))
> - goto err_abort;
> - }
> -
> - if (!group->attach_handle->domain->iopf_handler)
> - goto err_abort;
> + group->attach_handle = attach_handle;
>
>    /*
>    * On success iopf_handler must call iopf_group_response() and
> @@ -222,7 +251,7 @@ void iommu_report_device_fault(struct device *dev,
> struct iopf_fault *evt)
>    if (group->attach_handle->domain->iopf_handler(group))
>    goto err_abort;
>
> - return;
> + return 0;
>
>   err_abort:
>    dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
> @@ -232,6 +261,14 @@ void iommu_report_device_fault(struct device
> *dev, struct iopf_fault *evt)
>    __iopf_free_group(group);
>    else
>    iopf_free_group(group);
> +
> + return 0;
> +
> +err_bad_iopf:
> + if (fault->type == IOMMU_FAULT_PAGE_REQ)
> + iopf_error_response(dev, fault);
> +
> + return -EINVAL;
>   }
>   EXPORT_SYMBOL_GPL(iommu_report_device_fault);
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d87f9cbfc01e..062156a8d87b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1561,7 +1561,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
>   void iopf_queue_free(struct iopf_queue *queue);
>   int iopf_queue_discard_partial(struct iopf_queue *queue);
>   void iopf_free_group(struct iopf_group *group);
> -void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
> +int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
>   void iopf_group_response(struct iopf_group *group,
>    enum iommu_page_response_code status);
>   #else
> @@ -1599,9 +1599,10 @@ static inline void iopf_free_group(struct
> iopf_group *group)
>   {
>   }
>
> -static inline void
> +static inline int
>   iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>   {
> + return -ENODEV;
>   }
>
>   static inline void iopf_group_response(struct iopf_group *group,
> .
