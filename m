Return-Path: <SRS0=HOXO=5O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE36C2D0E9
	for <iommu@archiver.kernel.org>; Sun, 29 Mar 2020 15:34:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B607A20733
	for <iommu@archiver.kernel.org>; Sun, 29 Mar 2020 15:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNpxXm4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B607A20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6AE85875EA;
	Sun, 29 Mar 2020 15:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JDX7YHQ+3x5P; Sun, 29 Mar 2020 15:34:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1C59687590;
	Sun, 29 Mar 2020 15:34:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01381C089E;
	Sun, 29 Mar 2020 15:34:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31FB2C07FF
 for <iommu@lists.linux-foundation.org>; Sun, 29 Mar 2020 15:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1E4102013C
 for <iommu@lists.linux-foundation.org>; Sun, 29 Mar 2020 15:34:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wSCgM5Cqyaet for <iommu@lists.linux-foundation.org>;
 Sun, 29 Mar 2020 15:34:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 by silver.osuosl.org (Postfix) with ESMTPS id 0169E2002D
 for <iommu@lists.linux-foundation.org>; Sun, 29 Mar 2020 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585496070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gr8qyUskxguDCiKHpXkMO/Amtup15DW+EgxPTyiCN+0=;
 b=hNpxXm4hjjMexuF2+qM462iATGdx9cIY9ePTCfM90YFforo92TFis6oP79WNNLEPz1WITY
 Xzda5VaWZsuSTQKf0jVrd4pg/vhYKBHXWRvxWDDiUbDudN0CVK/nBg8tKjt64yjmb8aiB4
 h6zNFn+SL63C/5KGUDEVEOrZUfhWY14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-2HAWSRdyORuChJUHi3Y0GQ-1; Sun, 29 Mar 2020 11:34:26 -0400
X-MC-Unique: 2HAWSRdyORuChJUHi3Y0GQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0A7800D5B;
 Sun, 29 Mar 2020 15:34:24 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1E1360BEC;
 Sun, 29 Mar 2020 15:34:16 +0000 (UTC)
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3215b83c-81f7-a30f-fe82-a51f29d7b874@redhat.com>
Date: Sun, 29 Mar 2020 17:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Cameron <jic23@kernel.org>
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

Hi,

