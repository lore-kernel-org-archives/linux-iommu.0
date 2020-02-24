Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A48C38BFF
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 22:54:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE5320838
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 22:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE5320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8C09D2048B;
	Mon, 24 Feb 2020 22:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FOwEZcJAZ9zP; Mon, 24 Feb 2020 22:54:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B9C5D20380;
	Mon, 24 Feb 2020 22:54:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAAD3C18DA;
	Mon, 24 Feb 2020 22:54:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 540FDC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 22:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4300182221
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 22:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26VZs1Lahhjc for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 22:54:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E42AB81A6A
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 22:54:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 14:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; d="scan'208";a="437864371"
Received: from jacob-xps-13-9365.jf.intel.com (HELO jacob-XPS-13-9365)
 ([10.54.75.153])
 by fmsmga006.fm.intel.com with ESMTP; 24 Feb 2020 14:54:45 -0800
Date: Mon, 24 Feb 2020 14:55:10 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V9 03/10] iommu/vt-d: Add nested translation helper
 function
Message-ID: <20200224145510.616878bb@jacob-XPS-13-9365>
In-Reply-To: <7d127a3d-fddf-e180-3d5a-3cd6c330fba5@redhat.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277713-66934-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <7d127a3d-fddf-e180-3d5a-3cd6c330fba5@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
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

Hi Eric,
Appreciated your review. Comments below.

On Wed, 12 Feb 2020 13:43:17 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 1/29/20 7:01 AM, Jacob Pan wrote:
> > Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
> > With PASID granular translation type set to 0x11b, translation
> > result from the first level(FL) also subject to a second level(SL)
> > page table translation. This mode is used for SVA virtualization,
> > where FL performs guest virtual to guest physical translation and
> > SL performs guest physical to host physical translation.  
> You may also describe what the patch brings. The above text does not.
Will add the following:
"
  This patch adds a helper function for setting up nested translation
  where second level comes from a domain and first level comes from  
  a guest PGD.                                                       
