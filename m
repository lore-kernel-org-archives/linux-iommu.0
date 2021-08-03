Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D0AC4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 18:50:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBC960F58
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 18:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFBC960F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C6A583126;
	Tue,  3 Aug 2021 18:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4P2pnBWpSair; Tue,  3 Aug 2021 18:50:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 39C40829B1;
	Tue,  3 Aug 2021 18:50:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F163BC0010;
	Tue,  3 Aug 2021 18:50:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EB40C000E;
 Tue,  3 Aug 2021 18:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E763608DD;
 Tue,  3 Aug 2021 18:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kyV7ZZPWignv; Tue,  3 Aug 2021 18:40:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31032608D6;
 Tue,  3 Aug 2021 18:40:55 +0000 (UTC)
Received: from [192.168.1.115] (unknown [223.178.56.171])
 by linux.microsoft.com (Postfix) with ESMTPSA id ED6F4208AB1A;
 Tue,  3 Aug 2021 11:40:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED6F4208AB1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1628016054;
 bh=HCe3GshWTF7vPJaEOofUaKnKzeINHIBZgPnnV5jC2+0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=mHZgfl1Q5lJPQVPX9SoXjFNffyQd154C3GYng+WnVdmQuXOaOWJ+wjQ/17TCrJkBn
 az9me95RrkjyJ9knQ6lP/rPHR20eA2rCcm05E2fBci6t9URSfPF27JouSoZjYuDWaP
 IWxiJRtYcxk+787gLGL0VPqkWFJNWb1jw2rIPYh0=
Subject: Re: [RFC v1 5/8] mshv: add paravirtualized IOMMU support
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-6-wei.liu@kernel.org>
From: Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <77670985-2a1b-7bbd-2ede-4b7810c3e220@linux.microsoft.com>
Date: Wed, 4 Aug 2021 00:10:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-6-wei.liu@kernel.org>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 03 Aug 2021 18:50:33 +0000
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, pasha.tatashin@soleen.com,
 Will Deacon <will@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
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

On 09-07-2021 17:13, Wei Liu wrote:
> +static void hv_iommu_domain_free(struct iommu_domain *d)
> +{
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	unsigned long flags;
> +	u64 status;
> +	struct hv_input_delete_device_domain *input;
> +
> +	if (is_identity_domain(domain) || is_null_domain(domain))
> +		return;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain= domain->device_domain;
> +
> +	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);

Is it OK to deallocate the resources, if hypercall has failed ?
Do we have any specific error code EBUSY (kind of) which we need to wait upon ?

> +
> +	ida_free(&domain->hv_iommu->domain_ids, domain->device_domain.domain_id.id);
> +
> +	iommu_put_dma_cookie(d);
> +
> +	kfree(domain);
> +}
> +
> +static int hv_iommu_attach_dev(struct iommu_domain *d, struct device *dev)
> +{
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_attach_device_domain *input;
> +	struct pci_dev *pdev;
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +
> +	/* Only allow PCI devices for now */
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	dev_dbg(dev, "Attaching (%strusted) to %d\n", pdev->untrusted ? "un" : "",
> +		domain->device_domain.domain_id.id);
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain = domain->device_domain;
> +	input->device_id = hv_build_pci_dev_id(pdev);
> +
> +	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);

Does it make sense to vdev->domain = NULL ?

