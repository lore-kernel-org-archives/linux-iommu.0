Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49965C432BE
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 04:32:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E480C60F8F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 04:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E480C60F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A137840645;
	Fri, 20 Aug 2021 04:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yZJ5uw5gJ0WP; Fri, 20 Aug 2021 04:32:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 67CFA4063E;
	Fri, 20 Aug 2021 04:32:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF54C001A;
	Fri, 20 Aug 2021 04:32:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF244C000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 04:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A2288188A
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 04:32:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8y_HK6gyLr0Q for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 04:32:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B7688184F
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 04:32:43 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0B8C66736F; Fri, 20 Aug 2021 06:32:38 +0200 (CEST)
Date: Fri, 20 Aug 2021 06:32:37 +0200
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH V3 13/13] HV/Storvsc: Add Isolation VM support for
 storvsc driver
Message-ID: <20210820043237.GC26450@lst.de>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-14-ltykernel@gmail.com>
 <MWHPR21MB1593EEF30FFD5C60ED744985D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593EEF30FFD5C60ED744985D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 vkuznets <vkuznets@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
 KY Srinivasan <kys@microsoft.com>, "will@kernel.org" <will@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "x86@kernel.org" <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Tianyu Lan <ltykernel@gmail.com>, "hch@lst.de" <hch@lst.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "pgonda@google.com" <pgonda@google.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "jgross@suse.com" <jgross@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "tj@kernel.org" <tj@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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

On Thu, Aug 19, 2021 at 06:17:40PM +0000, Michael Kelley wrote:
> > +#define storvsc_dma_map(dev, page, offset, size, dir) \
> > +	dma_map_page(dev, page, offset, size, dir)
> > +
> > +#define storvsc_dma_unmap(dev, dma_range, dir)		\
> > +		dma_unmap_page(dev, dma_range.dma,	\
> > +			       dma_range.mapping_size,	\
> > +			       dir ? DMA_FROM_DEVICE : DMA_TO_DEVICE)
> > +
> 
> Each of these macros is used only once.  IMHO, they don't
> add a lot of value.  Just coding dma_map/unmap_page()
> inline would be fine and eliminate these lines of code.

Yes, I had the same thought when looking over the code.  Especially
as macros tend to further obsfucate the code (compared to actual helper
functions).

> > +				for (i = 0; i < request->hvpg_count; i++)
> > +					storvsc_dma_unmap(&device->device,
> > +						request->dma_range[i],
> > +						request->vstor_packet.vm_srb.data_in == READ_TYPE);
> 
> I think you can directly get the DMA direction as request->cmd->sc_data_direction.

Yes.

> > 
> > @@ -1824,6 +1848,13 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
> >  		payload->range.len = length;
> >  		payload->range.offset = offset_in_hvpg;
> > 
> > +		cmd_request->dma_range = kcalloc(hvpg_count,
> > +				 sizeof(*cmd_request->dma_range),
> > +				 GFP_ATOMIC);
> 
> With this patch, it appears that storvsc_queuecommand() is always
> doing bounce buffering, even when running in a non-isolated VM.
> The dma_range is always allocated, and the inner loop below does
> the dma mapping for every I/O page.  The corresponding code in
> storvsc_on_channel_callback() that does the dma unmap allows for
> the dma_range to be NULL, but that never happens.

Maybe I'm missing something in the hyperv code, but I don't think
dma_map_page would bounce buffer for the non-isolated case.  It
will just return the physical address.

> > +		if (!cmd_request->dma_range) {
> > +			ret = -ENOMEM;
> 
> The other memory allocation failure in this function returns
> SCSI_MLQUEUE_DEVICE_BUSY.   It may be debatable as to whether
> that's the best approach, but that's a topic for a different patch.  I
> would suggest being consistent and using the same return code
> here.

Independent of if SCSI_MLQUEUE_DEVICE_BUSY is good (it it a common
pattern in SCSI drivers), ->queuecommand can't return normal
negative errnos.  It must return the SCSI_MLQUEUE_* codes or 0.
We should probably change the return type of the method definition
to a suitable enum to make this more clear.

> > +				if (offset_in_hvpg) {
> > +					payload->range.offset = dma & ~HV_HYP_PAGE_MASK;
> > +					offset_in_hvpg = 0;
> > +				}
> 
> I'm not clear on why payload->range.offset needs to be set again.
> Even after the dma mapping is done, doesn't the offset in the first
> page have to be the same?  If it wasn't the same, Hyper-V wouldn't
> be able to process the PFN list correctly.  In fact, couldn't the above
> code just always set offset_in_hvpg = 0?

Careful.  DMA mapping is supposed to keep the offset in the page, but
for that the DMA mapping code needs to know what the device considers a
"page".  For that the driver needs to set the min_align_mask field in
struct device_dma_parameters.

> 
> The whole approach here is to do dma remapping on each individual page
> of the I/O buffer.  But wouldn't it be possible to use dma_map_sg() to map
> each scatterlist entry as a unit?  Each scatterlist entry describes a range of
> physically contiguous memory.  After dma_map_sg(), the resulting dma
> address must also refer to a physically contiguous range in the swiotlb
> bounce buffer memory.   So at the top of the "for" loop over the scatterlist
> entries, do dma_map_sg() if we're in an isolated VM.  Then compute the
> hvpfn value based on the dma address instead of sg_page().  But everything
> else is the same, and the inner loop for populating the pfn_arry is unmodified.
> Furthermore, the dma_range array that you've added is not needed, since
> scatterlist entries already have a dma_address field for saving the mapped
> address, and dma_unmap_sg() uses that field.

Yes, I think dma_map_sg is the right thing to use here, probably even
for the non-isolated case so that we can get the hv drivers out of their
little corner and into being more like a normal kernel driver.  That
is, use the scsi_dma_map/scsi_dma_unmap helpers, and then iterate over
the dma addresses one page at a time using for_each_sg_dma_page.

> 
> One thing:  There's a maximum swiotlb mapping size, which I think works
> out to be 256 Kbytes.  See swiotlb_max_mapping_size().  We need to make
> sure that we don't get a scatterlist entry bigger than this size.  But I think
> this already happens because you set the device->dma_mask field in
> Patch 11 of this series.  __scsi_init_queue checks for this setting and
> sets max_sectors to limits transfers to the max mapping size.

Indeed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