"
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  drivers/iommu/intel-pasid.c | 225
> > ++++++++++++++++++++++++++++++++++++++++++++
> > drivers/iommu/intel-pasid.h |  12 +++ include/linux/intel-iommu.h |
> >   3 + 3 files changed, 240 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 22b30f10b396..bd067af4d20b
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -359,6 +359,76 @@ pasid_set_flpm(struct pasid_entry *pe, u64
> > value) pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
> >  }
> >  
> > +/*
> > + * Setup the Extended Memory Type(EMT) field (Bits 91-93)
> > + * of a scalable mode PASID entry.
> > + */
> > +static inline void
> > +pasid_set_emt(struct pasid_entry *pe, u64 value)
> > +{
> > +	pasid_set_bits(&pe->val[1], GENMASK_ULL(29, 27), value <<
> > 27); +}
> > +
> > +/*
> > + * Setup the Page Attribute Table (PAT) field (Bits 96-127)
> > + * of a scalable mode PASID entry.
> > + */
> > +static inline void
> > +pasid_set_pat(struct pasid_entry *pe, u64 value)  
> pat is 32b
Yeah, but I am trying to use pasid_set_bits() which only takes
shifted value as u64. Since there is no sign extension, using u64
should be safe, right?
> > +{
> > +	pasid_set_bits(&pe->val[1], GENMASK_ULL(63, 32), value <<
> > 32); +}
> > +
> > +/*
> > + * Setup the Cache Disable (CD) field (Bit 89)
> > + * of a scalable mode PASID entry.
> > + */
> > +static inline void
> > +pasid_set_cd(struct pasid_entry *pe)
> > +{
> > +	pasid_set_bits(&pe->val[1], 1 << 25, 1 << 25);  
> BIT_ULL() here and below?
> My preference would have been to a have a helper converting absolute
> field boundaries (as the spec, Fig 9-36 describes those with absolute
> values) into the right val and offset. I think it would be less error
> prone globally.
I agree. Here I am trying to conform with existing coding style.

Perhaps as another cleanup patch for both pasid_set_bits and BIT_ULL,
Baolu?

> > +}
> > +
> > +/*
> > + * Setup the Extended Memory Type Enable (EMTE) field (Bit 90)
> > + * of a scalable mode PASID entry.
> > + */
> > +static inline void
> > +pasid_set_emte(struct pasid_entry *pe)
> > +{
> > +	pasid_set_bits(&pe->val[1], 1 << 26, 1 << 26);> +}
> > +
> > +/*
> > + * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
> > + * of a scalable mode PASID entry.
> > + */
> > +static inline void
> > +pasid_set_eafe(struct pasid_entry *pe)
> > +{
> > +	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
> > +}
> > +
> > +/*
> > + * Setup the Page-level Cache Disable (PCD) field (Bit 95)
> > + * of a scalable mode PASID entry.
> > + */
> > +static inline void
> > +pasid_set_pcd(struct pasid_entry *pe)
> > +{
> > +	pasid_set_bits(&pe->val[1], 1 << 31, 1 << 31);
> > +}
> > +
> > +/*
> > + * Setup the Page-level Write-Through (PWT)) field (Bit 94)  
> ))
> > + * of a scalable mode PASID entry.
> > + */
> > +static inline void
> > +pasid_set_pwt(struct pasid_entry *pe)
> > +{
> > +	pasid_set_bits(&pe->val[1], 1 << 30, 1 << 30);
> > +}
> > +
> >  static void
> >  pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
> >  				    u16 did, int pasid)
> > @@ -596,3 +666,158 @@ int intel_pasid_setup_pass_through(struct
> > intel_iommu *iommu, 
> >  	return 0;
> >  }
> > +
> > +static int intel_pasid_setup_bind_data(struct intel_iommu *iommu,
> > +				struct pasid_entry *pte,
> > +				struct iommu_gpasid_bind_data_vtd
> > *pasid_data) +{
> > +	/*
> > +	 * Not all guest PASID table entry fields are passed down
> > during bind,
> > +	 * here we only set up the ones that are dependent on
> > guest settings.
> > +	 * Execution related bits such as NXE, SMEP are not
> > meaningful to IOMMU,
> > +	 * therefore not set. Other fields, such as snoop related,
> > are set based
> > +	 * on host needs regardless of  guest settings.  
> s/of  /of /
will fix, thanks.

> > +	 */
> > +	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_SRE) {
> > +		if (!ecap_srs(iommu->ecap)) {
> > +			pr_err("No supervisor request support on
> > %s\n",
> > +			       iommu->name);
> > +			return -EINVAL;
> > +		}
> > +		pasid_set_sre(pte);
> > +	}
> > +
> > +	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
> > +		if (!ecap_eafs(iommu->ecap)) {
> > +			pr_err("No extended access flag support on
> > %s\n",
> > +				iommu->name);
> > +			return -EINVAL;
> > +		}
> > +		pasid_set_eafe(pte);
> > +	}
> > +
> > +	/*
> > +	 * Memory type is only applicable to devices inside
> > processor coherent
> > +	 * domain. PCIe devices are not included. We can skip the
> > rest of the
> > +	 * flags if IOMMU does not support MTS.
> > +	 */
> > +	if (ecap_mts(iommu->ecap)) {
> > +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EMTE)
> > {
> > +			pasid_set_emte(pte);
> > +			pasid_set_emt(pte, pasid_data->emt);
> > +		}
> > +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PCD)
> > +			pasid_set_pcd(pte);
> > +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PWT)
> > +			pasid_set_pwt(pte);
> > +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_CD)
> > +			pasid_set_cd(pte);
> > +		pasid_set_pat(pte, pasid_data->pat);  
> why isn't the pat struct member also guarded by a flag. If I
> understand correctly it should not be set of MTS is not supported.
We probably should add a flag for PAT, but even that we might still
need to sanity check on the host side. My original thinking was that
PAT is just a table, it will not be used if the entries (PWT, PCD) used
to compute the index is not valid. So it is harmless to set it.

