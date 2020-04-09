Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CECAC2BA2B
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 00:33:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6172078E
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 00:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6172078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 08F8887986;
	Thu,  9 Apr 2020 00:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHw4YKD7mEBF; Thu,  9 Apr 2020 00:33:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8CC5187985;
	Thu,  9 Apr 2020 00:33:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65234C1D7E;
	Thu,  9 Apr 2020 00:33:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C59EC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 00:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 668FA87986
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 00:33:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RYd72gYRmYPu for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 00:33:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6F14E87985
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 00:33:04 +0000 (UTC)
IronPort-SDR: TSsGVLs0KhREkKp09ZhcWlKBo4QGCYSoefJpbqekelrBDUtwCi0mLum9t1ZE5rJu24c5JQgloL
 TNSF5iWLkUkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2020 17:33:03 -0700
IronPort-SDR: C1qL5Uv7rF+DQmP7fh9jTXrGc/LGfxRt0QrtVkuPxjfPpYBQrc5At/gGm3/fi6RvwufCk3LjSd
 XTRrdBZO4Efw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,360,1580803200"; d="scan'208";a="362000598"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2020 17:33:02 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 17:33:01 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.225]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.103]) with mapi id 14.03.0439.000;
 Wed, 8 Apr 2020 17:33:01 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "drake@endlessm.com" <drake@endlessm.com>
Subject: Re: [PATCH v4] iommu/vt-d: consider real PCI device when checking
 if mapping is needed
Thread-Topic: [PATCH v4] iommu/vt-d: consider real PCI device when checking
 if mapping is needed
Thread-Index: AQHV5tO6P1q7GPBOf0WbPL1Nv6XzmagiZPoAgAGRbgCAAGzJgIBMTL4AgAAEmAA=
Date: Thu, 9 Apr 2020 00:33:00 +0000
Message-ID: <ae740b4de5fd6cf7f52ee1baa7b9347fed26a3b4.camel@intel.com>
References: <CAD8Lp47Bhv_58-Z+a+JFS9rTZW58_rWvE8N+XVtX7mmB-Tj55A@mail.gmail.com>
 <20200220100607.9044-1-drake@endlessm.com>
 <a99ff4f4edc4fd5495c9d6b245a590a256c9261b.camel@intel.com>
In-Reply-To: <a99ff4f4edc4fd5495c9d6b245a590a256c9261b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.6.119]
Content-ID: <B84581C980EFBB4490BA4C90366C9409@intel.com>
MIME-Version: 1.0
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux@endlessm.com" <linux@endlessm.com>
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

Hm that didn't come through right..

