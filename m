Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C675C3A5A8
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 02:15:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F411A21881
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 02:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F411A21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AFE4B9CA;
	Mon,  2 Sep 2019 02:15:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5964E907
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 02:15:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8C89D5D3
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 02:15:25 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	01 Sep 2019 19:15:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; d="scan'208";a="381729047"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2019 19:15:20 -0700
Subject: Re: [PATCH v8 6/7] iommu/vt-d: Add trace events for device dma
	map/unmap
To: Steven Rostedt <rostedt@goodmis.org>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com>
	<20190830071718.16613-7-baolu.lu@linux.intel.com>
	<20190830095349.1c222240@gandalf.local.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <319db353-6641-61af-a86a-93d832b742c2@linux.intel.com>
Date: Mon, 2 Sep 2019 10:13:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830095349.1c222240@gandalf.local.home>
Content-Language: en-US
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Steve,

On 8/30/19 9:53 PM, Steven Rostedt wrote:
> On Fri, 30 Aug 2019 15:17:17 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> This adds trace support for the Intel IOMMU driver. It
>> also declares some events which could be used to trace
>> the events when an IOVA is being mapped or unmapped in
>> a domain.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> ---
>>   drivers/iommu/Makefile             |  1 +
>>   drivers/iommu/intel-trace.c        | 14 +++++
>>   include/trace/events/intel_iommu.h | 84 ++++++++++++++++++++++++++++++
>>   3 files changed, 99 insertions(+)
>>   create mode 100644 drivers/iommu/intel-trace.c
>>   create mode 100644 include/trace/events/intel_iommu.h
>>
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index f13f36ae1af6..bfe27b2755bd 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>>   obj-$(CONFIG_DMAR_TABLE) += dmar.o
>>   obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
>> +obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o
>>   obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel-iommu-debugfs.o
>>   obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
>>   obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
>> diff --git a/drivers/iommu/intel-trace.c b/drivers/iommu/intel-trace.c
>> new file mode 100644
>> index 000000000000..bfb6a6e37a88
>> --- /dev/null
>> +++ b/drivers/iommu/intel-trace.c
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Intel IOMMU trace support
>> + *
>> + * Copyright (C) 2019 Intel Corporation
>> + *
>> + * Author: Lu Baolu <baolu.lu@linux.intel.com>
>> + */
>> +
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/intel_iommu.h>
>> diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
>> new file mode 100644
>> index 000000000000..9c28e6cae86f
>> --- /dev/null
>> +++ b/include/trace/events/intel_iommu.h
>> @@ -0,0 +1,84 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Intel IOMMU trace support
>> + *
>> + * Copyright (C) 2019 Intel Corporation
>> + *
>> + * Author: Lu Baolu <baolu.lu@linux.intel.com>
>> + */
>> +#ifdef CONFIG_INTEL_IOMMU
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM intel_iommu
>> +
>> +#if !defined(_TRACE_INTEL_IOMMU_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_INTEL_IOMMU_H
>> +
>> +#include <linux/tracepoint.h>
>> +#include <linux/intel-iommu.h>
>> +
>> +DECLARE_EVENT_CLASS(dma_map,
>> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
>> +		 size_t size),
>> +
>> +	TP_ARGS(dev, dev_addr, phys_addr, size),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name(dev))
>> +		__field(dma_addr_t, dev_addr)
>> +		__field(phys_addr_t, phys_addr)
>> +		__field(size_t,	size)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name(dev));
>> +		__entry->dev_addr = dev_addr;
>> +		__entry->phys_addr = phys_addr;
>> +		__entry->size = size;
>> +	),
>> +
>> +	TP_printk("dev=%s dev_addr=0x%llx phys_addr=0x%llx size=%zu",
>> +		  __get_str(dev_name),
>> +		  (unsigned long long)__entry->dev_addr,
>> +		  (unsigned long long)__entry->phys_addr,
>> +		  __entry->size)
>> +);
>> +
>> +DEFINE_EVENT(dma_map, bounce_map_single,
>> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
>> +		 size_t size),
>> +	TP_ARGS(dev, dev_addr, phys_addr, size)
>> +);
> 
> Do you plan on adding more events to these classes? This patch has two
> distinct DECLARE_EVENT_CLASS() calls, and each has one DEFINE_EVENT()
> for them.

Yes, we will add more. This patch only adds the trace events that are
necessary for this patch series's development. It's easy to extend to
other events.

> 
> It's fine to do this, but I'm curious to why you did not use
> the "TRACE_EVENT()" macro, which basically is just a single
> DECLARE_EVENT_CLASS() followed by a single DEFINE_EVENT(). In other
> words, you just open coded TRACE_EVENT().

Fair enough.

> 
> -- Steve

Best regards,
Lu Baolu

> 
>> +
>> +DECLARE_EVENT_CLASS(dma_unmap,
>> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
>> +
>> +	TP_ARGS(dev, dev_addr, size),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name(dev))
>> +		__field(dma_addr_t, dev_addr)
>> +		__field(size_t,	size)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name(dev));
>> +		__entry->dev_addr = dev_addr;
>> +		__entry->size = size;
>> +	),
>> +
>> +	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
>> +		  __get_str(dev_name),
>> +		  (unsigned long long)__entry->dev_addr,
>> +		  __entry->size)
>> +);
>> +
>> +DEFINE_EVENT(dma_unmap, bounce_unmap_single,
>> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
>> +	TP_ARGS(dev, dev_addr, size)
>> +);
>> +
>> +#endif /* _TRACE_INTEL_IOMMU_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> +#endif /* CONFIG_INTEL_IOMMU */
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