Another reason is that host driver does not use MTS yet since we don't
have devices in processor coherent domain. Perhaps, I can put a note
here to explain?
/*
* REVISIT: PAT entries will not be used if other entries used to
* compute PAT index is not valid. Need to sanity check against host
* once we have devices in processor coherent domain.
*/
> > +	} else if (pasid_data->flags &
> > IOMMU_SVA_VTD_GPASID_EMT_MASK) {
> > +		pr_warn("No memory type support for bind guest
> > PASID on %s\n",
> > +			iommu->name);  
> why not pr_err() here as well?
Yes. pr_err is better. Since it will be incorrect.

> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +
> > +}
> > +
> > +/**
> > + * intel_pasid_setup_nested() - Set up PASID entry for nested
> > translation.
> > + * This could be used for guest shared virtual address. In this
> > case, the
> > + * first level page tables are used for GVA-GPA translation in the
> > guest,
> > + * second level page tables are used for GPA-HPA translation.
> > + *
> > + * @iommu:      Iommu which the device belong to  
> s/Iommu/iommu or IOMMU, belongs
will fix. thanks

> > + * @dev:        Device to be set up for translation
> > + * @gpgd:       FLPTPTR: First Level Page translation pointer in
> > GPA
> > + * @pasid:      PASID to be programmed in the device PASID table
> > + * @pasid_data: Additional PASID info from the guest bind request
> > + * @domain:     Domain info for setting up second level page tables
> > + * @addr_width: Address width of the first level (guest)
> > + */
> > +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> > +			struct device *dev, pgd_t *gpgd,
> > +			int pasid, struct
> > iommu_gpasid_bind_data_vtd *pasid_data,
> > +			struct dmar_domain *domain,
> > +			int addr_width)
> > +{
> > +	struct pasid_entry *pte;
> > +	struct dma_pte *pgd;
> > +	int ret = 0;
> > +	u64 pgd_val;
> > +	int agaw;
> > +	u16 did;
> > +
> > +	if (!ecap_nest(iommu->ecap)) {
> > +		pr_err("IOMMU: %s: No nested translation
> > support\n",
> > +		       iommu->name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	pte = intel_pasid_get_entry(dev, pasid);  
> in intel_pasid_get_entry() there may be one WARN_ON hitting in some
> conditions. But I see other callers of intel_pasid_get_entry also have
> the WARN_ON.
Could you explain your suggestion?
I think the WARN_ON inside intel_pasid_get_entry() will produce
different stack trace for debugging.

> > +	if (WARN_ON(!pte))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Caller must ensure PASID entry is not in use, i.e. not
> > bind the
> > +	 * same PASID to the same device twice.
> > +	 */
> > +	if (pasid_pte_is_present(pte))
> > +		return -EBUSY;
> > +
> > +	pasid_clear_entry(pte);
> > +
> > +	/* Sanity checking performed by caller to make sure address
> > +	 * width matching in two dimensions:
> > +	 * 1. CPU vs. IOMMU
> > +	 * 2. Guest vs. Host.
> > +	 */
> > +	switch (addr_width) {
> > +	case ADDR_WIDTH_5LEVEL:
> > +		pasid_set_flpm(pte, 1);  
> don't you need to check whether 5-level paging mode is supported (5LP)
> This data comes from userspace
Good point. Will add code below


-               pasid_set_flpm(pte, 1);
+               if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+                       cap_5lp_support(iommu->cap)) {
+                       pasid_set_flpm(pte, 1);
+               } else {
+                       dev_err(dev, "5-level paging not supported\n");
+                       return -EINVAL;
+               }

> > +		break;
> > +	case ADDR_WIDTH_4LEVEL:
> > +		pasid_set_flpm(pte, 0);
> > +		break;
> > +	default:
> > +		dev_err(dev, "Invalid guest address width %d\n",
> > addr_width);> +		return -EINVAL;
> > +	}
> > +
> > +	pasid_set_flptr(pte, (u64)gpgd);  
> don't you need to do some checks on the gpgd versus the max addr_width
> supported by the HW?
Yes, but I think we should check gpgd against domain's max_addr since
since gpgd is in GPA. Right?

> > +
> > +	ret = intel_pasid_setup_bind_data(iommu, pte, pasid_data);
> > +	if (ret) {
> > +		dev_err(dev, "Guest PASID bind data not
> > supported\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Setup the second level based on the given domain */
> > +	pgd = domain->pgd;
> > +
> > +	for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
> > +		pgd = phys_to_virt(dma_pte_addr(pgd));
> > +		if (!dma_pte_present(pgd)) {
> > +			pasid_clear_entry(pte);  
> here you clear the PTE entry while above, on the other error cases you
> don't. Any reason?
I probably don't need to clear PASID entry here either since the
present bit is not set.

> > +			dev_err(dev, "Invalid domain page
> > table\n");
> > +			return -EINVAL;
> > +		}
> > +	}  
> Maybe you could introduce an helper as the above code is duplicated in
> intel_pasid_setup_second_level
Good point. Duplicated code is in intel-iommu.c as well.

> > +	pgd_val = virt_to_phys(pgd);
> > +	pasid_set_slptr(pte, pgd_val);
> > +	pasid_set_fault_enable(pte);
> > +
> > +	did = domain->iommu_did[iommu->seq_id];
> > +	pasid_set_domain_id(pte, did);
> > +
> > +	pasid_set_address_width(pte, agaw);
> > +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> > +
> > +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
> > +	pasid_set_present(pte);
> > +	pasid_flush_caches(iommu, pte, pasid, did);
> > +
> > +	return ret;
> > +}
> > diff --git a/drivers/iommu/intel-pasid.h
> > b/drivers/iommu/intel-pasid.h index 92de6df24ccb..698015ee3f04
> > 100644 --- a/drivers/iommu/intel-pasid.h
> > +++ b/drivers/iommu/intel-pasid.h
> > @@ -36,6 +36,7 @@
> >   * to vmalloc or even module mappings.
> >   */
> >  #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
> > +#define PASID_FLAG_NESTED		BIT(1)
> >  
> >  /*
> >   * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for
> > first- @@ -51,6 +52,11 @@ struct pasid_entry {
> >  	u64 val[8];
> >  };
> >  
> > +#define PASID_ENTRY_PGTT_FL_ONLY	(1)
> > +#define PASID_ENTRY_PGTT_SL_ONLY	(2)  
> May use the above in the relevant places. Otherwise they may not be
> used.
Good point, will use these in first, second, and pt setup.

> > +#define PASID_ENTRY_PGTT_NESTED		(3)
> > +#define PASID_ENTRY_PGTT_PT		(4)
> > +
> >  /* The representative of a PASID table */
> >  struct pasid_table {
> >  	void			*table;		/*
> > pasid table pointer */ @@ -99,6 +105,12 @@ int
> > intel_pasid_setup_second_level(struct intel_iommu *iommu, int
> > intel_pasid_setup_pass_through(struct intel_iommu *iommu, struct
> > dmar_domain *domain, struct device *dev, int pasid);
> > +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> > +			struct device *dev, pgd_t *pgd,
> > +			int pasid,
> > +			struct iommu_gpasid_bind_data_vtd
> > *pasid_data,
> > +			struct dmar_domain *domain,
> > +			int addr_width);
> >  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> >  				 struct device *dev, int pasid);
> >  
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 27c6bbb0a333..c8abf051b2d5
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -42,6 +42,9 @@
> >  #define DMA_FL_PTE_PRESENT	BIT_ULL(0)
> >  #define DMA_FL_PTE_XD		BIT_ULL(63)
> >  
> > +#define ADDR_WIDTH_5LEVEL	(57)
> > +#define ADDR_WIDTH_4LEVEL	(48)
> > +
> >  #define CONTEXT_TT_MULTI_LEVEL	0
> >  #define CONTEXT_TT_DEV_IOTLB	1
> >  #define CONTEXT_TT_PASS_THROUGH 2
> >   
> 
> Thanks
> 
> Eric
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
