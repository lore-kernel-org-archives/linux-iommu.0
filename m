Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB99DC43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 02:54:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F3A2168B
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 02:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F3A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DC12885EC4;
	Mon, 14 Sep 2020 02:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iKkNag-fXyBH; Mon, 14 Sep 2020 02:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A7D9A85EC6;
	Mon, 14 Sep 2020 02:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 910F0C0864;
	Mon, 14 Sep 2020 02:54:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D36B1C0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 02:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C2868868B8
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 02:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v4DOdqHi9LH2 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 02:54:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DAF02868B5
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 02:54:18 +0000 (UTC)
IronPort-SDR: HGBs8vL0D0Eo85s6L1EL/8QTLY3rIXb239R7W+QjJY4RIwhL5xS/pVRAZM5gc55rtKEF/o8IUK
 PL6UT9mpETgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="220570990"
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; d="scan'208";a="220570990"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 19:54:18 -0700
IronPort-SDR: EUrWQSqR6DHIOtg57kl2UCCXbO8hD9KwPWBYBWU5YxQ96nHRSGCzaV976NQWsaCex9uFh+hCYc
 +65O6cEVTxoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; d="scan'208";a="408728300"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2020 19:54:14 -0700
Subject: Re: [PATCH v4 1/5] iommu: Add optional subdev in aux_at(de)tach ops
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200901033422.22249-1-baolu.lu@linux.intel.com>
 <20200901033422.22249-2-baolu.lu@linux.intel.com>
 <20200910160549.2b176ac5@w520.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2ed8c946-328a-e2aa-5747-8164b53af40c@linux.intel.com>
Date: Mon, 14 Sep 2020 10:48:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910160549.2b176ac5@w520.home>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

Hi Alex,

On 9/11/20 6:05 AM, Alex Williamson wrote:
> On Tue,  1 Sep 2020 11:34:18 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> In the vfio/mdev use case of aux-domain, the subdevices are created from
>> the physical devices with IOMMU_DEV_FEAT_AUX enabled and the aux-domains
>> are attached to the subdevices through the iommu_ops.aux_attach_dev()
>> interface.
>>
>> Current iommu_ops.aux_at(de)tach_dev() design only takes the aux-domain
>> and the physical device as the parameters, this is insufficient if we
>> want the vendor iommu drivers to learn the knowledge about relationships
>> between the aux-domains and the subdevices. Add a @subdev parameter to
>> iommu_ops.aux_at(de)tach_dev() interfaces so that a subdevice could be
>> opt-in.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 10 ++++++----
>>   drivers/iommu/iommu.c       |  4 ++--
>>   include/linux/iommu.h       |  6 ++++--
>>   3 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index bce158468abf..3c12fd06856c 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -5338,8 +5338,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>>   	return domain_add_dev_info(to_dmar_domain(domain), dev);
>>   }
>>   
>> -static int intel_iommu_aux_attach_device(struct iommu_domain *domain,
>> -					 struct device *dev)
>> +static int
>> +intel_iommu_aux_attach_device(struct iommu_domain *domain,
>> +			      struct device *dev, struct device *subdev)
>>   {
>>   	int ret;
>>   
>> @@ -5359,8 +5360,9 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
>>   	dmar_remove_one_dev_info(dev);
>>   }
>>   
>> -static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
>> -					  struct device *dev)
>> +static void
>> +intel_iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev,
>> +			      struct device *subdev)
>>   {
>>   	aux_domain_remove_dev(to_dmar_domain(domain), dev);
>>   }
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 609bd25bf154..38cdfeb887e1 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2728,7 +2728,7 @@ int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
>>   	int ret = -ENODEV;
>>   
>>   	if (domain->ops->aux_attach_dev)
>> -		ret = domain->ops->aux_attach_dev(domain, dev);
>> +		ret = domain->ops->aux_attach_dev(domain, dev, NULL);
>>   
>>   	if (!ret)
>>   		trace_attach_device_to_domain(dev);
>> @@ -2740,7 +2740,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
>>   void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
>>   {
>>   	if (domain->ops->aux_detach_dev) {
>> -		domain->ops->aux_detach_dev(domain, dev);
>> +		domain->ops->aux_detach_dev(domain, dev, NULL);
>>   		trace_detach_device_from_domain(dev);
>>   	}
>>   }
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index fee209efb756..871267104915 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -279,8 +279,10 @@ struct iommu_ops {
>>   	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
>>   
>>   	/* Aux-domain specific attach/detach entries */
>> -	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
>> -	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
>> +	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev,
>> +			      struct device *subdev);
>> +	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev,
>> +			       struct device *subdev);
>>   	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
>>   
>>   	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
> 
> Would this be a good spot in the code to provide comments more formally
> defining this subdevice concept?  For example, what exactly is the
> relationship between the device and the subdevice and which device do
> we use for the remaining aux domain functions, ex. aux_get_pasid().

Yes. Agreed. I will add below comments and adjust the function
parameters according to the naming rule.

/*
- * Aux-domain specific attach/detach.
+ * Aux-domain specific interfaces.
   *
   * Only works if iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX) 
returns
   * true. Also, as long as domains are attached to a device through this
@@ -2722,6 +2722,14 @@ EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
   * (iommu_detach_device() can't fail, so we fail when trying to 
re-attach).
   * This should make us safe against a device being attached to a guest 
as a
   * whole while there are still pasid users on it (aux and sva).
+ *
+ * Some physical devices can be configured to generate several subdevices.
+ * The modern IOMMUs support the identification and isolation of these
+ * subdevices. Hence they could be passed through to users space. VFIO/mdev
+ * provides a generic framework for subdevice passthrough. Below interfaces
+ * are extended to support such use case. Generally, among the 
parameters of
+ * the following aux-domain specific functions, @physdev represents a 
physical
+ * device and @subdev represents a subdevice.
   */

Please help to review.

Best regards,
baolu

> Thanks,
> 
> Alex
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
