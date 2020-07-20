Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C26C433E2
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 12:38:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93057207FC
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 12:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdBfi7fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93057207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B676855CE;
	Mon, 20 Jul 2020 12:38:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wb0Pa9k96bpv; Mon, 20 Jul 2020 12:38:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CACD3855F6;
	Mon, 20 Jul 2020 12:38:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B41C0C0894;
	Mon, 20 Jul 2020 12:38:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFD4EC016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A676587E6E
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:38:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tkfWjUpAr6Wy for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 12:38:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DB65387A5E
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595248690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlxgO/hjprq758LS3bEpP1ly/+KkksHeMXbfu4RGOqE=;
 b=HdBfi7fvwtyckQPRYvmeshg3q2q0HQ4/lL0T2M1NEIdnGihBY0iG+ajCfgidLydn496AT4
 p04lGJgNOI1wlQAaJ0y/kD6O7MpKG3mZZL3DUTg00nobSHJW9ff2eaaW/0aX4aeVkvPmcN
 PEvPFqKSnabhSLEFcrVxw+TsqVgGsCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-6fCf_g1VPKCI--6FnThA-Q-1; Mon, 20 Jul 2020 08:38:06 -0400
X-MC-Unique: 6fCf_g1VPKCI--6FnThA-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24E551DE1;
 Mon, 20 Jul 2020 12:38:04 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7AC25C1D4;
 Mon, 20 Jul 2020 12:37:54 +0000 (UTC)
Subject: Re: [PATCH v5 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-10-git-send-email-yi.l.liu@intel.com>
 <b55a09f7-c0ce-f2ff-a725-87a8e042ab80@redhat.com>
 <DM5PR11MB14351CB472AEEAFB864A4DFEC37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e31c2b5e-b3c1-b42d-a280-83ed61f311c0@redhat.com>
Date: Mon, 20 Jul 2020 14:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB14351CB472AEEAFB864A4DFEC37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Yi,

On 7/20/20 12:18 PM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Monday, July 20, 2020 12:06 AM
>>
>> Hi Yi,
>>
>> On 7/12/20 1:21 PM, Liu Yi L wrote:
>>> When an IOMMU domain with nesting attribute is used for guest SVA, a
>>> system-wide PASID is allocated for binding with the device and the domain.
>>> For security reason, we need to check the PASID passsed from user-space.
>> passed
> 
> got it.
> 
>>> e.g. page table bind/unbind and PASID related cache invalidation.
>>>
>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>>  drivers/iommu/intel/iommu.c | 10 ++++++++++
>>>  drivers/iommu/intel/svm.c   |  7 +++++--
>>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 4d54198..a9504cb 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -5436,6 +5436,7 @@ intel_iommu_sva_invalidate(struct iommu_domain
>> *domain, struct device *dev,
>>>  		int granu = 0;
>>>  		u64 pasid = 0;
>>>  		u64 addr = 0;
>>> +		void *pdata;
>>>
>>>  		granu = to_vtd_granularity(cache_type, inv_info->granularity);
>>>  		if (granu == -EINVAL) {
>>> @@ -5456,6 +5457,15 @@ intel_iommu_sva_invalidate(struct iommu_domain
>> *domain, struct device *dev,
>>>  			 (inv_info->granu.addr_info.flags &
>> IOMMU_INV_ADDR_FLAGS_PASID))
>>>  			pasid = inv_info->granu.addr_info.pasid;
>>>
>>> +		pdata = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
>>> +		if (!pdata) {
>>> +			ret = -EINVAL;
>>> +			goto out_unlock;
>>> +		} else if (IS_ERR(pdata)) {
>>> +			ret = PTR_ERR(pdata);
>>> +			goto out_unlock;
>>> +		}
>>> +
>>>  		switch (BIT(cache_type)) {
>>>  		case IOMMU_CACHE_INV_TYPE_IOTLB:
>>>  			/* HW will ignore LSB bits based on address mask */
>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>> index d2c0e1a..212dee0 100644
>>> --- a/drivers/iommu/intel/svm.c
>>> +++ b/drivers/iommu/intel/svm.c
>>> @@ -319,7 +319,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
>> struct device *dev,
>>>  	dmar_domain = to_dmar_domain(domain);
>>>
>>>  	mutex_lock(&pasid_mutex);
>>> -	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
I meant while using INVALID_IOASID_SET instead of the actual
dmar_domain->ioasid_sid. But I think I've now recovered, the asset is
simply not used ;-)
>> I do not get what the call was supposed to do before that patch?
> 
> you mean patch 10/15 by "that patch", right? the ownership check should
> be done as to prevent illegal bind request from userspace. before patch
> 10/15, it should be added.
> 
>>> +	svm = ioasid_find(dmar_domain->ioasid_sid, data->hpasid, NULL);
>>>  	if (IS_ERR(svm)) {
>>>  		ret = PTR_ERR(svm);
>>>  		goto out;
>>> @@ -436,6 +436,7 @@ int intel_svm_unbind_gpasid(struct iommu_domain
>> *domain,
>>>  			    struct device *dev, ioasid_t pasid)
>>>  {
>>>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>>> +	struct dmar_domain *dmar_domain;
>>>  	struct intel_svm_dev *sdev;
>>>  	struct intel_svm *svm;
>>>  	int ret = -EINVAL;
>>> @@ -443,8 +444,10 @@ int intel_svm_unbind_gpasid(struct iommu_domain
>> *domain,
>>>  	if (WARN_ON(!iommu))
>>>  		return -EINVAL;
>>>
>>> +	dmar_domain = to_dmar_domain(domain);
>>> +
>>>  	mutex_lock(&pasid_mutex);
>>> -	svm = ioasid_find(INVALID_IOASID_SET, pasid, NULL);
>>> +	svm = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
>> just to make sure, about the locking, can't domain->ioasid_sid change
>> under the hood?
> 
> I guess not. intel_svm_unbind_gpasid() and iommu_domain_set_attr()
> is called by vfio today, and within vfio, there is vfio_iommu->lock.
OK

Thanks

Eric
> 
> Regards,
> Yi Liu
> 
>>
>> Thanks
>>
>> Eric
>>>  	if (!svm) {
>>>  		ret = -EINVAL;
>>>  		goto out;
>>>
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
