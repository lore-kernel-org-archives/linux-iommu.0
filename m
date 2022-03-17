Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A1FC433EF
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 00:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FB0384390;
	Thu, 17 Mar 2022 00:46:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YbjtstIr3lG0; Thu, 17 Mar 2022 00:46:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4D3908438B;
	Thu, 17 Mar 2022 00:46:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D815C001A;
	Thu, 17 Mar 2022 00:46:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18BB3C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 00:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E900284390
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 00:46:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q2RJmmwu1hd0 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 00:46:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A5C48438B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647478004; x=1679014004;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NnAPp6oZd6VCwzUOq2GdDfZv4iSoBJAkNLTJDUkH7T0=;
 b=k4ALTn/w9L8jZ+v93cajV9EOtfG1SFaWuedIrCYgSNlja5yLyra4h1U/
 dVKUHdRhtYL3ZVdWIPODYAp5FIgyUVmU4CxE20bshYjnZwMdSUatH5kVq
 5gyWt0zZfSPfqqWwWupDpxOTCUuWJVJv1gLRQC4k3vk8SAzOzXakjpcfP
 9/sap4CKkxs2KQSVsGCxrqyrLJzKc3DtCtO5/rzW7kwjdkKruX66YgCaJ
 aj2JBvD/WAy1iKKVeFlv4n66YDeqKfxy5YdkipMbG7qvTw7JIUyysP/3f
 qjl0KlheQx/WImlSELlCrlj5ct2zoBCh7M7Vs9mmoGa+jHYVeQKP32xM1 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236695091"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="236695091"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 17:46:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="513240440"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 17:46:43 -0700
Date: Wed, 16 Mar 2022 17:49:59 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220316174959.08040193@jacob-builder>
In-Reply-To: <20220316221550.GS11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <20220315153620.710a30fa@jacob-builder>
 <20220315230457.GO11336@nvidia.com>
 <20220316135004.61ae1611@jacob-builder>
 <20220316221550.GS11336@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi, 
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Jason,

On Wed, 16 Mar 2022 19:15:50 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 16, 2022 at 01:50:04PM -0700, Jacob Pan wrote:
> 
> > I guess a list of (device, pasid) tuples as you suggested could work
> > but it will have duplicated device entries since each device could have
> > multiple PASIDs. right?  
> 
> Is assigning the same iommu_domain to multiple PASIDs of the same
> device something worth optimizing for?
Probably not, the current usage case has only two PASIDs at most (RID2PASID
+ a kernel PASID).

I was just thinking for the generalized case, device TLB flush would be
more efficient if we don't go through the domain list. Use a per-domain-dev
list instead. But it doesn't matter much for DMA domain which has one
device mostly.

> I would expect real applications will try to use the same PASID for
> the same IOVA map to optimize IOTLB caching.
> 
> Is there a use case for that I'm missing?
> 
Yes. it would be more efficient for PASID selective domain TLB flush. But
on VT-d IOTLB is also tagged by domain ID, domain flush can use DID if
there are many PASIDs. Not sure about other archs. Agree that optimizing
PASIDs for TLB flush should be a common goal.

> Otherwise your explanation is what I was imagining as well.
> 
> I would also think about expanding your struct so that the device
> driver can track per-device per-domain data as well, that seems
> useful IIRC?
> 
yes, at least both VT-d and FSL drivers have struct device_domain_info.

> ie put a 'sizeof_iommu_dev_pasid_data' in the domain->ops and
> allocate that much memory so the driver can use the trailer space for
> its own purpose.
> 
That sounds great to have but not sure i understood correctly how to do it.

Do you mean for each vendor driver's struct device_domain_info (or
equivalent), we carve out sizeof_iommu_dev_pasid_data as common data, then
the rest of the space is vendor specific? I don't feel I get your point,
could you elaborate?


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
