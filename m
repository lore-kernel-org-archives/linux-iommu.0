Return-Path: <SRS0=J567=KB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A611AC433ED
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 16:34:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12ED61132
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 16:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12ED61132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 772FD402CA;
	Thu,  6 May 2021 16:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cK-kSFspjVs9; Thu,  6 May 2021 16:34:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27D804028B;
	Thu,  6 May 2021 16:34:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5F32C000E;
	Thu,  6 May 2021 16:34:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37465C0001
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 16:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F245402CA
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 16:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eep90OBhn5IA for <iommu@lists.linux-foundation.org>;
 Thu,  6 May 2021 16:34:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63FD04028B
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 16:34:01 +0000 (UTC)
IronPort-SDR: fInNBmHiqzZiTuJ+w4yktpUzNsSutRgynK35WgtU1IVWN1v8Fqg0vPXDN54ynvv0/OllFO1A+e
 +43ZVTTZdF3A==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="185981074"
X-IronPort-AV: E=Sophos;i="5.82,278,1613462400"; d="scan'208";a="185981074"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2021 09:32:41 -0700
IronPort-SDR: wyPtzq1AlkC8XDzoyMUG3bfiBuyrMzsFN73gf9J8keEmp0nD/1ecblUB/ji3/061mupVrEkq5v
 gUQKN9QAVdPQ==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; d="scan'208";a="428627255"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2021 09:32:41 -0700
Date: Thu, 6 May 2021 09:32:40 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210506163240.GA9058@otc-nc-03>
References: <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210506122730.GQ1370958@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jason

On Thu, May 06, 2021 at 09:27:30AM -0300, Jason Gunthorpe wrote:
> On Thu, May 06, 2021 at 09:23:48AM +0200, Jean-Philippe Brucker wrote:
> > On Wed, May 05, 2021 at 01:04:46PM -0700, Jacob Pan wrote:
> > > > > For ARM, since the guest owns the per device PASID table. There is no
> > > > > need to allocate PASIDs from the host nor the hypervisor. Without SWQ,
> > > > > there is no need for global PASID/SSID either. So PASID being global
> > > > > for ARM is for simplicity in case of host PASID/SSID.  
> > > > 
> > > > It isn't clear how ARM can support PASID and mdev but that is an
> > > > unrelated issue..
> > > > 
> > > AFAIK, the current SMMU device assignment is per RID, since only one stage2
> > > page tables per RID, not per PASID. This is equivalent to the older VT-d
> > > spec. prior to scalable mode.
> > 
> > Yes that's right. Since SMMUv3 has a single level-2 page table per RID, it
> > doesn't support assigning level-1 page tables to guests for mdevs (sub-VF
> > devices). So no PASIDs for mdevs, which also means each guest has its own
> > PASID space and the host doesn't track guest PASIDs.
> 
> Basically it means when the guest's top level IOASID is created for
> nesting that IOASID claims all PASID's on the RID and excludes any
> PASID IOASIDs from existing on the RID now or in future.

The way to look at it this is as follows:

For platforms that do not have a need to support shared work queue model
support for ENQCMD or similar, PASID space is naturally per RID. There is no
complication with this. Every RID has the full range of PASID's and no need
for host to track which PASIDs are allocated now or in future in the guest.

For platforms that support ENQCMD, it is required to mandate PASIDs are
global across the entire system. Maybe its better to call them gPASID for
guest and hPASID for host. Short reason being gPASID->hPASID is a guest
wide mapping for ENQCMD and not a per-RID based mapping. (We covered that
in earlier responses)

In our current implementation we actually don't separate this space, and
gPASID == hPASID. The iommu driver enforces that by using the custom
allocator and the architected interface that allows all guest vIOMMU
allocations to be proxied to host. Nothing but a glorified hypercall like
interface. In fact some OS's do use hypercall to get a hPASID vs using
the vCMD style interface.

For cases where there is full PASID range for every RID and completely
managed by the guest that requires no assist from host to ensure
uniqueness, they don't need to have a custom allocator. Maybe the general
allocator can have ways to ensure global uniqueness vs. RID wide
uniqueness. This is still managed by the iommu driver (vIOMMU) + the
backend for vCMD in the host IOMMU driver.

> 
> Which would be a different behavior than something like Intel's top
> level IOASID that doesn't claim all the PASIDs.

isn't this simple, if we can say ioasid allocator can provide 

- system wide PASID
- RID local PASID

Based on platform capabilities that require such differentiation?

And based on the other threads, if ioasid is just a pgtable representation,
it doesn't need a PASID per-se. But when you want to use SVM or such, you
can associate a PASID with it for the IOMMU to plumb things with hardware.

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