> +	else
> +		vdev->domain = domain;
> +
> +	return hv_status_to_errno(status);
> +}
> +
> +static void hv_iommu_detach_dev(struct iommu_domain *d, struct device *dev)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_detach_device_domain *input;
> +	struct pci_dev *pdev;
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +
> +	/* See the attach function, only PCI devices for now */
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	dev_dbg(dev, "Detaching from %d\n", domain->device_domain.domain_id.id);
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->partition_id = HV_PARTITION_ID_SELF;
> +	input->device_id = hv_build_pci_dev_id(pdev);
> +
> +	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	vdev->domain = NULL;
> +}
> +
> +static int hv_iommu_add_mapping(struct hv_iommu_domain *domain, unsigned long iova,
> +		phys_addr_t paddr, size_t size, u32 flags)
> +{
> +	unsigned long irqflags;
> +	struct hv_iommu_mapping *mapping;
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_ATOMIC);
> +	if (!mapping)
> +		return -ENOMEM;
> +
> +	mapping->paddr = paddr;
> +	mapping->iova.start = iova;
> +	mapping->iova.last = iova + size - 1;
> +	mapping->flags = flags;
> +
> +	spin_lock_irqsave(&domain->mappings_lock, irqflags);
> +	interval_tree_insert(&mapping->iova, &domain->mappings);
> +	spin_unlock_irqrestore(&domain->mappings_lock, irqflags);
> +
> +	return 0;
> +}
> +
> +static size_t hv_iommu_del_mappings(struct hv_iommu_domain *domain,
> +		unsigned long iova, size_t size)
> +{
> +	unsigned long flags;
> +	size_t unmapped = 0;
> +	unsigned long last = iova + size - 1;
> +	struct hv_iommu_mapping *mapping = NULL;
> +	struct interval_tree_node *node, *next;
> +
> +	spin_lock_irqsave(&domain->mappings_lock, flags);
> +	next = interval_tree_iter_first(&domain->mappings, iova, last);
> +	while (next) {
> +		node = next;
> +		mapping = container_of(node, struct hv_iommu_mapping, iova);
> +		next = interval_tree_iter_next(node, iova, last);
> +
> +		/* Trying to split a mapping? Not supported for now. */
> +		if (mapping->iova.start < iova)
> +			break;
> +
> +		unmapped += mapping->iova.last - mapping->iova.start + 1;
> +
> +		interval_tree_remove(node, &domain->mappings);
> +		kfree(mapping);
> +	}
> +	spin_unlock_irqrestore(&domain->mappings_lock, flags);
> +
> +	return unmapped;
> +}
> +
> +static int hv_iommu_map(struct iommu_domain *d, unsigned long iova,
> +			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +{
> +	u32 map_flags;
> +	unsigned long flags, pfn, npages;
> +	int ret, i;
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	struct hv_input_map_device_gpa_pages *input;
> +	u64 status;
> +
> +	/* Reject size that's not a whole page */
> +	if (size & ~HV_HYP_PAGE_MASK)
> +		return -EINVAL;
> +
> +	map_flags = HV_MAP_GPA_READABLE; /* Always required */
> +	map_flags |= prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
> +
> +	ret = hv_iommu_add_mapping(domain, iova, paddr, size, flags);
> +	if (ret)
> +		return ret;
> +
> +	npages = size >> HV_HYP_PAGE_SHIFT;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain = domain->device_domain;
> +	input->map_flags = map_flags;
> +	input->target_device_va_base = iova;
> +
> +	pfn = paddr >> HV_HYP_PAGE_SHIFT;
> +	for (i = 0; i < npages; i++) {
> +		input->gpa_page_list[i] = pfn;
> +		pfn += 1;
> +	}
> +
> +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_GPA_PAGES, npages, 0,
> +			input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +		hv_iommu_del_mappings(domain, iova, size);
> +	}
> +
> +	return hv_status_to_errno(status);
> +}
> +
> +static size_t hv_iommu_unmap(struct iommu_domain *d, unsigned long iova,
> +			   size_t size, struct iommu_iotlb_gather *gather)
> +{
> +	size_t unmapped;
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	unsigned long flags, npages;
> +	struct hv_input_unmap_device_gpa_pages *input;
> +	u64 status;
> +
> +	unmapped = hv_iommu_del_mappings(domain, iova, size);
> +	if (unmapped < size)
> +		return 0;

Is there a case where unmapped > 0 && unmapped < size ?

> +
> +	npages = size >> HV_HYP_PAGE_SHIFT;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain = domain->device_domain;
> +	input->target_device_va_base = iova;
> +
> +	/* Unmap `npages` pages starting from VA base */
> +	status = hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_GPA_PAGES, npages,
> +			0, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	return hv_result_success(status) ? unmapped : 0;
> +}
> +

Regards,

~Praveen.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
