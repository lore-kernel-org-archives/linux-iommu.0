Return-Path: <SRS0=/ROq=YQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6506ECA9EB6
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 13:41:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DA620663
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 13:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DA620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 027F9C9A;
	Wed, 23 Oct 2019 13:41:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2764EB7D
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 13:41:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3DD2114D
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 13:41:39 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Oct 2019 06:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; d="scan'208";a="281621924"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga001.jf.intel.com with ESMTP; 23 Oct 2019 06:41:39 -0700
Date: Wed, 23 Oct 2019 06:46:00 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v6 00/10] Nested Shared Virtual Address (SVA) VT-d support
Message-ID: <20191023064600.5e24234b@jacob-builder>
In-Reply-To: <20191023002751.GA100970@otc-nc-03>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20191023002751.GA100970@otc-nc-03>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Jonathan Cameron <jic23@kernel.org>
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

On Tue, 22 Oct 2019 17:27:51 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> Hi Jacob
> 
> On Tue, Oct 22, 2019 at 04:53:13PM -0700, Jacob Pan wrote:
> > Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on
> > Intel platforms allow address space sharing between device DMA and
> > applications. SVA can reduce programming complexity and enhance
> > security. This series is intended to enable SVA virtualization,
> > i.e. shared guest application address space and physical device DMA
> > address. Only IOMMU portion  
> 
> Last line "i.e shared guest application address space and physical
> device DMA address" doesn't read well. 
> 
> Simply rephrase as "enable use of SVA within a guest user application"
> 
Much better, thanks!
> > of the changes are included in this series. Additional support is
> > needed in VFIO and QEMU (will be submitted separately) to complete
> > this functionality.
> > 
> > To make incremental changes and reduce the size of each patchset.
> > This series does not inlcude support for page request services.
> > 
> > In VT-d implementation, PASID table is per device and maintained in
> > the host. Guest PASID table is shadowed in VMM where virtual IOMMU
> > is emulated.
> > 
> >     .-------------.  .---------------------------.
> >     |   vIOMMU    |  | Guest process CR3, FL only|
> >     |             |  '---------------------------'
> >     .----------------/
> >     | PASID Entry |--- PASID cache flush -
> >     '-------------'                       |
> >     |             |                       V
> >     |             |                CR3 in GPA
> >     '-------------'
> > Guest
> > ------| Shadow |--------------------------|--------
> >       v        v                          v
> > Host
> >     .-------------.  .----------------------.
> >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> >     |             |  '----------------------'
> >     .----------------/  |
> >     | PASID Entry |     V (Nested xlate)
> >     '----------------\.------------------------------.
> >     |             |   |SL for GPA-HPA, default domain|
> >     |             |   '------------------------------'
> >     '-------------'  
> 
> is the SL for GPA-HPA default domain? When you assign a device to 
> Guest, this isn't default domain right?
> 
SL is harvested from default domain for PCI device assignment. Once we
add mdev support, you are right that SL is not default domain, but this
patchset is not dealing with mdev yet. Jumping ahead :)

