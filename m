Return-Path: <SRS0=hrQw=A6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA329C433E3
	for <iommu@archiver.kernel.org>; Sun, 19 Jul 2020 16:06:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A167D20B1F
	for <iommu@archiver.kernel.org>; Sun, 19 Jul 2020 16:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxlSaHQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A167D20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6B4FF2045F;
	Sun, 19 Jul 2020 16:06:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id awiwq84ZuZNL; Sun, 19 Jul 2020 16:06:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 45D4D20482;
	Sun, 19 Jul 2020 16:06:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA8EC0890;
	Sun, 19 Jul 2020 16:06:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF6F7C016F
 for <iommu@lists.linux-foundation.org>; Sun, 19 Jul 2020 16:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A6C578673C
 for <iommu@lists.linux-foundation.org>; Sun, 19 Jul 2020 16:06:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UtivhJUfJ3yB for <iommu@lists.linux-foundation.org>;
 Sun, 19 Jul 2020 16:06:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 308A68664C
 for <iommu@lists.linux-foundation.org>; Sun, 19 Jul 2020 16:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595174775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvn7ah9yf4ty3GXyVniTDmRhC/pcWFvbVoRwSMY5+K0=;
 b=PxlSaHQgPaJZMhUhB/ERIK4y6pavVRlBcWYXtvKNtRNJ73sHhVv4nkos/F2zsBgtm+NcCE
 +5rsoOdvQQDjWiJn7a0KiKutg06yZzQwcMan5qsPBqr1mpmtE6Bdklny3asgUi+uZ9PDfM
 0FFROadcd5wigd7FjDL+/X+dZWx16OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-Oax_5lNPP8a5oDpzki4syg-1; Sun, 19 Jul 2020 12:06:13 -0400
X-MC-Unique: Oax_5lNPP8a5oDpzki4syg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5984A1005504;
 Sun, 19 Jul 2020 16:06:11 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 398A472E45;
 Sun, 19 Jul 2020 16:06:02 +0000 (UTC)
Subject: Re: [PATCH v5 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-10-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b55a09f7-c0ce-f2ff-a725-87a8e042ab80@redhat.com>
Date: Sun, 19 Jul 2020 18:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594552870-55687-10-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Hi Yi,

On 7/12/20 1:21 PM, Liu Yi L wrote:
> When an IOMMU domain with nesting attribute is used for guest SVA, a
> system-wide PASID is allocated for binding with the device and the domain.
> For security reason, we need to check the PASID passsed from user-space.
passed
> e.g. page table bind/unbind and PASID related cache invalidation.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 10 ++++++++++
>  drivers/iommu/intel/svm.c   |  7 +++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d54198..a9504cb 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5436,6 +5436,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  		int granu = 0;
>  		u64 pasid = 0;
>  		u64 addr = 0;
> +		void *pdata;
>  
>  		granu = to_vtd_granularity(cache_type, inv_info->granularity);
>  		if (granu == -EINVAL) {
> @@ -5456,6 +5457,15 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  			 (inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
>  			pasid = inv_info->granu.addr_info.pasid;
>  
> +		pdata = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
> +		if (!pdata) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		} else if (IS_ERR(pdata)) {
> +			ret = PTR_ERR(pdata);
> +			goto out_unlock;
> +		}
> +
>  		switch (BIT(cache_type)) {
>  		case IOMMU_CACHE_INV_TYPE_IOTLB:
>  			/* HW will ignore LSB bits based on address mask */
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index d2c0e1a..212dee0 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -319,7 +319,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	dmar_domain = to_dmar_domain(domain);
>  
>  	mutex_lock(&pasid_mutex);
> -	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
I do not get what the call was supposed to do before that patch?
> +	svm = ioasid_find(dmar_domain->ioasid_sid, data->hpasid, NULL);
>  	if (IS_ERR(svm)) {
>  		ret = PTR_ERR(svm);
>  		goto out;
> @@ -436,6 +436,7 @@ int intel_svm_unbind_gpasid(struct iommu_domain *domain,
>  			    struct device *dev, ioasid_t pasid)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> +	struct dmar_domain *dmar_domain;
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm;
>  	int ret = -EINVAL;
> @@ -443,8 +444,10 @@ int intel_svm_unbind_gpasid(struct iommu_domain *domain,
>  	if (WARN_ON(!iommu))
>  		return -EINVAL;
>  
> +	dmar_domain = to_dmar_domain(domain);
> +
>  	mutex_lock(&pasid_mutex);
> -	svm = ioasid_find(INVALID_IOASID_SET, pasid, NULL);
> +	svm = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
just to make sure, about the locking, can't domain->ioasid_sid change
under the hood?

Thanks

Eric
>  	if (!svm) {
>  		ret = -EINVAL;
>  		goto out;
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
