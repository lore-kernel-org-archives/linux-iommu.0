Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A32FC6198
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 22:22:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5229221848
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 22:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5229221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 10557C9F;
	Fri,  8 Nov 2019 22:22:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1C619C91
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 22:22:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6A7C2196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 22:22:23 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Nov 2019 14:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; d="scan'208";a="233974175"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2019 14:22:21 -0800
Date: Fri, 8 Nov 2019 14:26:50 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20191108142650.0121ba2f@jacob-builder>
In-Reply-To: <d4902c68-57b7-a116-10fa-f4b292304f9a@redhat.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<d4902c68-57b7-a116-10fa-f4b292304f9a@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
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

On Fri, 8 Nov 2019 11:40:23 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 10/24/19 9:54 PM, Jacob Pan wrote:
> > When VT-d driver runs in the guest, PASID allocation must be
> > performed via virtual command interface. This patch registers a
> > custom IOASID allocator which takes precedence over the default
> > XArray based allocator. The resulting IOASID allocation will always
> > come from the host. This ensures that PASID namespace is system-
> > wide.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/Kconfig       |  1 +
> >  drivers/iommu/intel-iommu.c | 67
> > +++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/intel-iommu.h |  2 ++ 3 files changed, 70
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index fd50ddffffbf..961fe5795a90 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -211,6 +211,7 @@ config INTEL_IOMMU_SVM
> >  	bool "Support for Shared Virtual Memory with Intel IOMMU"
> >  	depends on INTEL_IOMMU && X86
> >  	select PCI_PASID
> > +	select IOASID
> >  	select MMU_NOTIFIER
> >  	help
> >  	  Shared Virtual Memory (SVM) provides a facility for
> > devices diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 3f974919d3bd..ced1d89ef977
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1706,6 +1706,9 @@ static void free_dmar_iommu(struct
> > intel_iommu *iommu) if (ecap_prs(iommu->ecap))
> >  			intel_svm_finish_prq(iommu);
> >  	}
> > +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
> > +
> > ioasid_unregister_allocator(&iommu->pasid_allocator); +
> >  #endif
> >  }
> >  
> > @@ -4910,6 +4913,44 @@ static int __init
> > probe_acpi_namespace_devices(void) return 0;
> >  }
> >  
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max,
> > void *data) +{
> > +	struct intel_iommu *iommu = data;
> > +	ioasid_t ioasid;
> > +
> > +	/*
> > +	 * VT-d virtual command interface always uses the full 20
> > bit
> > +	 * PASID range. Host can partition guest PASID range based
> > on
> > +	 * policies but it is out of guest's control.
> > +	 */
> > +	if (min < PASID_MIN || max > intel_pasid_max_id)>
> > +		return INVALID_IOASID;  
> 
> > +
> > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > +		return INVALID_IOASID;
> > +
> > +	return ioasid;
> > +}
> > +
> > +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> > +{
> > +	struct intel_iommu *iommu = data;
> > +
> > +	if (!iommu)
> > +		return;
> > +	/*
> > +	 * Sanity check the ioasid owner is done at upper layer,
> > e.g. VFIO
> > +	 * We can only free the PASID when all the devices are
> > unbond.
> > +	 */
> > +	if (ioasid_find(NULL, ioasid, NULL)) {
> > +		pr_alert("Cannot free active IOASID %d\n", ioasid);
> > +		return;
> > +	}
> > +	vcmd_free_pasid(iommu, ioasid);
> > +}
> > +#endif
> > +
> >  int __init intel_iommu_init(void)
> >  {
> >  	int ret = -ENODEV;
> > @@ -5020,6 +5061,32 @@ int __init intel_iommu_init(void)
> >  				       "%s", iommu->name);
> >  		iommu_device_set_ops(&iommu->iommu,
> > &intel_iommu_ops); iommu_device_register(&iommu->iommu);
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +		if (ecap_vcs(iommu->ecap) &&
> > vccap_pasid(iommu->vccap)) {
> > +			pr_info("Register custom PASID
> > allocator\n");
> > +			/*
> > +			 * Register a custom ASID allocator if we
> > are running
> > +			 * in a guest, the purpose is to have a
> > system wide PASID
> > +			 * namespace among all PASID users.
> > +			 * There can be multiple vIOMMUs in each
> > guest but only
> > +			 * one allocator is active. All vIOMMU
> > allocators will
> > +			 * eventually be calling the same host
> > allocator.
> > +			 */
> > +			iommu->pasid_allocator.alloc =
> > intel_ioasid_alloc;
> > +			iommu->pasid_allocator.free =
> > intel_ioasid_free;
> > +			iommu->pasid_allocator.pdata = (void
> > *)iommu;
> > +			ret =
> > ioasid_register_allocator(&iommu->pasid_allocator);
> > +			if (ret) {
> > +				pr_warn("Custom PASID allocator
> > registeration failed\n");  
> nit: registration
> > +				/*
> > +				 * Disable scalable mode on this
> > IOMMU if there
> > +				 * is no custom allocator. Mixing
> > SM capable vIOMMU
> > +				 * and non-SM vIOMMU are not
> > supported:   
> nit; is not supported. But I guess you will reshape it according to
> previous comments.

Yes, i moved this earlier to avoid the need to clean up after scalable
mode root table is set.
> > +				 */
> > +				intel_iommu_sm = 0;
> > +			}
> > +		}
> > +#endif
> >  	}
> >  
> >  	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 1d4b8dcdc5d8..c624733cb2e6
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -19,6 +19,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/dmar.h>
> > +#include <linux/ioasid.h>
> >  
> >  #include <asm/cacheflush.h>
> >  #include <asm/iommu.h>
> > @@ -546,6 +547,7 @@ struct intel_iommu {
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> >  	struct page_req_dsc *prq;
> >  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> > +	struct ioasid_allocator_ops pasid_allocator; /* Custom
> > allocator for PASIDs */ #endif
> >  	struct q_inval  *qi;            /* Queued invalidation
> > info */ u32 *iommu_state; /* Store iommu states between suspend and
> > resume.*/ 
> 
> Thanks
> 
> Eric
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
