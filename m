Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EAFC2BB86
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 22:00:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5CD20663
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 22:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5CD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1F95C20456;
	Mon, 13 Apr 2020 22:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iIrsrO2W0zfe; Mon, 13 Apr 2020 22:00:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2709120424;
	Mon, 13 Apr 2020 22:00:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0914FC1797;
	Mon, 13 Apr 2020 22:00:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 112EFC0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 22:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0A0A187699
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 22:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7G6Tm-GQGIiB for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 22:00:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4866D87553
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 22:00:38 +0000 (UTC)
IronPort-SDR: k0cITnnvRsFo3ubtztdXEih+TF+l5qcCPwF4ckWBRu2ns6VPX40MHnD7fQ7hRU45AakfRhdzoV
 6+oyRFLHiB8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2020 15:00:37 -0700
IronPort-SDR: kB4hp6LPCZ3IoaiJG6JAz+dV9wID9jFgQ7iFYoK5jOS+RyHlpB4bPywThXslAxtNNuAa7maO7V
 pPiN8fHdqeOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; d="scan'208";a="331974546"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 13 Apr 2020 15:00:37 -0700
Date: Mon, 13 Apr 2020 15:06:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA use
Message-ID: <20200413150631.60e54d85@jacob-builder>
In-Reply-To: <20200407110146.GB285264@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200401135316.GF882512@myrica>
 <20200406083353.73efda5b@jacob-builder>
 <20200407110146.GB285264@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

Hi Jean,

Sorry for the delay, I have to do some research based on your feedback.
I also plan to document this in the next version.


On Tue, 7 Apr 2020 13:01:46 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Mon, Apr 06, 2020 at 08:33:53AM -0700, Jacob Pan wrote:
> > Hi Jean,
> > 
> > On Wed, 1 Apr 2020 15:53:16 +0200
> > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> >   
> > > On Wed, Mar 25, 2020 at 10:55:26AM -0700, Jacob Pan wrote:  
> > > > Bare metal SVA allocates IOASIDs for native process addresses.
> > > > This should be separated from VM allocated IOASIDs thus under
> > > > its own set.
> > > > 
> > > > This patch creates a system IOASID set with its quota set to
> > > > PID_MAX. This is a reasonable default in that SVM capable
> > > > devices can only bind to limited user processes.    
> > > 
> > > Yes realistically there won't be more than PID_MAX_DEFAULT=0x8000
> > > bound address spaces. My machine uses a PID_MAX of 4 million
> > > though, so in theory more than 0x8000 processes may want a bond.  
> > Got it, I assume we can adjust the system set quota as necessary.
> >   
> > > On Arm the
> > > limit of shared contexts per VM is currently a little less than
> > > 0x10000 (which is the number of CPU ASIDs).
> > >   
> > I guess shared contexts means shared address? then it makes sense
> > #IOASID < #ASID.  
> 
> Yes by shared contexts I mean shared address spaces. Theoretically
> #ASID < #IOASID for us, because the max ASID size is 16-bit.
> 
Got it.

> >   
> > > But quotas are only necessary for VMs, when the host shares the
> > > PASID space with them (which isn't a use-case for Arm systems as
> > > far as I know, each VM gets its own PASID space).  
> > Is there a host-guest PASID translation? or the PASID used by the
> > VM is physical PASID? When a page request comes in to SMMU, how
> > does it know the owner of the PASID if PASID range can overlap
> > between host and guest?  
> 
> We assign PCI functions to VMs, so Page Requests are routed with
> RID:PASID, not PASID alone. The SMMU finds the struct device
> associated with the RID, and submits the fault with
> iommu_report_device_fault(). If the VF is assigned to a VM, then the
> page request gets injected into the VM, otherwise it uses the host
> IOPF handler
> 
Got it, VM private PASID space works then.
For VM, the IOASID search is within the VM ioasid_set.
For SVA, the IOASID search is within host default set.
Should be faster than global search once we have per set xarray.
I guess the PASID table is per VM instead of per RID (device)? Sorry if
you already answered it before.


> > > Could we have quota-free IOASID sets for the host?
> > >   
> > Yes, perhaps just add a flag such that the set has its own
> > namespace. You mean have this quota-free IOASID set even co-exist
> > with VMs? I still don't get how PRQ works.
> > 
> > That is not the use case for VT-d in that we have to have
> > system-wide allocation for host PASIDs. We have enqcmd which can
> > take a PASID from the per task MSR and deliver to multiple devices,
> > so even though the PASID table is per device the PASID name space
> > must be global. 
> > > For the SMMU I'd like to allocate two sets, one SVA and one
> > > private for auxiliary domains, and I don't think giving either a
> > > quota makes much sense at the moment.  
> > I agree we don;t need the quota if we don't support guest SVA at the
> > same time.
> > 
> > So the sva set and aux_domain set PASIDs have their own
> > namespaces?  
> 
> They share the same PASID space, but they store different objects
> (mm_struct and context descriptor, respectively) so they need
> different ioasid_set tokens.
> 
Got it.

