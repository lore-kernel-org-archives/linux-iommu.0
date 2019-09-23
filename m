Return-Path: <SRS0=v/Dl=XS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1AAC4CED0
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 20:25:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE0A2054F
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 20:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE0A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7A9A3135C;
	Mon, 23 Sep 2019 20:25:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 165B41358
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 20:25:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 84F7D102
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 20:25:54 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Sep 2019 13:25:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; d="scan'208";a="388606520"
Received: from araj-mobl1.jf.intel.com ([10.24.10.67])
	by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2019 13:25:52 -0700
Date: Mon, 23 Sep 2019 13:25:52 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 0/4] Use 1st-level for DMA remapping in guest
Message-ID: <20190923202552.GA21816@araj-mobl1.jf.intel.com>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122715.53de79d0@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190923122715.53de79d0@jacob-builder>
User-Agent: Mutt/1.9.1 (2017-09-22)
Cc: kevin.tian@intel.com, Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
	sanjay.k.kumar@intel.com, yi.y.sun@intel.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob

On Mon, Sep 23, 2019 at 12:27:15PM -0700, Jacob Pan wrote:
> > 
> > In VT-d 3.0, scalable mode is introduced, which offers two level
> > translation page tables and nested translation mode. Regards to
> > GIOVA support, it can be simplified by 1) moving the GIOVA support
> > over 1st-level page table to store GIOVA->GPA mapping in vIOMMU,
> > 2) binding vIOMMU 1st level page table to the pIOMMU, 3) using pIOMMU
> > second level for GPA->HPA translation, and 4) enable nested (a.k.a.
> > dual stage) translation in host. Compared with current shadow GIOVA
> > support, the new approach is more secure and software is simplified
> > as we only need to flush the pIOMMU IOTLB and possible device-IOTLB
> > when an IOVA mapping in vIOMMU is torn down.
> > 
> >      .-----------.
> >      |  vIOMMU   |
> >      |-----------|                 .-----------.
> >      |           |IOTLB flush trap |   QEMU    |
> >      .-----------.    (unmap)      |-----------|
> >      | GVA->GPA  |---------------->|           |
> >      '-----------'                 '-----------'
> >      |           |                       |
> >      '-----------'                       |
> >            <------------------------------
> >            |      VFIO/IOMMU          
> >            |  cache invalidation and  
> >            | guest gpd bind interfaces
> >            v
> For vSVA, the guest PGD bind interface will mark the PASID as guest
> PASID and will inject page request into the guest. In FL gIOVA case, I
> guess we are assuming there is no page fault for GIOVA. I will need to
> add a flag in the gpgd bind such that any PRS will be auto responded
> with invalid.

Is there real need to enforce this? I'm not sure if there is any
limitation in the spec, and if so, can the guest check that instead?

Also i believe the idea is to overcommit PASID#0 such uses. Thought
we had a capability to expose this to the vIOMMU as well. Not sure if this
is already documented, if not should be up in the next rev.


> 
> Also, native use of IOVA FL map is not to be supported? i.e. IOMMU API
> and DMA API for native usage will continue to be SL only?
> >      .-----------.
> >      |  pIOMMU   |
> >      |-----------|
> >      .-----------.
> >      | GVA->GPA  |<---First level
> >      '-----------'
> >      | GPA->HPA  |<---Scond level

s/Scond/Second

> >      '-----------'
> >      '-----------'
> > 
> > This patch series only aims to achieve the first goal, a.k.a using
> > first level translation for IOVA mappings in vIOMMU. I am sending
> > it out for your comments. Any comments, suggestions and concerns are
> > welcomed.
> > 
> 
> 
> > Based-on-idea-by: Ashok Raj <ashok.raj@intel.com>
> > Based-on-idea-by: Kevin Tian <kevin.tian@intel.com>
> > Based-on-idea-by: Liu Yi L <yi.l.liu@intel.com>
> > Based-on-idea-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Based-on-idea-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > 
> > Lu Baolu (4):
> >   iommu/vt-d: Move domain_flush_cache helper into header
> >   iommu/vt-d: Add first level page table interfaces
> >   iommu/vt-d: Map/unmap domain with mmmap/mmunmap
> >   iommu/vt-d: Identify domains using first level page table
> > 
> >  drivers/iommu/Makefile             |   2 +-
> >  drivers/iommu/intel-iommu.c        | 142 ++++++++++--
> >  drivers/iommu/intel-pgtable.c      | 342
> > +++++++++++++++++++++++++++++ include/linux/intel-iommu.h        |
> > 31 ++- include/trace/events/intel_iommu.h |  60 +++++
> >  5 files changed, 553 insertions(+), 24 deletions(-)
> >  create mode 100644 drivers/iommu/intel-pgtable.c
> > 
> 
> [Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
