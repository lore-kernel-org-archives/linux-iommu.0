Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE95C433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 07:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C22A40922;
	Fri,  6 May 2022 07:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aeP0RT80DcdA; Fri,  6 May 2022 07:41:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3639540E46;
	Fri,  6 May 2022 07:41:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F034FC0032;
	Fri,  6 May 2022 07:41:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B9DBC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 07:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE5C240E46
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 07:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PdmUgK0uKWEK for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 07:41:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BC1440942
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651822910; x=1683358910;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4qkVneJsyWqf2kkvrL6fvf+P6n2txyfxdD4MiAVsMII=;
 b=FTumqF1Yh1qg/RE9jSxZQbeq80b8Qey6iFS/gxTbTxnQNQX+hXzUEGq4
 1cIB9KKYf0kOEYle/8o7Bp3QELswCVZgLAt87pr2I3j2FJT+5CZh83OrY
 ppNXa5yR58jwrOymZ2v7hycy/iuS0kfhYnxKFyVPIGGTpFkxL90PPYpvp
 cgxvF0CZ69fgWJlg/h2XnYbxV/v30cX5a8IzwSjMio+leXDrgwEWIQvpu
 Acly+6wcvoKyZD28u1AUI4aQMRWImr2V+cOgxZ0DWZHfze6tOrA7SstnE
 VPlL24Bz3m22mSkj77Xpk1fm0S8oX48OXcKXGHQ7Yd9SYJCQCCwd/Ot/x A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267986008"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="267986008"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 00:41:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="735463665"
Received: from sunyanwa-mobl1.ccr.corp.intel.com (HELO [10.255.31.183])
 ([10.255.31.183])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 00:41:46 -0700
Message-ID: <b3b353eb-11f7-92c2-3958-fc782fc54389@linux.intel.com>
Date: Fri, 6 May 2022 15:41:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
 <20220506052727.1689687-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52762145C90CDAF980E5E3EB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762145C90CDAF980E5E3EB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/5/6 14:10, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, May 6, 2022 1:27 PM
>> +
>> +/*
>> + * Set the page snoop control for a pasid entry which has been set up.
>> + */
>> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
>> +					  struct device *dev, u32 pasid)
>> +{
>> +	struct pasid_entry *pte;
>> +	u16 did;
>> +
>> +	spin_lock(&iommu->lock);
>> +	pte = intel_pasid_get_entry(dev, pasid);
>> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
>> +		spin_unlock(&iommu->lock);
>> +		return;
>> +	}
>> +
>> +	pasid_set_pgsnp(pte);
>> +	did = pasid_get_domain_id(pte);
>> +	spin_unlock(&iommu->lock);
>> +
>> +	pasid_flush_caches(iommu, pte, pasid, did);
>> +}
> 
> The comment of pasid_flush_caches() says:
> 
> /*
>   * This function flushes cache for a newly setup pasid table entry.
>   * Caller of it should not modify the in-use pasid table entries.
>   */
> 
> Can you check whether that comment still hold?

I am sorry that I overlooked this. Very appreciated for pointing this
out!

How about below additional changes?

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index da47406011d3..68f7e8cfa848 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -782,5 +782,24 @@ void intel_pasid_setup_page_snoop_control(struct 
intel_iommu *iommu,
         did = pasid_get_domain_id(pte);
         spin_unlock(&iommu->lock);

-       pasid_flush_caches(iommu, pte, pasid, did);
+       if (!ecap_coherent(iommu->ecap))
+               clflush_cache_range(pte, sizeof(*pte));
+
+       /*
+        * VT-d spec 3.4 table23 states guides for cache invalidation:
+        *
+        * - PASID-selective-within-Domain PASID-cache invalidation
+        * - PASID-selective PASID-based IOTLB invalidation
+        * - If (pasid is RID_PASID)
+        *    - Global Device-TLB invalidation to affected functions
+        *   Else
+        *    - PASID-based Device-TLB invalidation (with S=1 and
+        *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
+        */
+       pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+       qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+
+       /* Device IOTLB doesn't need to be flushed in caching mode. */
+       if (!cap_caching_mode(iommu->cap))
+               devtlb_invalidation_with_pasid(iommu, dev, pasid);
  }

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
