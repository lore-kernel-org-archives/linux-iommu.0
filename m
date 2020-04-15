Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1615BC3815B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 08:33:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CD020784
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 08:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CD020784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AC81F20020;
	Wed, 15 Apr 2020 08:33:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iLOJpCZ9dI1L; Wed, 15 Apr 2020 08:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D8DAA20384;
	Wed, 15 Apr 2020 08:33:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0FD0C1AE2;
	Wed, 15 Apr 2020 08:33:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0897C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 08:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D6EB485F90
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 08:33:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qHKce8vvPtfc for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 08:33:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0667585F8F
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 08:33:18 +0000 (UTC)
IronPort-SDR: 6gvBhgzY0XVJVoO+6STE98jefh7VKyfB6qFjI0nSfSkzSsxmoJLyeq0ubdJRI2eKYm9iO0MhQ/
 Z1fy0aEjwYiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 01:33:18 -0700
IronPort-SDR: rJxOfdeheUuNeZhAZkyWqxJVPLRtHUTot9g+3TqTgSQXegFQCcN3DIouRWMxDDkHyXbcwRdj0r
 XejIKQlV1O1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="363613501"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.208])
 ([10.254.210.208])
 by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2020 01:33:15 -0700
Subject: Re: [PATCH v2 1/7] iommu/vt-d: Refactor parameters for
 qi_submit_sync()
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-2-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8204B4@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0221ba27-d997-3a7f-adfc-6caef920ed39@linux.intel.com>
Date: Wed, 15 Apr 2020 16:33:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D8204B4@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On 2020/4/15 16:02, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 15, 2020 1:26 PM
>>
>> Current qi_submit_sync() supports single invalidation descriptor
>> per submission and appends wait descriptor after each submission
>> to poll hardware completion. This patch adjusts the parameters
>> of this function so that multiple descriptors per submission can
>> be supported.
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/dmar.c                | 24 ++++++++++++++----------
>>   drivers/iommu/intel-pasid.c         |  4 ++--
>>   drivers/iommu/intel-svm.c           |  6 +++---
>>   drivers/iommu/intel_irq_remapping.c |  2 +-
>>   include/linux/intel-iommu.h         |  8 +++++++-
>>   5 files changed, 27 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>> index d9dc787feef7..bb42177e2369 100644
>> --- a/drivers/iommu/dmar.c
>> +++ b/drivers/iommu/dmar.c
>> @@ -1225,10 +1225,14 @@ static int qi_check_fault(struct intel_iommu
>> *iommu, int index)
>>   }
>>
>>   /*
>> - * Submit the queued invalidation descriptor to the remapping
>> - * hardware unit and wait for its completion.
>> + * Function to submit invalidation descriptors of all types to the queued
>> + * invalidation interface(QI). Multiple descriptors can be submitted at a
>> + * time, a wait descriptor will be appended to each submission to ensure
>> + * hardware has completed the invalidation before return. Wait descriptors
>> + * can be part of the submission but it will not be polled for completion.
>>    */
>> -int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
>> +int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>> +		   unsigned int count, unsigned long options)
> 
> Adding parameter w/o actually using them is not typical way of splitting
> patches. Better squash this with 2/7 together.

My original thought was to make it easier for code review. No particular
preference. Both are okay to me. :-)

Best regards,
baolu

