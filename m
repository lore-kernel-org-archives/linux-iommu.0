Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31985C433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:09:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A56207BB
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STB2EhqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A56207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9580C20428;
	Fri, 21 Aug 2020 13:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HXLofNzsEqh0; Fri, 21 Aug 2020 13:09:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7FF2A2042D;
	Fri, 21 Aug 2020 13:09:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69961C07FF;
	Fri, 21 Aug 2020 13:09:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58CF2C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3B8AE2043C
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2tlc-rCmhZMR for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:09:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 06F7E20428
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598015387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Od+bO6wwGHZOpfyUe8CiRlpyX1hZ1GD4+OWd3dAX8YA=;
 b=STB2EhqUyy49UsAXTTFI1HiJZRY1NW+uJWaeMn2QGu+w9LW8TBYTfmPLLha1JUsqcWdRpB
 +H9djbOQgOA8nAcvuI9yLake6AJAWqrUhaWVhCzQwmbazFlGaDYRDs/zKW+i2OACFFZZpp
 dAeL/l+82+ndepKHZ0YMU9UrqPWBT5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-mXq3zwf3MwmX4df6JT2Brg-1; Fri, 21 Aug 2020 09:09:44 -0400
X-MC-Unique: mXq3zwf3MwmX4df6JT2Brg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E550B18BA282;
 Fri, 21 Aug 2020 13:09:41 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D35877DC2;
 Fri, 21 Aug 2020 13:09:31 +0000 (UTC)
Subject: Re: [PATCH v6 08/15] iommu: Pass domain to sva_unbind_gpasid()
To: Alex Williamson <alex.williamson@redhat.com>, Liu Yi L <yi.l.liu@intel.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-9-git-send-email-yi.l.liu@intel.com>
 <20200820150619.5dc1ec7a@x1.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7db3f15c-09e3-6a52-352a-c9a499895922@redhat.com>
Date: Fri, 21 Aug 2020 15:09:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200820150619.5dc1ec7a@x1.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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

On 8/20/20 11:06 PM, Alex Williamson wrote:
> On Mon, 27 Jul 2020 23:27:37 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
>> From: Yi Sun <yi.y.sun@intel.com>
>>
>> Current interface is good enough for SVA virtualization on an assigned
>> physical PCI device, but when it comes to mediated devices, a physical
>> device may attached with multiple aux-domains. Also, for guest unbind,
> 
> s/may/may be/
> 
>> the PASID to be unbind should be allocated to the VM. This check requires
>> to know the ioasid_set which is associated with the domain.
>>
>> So this interface needs to pass in domain info. Then the iommu driver is
>> able to know which domain will be used for the 2nd stage translation of
>> the nesting mode and also be able to do PASID ownership check. This patch
>> passes @domain per the above reason. Also, the prototype of &pasid is
>> changed frnt" to "u32" as the below link.
> 
> s/frnt"/from an "int"/
>  
>> https://lore.kernel.org/kvm/27ac7880-bdd3-2891-139e-b4a7cd18420b@redhat.com/
> 
> This is really confusing, the link is to Eric's comment asking that the
> conversion from (at the time) int to ioasid_t be included in the commit
> log.  The text here implies that it's pointing to some sort of
> justification for the change, which it isn't.  It just notes that it
> happened, not why it happened, with a mostly irrelevant link.
> 
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> ---
>> v5 -> v6:
>> *) use "u32" prototype for @pasid.
>> *) add review-by from Eric Auger.
> 
> I'd probably hold off on adding Eric's R-b given the additional change
> in this version FWIW.  Thanks,

Yep I did not notice that change given the R-b was applied ;-)

Thanks

Eric
> 
> Alex
>  
>> v2 -> v3:
>> *) pass in domain info only
>> *) use u32 for pasid instead of int type
>>
>> v1 -> v2:
>> *) added in v2.
>> ---
>>  drivers/iommu/intel/svm.c   | 3 ++-
>>  drivers/iommu/iommu.c       | 2 +-
>>  include/linux/intel-iommu.h | 3 ++-
>>  include/linux/iommu.h       | 3 ++-
>>  4 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index c27d16a..c85b8d5 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -436,7 +436,8 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>>  	return ret;
>>  }
>>  
>> -int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>> +int intel_svm_unbind_gpasid(struct iommu_domain *domain,
>> +			    struct device *dev, u32 pasid)
>>  {
>>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>>  	struct intel_svm_dev *sdev;
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 1ce2a61..bee79d7 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2145,7 +2145,7 @@ int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
>>  	if (unlikely(!domain->ops->sva_unbind_gpasid))
>>  		return -ENODEV;
>>  
>> -	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
>> +	return domain->ops->sva_unbind_gpasid(domain, dev, data->hpasid);
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
>>  
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 0d0ab32..f98146b 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -738,7 +738,8 @@ extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>>  int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>>  			  struct iommu_gpasid_bind_data *data);
>> -int intel_svm_unbind_gpasid(struct device *dev, int pasid);
>> +int intel_svm_unbind_gpasid(struct iommu_domain *domain,
>> +			    struct device *dev, u32 pasid);
>>  struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
>>  				 void *drvdata);
>>  void intel_svm_unbind(struct iommu_sva *handle);
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index b1ff702..80467fc 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -303,7 +303,8 @@ struct iommu_ops {
>>  	int (*sva_bind_gpasid)(struct iommu_domain *domain,
>>  			struct device *dev, struct iommu_gpasid_bind_data *data);
>>  
>> -	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
>> +	int (*sva_unbind_gpasid)(struct iommu_domain *domain,
>> +				 struct device *dev, u32 pasid);
>>  
>>  	int (*def_domain_type)(struct device *dev);
>>  
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
