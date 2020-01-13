Return-Path: <SRS0=W82T=3C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C2AC33CAE
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 17:13:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5497F2075B
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5497F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1C73B85F29;
	Mon, 13 Jan 2020 17:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nHUigUCo3k+U; Mon, 13 Jan 2020 17:13:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F8C785B29;
	Mon, 13 Jan 2020 17:13:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 628F8C1D80;
	Mon, 13 Jan 2020 17:13:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CEF5C077D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 17:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 829FA85ECB
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 17:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LEp6vK2fNRNe for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jan 2020 17:13:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 74F3685B29
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 17:13:40 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Jan 2020 09:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; d="scan'208";a="217466080"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by orsmga008.jf.intel.com with ESMTP; 13 Jan 2020 09:13:39 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jan 2020 09:13:39 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.100]) with mapi id 14.03.0439.000;
 Mon, 13 Jan 2020 09:13:39 -0800
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 0/5] Clean up VMD DMA Map Ops
Thread-Topic: [PATCH v3 0/5] Clean up VMD DMA Map Ops
Thread-Index: AQHVyA0Lu7RxyhVCQkiZlD/A0y0JB6fpCjsAgABVXYA=
Date: Mon, 13 Jan 2020 17:13:38 +0000
Message-ID: <7b55519959391b7102c54341c6f6f23b2d24dabb.camel@intel.com>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
 <20200113120806.GA15462@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200113120806.GA15462@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.159]
Content-ID: <5AB7891C721585418C2B64760AC9A88B@intel.com>
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "hch@lst.de" <hch@lst.de>
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

Hi Lorenzo,

On Mon, 2020-01-13 at 12:08 +0000, Lorenzo Pieralisi wrote:
> On Fri, Jan 10, 2020 at 10:21:08AM -0700, Jon Derrick wrote:
> > v2 Set: https://lore.kernel.org/linux-iommu/1578580256-3483-1-git-send-email-jonathan.derrick@intel.com/T/#t
> > v1 Set: https://lore.kernel.org/linux-iommu/20200107134125.GD30750@8bytes.org/T/#t
> > 
> > VMD currently works with VT-d enabled by pointing DMA and IOMMU actions at the
> > VMD endpoint. The problem with this approach is that the VMD endpoint's
> > device-specific attributes, such as the DMA Mask Bits, are used instead.
> > 
> > This set cleans up VMD by removing the override that redirects DMA map
> > operations to the VMD endpoint. Instead it introduces a new DMA alias mechanism
> > into the existing DMA alias infrastructure.
> > 
> > v1 added a pointer in struct pci_dev that pointed to the DMA alias' struct
> > pci_dev and did the necessary DMA alias and IOMMU modifications.
> > 
> > v2 introduced a new weak function to reference the 'Direct DMA Alias', and
> > removed the need to add a pointer in struct device or pci_dev. Weak functions
> > are generally frowned upon when it's a single architecture implementation, so I
> > am open to alternatives.
> > 
> > v3 references the pci_dev rather than the struct device for the PCI
> > 'Direct DMA Alias' (pci_direct_dma_alias()). This revision also allows
> > pci_for_each_dma_alias() to call any DMA aliases for the Direct DMA alias
> > device, though I don't expect the VMD endpoint to need intra-bus DMA aliases.
> > 
> > Changes from v2:
> > Uses struct pci_dev for PCI Device 'Direct DMA aliasing' (pci_direct_dma_alias)
> > Allows pci_for_each_dma_alias to iterate over the alias mask of the 'Direct DMA alias'
> > 
> > Changes from v1:
> > Removed 1/5 & 2/5 misc fix patches that were merged
> > Uses Christoph's staging/cleanup patches
> > Introduce weak function rather than including pointer in struct device or pci_dev.
> > 
> > Based on Joerg's next:
> > https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/
> > 
> > Jon Derrick (5):
> >   x86/pci: Add a to_pci_sysdata helper
> >   x86/PCI: Expose VMD's PCI Device in pci_sysdata
> >   PCI: Introduce pci_direct_dma_alias()
> >   PCI: vmd: Stop overriding dma_map_ops
> >   x86/pci: Remove X86_DEV_DMA_OPS
> > 
> >  arch/x86/Kconfig               |   3 -
> >  arch/x86/include/asm/device.h  |  10 ---
> >  arch/x86/include/asm/pci.h     |  31 ++++-----
> >  arch/x86/pci/common.c          |  45 ++----------
> >  drivers/iommu/intel-iommu.c    |  18 +++--
> >  drivers/pci/controller/Kconfig |   1 -
> >  drivers/pci/controller/vmd.c   | 152 +----------------------------------------
> >  drivers/pci/pci.c              |  19 +++++-
> >  drivers/pci/search.c           |   7 ++
> >  include/linux/pci.h            |   1 +
> >  10 files changed, 61 insertions(+), 226 deletions(-)
> 
> Jon, Christoph,
> 
> AFAICS this series supersedes/overrides:
> 
> https://patchwork.kernel.org/patch/11114831/
> 
> Please let me know if that's correct, actually I was waiting to
> see consensus on the patch above but if this series supersedes
> it I would drop it from the PCI review queue.
> 
> Thanks,
> Lorenzo

It does supercede it (with Christoph's blessing). By the way, I have
been basing on Joerg's repo  due to the v1/RFC IOMMU modifcations. As
there's more pci work at this point, should I base it on Bjorn's repo
instead?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
