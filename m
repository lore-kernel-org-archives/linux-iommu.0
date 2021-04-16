Return-Path: <SRS0=B6PL=JN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0863CC433B4
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 13:10:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BE3611AC
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 13:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BE3611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FF5684760;
	Fri, 16 Apr 2021 13:10:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2NZCeGnU2J0l; Fri, 16 Apr 2021 13:10:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D8E184419;
	Fri, 16 Apr 2021 13:10:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E29A3C000C;
	Fri, 16 Apr 2021 13:10:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA9B4C000A
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 13:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D57B040422
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 13:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iKF1Iz4MkE4H for <iommu@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 13:10:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8108403AE
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 13:10:19 +0000 (UTC)
IronPort-SDR: sBohF918kFJUa8ehQfV3R+fsYM2/D0zTVn7FDuf5NyLBph3mhdMik4oYOYh64WBuJZP2mzISwd
 n52yiRUTflaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194596254"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="194596254"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 06:10:19 -0700
IronPort-SDR: bNdvfTep5YEmj6Da3ykd0jME7lPZtO68SgGihYTvPURY4blc1mzqZfn57deXfbO2oHSXU3vBh9
 faWSbcPiLvBQ==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="422006223"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 06:10:18 -0700
Date: Fri, 16 Apr 2021 06:12:58 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210416061258.325e762e@jacob-builder>
In-Reply-To: <20210415230732.GG1370958@nvidia.com>
References: <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Thu, 15 Apr 2021 20:07:32 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 15, 2021 at 03:11:19PM +0200, Auger Eric wrote:
> > Hi Jason,
> > 
> > On 4/1/21 6:03 PM, Jason Gunthorpe wrote:  
> > > On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:
> > >   
> > >> DMA page faults are delivered to root-complex via page request
> > >> message and it is per-device according to PCIe spec. Page request
> > >> handling flow is:
> > >>
> > >> 1) iommu driver receives a page request from device
> > >> 2) iommu driver parses the page request message. Get the RID,PASID,
> > >> faulted page and requested permissions etc.
> > >> 3) iommu driver triggers fault handler registered by device driver
> > >> with iommu_report_device_fault()  
> > > 
> > > This seems confused.
> > > 
> > > The PASID should define how to handle the page fault, not the driver.
> > >  
> > 
> > In my series I don't use PASID at all. I am just enabling nested stage
> > and the guest uses a single context. I don't allocate any user PASID at
> > any point.
> > 
> > When there is a fault at physical level (a stage 1 fault that concerns
> > the guest), this latter needs to be reported and injected into the
> > guest. The vfio pci driver registers a fault handler to the iommu layer
> > and in that fault handler it fills a circ bugger and triggers an eventfd
> > that is listened to by the VFIO-PCI QEMU device. this latter retrives
> > the faault from the mmapped circ buffer, it knowns which vIOMMU it is
> > attached to, and passes the fault to the vIOMMU.
> > Then the vIOMMU triggers and IRQ in the guest.
> > 
> > We are reusing the existing concepts from VFIO, region, IRQ to do that.
> > 
> > For that use case, would you also use /dev/ioasid?  
> 
> /dev/ioasid could do all the things you described vfio-pci as doing,
> it can even do them the same way you just described.
> 
> Stated another way, do you plan to duplicate all of this code someday
> for vfio-cxl? What about for vfio-platform? ARM SMMU can be hooked to
> platform devices, right?
> 
> I feel what you guys are struggling with is some choice in the iommu
> kernel APIs that cause the events to be delivered to the pci_device
> owner, not the PASID owner.
> 
> That feels solvable.
> 
Perhaps more of a philosophical question for you and Alex. There is no
doubt that the direction you guided for /dev/ioasid is a much cleaner one,
especially after VDPA emerged as another IOMMU backed framework.

The question is what do we do with the nested translation features that have
been targeting the existing VFIO-IOMMU for the last three years? That
predates VDPA. Shall we put a stop marker *after* nested support and say no
more extensions for VFIO-IOMMU, new features must be built on this new
interface?

If we were to close a checkout line for some unforeseen reasons, should we
honor the customers already in line for a long time?

This is not a tactic or excuse for not working on the new /dev/ioasid
interface. In fact, I believe we can benefit from the lessons learned while
completing the existing. This will give confidence to the new
interface. Thoughts?

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