> >   
> > > There can be systems using only SVA and
> > > systems using only private PASIDs. I think it should be
> > > first-come-first-served until admins want a knob to define a
> > > policy themselves, based on cgroups for example.
> > >   
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > ---
> > > >  drivers/iommu/intel-iommu.c | 8 +++++++-
> > > >  drivers/iommu/ioasid.c      | 9 +++++++++
> > > >  include/linux/ioasid.h      | 9 +++++++++
> > > >  3 files changed, 25 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iommu/intel-iommu.c
> > > > b/drivers/iommu/intel-iommu.c index ec3fc121744a..af7a1ef7b31e
> > > > 100644 --- a/drivers/iommu/intel-iommu.c
> > > > +++ b/drivers/iommu/intel-iommu.c
> > > > @@ -3511,8 +3511,14 @@ static int __init init_dmars(void)
> > > >  		goto free_iommu;
> > > >  
> > > >  	/* PASID is needed for scalable mode irrespective to
> > > > SVM */
> > > > -	if (intel_iommu_sm)
> > > > +	if (intel_iommu_sm) {
> > > >  		ioasid_install_capacity(intel_pasid_max_id);
> > > > +		/* We should not run out of IOASIDs at boot */
> > > > +		if (ioasid_alloc_system_set(PID_MAX_DEFAULT)) {
> > > > +			pr_err("Failed to enable host PASID
> > > > allocator\n");
> > > > +			intel_iommu_sm = 0;
> > > > +		}
> > > > +	}
> > > >  
> > > >  	/*
> > > >  	 * for each drhd
> > > > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > > > index 6265d2dbbced..9135af171a7c 100644
> > > > --- a/drivers/iommu/ioasid.c
> > > > +++ b/drivers/iommu/ioasid.c
> > > > @@ -39,6 +39,9 @@ struct ioasid_data {
> > > >  static ioasid_t ioasid_capacity;
> > > >  static ioasid_t ioasid_capacity_avail;
> > > >  
> > > > +int system_ioasid_sid;
> > > > +static DECLARE_IOASID_SET(system_ioasid);
> > > > +
> > > >  /* System capacity can only be set once */
> > > >  void ioasid_install_capacity(ioasid_t total)
> > > >  {
> > > > @@ -51,6 +54,12 @@ void ioasid_install_capacity(ioasid_t total)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> > > >  
> > > > +int ioasid_alloc_system_set(int quota)
> > > > +{
> > > > +	return ioasid_alloc_set(&system_ioasid, quota,
> > > > &system_ioasid_sid); +}
> > > > +EXPORT_SYMBOL_GPL(ioasid_alloc_system_set);    
> > > 
> > > I think this helper could stay in the VT-d driver for the moment.
> > > If the SMMU driver ever implements auxiliary domains it will use a
> > > private IOASID set, separate from the shared IOASID set managed by
> > > iommu-sva. Both could qualify as "system set".
> > >   
> > Sounds good. Perhaps remove the special "system set". SVA code,
> > VFIO, VT-d, or SMMU driver can all allocate their own sets.
> > So to meet both SMMU and VT-d requirements, we should do:
> > 1. add an IOASID_PRIVATE flag to ioasid_alloc_set(), indicating
> > this is a private set
> > 2. All APIs operate on the set_id accordingly, e.g. ioasid_find()
> > will only search within the private set. Private set is excluded
> > from from global search (VT-d needs this in PRQ).
> > 
> > Since VT-d already needs private PASIDs for guest SVM where
> > GPASID!=HPASID, I feel we can just reuse the per ioasid_set Xarray
> > for both quota-free private set and guest set.  
> 
> Ok I think this sounds fine
> 
> Thanks,
> Jean
> 
> > 
> > 
> > Thanks for the feedback!
> > 
> > Jacob
> >   
> > > Thanks,
> > > Jean
> > >   
> > > > +
> > > >  /*
> > > >   * struct ioasid_allocator_data - Internal data structure to
> > > > hold information
> > > >   * about an allocator. There are two types of allocators:
> > > > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > > > index 8c82d2625671..097b1cc043a3 100644
> > > > --- a/include/linux/ioasid.h
> > > > +++ b/include/linux/ioasid.h
> > > > @@ -29,6 +29,9 @@ struct ioasid_allocator_ops {
> > > >  	void *pdata;
> > > >  };
> > > >  
> > > > +/* Shared IOASID set for reserved for host system use */
> > > > +extern int system_ioasid_sid;
> > > > +
> > > >  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> > > >  
> > > >  #if IS_ENABLED(CONFIG_IOASID)
> > > > @@ -41,6 +44,7 @@ int ioasid_register_allocator(struct
> > > > ioasid_allocator_ops *allocator); void
> > > > ioasid_unregister_allocator(struct ioasid_allocator_ops
> > > > *allocator); int ioasid_attach_data(ioasid_t ioasid, void
> > > > *data); void ioasid_install_capacity(ioasid_t total); +int
> > > > ioasid_alloc_system_set(int quota); int ioasid_alloc_set(struct
> > > > ioasid_set *token, ioasid_t quota, int *sid); void
> > > > ioasid_free_set(int sid, bool destroy_set); int
> > > > ioasid_find_sid(ioasid_t ioasid); @@ -88,5 +92,10 @@ static
> > > > inline void ioasid_install_capacity(ioasid_t total) {
> > > >  }
> > > >  
> > > > +static inline int ioasid_alloc_system_set(int quota)
> > > > +{
> > > > +	return -ENOTSUPP;
> > > > +}
> > > > +
> > > >  #endif /* CONFIG_IOASID */
> > > >  #endif /* __LINUX_IOASID_H */
> > > > -- 
> > > > 2.7.4
> > > >     
> > 
> > [Jacob Pan]  

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