On Wed, 2020-04-08 at 18:16 -0600, Jonathan Derrick wrote:
> Hi Daniel,
> 
> Reviving this thread
> 
> On Thu, 2020-02-20 at 18:06 +0800, Daniel Drake wrote:
> > > On Wed, Feb 19, 2020 at 11:40 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> > > > With respect, this is problematical. The parent and all subdevices share
> > > > a single translation entry. The DMA mask should be consistent.
> > > > 
> > > > Otherwise, for example, subdevice A has 64-bit DMA capability and uses
> > > > an identity domain for DMA translation. While subdevice B has 32-bit DMA
> > > > capability and is forced to switch to DMA domain. Subdevice A will be
> > > > impacted without any notification.
> > 
> > Looking closer, this problematic codepath may already be happening for VMD,
> > under intel_iommu_add_device(). Consider this function running for a VMD
> > subdevice, we hit:
> > 
> >     domain = iommu_get_domain_for_dev(dev);
> > 
> > I can't quite grasp the code flow here, but domain->type now always seems
> > to return the domain type of the real DMA device, which seems like pretty
> > reasonable behaviour.
> > 
> >     if (domain->type == IOMMU_DOMAIN_DMA) {
> > 
> > and as detailed in previous mails, the real VMD device seems to be in a DMA
> > domain by default, so we continue.
> > 
> >         if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
> > 
> > Now we checked the default domain type of the subdevice. This seems rather
> > likely to return IDENTITY because that's effectively the default type...
> > 
> >             ret = iommu_request_dm_for_dev(dev);
> >             if (ret) {
> >                 dmar_remove_one_dev_info(dev);
> >                 dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
> >                 domain_add_dev_info(si_domain, dev);
> >                 dev_info(dev,
> >                      "Device uses a private identity domain.\n");
> >             }
> >         }
> > 
> > and now we're doing the bad stuff that Lu pointed out: we only have one
> > mapping shared for all the subdevices, so if we end up changing it for one
> > subdevice, we're likely to be breaking another.
> > In this case iommu_request_dm_for_dev() returns -EBUSY without doing anything
> > and the following private identity code fortunately seems to have no
> > consequential effects - the real DMA device continues to operate in the DMA
> > domain, and all subdevice DMA requests go through the DMA mapping codepath.
> > That's probably why VMD appears to be working fine anyway, but this seems
> > fragile.
> > 
> > The following changes enforce that the real DMA device is in the DMA domain,
> > and avoid the intel_iommu_add_device() codepaths that would try to change
> > it to a different domain type. Let me know if I'm on the right lines...
> > ---
> >  drivers/iommu/intel-iommu.c               | 16 ++++++++++++++++
> >  drivers/pci/controller/intel-nvme-remap.c |  6 ++++++
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 9644a5b3e0ae..8872b8d1780d 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -2911,6 +2911,9 @@ static int device_def_domain_type(struct device *dev)
> >  	if (dev_is_pci(dev)) {
> >  		struct pci_dev *pdev = to_pci_dev(dev);
> >  
> > +		if (pci_real_dma_dev(pdev) != pdev)
> > +			return IOMMU_DOMAIN_DMA;
> > +
> >  		if (device_is_rmrr_locked(dev))
> >  			return IOMMU_DOMAIN_DMA;
> >  
> > @@ -5580,6 +5583,7 @@ static bool intel_iommu_capable(enum iommu_cap cap)
> >  
> >  static int intel_iommu_add_device(struct device *dev)
> >  {
> > +	struct device *real_dev = dev;
> >  	struct dmar_domain *dmar_domain;
> >  	struct iommu_domain *domain;
> >  	struct intel_iommu *iommu;
> > @@ -5591,6 +5595,17 @@ static int intel_iommu_add_device(struct device *dev)
> >  	if (!iommu)
> >  		return -ENODEV;
> >  
> > +	if (dev_is_pci(dev))
> > +		real_dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
> > +
> > +	if (real_dev != dev) {
> > +		domain = iommu_get_domain_for_dev(real_dev);
> > +		if (domain->type != IOMMU_DOMAIN_DMA) {
> > +			dev_err(dev, "Real DMA device not in DMA domain; can't handle DMA\n");
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> >  	iommu_device_link(&iommu->iommu, dev);
> >  
> >  	if (translation_pre_enabled(iommu))
> > 
> 
> We need one additional change to enforce IOMMU_DOMAIN_DMA on the real
> dma dev, otherwise it could be put into Identity and the subdevices as
> DMA leading to this WARN:
> 
> struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
> {
>         int iommu_id;
> 
>         /* si_domain and vm domain should not get here. */
>         if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
>                 return NULL;
> 
> 
> We could probably define and enforce it in device_def_domain_type. We
> could also try moving real dma dev to DMA on the first subdevice, like
> below. Though there might be a few cases we can't do that.
> 
> 
> [snip]

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4be549478691..6c80c6c9d808 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3049,6 +3049,9 @@ static int device_def_domain_type(struct device *dev)
                if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
                        return IOMMU_DOMAIN_IDENTITY;
 
+               if (pci_real_dma_dev(pdev) != pdev)
+                       return IOMMU_DOMAIN_DMA;
+
                /*
                 * We want to start off with all devices in the 1:1 domain, and
                 * take them out later if we find they can't access all of memory.
@@ -5780,12 +5783,32 @@ static bool intel_iommu_capable(enum iommu_cap cap)
        return false;
 }
 
+static int intel_iommu_request_dma_domain_for_dev(struct device *dev,
+                                                  struct dmar_domain *domain)
+{
+       int ret;
+
+       ret = iommu_request_dma_domain_for_dev(dev);
+       if (ret) {
+               dmar_remove_one_dev_info(dev);
+               domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
+               if (!get_private_domain_for_dev(dev)) {
+                       dev_warn(dev,
+                                "Failed to get a private domain.\n");
+                               return -ENOMEM;
+               }
+       }
+
+       return 0;
+}
+
 static int intel_iommu_add_device(struct device *dev)
 {
        struct dmar_domain *dmar_domain;
        struct iommu_domain *domain;
        struct intel_iommu *iommu;
        struct iommu_group *group;
+       struct device *real_dev = dev;
        u8 bus, devfn;
        int ret;
 
@@ -5809,6 +5832,21 @@ static int intel_iommu_add_device(struct device *dev)
 
        domain = iommu_get_domain_for_dev(dev);
        dmar_domain = to_dmar_domain(domain);
+
+       if (dev_is_pci(dev))
+               real_dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
+
+       if (real_dev != dev) {
+               domain = iommu_get_domain_for_dev(real_dev);
+               if (domain->type != IOMMU_DOMAIN_DMA) {
+                       dmar_remove_one_dev_info(real_dev);
+
+                       ret = intel_iommu_request_dma_domain_for_dev(real_dev, dmar_domain);
+                       if (ret)
+                               goto unlink;
+               }
+       }
+
        if (domain->type == IOMMU_DOMAIN_DMA) {
                if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
                        ret = iommu_request_dm_for_dev(dev);
@@ -5822,20 +5860,12 @@ static int intel_iommu_add_device(struct device *dev)
                }
        } else {
                if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
-                       ret = iommu_request_dma_domain_for_dev(dev);
-                       if (ret) {
-                               dmar_remove_one_dev_info(dev);
-                               dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-                               if (!get_private_domain_for_dev(dev)) {
-                                       dev_warn(dev,
-                                                "Failed to get a private domain.\n");
-                                       ret = -ENOMEM;
-                                       goto unlink;
-                               }
+                       ret = intel_iommu_request_dma_domain_for_dev(dev, dmar_domain);
+                       if (ret)
+                               goto unlink;
 
-                               dev_info(dev,
-                                        "Device uses a private dma domain.\n");
-                       }
+                       dev_info(dev,
+                                "Device uses a private dma domain.\n");
                }
        }
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
