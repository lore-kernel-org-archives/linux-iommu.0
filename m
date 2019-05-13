Return-Path: <SRS0=HAYh=TN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4978DC04AAA
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 11:20:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EE1208CA
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 11:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EE1208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 321CCC2C;
	Mon, 13 May 2019 11:20:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 171F2C2A
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 11:20:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 77410878
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 11:20:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BDCC374;
	Mon, 13 May 2019 04:20:51 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00B7D3F703;
	Mon, 13 May 2019 04:20:48 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
To: Auger Eric <eric.auger@redhat.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <44d5ba37-a9e9-cc7a-2a3a-d32b840afa29@arm.com>
Date: Mon, 13 May 2019 12:20:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Hi Eric,

On 13/05/2019 10:14, Auger Eric wrote:
> I noticed my qemu integration was currently incorrectly using PASID
> invalidation for ASID based invalidation (SMMUV3 Stage1 CMD_TLBI_NH_ASID
> invalidation command). So I think we also need ARCHID invalidation.
> Sorry for the late notice.
>>  
>> +/* defines the granularity of the invalidation */
>> +enum iommu_inv_granularity {
>> +	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective invalidation */
>         IOMMU_INV_GRANU_ARCHID, /* archid-selective invalidation */
>> +	IOMMU_INV_GRANU_PASID,	/* pasid-selective invalidation */

In terms of granularity, these values have the same meaning: invalidate
the whole address space of a context. Then you can communicate two
things using the same struct:
* If ATS is enables an Arm host needs to invalidate all ATC entries
using PASID.
* If BTM isn't used by the guest, the host needs to invalidate all TLB
entries using ARCHID.

Rather than introducing a new granule here, could we just add an archid
field to the struct associated with IOMMU_INV_GRANU_PASID? Something like...

>> +	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation */
>> +	IOMMU_INVAL_GRANU_NR,   /* number of invalidation granularities */
>> +};
>> +
>> +/**
>> + * Address Selective Invalidation Structure
>> + *
>> + * @flags indicates the granularity of the address-selective invalidation
>> + * - if PASID bit is set, @pasid field is populated and the invalidation
>> + *   relates to cache entries tagged with this PASID and matching the
>> + *   address range.
>> + * - if ARCHID bit is set, @archid is populated and the invalidation relates
>> + *   to cache entries tagged with this architecture specific id and matching
>> + *   the address range.
>> + * - Both PASID and ARCHID can be set as they may tag different caches.
>> + * - if neither PASID or ARCHID is set, global addr invalidation applies
>> + * - LEAF flag indicates whether only the leaf PTE caching needs to be
>> + *   invalidated and other paging structure caches can be preserved.
>> + * @pasid: process address space id
>> + * @archid: architecture-specific id
>> + * @addr: first stage/level input address
>> + * @granule_size: page/block size of the mapping in bytes
>> + * @nb_granules: number of contiguous granules to be invalidated
>> + */
>> +struct iommu_inv_addr_info {
>> +#define IOMMU_INV_ADDR_FLAGS_PASID	(1 << 0)
>> +#define IOMMU_INV_ADDR_FLAGS_ARCHID	(1 << 1)
>> +#define IOMMU_INV_ADDR_FLAGS_LEAF	(1 << 2)
>> +	__u32	flags;
>> +	__u32	archid;
>> +	__u64	pasid;
>> +	__u64	addr;
>> +	__u64	granule_size;
>> +	__u64	nb_granules;
>> +};

struct iommu_inv_pasid_info {
#define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
#define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
	__u32	flags;
	__u32	archid;
	__u64	pasid;
};

>> +
>> +/**
>> + * First level/stage invalidation information
>> + * @cache: bitfield that allows to select which caches to invalidate
>> + * @granularity: defines the lowest granularity used for the invalidation:
>> + *     domain > pasid > addr
>> + *
>> + * Not all the combinations of cache/granularity make sense:
>> + *
>> + *         type |   DEV_IOTLB   |     IOTLB     |      PASID    |
>> + * granularity	|		|		|      cache	|
>> + * -------------+---------------+---------------+---------------+
>> + * DOMAIN	|	N/A	|       Y	|	Y	|
>  * ARCHID       |       N/A     |       Y       |       N/A     |
> 
>> + * PASID	|	Y	|       Y	|	Y	|
>> + * ADDR		|       Y	|       Y	|	N/A	|
>> + *
>> + * Invalidations by %IOMMU_INV_GRANU_ADDR use field @addr_info.
>  * Invalidations by %IOMMU_INV_GRANU_ARCHID use field @archid.
>> + * Invalidations by %IOMMU_INV_GRANU_PASID use field @pasid.
>> + * Invalidations by %IOMMU_INV_GRANU_DOMAIN don't take any argument.
>> + *
>> + * If multiple cache types are invalidated simultaneously, they all
>> + * must support the used granularity.
>> + */
>> +struct iommu_cache_invalidate_info {
>> +#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
>> +	__u32	version;
>> +/* IOMMU paging structure cache */
>> +#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
>> +#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB */
>> +#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
>> +#define IOMMU_CACHE_TYPE_NR		(3)
>> +	__u8	cache;
>> +	__u8	granularity;
>> +	__u8	padding[2];
>> +	union {
>> +		__u64	pasid;
>                 __u32   archid;

struct iommu_inv_pasid_info pasid_info;

Thanks,
Jean

> 
> Thanks
> 
> Eric
>> +		struct iommu_inv_addr_info addr_info;
>> +	};
>> +};
>> +
>> +
>>  #endif /* _UAPI_IOMMU_H */
>>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
