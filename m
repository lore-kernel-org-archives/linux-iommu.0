Return-Path: <SRS0=HOXO=5O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0835BC2D0E5
	for <iommu@archiver.kernel.org>; Sun, 29 Mar 2020 11:35:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4211206DB
	for <iommu@archiver.kernel.org>; Sun, 29 Mar 2020 11:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jz9tcwfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4211206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 96CAF2041B;
	Sun, 29 Mar 2020 11:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OqJutGGSqaGD; Sun, 29 Mar 2020 11:35:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A179020119;
	Sun, 29 Mar 2020 11:35:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86557C089E;
	Sun, 29 Mar 2020 11:35:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31CA1C07FF
 for <iommu@lists.linux-foundation.org>; Sun, 29 Mar 2020 11:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1BA63875AE
 for <iommu@lists.linux-foundation.org>; Sun, 29 Mar 2020 11:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6K-UC5upiA2I for <iommu@lists.linux-foundation.org>;
 Sun, 29 Mar 2020 11:35:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9B50A8758F
 for <iommu@lists.linux-foundation.org>; Sun, 29 Mar 2020 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585481743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1IxVYco8UCh+YPdSWkO2vy9au9OnrKwIy5vfXeKc9k=;
 b=Jz9tcwfcUig6OF/7W7p0FCIzVxGSwABMzt9VaNW6igI+Rs0PgD0tm/k9vf+XU+rEEqJdck
 nnv+pVhzfyBBZ5DJMg4tTLha49ZoHMRY5ugRhC4K8kQxyGAqhQznPG2B8X/i73Cp9s+ssu
 5tb+h2syzawUb849QHv4h4o3QGmTCNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-ZPNojbtWMDme4-imT-Oi-A-1; Sun, 29 Mar 2020 07:35:26 -0400
X-MC-Unique: ZPNojbtWMDme4-imT-Oi-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5019477;
 Sun, 29 Mar 2020 11:35:23 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B633C97AFA;
 Sun, 29 Mar 2020 11:35:17 +0000 (UTC)
Subject: Re: [PATCH V10 05/11] iommu/vt-d: Add nested translation helper
 function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-6-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <752fa022-908d-a3d5-e1e7-c319bcbe7ce9@redhat.com>
Date: Sun, 29 Mar 2020 13:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1584746861-76386-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Cameron <jic23@kernel.org>
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

Hi Jacob,

On 3/21/20 12:27 AM, Jacob Pan wrote:
> Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
> With PASID granular translation type set to 0x11b, translation
> result from the first level(FL) also subject to a second level(SL)
> page table translation. This mode is used for SVA virtualization,
> where FL performs guest virtual to guest physical translation and
> SL performs guest physical to host physical translation.
> 
> This patch adds a helper function for setting up nested translation
> where second level comes from a domain and first level comes from
> a guest PGD.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 240 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/iommu/intel-pasid.h |  12 +++
>  include/linux/intel-iommu.h |   3 +
>  3 files changed, 252 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 9bdb7ee228b6..10c7856afc6b 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -359,6 +359,76 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
>  	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
>  }
>  
> +/*
> + * Setup the Extended Memory Type(EMT) field (Bits 91-93)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_emt(struct pasid_entry *pe, u64 value)
> +{
> +	pasid_set_bits(&pe->val[1], GENMASK_ULL(29, 27), value << 27);
> +}
> +
> +/*
> + * Setup the Page Attribute Table (PAT) field (Bits 96-127)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_pat(struct pasid_entry *pe, u64 value)
> +{
> +	pasid_set_bits(&pe->val[1], GENMASK_ULL(63, 32), value << 32);
> +}
> +
> +/*
> + * Setup the Cache Disable (CD) field (Bit 89)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_cd(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[1], 1 << 25, 1 << 25);
> +}
> +
> +/*
> + * Setup the Extended Memory Type Enable (EMTE) field (Bit 90)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_emte(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[1], 1 << 26, 1 << 26);
> +}
> +
> +/*
> + * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_eafe(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
> +}
> +
> +/*
> + * Setup the Page-level Cache Disable (PCD) field (Bit 95)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_pcd(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[1], 1 << 31, 1 << 31);
> +}
> +
> +/*
> + * Setup the Page-level Write-Through (PWT)) field (Bit 94)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_pwt(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[1], 1 << 30, 1 << 30);
> +}
> +
>  static void
>  pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>  				    u16 did, int pasid)
> @@ -492,7 +562,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>  	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>  
>  	/* Setup Present and PASID Granular Transfer Type: */
> -	pasid_set_translation_type(pte, 1);
> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
>  	pasid_set_present(pte);
>  	pasid_flush_caches(iommu, pte, pasid, did);
>  
> @@ -564,7 +634,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  	pasid_set_domain_id(pte, did);
>  	pasid_set_slptr(pte, pgd_val);
>  	pasid_set_address_width(pte, agaw);
> -	pasid_set_translation_type(pte, 2);
> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_SL_ONLY);
>  	pasid_set_fault_enable(pte);
>  	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>  
> @@ -598,7 +668,7 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  	pasid_clear_entry(pte);
>  	pasid_set_domain_id(pte, did);
>  	pasid_set_address_width(pte, iommu->agaw);
> -	pasid_set_translation_type(pte, 4);
> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_PT);
>  	pasid_set_fault_enable(pte);
>  	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));

