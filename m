Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420F6C433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 02:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A81C360D9D;
	Fri,  1 Jul 2022 02:40:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A81C360D9D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hK1wdnRZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id odxtKqKGiGFA; Fri,  1 Jul 2022 02:40:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4BE6260FB1;
	Fri,  1 Jul 2022 02:40:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BE6260FB1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 282D2C0021;
	Fri,  1 Jul 2022 02:40:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5510C0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 02:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8982641812
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 02:40:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8982641812
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hK1wdnRZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h3mr5uZ9Rhe5 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 02:40:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 366CE41805
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 366CE41805
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 02:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656643211; x=1688179211;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=edwKdOeVps2DTKJzwrZSMgChaL5jo07778euBqV1TM8=;
 b=hK1wdnRZjgRRifFZE1yHIPdRL2RsYX0cFWw17UXVCH+PLdVcQkGwJyBp
 SgXUEjbviJOMHVPOB/xX7d6UrUgVwBLmlZ1LPQAjf6Bh65OiJzS+uY6Et
 /AnZhpf8T21VC7PJLXcAMtUss/2EI7OgsWeMTBS0WT28t0i0/jEhij/ES
 VIFZ8AXBV2avl+XVJgGObok/oqNbNgfCImnVzUEXAk6+QxGaH8gin+FZz
 hxtg93YXsvH13Qf+mfUbnxWbhDFPSAehQRbjfk77kJJC9ZHmfiNIaek16
 dMhfqrUPnzbCVq+V7nZn5UUogkS8bbB2vZOrbyjhZkJIiw+Dta6+S6+2k A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="283267839"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="283267839"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 19:40:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="589059098"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 19:40:07 -0700
Message-ID: <595c314b-2d16-aeef-d808-d1cb713ba175@linux.intel.com>
Date: Fri, 1 Jul 2022 10:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 3/6] iommu/vt-d: Refactor iommu information of each
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Steve Wahl <steve.wahl@hpe.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A78546BD2B38068385E18CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A78546BD2B38068385E18CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>, "Anderson,
 Russ" <russ.anderson@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 6/30/22 4:28 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, June 25, 2022 8:52 PM
>>
>> +struct iommu_domain_info {
>> +	struct intel_iommu *iommu;
>> +	unsigned int refcnt;
>> +	u16 did;
>> +};
>> +
>>   struct dmar_domain {
>>   	int	nid;			/* node id */
>> -
>> -	unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
>> -					/* Refcount of devices per iommu */
>> -
>> -
>> -	u16		iommu_did[DMAR_UNITS_SUPPORTED];
>> -					/* Domain ids per IOMMU. Use u16
>> since
>> -					 * domain ids are 16 bit wide
>> according
>> -					 * to VT-d spec, section 9.3 */
> 
> It'd make sense to keep the comments when moving above fields.

Sure. Updated.

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 56c3d1a9e155..fae45bbb0c7f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -527,8 +527,10 @@ struct context_entry {

  struct iommu_domain_info {
         struct intel_iommu *iommu;
-       unsigned int refcnt;
-       u16 did;
+       unsigned int refcnt;            /* Refcount of devices per iommu */
+       u16 did;                        /* Domain ids per IOMMU. Use u16 
since
+                                        * domain ids are 16 bit wide 
according
+                                        * to VT-d spec, section 9.3 */
  };


> 
>> +	spin_lock(&iommu->lock);
>> +	curr = xa_load(&domain->iommu_array, iommu->seq_id);
>> +	if (curr) {
>> +		curr->refcnt++;
>> +		kfree(info);
>> +		goto success;
> 
> Not a fan of adding a label for success. Just putting two lines (unlock+
> return) here is clearer.

Updated.

> 
>> +	ret = xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
>> +			      info, GFP_ATOMIC));
> 
> check xa_err in separate line.

Sure. Updated as below:

@@ -1778,13 +1780,14 @@ static int domain_attach_iommu(struct 
dmar_domain *domain,
         info->did       = num;
         info->iommu     = iommu;
         domain->nid     = iommu->node;
-       ret = xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
-                             info, GFP_ATOMIC));
-       if (ret)
+       curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
+                         NULL, info, GFP_ATOMIC);
+       if (curr) {
+               ret = xa_err(curr) ? : -EBUSY;
                 goto err_clear;
+       }
         domain_update_iommu_cap(domain);

> 
>>
>>   static void domain_detach_iommu(struct dmar_domain *domain,
>>   				struct intel_iommu *iommu)
>>   {
>> -	int num;
>> +	struct iommu_domain_info *info;
>>
>>   	spin_lock(&iommu->lock);
>> -	domain->iommu_refcnt[iommu->seq_id] -= 1;
>> -	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
>> -		num = domain->iommu_did[iommu->seq_id];
>> -		clear_bit(num, iommu->domain_ids);
>> +	info = xa_load(&domain->iommu_array, iommu->seq_id);
>> +	if (--info->refcnt == 0) {
>> +		clear_bit(info->did, iommu->domain_ids);
>> +		xa_erase(&domain->iommu_array, iommu->seq_id);
>>   		domain_update_iommu_cap(domain);
>> -		domain->iommu_did[iommu->seq_id] = 0;
>> +		kfree(info);
> 
> domain->nid may still point to the node of the removed iommu.

Good catch! I should assign it to NUMA_NO_NODE, so that it could be
updated in the next domain_update_iommu_cap(). Updated as below:

@@ -1806,6 +1809,7 @@ static void domain_detach_iommu(struct dmar_domain 
*domain,
         if (--info->refcnt == 0) {
                 clear_bit(info->did, iommu->domain_ids);
                 xa_erase(&domain->iommu_array, iommu->seq_id);
+               domain->nid = NUMA_NO_NODE;
                 domain_update_iommu_cap(domain);
                 kfree(info);
         }

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
