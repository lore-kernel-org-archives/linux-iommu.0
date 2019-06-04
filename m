Return-Path: <SRS0=MUIX=UD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB3C28D17
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 09:01:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4F424088
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 09:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4F424088
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6AABDCBB;
	Tue,  4 Jun 2019 09:01:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 92863CBA
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 09:01:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CD55E711
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 09:01:32 +0000 (UTC)
Received: from oasis.local.home (unknown [146.247.46.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B08BB24071;
	Tue,  4 Jun 2019 09:01:27 +0000 (UTC)
Date: Tue, 4 Jun 2019 05:01:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 7/9] iommu/vt-d: Add trace events for domain map/unmap
Message-ID: <20190604050122.4a095569@oasis.local.home>
In-Reply-To: <20190603011620.31999-8-baolu.lu@linux.intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
	<20190603011620.31999-8-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon,  3 Jun 2019 09:16:18 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:


> +TRACE_EVENT(bounce_unmap_single,
> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
> +
> +	TP_ARGS(dev, dev_addr, size),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(dma_addr_t, dev_addr)
> +		__field(size_t,	size)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->dev_addr = dev_addr;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
> +		  __get_str(dev_name),
> +		  (unsigned long long)__entry->dev_addr,
> +		  __entry->size)
> +);
> +
> +TRACE_EVENT(bounce_map_sg,
> +	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
> +		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
> +
> +	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(unsigned int, i)
> +		__field(unsigned int, last)
> +		__field(dma_addr_t, dev_addr)
> +		__field(phys_addr_t, phys_addr)
> +		__field(size_t,	size)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->i = i;
> +		__entry->last = nelems - 1;
> +		__entry->dev_addr = dev_addr;
> +		__entry->phys_addr = phys_addr;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
> +		  __get_str(dev_name), __entry->i, __entry->last,
> +		  (unsigned long long)__entry->dev_addr,
> +		  (unsigned long long)__entry->phys_addr,
> +		  __entry->size)
> +);
> +
> +TRACE_EVENT(bounce_unmap_sg,
> +	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
> +		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
> +
> +	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(unsigned int, i)
> +		__field(unsigned int, last)
> +		__field(dma_addr_t, dev_addr)
> +		__field(phys_addr_t, phys_addr)
> +		__field(size_t,	size)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->i = i;
> +		__entry->last = nelems - 1;
> +		__entry->dev_addr = dev_addr;
> +		__entry->phys_addr = phys_addr;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
> +		  __get_str(dev_name), __entry->i, __entry->last,
> +		  (unsigned long long)__entry->dev_addr,
> +		  (unsigned long long)__entry->phys_addr,
> +		  __entry->size)
> +);

These last two events look identical. Please use the
DECLARE_EVENT_CLASS() to describe the event and then DEFINE_EVENT() for
the two events.

Each TRACE_EVENT() can add up to 5k of data/text, where as a
DEFINE_EVENT() just adds around 250 bytes.

(Note, a TRACE_EVENT() is defined as a
DECLARE_EVENT_CLASS()/DEFINE_EVENT() pair)

-- Steve


> +#endif /* _TRACE_INTEL_IOMMU_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