All above looks good to me
>  
> @@ -612,3 +682,167 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  
>  	return 0;
>  }
> +
> +static int intel_pasid_setup_bind_data(struct intel_iommu *iommu,
> +				struct pasid_entry *pte,
> +				struct iommu_gpasid_bind_data_vtd *pasid_data)
> +{
> +	/*
> +	 * Not all guest PASID table entry fields are passed down during bind,
> +	 * here we only set up the ones that are dependent on guest settings.
> +	 * Execution related bits such as NXE, SMEP are not meaningful to IOMMU,
> +	 * therefore not set. Other fields, such as snoop related, are set based
> +	 * on host needs regardless of guest settings.
> +	 */
> +	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_SRE) {
> +		if (!ecap_srs(iommu->ecap)) {
> +			pr_err("No supervisor request support on %s\n",
> +			       iommu->name);
> +			return -EINVAL;
> +		}
> +		pasid_set_sre(pte);
> +	}
> +
> +	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
> +		if (!ecap_eafs(iommu->ecap)) {
> +			pr_err("No extended access flag support on %s\n",
> +				iommu->name);
> +			return -EINVAL;
> +		}
> +		pasid_set_eafe(pte);
> +	}
> +
> +	/*
> +	 * Memory type is only applicable to devices inside processor coherent
> +	 * domain. PCIe devices are not included. We can skip the rest of the
> +	 * flags if IOMMU does not support MTS.
> +	 */
nit:
	if (!pasid_data->flags & IOMMU_SVA_VTD_GPASID_MTS_MASK)
		return 0;

	if (!ecap_mts(iommu->ecap) {
		pr_err("No memory type support for bind guest PASID on %s\n",
		iommu->name);
		return -EINVAL;
	}

	settings ../..
> +	if (ecap_mts(iommu->ecap)) {
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EMTE) {
> +			pasid_set_emte(pte);
> +			pasid_set_emt(pte, pasid_data->emt);
> +		}
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PCD)
> +			pasid_set_pcd(pte);
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PWT)
> +			pasid_set_pwt(pte);
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_CD)
> +			pasid_set_cd(pte);
> +		pasid_set_pat(pte, pasid_data->pat);
> +	} else if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_MTS_MASK) {
> +		pr_err("No memory type support for bind guest PASID on %s\n",
> +			iommu->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +/**
> + * intel_pasid_setup_nested() - Set up PASID entry for nested translation.
> + * This could be used for guest shared virtual address. In this case, the
> + * first level page tables are used for GVA-GPA translation in the guest,
> + * second level page tables are used for GPA-HPA translation.
> + *
> + * @iommu:      IOMMU which the device belong to
> + * @dev:        Device to be set up for translation
> + * @gpgd:       FLPTPTR: First Level Page translation pointer in GPA
> + * @pasid:      PASID to be programmed in the device PASID table
> + * @pasid_data: Additional PASID info from the guest bind request
> + * @domain:     Domain info for setting up second level page tables
> + * @addr_width: Address width of the first level (guest)
> + */
> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> +			struct device *dev, pgd_t *gpgd,
> +			int pasid, struct iommu_gpasid_bind_data_vtd *pasid_data,
> +			struct dmar_domain *domain,
> +			int addr_width)
> +{
> +	struct pasid_entry *pte;
> +	struct dma_pte *pgd;
> +	int ret = 0;
> +	u64 pgd_val;
> +	int agaw;
> +	u16 did;
> +
> +	if (!ecap_nest(iommu->ecap)) {
> +		pr_err("IOMMU: %s: No nested translation support\n",
> +		       iommu->name);
> +		return -EINVAL;
> +	}
I am surprised you don't check that the dmar_domain has the
DOMAIN_FLAG_NESTED_MODE flag (ir I missed it). Don't you have any risk
that the userspace overwrites the PTE of a device attached to an usual
domain, ie. fulled handled by the host?
> +
> +	pte = intel_pasid_get_entry(dev, pasid);
> +	if (WARN_ON(!pte))
> +		return -EINVAL;
> +
> +	/*
> +	 * Caller must ensure PASID entry is not in use, i.e. not bind the
> +	 * same PASID to the same device twice.
> +	 */
> +	if (pasid_pte_is_present(pte))
> +		return -EBUSY;
Here you check the PTE is not valid, is it sufficient to guarantee the
above? Also refering to the race potential issue pointed out by Kevin.
> +
> +	pasid_clear_entry(pte);
> +
> +	/* Sanity checking performed by caller to make sure address
> +	 * width matching in two dimensions:
> +	 * 1. CPU vs. IOMMU
> +	 * 2. Guest vs. Host.
> +	 */
> +	switch (addr_width) {
> +	case ADDR_WIDTH_5LEVEL:
> +		if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> +			cap_5lp_support(iommu->cap)) {
> +			pasid_set_flpm(pte, 1);
> +		} else {
> +			dev_err(dev, "5-level paging not supported\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case ADDR_WIDTH_4LEVEL:
> +		pasid_set_flpm(pte, 0);
> +		break;
> +	default:
> +		dev_err(dev, "Invalid guest address width %d\n", addr_width);
> +		return -EINVAL;
> +	}
> +
> +	/* First level PGD is in GPA, must be supported by the second level */
> +	if ((u64)gpgd > domain->max_addr) {
> +		dev_err(dev, "Guest PGD %llx not supported, max %llx\n",
> +			(u64)gpgd, domain->max_addr);
> +		return -EINVAL;
> +	}
> +	pasid_set_flptr(pte, (u64)gpgd);
> +
> +	ret = intel_pasid_setup_bind_data(iommu, pte, pasid_data);
> +	if (ret) {
> +		dev_err(dev, "Guest PASID bind data not supported\n");
Shall we output all those traces without limit? They are triggered by
userspace, meaning this latter can trigger a storm of those.
> +		return ret;
> +	}
> +
> +	/* Setup the second level based on the given domain */
> +	pgd = domain->pgd;
> +
> +	agaw = iommu_skip_agaw(domain, iommu, &pgd);
> +	if (agaw < 0) {
> +		dev_err(dev, "Invalid domain page table\n");
> +		return -EINVAL;
> +	}
> +	pgd_val = virt_to_phys(pgd);
> +	pasid_set_slptr(pte, pgd_val);
> +	pasid_set_fault_enable(pte);
> +
> +	did = domain->iommu_did[iommu->seq_id];
> +	pasid_set_domain_id(pte, did);
> +
> +	pasid_set_address_width(pte, agaw);
> +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> +
> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
> +	pasid_set_present(pte);
> +	pasid_flush_caches(iommu, pte, pasid, did);
> +
> +	return ret;
> +}
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 92de6df24ccb..698015ee3f04 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -36,6 +36,7 @@
>   * to vmalloc or even module mappings.
>   */
>  #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
> +#define PASID_FLAG_NESTED		BIT(1)
>  
>  /*
>   * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for first-
> @@ -51,6 +52,11 @@ struct pasid_entry {
>  	u64 val[8];
>  };
>  
> +#define PASID_ENTRY_PGTT_FL_ONLY	(1)
> +#define PASID_ENTRY_PGTT_SL_ONLY	(2)
> +#define PASID_ENTRY_PGTT_NESTED		(3)
> +#define PASID_ENTRY_PGTT_PT		(4)
> +
>  /* The representative of a PASID table */
>  struct pasid_table {
>  	void			*table;		/* pasid table pointer */
> @@ -99,6 +105,12 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
>  				   struct device *dev, int pasid);
> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> +			struct device *dev, pgd_t *pgd,
> +			int pasid,
> +			struct iommu_gpasid_bind_data_vtd *pasid_data,
> +			struct dmar_domain *domain,
> +			int addr_width);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>  				 struct device *dev, int pasid);
>  
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ed7171d2ae1f..eda1d6687144 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -42,6 +42,9 @@
>  #define DMA_FL_PTE_PRESENT	BIT_ULL(0)
>  #define DMA_FL_PTE_XD		BIT_ULL(63)
>  
> +#define ADDR_WIDTH_5LEVEL	(57)
> +#define ADDR_WIDTH_4LEVEL	(48)
> +
>  #define CONTEXT_TT_MULTI_LEVEL	0
>  #define CONTEXT_TT_DEV_IOTLB	1
>  #define CONTEXT_TT_PASS_THROUGH 2
> 
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