On 3/28/20 11:01 AM, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Saturday, March 21, 2020 7:28 AM
>>
>> When Shared Virtual Address (SVA) is enabled for a guest OS via
>> vIOMMU, we need to provide invalidation support at IOMMU API and driver
>> level. This patch adds Intel VT-d specific function to implement
>> iommu passdown invalidate API for shared virtual address.
>>
>> The use case is for supporting caching structure invalidation
>> of assigned SVM capable devices. Emulated IOMMU exposes queue
> 
> emulated IOMMU -> vIOMMU, since virito-iommu could use the
> interface as well.
> 
>> invalidation capability and passes down all descriptors from the guest
>> to the physical IOMMU.
>>
>> The assumption is that guest to host device ID mapping should be
>> resolved prior to calling IOMMU driver. Based on the device handle,
>> host IOMMU driver can replace certain fields before submit to the
>> invalidation queue.
>>
>> ---
>> v7 review fixed in v10
>> ---
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
>> ---
>>  drivers/iommu/intel-iommu.c | 182
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 182 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index b1477cd423dd..a76afb0fd51a 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5619,6 +5619,187 @@ static void
>> intel_iommu_aux_detach_device(struct iommu_domain *domain,
>>  	aux_domain_remove_dev(to_dmar_domain(domain), dev);
>>  }
>>
>> +/*
>> + * 2D array for converting and sanitizing IOMMU generic TLB granularity to
>> + * VT-d granularity. Invalidation is typically included in the unmap operation
>> + * as a result of DMA or VFIO unmap. However, for assigned devices guest
>> + * owns the first level page tables. Invalidations of translation caches in the
>> + * guest are trapped and passed down to the host.
>> + *
>> + * vIOMMU in the guest will only expose first level page tables, therefore
>> + * we do not include IOTLB granularity for request without PASID (second
>> level).
> 
> I would revise above as "We do not support IOTLB granularity for request 
> without PASID (second level), therefore any vIOMMU implementation that
> exposes the SVA capability to the guest should only expose the first level
> page tables, implying all invalidation requests from the guest will include
> a valid PASID"
> 
>> + *
>> + * For example, to find the VT-d granularity encoding for IOTLB
>> + * type and page selective granularity within PASID:
>> + * X: indexed by iommu cache type
>> + * Y: indexed by enum iommu_inv_granularity
>> + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
>> + *
>> + * Granu_map array indicates validity of the table. 1: valid, 0: invalid
>> + *
>> + */
>> +const static int
>> inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_
>> NR] = {
>> +	/*
>> +	 * PASID based IOTLB invalidation: PASID selective (per PASID),
>> +	 * page selective (address granularity)
>> +	 */
>> +	{0, 1, 1},
>> +	/* PASID based dev TLBs, only support all PASIDs or single PASID */
>> +	{1, 1, 0},
> 
> Is this combination correct? when single PASID is being specified, it is 
> essentially a page-selective invalidation since you need provide Address
> and Size. 
Isn't it the same when G=1? Still the addr/size is used. Doesn't it
correspond to IOMMU_INV_GRANU_ADDR with IOMMU_INV_ADDR_FLAGS_PASID flag
unset?

so {0, 0, 1}?

Thanks

Eric

> 
>> +	/* PASID cache */
> 
> PASID cache is fully managed by the host. Guest PASID cache invalidation
> is interpreted by vIOMMU for bind and unbind operations. I don't think
> we should accept any PASID cache invalidation from userspace or guest.
> 
>> +	{1, 1, 0}
>> +};
>> +
>> +const static int
>> inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU
>> _NR] = {
>> +	/* PASID based IOTLB */
>> +	{0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
>> +	/* PASID based dev TLBs */
>> +	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
>> +	/* PASID cache */
>> +	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
>> +};
>> +
>> +static inline int to_vtd_granularity(int type, int granu, int *vtd_granu)
>> +{
>> +	if (type >= IOMMU_CACHE_INV_TYPE_NR || granu >=
>> IOMMU_INV_GRANU_NR ||
>> +		!inv_type_granu_map[type][granu])
>> +		return -EINVAL;
>> +
>> +	*vtd_granu = inv_type_granu_table[type][granu];
>> +
> 
> btw do we really need both map and table here? Can't we just
> use one table with unsupported granularity marked as a special
> value?
> 
>> +	return 0;
>> +}
>> +
>> +static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
>> +{
>> +	u64 nr_pages = (granu_size * nr_granules) >> VTD_PAGE_SHIFT;
>> +
>> +	/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
>> +	 * IOMMU cache invalidate API passes granu_size in bytes, and
>> number of
>> +	 * granu size in contiguous memory.
>> +	 */
>> +	return order_base_2(nr_pages);
>> +}
>> +
>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
>> +		struct device *dev, struct iommu_cache_invalidate_info
>> *inv_info)
>> +{
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct device_domain_info *info;
>> +	struct intel_iommu *iommu;
>> +	unsigned long flags;
>> +	int cache_type;
>> +	u8 bus, devfn;
>> +	u16 did, sid;
>> +	int ret = 0;
>> +	u64 size = 0;
>> +
>> +	if (!inv_info || !dmar_domain ||
>> +		inv_info->version !=
>> IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
>> +		return -EINVAL;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return -ENODEV;
>> +
>> +	iommu = device_to_iommu(dev, &bus, &devfn);
>> +	if (!iommu)
>> +		return -ENODEV;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	spin_lock(&iommu->lock);
>> +	info = iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
>> +	if (!info) {
>> +		ret = -EINVAL;
>> +		goto out_unlock;
> 
> -ENOTSUPP?
> 
>> +	}
>> +	did = dmar_domain->iommu_did[iommu->seq_id];
>> +	sid = PCI_DEVID(bus, devfn);
>> +
>> +	/* Size is only valid in non-PASID selective invalidation */
>> +	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
>> +		size = to_vtd_size(inv_info->addr_info.granule_size,
>> +				   inv_info->addr_info.nb_granules);
>> +
>> +	for_each_set_bit(cache_type, (unsigned long *)&inv_info->cache,
>> IOMMU_CACHE_INV_TYPE_NR) {
>> +		int granu = 0;
>> +		u64 pasid = 0;
>> +
>> +		ret = to_vtd_granularity(cache_type, inv_info->granularity,
>> &granu);
>> +		if (ret) {
>> +			pr_err("Invalid cache type and granu
>> combination %d/%d\n", cache_type,
>> +				inv_info->granularity);
>> +			break;
>> +		}
>> +
>> +		/* PASID is stored in different locations based on granularity
>> */
>> +		if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
>> +			inv_info->pasid_info.flags &
>> IOMMU_INV_PASID_FLAGS_PASID)
>> +			pasid = inv_info->pasid_info.pasid;
>> +		else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR
>> &&
>> +			inv_info->addr_info.flags &
>> IOMMU_INV_ADDR_FLAGS_PASID)
>> +			pasid = inv_info->addr_info.pasid;
>> +		else {
>> +			pr_err("Cannot find PASID for given cache type and
>> granularity\n");
>> +			break;
>> +		}
>> +
>> +		switch (BIT(cache_type)) {
>> +		case IOMMU_CACHE_INV_TYPE_IOTLB:
>> +			if ((inv_info->granularity !=
>> IOMMU_INV_GRANU_PASID) &&
> 
> granularity == IOMMU_INV_GRANU_ADDR? otherwise it's unclear
> why IOMMU_INV_GRANU_DOMAIN also needs size check.
> 
>> +				size && (inv_info->addr_info.addr &
>> ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
>> +				pr_err("Address out of range, 0x%llx, size
>> order %llu\n",
>> +					inv_info->addr_info.addr, size);
>> +				ret = -ERANGE;
>> +				goto out_unlock;
>> +			}
>> +
>> +			qi_flush_piotlb(iommu, did,
>> +					pasid,
>> +					mm_to_dma_pfn(inv_info-
>>> addr_info.addr),
>> +					(granu == QI_GRAN_NONG_PASID) ? -
>> 1 : 1 << size,
>> +					inv_info->addr_info.flags &
>> IOMMU_INV_ADDR_FLAGS_LEAF);
>> +
>> +			/*
>> +			 * Always flush device IOTLB if ATS is enabled since
>> guest
>> +			 * vIOMMU exposes CM = 1, no device IOTLB flush
>> will be passed
>> +			 * down.
>> +			 */
> 
> Does VT-d spec mention that no device IOTLB flush is required when CM=1?
> 
>> +			if (info->ats_enabled) {
>> +				qi_flush_dev_iotlb_pasid(iommu, sid, info-
>>> pfsid,
>> +						pasid, info->ats_qdep,
>> +						inv_info->addr_info.addr,
>> size,
>> +						granu);
>> +			}
>> +			break;
>> +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
>> +			if (info->ats_enabled) {
>> +				qi_flush_dev_iotlb_pasid(iommu, sid, info-
>>> pfsid,
>> +						inv_info->addr_info.pasid,
>> info->ats_qdep,
>> +						inv_info->addr_info.addr,
>> size,
>> +						granu);
> 
> I'm confused here. There are two granularities allowed for devtlb, but here
> you only handle one of them?
> 
>> +			} else
>> +				pr_warn("Passdown device IOTLB flush w/o
>> ATS!\n");
>> +
>> +			break;
>> +		case IOMMU_CACHE_INV_TYPE_PASID:
>> +			qi_flush_pasid_cache(iommu, did, granu, inv_info-
>>> pasid_info.pasid);
>> +
> 
> as earlier comment, we shouldn't allow userspace or guest to invalidate
> PASID cache
> 
>> +			break;
>> +		default:
>> +			dev_err(dev, "Unsupported IOMMU invalidation
>> type %d\n",
>> +				cache_type);
>> +			ret = -EINVAL;
>> +		}
>> +	}
>> +out_unlock:
>> +	spin_unlock(&iommu->lock);
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +
>> +	return ret;
>> +}
>> +#endif
>> +
>>  static int intel_iommu_map(struct iommu_domain *domain,
>>  			   unsigned long iova, phys_addr_t hpa,
>>  			   size_t size, int iommu_prot, gfp_t gfp)
>> @@ -6204,6 +6385,7 @@ const struct iommu_ops intel_iommu_ops = {
>>  	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>> +	.cache_invalidate	= intel_iommu_sva_invalidate,
>>  	.sva_bind_gpasid	= intel_svm_bind_gpasid,
>>  	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
>>  #endif
>> --
>> 2.7.4
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