> 
>>   {
>>   	int rc;
>>   	struct q_inval *qi = iommu->qi;
>> @@ -1318,7 +1322,7 @@ void qi_global_iec(struct intel_iommu *iommu)
>>   	desc.qw3 = 0;
>>
>>   	/* should never fail */
>> -	qi_submit_sync(&desc, iommu);
>> +	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
>> @@ -1332,7 +1336,7 @@ void qi_flush_context(struct intel_iommu *iommu,
>> u16 did, u16 sid, u8 fm,
>>   	desc.qw2 = 0;
>>   	desc.qw3 = 0;
>>
>> -	qi_submit_sync(&desc, iommu);
>> +	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>> @@ -1356,7 +1360,7 @@ void qi_flush_iotlb(struct intel_iommu *iommu,
>> u16 did, u64 addr,
>>   	desc.qw2 = 0;
>>   	desc.qw3 = 0;
>>
>> -	qi_submit_sync(&desc, iommu);
>> +	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>> @@ -1378,7 +1382,7 @@ void qi_flush_dev_iotlb(struct intel_iommu
>> *iommu, u16 sid, u16 pfsid,
>>   	desc.qw2 = 0;
>>   	desc.qw3 = 0;
>>
>> -	qi_submit_sync(&desc, iommu);
>> +	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   /* PASID-based IOTLB invalidation */
>> @@ -1419,7 +1423,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu,
>> u16 did, u32 pasid, u64 addr,
>>   				QI_EIOTLB_AM(mask);
>>   	}
>>
>> -	qi_submit_sync(&desc, iommu);
>> +	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   /* PASID-based device IOTLB Invalidate */
>> @@ -1448,7 +1452,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu
>> *iommu, u16 sid, u16 pfsid,
>>   	if (size_order)
>>   		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
>>
>> -	qi_submit_sync(&desc, iommu);
>> +	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
>> @@ -1458,7 +1462,7 @@ void qi_flush_pasid_cache(struct intel_iommu
>> *iommu, u16 did,
>>
>>   	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
>>   			QI_PC_GRAN(granu) | QI_PC_TYPE;
>> -	qi_submit_sync(&desc, iommu);
>> +	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   /*
>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>> index 48cc9ca5f3dc..7969e3dac2ad 100644
>> --- a/drivers/iommu/intel-pasid.c
>> +++ b/drivers/iommu/intel-pasid.c
>> @@ -498,7 +498,7 @@ pasid_cache_invalidation_with_pasid(struct
>> intel_iommu *iommu,
>>   	desc.qw2 = 0;
>>   	desc.qw3 = 0;
>>
>> -	qi_submit_sync(&desc, iommu);
>> +	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   static void
>> @@ -512,7 +512,7 @@ iotlb_invalidation_with_pasid(struct intel_iommu
>> *iommu, u16 did, u32 pasid)
>>   	desc.qw2 = 0;
>>   	desc.qw3 = 0;
>>
>> -	qi_submit_sync(&desc, iommu);
>> +	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   static void
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index e9f4e979a71f..83dc4319f661 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -138,7 +138,7 @@ static void intel_flush_svm_range_dev (struct
>> intel_svm *svm, struct intel_svm_d
>>   	}
>>   	desc.qw2 = 0;
>>   	desc.qw3 = 0;
>> -	qi_submit_sync(&desc, svm->iommu);
>> +	qi_submit_sync(svm->iommu, &desc, 1, 0);
>>
>>   	if (sdev->dev_iotlb) {
>>   		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |
>> @@ -162,7 +162,7 @@ static void intel_flush_svm_range_dev (struct
>> intel_svm *svm, struct intel_svm_d
>>   		}
>>   		desc.qw2 = 0;
>>   		desc.qw3 = 0;
>> -		qi_submit_sync(&desc, svm->iommu);
>> +		qi_submit_sync(svm->iommu, &desc, 1, 0);
>>   	}
>>   }
>>
>> @@ -850,7 +850,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   				       sizeof(req->priv_data));
>>   			resp.qw2 = 0;
>>   			resp.qw3 = 0;
>> -			qi_submit_sync(&resp, iommu);
>> +			qi_submit_sync(iommu, &resp, 1, 0);
>>   		}
>>   		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>>   	}
>> diff --git a/drivers/iommu/intel_irq_remapping.c
>> b/drivers/iommu/intel_irq_remapping.c
>> index 81e43c1df7ec..a042f123b091 100644
>> --- a/drivers/iommu/intel_irq_remapping.c
>> +++ b/drivers/iommu/intel_irq_remapping.c
>> @@ -151,7 +151,7 @@ static int qi_flush_iec(struct intel_iommu *iommu, int
>> index, int mask)
>>   	desc.qw2 = 0;
>>   	desc.qw3 = 0;
>>
>> -	return qi_submit_sync(&desc, iommu);
>> +	return qi_submit_sync(iommu, &desc, 1, 0);
>>   }
>>
>>   static int modify_irte(struct irq_2_iommu *irq_iommu,
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index cfe720f10112..ee2d5cdd8339 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -710,7 +710,13 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu
>> *iommu, u16 sid, u16 pfsid,
>>   void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
>>   			  int pasid);
>>
>> -extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
>> +int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>> +		   unsigned int count, unsigned long options);
>> +/*
>> + * Options used in qi_submit_sync:
>> + * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
>> + */
>> +#define QI_OPT_WAIT_DRAIN		BIT(0)
> 
> no one uses this flag in this patch
> 
>>
>>   extern int dmar_ir_support(void);
>>
>> --
>> 2.17.1
> 
> Thanks
> Kevin
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
