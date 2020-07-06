Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C43C433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:51:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B137920672
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B137920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8CAD5878DD;
	Mon,  6 Jul 2020 23:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2q6jwBNf7Kdd; Mon,  6 Jul 2020 23:51:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D5B0187893;
	Mon,  6 Jul 2020 23:51:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD29DC0893;
	Mon,  6 Jul 2020 23:51:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEF96C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EA9C22726C
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8I1ABZrrsStI for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 23:51:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 191732724A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:51:56 +0000 (UTC)
IronPort-SDR: HI/ZO+vMfBqRV3NPnF7z2W0eSrJTn5F6xNVkcM6ugqbQSwD/I/H5xMfo/vU47u37tCCJEhVMxD
 nKPG8dC4/VsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="165589782"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="165589782"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 16:51:55 -0700
IronPort-SDR: V3IqljHJ6mWHBfO15VYsfZ8uN2Dj8XM2Fc2l3ZI7BT/hDkI4J492xqJV6vct60ZOI34Y+DPVK6
 Pr9PfZTiE5Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="482865299"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2020 16:51:54 -0700
Date: Mon, 6 Jul 2020 16:58:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 2/7] iommu/vt-d: Remove global page support in devTLB
 flush
Message-ID: <20200706165831.0e62fa7f@jacob-builder>
In-Reply-To: <e4b05249-bf1b-4d27-f76b-90a80f8586b2@redhat.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593617636-79385-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <e4b05249-bf1b-4d27-f76b-90a80f8586b2@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

On Thu, 2 Jul 2020 09:16:22 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 7/1/20 5:33 PM, Jacob Pan wrote:
> > Global pages support is removed from VT-d spec 3.0 for dev TLB
> > invalidation. This patch is to remove the bits for vSVA. Similar
> > change already made for the native SVA. See the link below.
> > 
> > Link: https://lkml.org/lkml/2019/8/26/651
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/dmar.c  | 4 +---
> >  drivers/iommu/intel/iommu.c | 4 ++--
> >  include/linux/intel-iommu.h | 3 +--
> >  3 files changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> > index cc46dff98fa0..d9f973fa1190 100644
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -1437,8 +1437,7 @@ void qi_flush_piotlb(struct intel_iommu
> > *iommu, u16 did, u32 pasid, u64 addr, 
> >  /* PASID-based device IOTLB Invalidate */
> >  void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid,
> > u16 pfsid,
> > -			      u32 pasid,  u16 qdep, u64 addr,
> > -			      unsigned int size_order, u64 granu)
> > +			      u32 pasid,  u16 qdep, u64 addr,
> > unsigned int size_order) {
> >  	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order -
> > 1); struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> > @@ -1446,7 +1445,6 @@ void qi_flush_dev_iotlb_pasid(struct
> > intel_iommu *iommu, u16 sid, u16 pfsid, desc.qw0 =
> > QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> > QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> > QI_DEV_IOTLB_PFSID(pfsid);
> > -	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);  
> nit:
> 
> you may simplify the init of .qw1 to
> .qw1 = addr & ~mask
> 
> as you have
> desc.qw1 |= addr & ~mask;
> 
indeed, will change it in patch 4/7.
Thanks!

> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 
> >  
> >  	/*
> >  	 * If S bit is 0, we only flush a single page. If S bit is
> > set, diff --git a/drivers/iommu/intel/iommu.c
> > b/drivers/iommu/intel/iommu.c index 9129663a7406..96340da57075
> > 100644 --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5466,7 +5466,7 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, info->pfsid, pasid,
> >  						info->ats_qdep,
> >  						inv_info->addr_info.addr,
> > -						size, granu);
> > +						size);
> >  			break;
> >  		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> >  			if (info->ats_enabled)
> > @@ -5474,7 +5474,7 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, info->pfsid, pasid,
> >  						info->ats_qdep,
> >  						inv_info->addr_info.addr,
> > -						size, granu);
> > +						size);
> >  			else
> >  				pr_warn_ratelimited("Passdown
> > device IOTLB flush w/o ATS!\n"); break;
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 729386ca8122..9a6614880773
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -380,7 +380,6 @@ enum {
> >  
> >  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
> >  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> > -#define QI_DEV_EIOTLB_GLOB(g)	((u64)(g) & 0x1)
> >  #define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
> >  #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
> >  #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
> > @@ -704,7 +703,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu,
> > u16 did, u32 pasid, u64 addr, 
> >  void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid,
> > u16 pfsid, u32 pasid, u16 qdep, u64 addr,
> > -			      unsigned int size_order, u64 granu);
> > +			      unsigned int size_order);
> >  void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64
> > granu, int pasid);
> >  
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