> > Where:
> >  - FL = First level/stage one page tables
> >  - SL = Second level/stage two page tables
> > 
> > This is the remaining VT-d only portion of V5 since the uAPIs and
> > IOASID common code have been applied to Joerg's IOMMU core branch.
> > (https://lkml.org/lkml/2019/10/2/833)
> > 
> > The complete set with VFIO patches are here:
> > https://github.com/jacobpan/linux.git:siov_sva
> > 
> > The complete nested SVA upstream patches are divided into three
> > phases: 1. Common APIs and PCI device direct assignment
> >     2. Page Request Services (PRS) support
> >     3. Mediated device assignment
> > 
> > With this set and the accompanied VFIO code, we will achieve phase
> > #1.
> > 
> > Thanks,
> > 
> > Jacob
> > 
> > ChangeLog:
> > 	- V6
> > 	  - Rebased on top of Joerg's core branch
> > 	  (git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> > core)
> > 	  - Adapt to new uAPIs and IOASID allocators
> > 
> > 	- V5
> > 	  Rebased on v5.3-rc4 which has some of the IOMMU fault
> > APIs merged. Addressed v4 review comments from Eric Auger, Baolu
> > Lu, and Jonathan Cameron. Specific changes are as follows:
> > 	  - Refined custom IOASID allocator to support multiple
> > vIOMMU, hotplug cases.
> > 	  - Extracted vendor data from IOMMU guest PASID bind data,
> > for VT-d will support all necessary guest PASID entry fields for
> > PASID bind.
> > 	  - Support non-identity host-guest PASID mapping
> > 	  - Exception handling in various cases
> > 
> > 	- V4
> > 	  - Redesigned IOASID allocator such that it can support
> > custom allocators with shared helper functions. Use separate XArray
> > 	  to store IOASIDs per allocator. Took advice from Eric
> > Auger to have default allocator use the generic allocator structure.
> > 	  Combined into one patch in that the default allocator is
> > just "another" allocator now. Can be built as a module in case of
> > 	  driver use without IOMMU.
> > 	  - Extended bind guest PASID data to support SMMU and
> > non-identity guest to host PASID mapping
> > https://lkml.org/lkml/2019/5/21/802
> > 	  - Rebased on Jean's sva/api common tree, new patches
> > starts with [PATCH v4 10/22]
> > 
> > 	- V3
> > 	  - Addressed thorough review comments from Eric Auger
> > (Thank you!)
> > 	  - Moved IOASID allocator from driver core to IOMMU code
> > per suggestion by Christoph Hellwig
> > 	    (https://lkml.org/lkml/2019/4/26/462)
> > 	  - Rebased on top of Jean's SVA API branch and Eric's v7[1]
> > 	    (git://linux-arm.org/linux-jpb.git sva/api)
> > 	  - All IOMMU APIs are unmodified (except the new bind
> > guest PASID call in patch 9/16)
> > 
> > 	- V2
> > 	  - Rebased on Joerg's IOMMU x86/vt-d branch v5.1-rc4
> > 	  - Integrated with Eric Auger's new v7 series for common
> > APIs (https://github.com/eauger/linux/tree/v5.1-rc3-2stage-v7)
> > 	  - Addressed review comments from Andy Shevchenko and Alex
> > Williamson on IOASID custom allocator.
> > 	  - Support multiple custom IOASID allocators (vIOMMUs) and
> > dynamic registration.
> > 
> > 
> > Jacob Pan (9):
> >   iommu/vt-d: Add custom allocator for IOASID
> >   iommu/vt-d: Replace Intel specific PASID allocator with IOASID
> >   iommu/vt-d: Move domain helper to header
> >   iommu/vt-d: Avoid duplicated code for PASID setup
> >   iommu/vt-d: Add nested translation helper function
> >   iommu/vt-d: Misc macro clean up for SVM
> >   iommu/vt-d: Add bind guest PASID support
> >   iommu/vt-d: Support flushing more translation cache types
> >   iommu/vt-d: Add svm/sva invalidate function
> > 
> > Lu Baolu (1):
> >   iommu/vt-d: Enlightened PASID allocation
> > 
> >  drivers/iommu/Kconfig       |   1 +
> >  drivers/iommu/dmar.c        |  46 ++++++
> >  drivers/iommu/intel-iommu.c | 259 +++++++++++++++++++++++++++++++--
> >  drivers/iommu/intel-pasid.c | 343
> > +++++++++++++++++++++++++++++++++++++-------
> > drivers/iommu/intel-pasid.h |  25 +++- drivers/iommu/intel-svm.c
> > | 298 ++++++++++++++++++++++++++++++--------
> > include/linux/intel-iommu.h |  39 ++++- include/linux/intel-svm.h
> > |  17 +++ 8 files changed, 904 insertions(+), 124 deletions(-)
> > 
> > -- 
> > 2.7.4
> >   

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
