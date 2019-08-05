Return-Path: <SRS0=bWDR=WB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68215C433FF
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 19:58:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B3A2054F
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 19:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B3A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 06937F37;
	Mon,  5 Aug 2019 19:58:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 38C2CEB4
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 19:58:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B379B8EA
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 19:58:44 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Aug 2019 12:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="164754154"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga007.jf.intel.com with ESMTP; 05 Aug 2019 12:58:26 -0700
Date: Mon, 5 Aug 2019 13:02:04 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v4 14/22] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20190805130204.21aca034@jacob-builder>
In-Reply-To: <2f2ba561-793f-a6a0-5765-ef8e9a5a3ab6@redhat.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1560087862-57608-15-git-send-email-jacob.jun.pan@linux.intel.com>
	<2f2ba561-793f-a6a0-5765-ef8e9a5a3ab6@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Tue, 16 Jul 2019 11:30:14 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 6/9/19 3:44 PM, Jacob Pan wrote:
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
> >  drivers/iommu/intel-iommu.c | 60
> > +++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/intel-iommu.h |  2 ++ 3 files changed, 63
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index c40c4b5..5d1bc2a 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -213,6 +213,7 @@ config INTEL_IOMMU_SVM
> >  	bool "Support for Shared Virtual Memory with Intel IOMMU"
> >  	depends on INTEL_IOMMU && X86
> >  	select PCI_PASID
> > +	select IOASID
> >  	select MMU_NOTIFIER
> >  	select IOASID
> >  	help
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 09b8ff0..5b84994 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1711,6 +1711,8 @@ static void free_dmar_iommu(struct
> > intel_iommu *iommu) if (ecap_prs(iommu->ecap))
> >  			intel_svm_finish_prq(iommu);
> >  	}
> > +	ioasid_unregister_allocator(&iommu->pasid_allocator);
> > +
> >  #endif
> >  }
> >  
> > @@ -4820,6 +4822,46 @@ static int __init
> > platform_optin_force_iommu(void) return 1;
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
> > +	if (min < PASID_MIN || max > PASID_MAX)
> > +		return -EINVAL;  
> ioasid_alloc() does not handle that error value, use INVALID_IOASID?
> > +
> > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > +		return INVALID_IOASID;
> > +
> > +	return ioasid;
> > +}
> > +
> > +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> > +{
> > +	struct iommu_pasid_alloc_info *svm;
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
> > +	svm = ioasid_find(NULL, ioasid, NULL);
> > +	if (!svm) {
> > +		pr_warn("Freeing unbond IOASID %d\n", ioasid);
> > +		return;
> > +	}
> > +	vcmd_free_pasid(iommu, ioasid);
> > +}
> > +#endif
> > +
> >  int __init intel_iommu_init(void)
> >  {
> >  	int ret = -ENODEV;
> > @@ -4924,6 +4966,24 @@ int __init intel_iommu_init(void)
> >  				       "%s", iommu->name);
> >  		iommu_device_set_ops(&iommu->iommu,
> > &intel_iommu_ops); iommu_device_register(&iommu->iommu);
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +		if (cap_caching_mode(iommu->cap) &&
> > sm_supported(iommu)) {
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
> > +			if (ret)
> > +				pr_warn("Custom PASID allocator
> > registeration failed\n");  
> what if it fails, don't you want a tear down path?
> 

Good point, we need to disable PASID usage, i.e. disable scalable mode
if there is no virtual command based PASID allocator in the guest.

Sorry for the late reply.

> Thanks
> 
> Eric
>  [...]  

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
