Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57070C433E1
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 15:07:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE7920791
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKOJrpS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE7920791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA78188674;
	Thu, 13 Aug 2020 15:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wV3Ziv-qwHrQ; Thu, 13 Aug 2020 15:07:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 38C8986BC1;
	Thu, 13 Aug 2020 15:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C30EC013C;
	Thu, 13 Aug 2020 15:07:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5669C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 15:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8F73088698
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 15:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k7H6U55x9wed for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 15:07:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 64D0388699
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597331235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1/COf1rYZPBo+t1nqm+FQLIB91ekTH/x8nDL3/8R0g=;
 b=TKOJrpS6+Yz8ZP0GeIdOVpmOEdDlWq95xLC0u3VGibkVaQ3TfyE0cQLEBJrBbnfLiTArvl
 ewEHyTCtzsFceUMu4cS4g3ZFAEgI7O4v2y4aZp+M1pLEVMcCN5lNhY45F6mdwI7+VzqlKz
 ZH5cm4XbhBvNrqu6xj8uigG5T27bd1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-JpFIrVg6ObCUBU0HBSwDUQ-1; Thu, 13 Aug 2020 11:07:10 -0400
X-MC-Unique: JpFIrVg6ObCUBU0HBSwDUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A00A9100CA88;
 Thu, 13 Aug 2020 15:07:08 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD7745C1A3;
 Thu, 13 Aug 2020 15:06:57 +0000 (UTC)
Subject: Re: [PATCH v6 06/15] iommu/vt-d: Support setting ioasid set to domain
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-7-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ae43dda5-01aa-adb1-d21d-2525cf4f4d95@redhat.com>
Date: Thu, 13 Aug 2020 17:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1595917664-33276-7-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On 7/28/20 8:27 AM, Liu Yi L wrote:
> From IOMMU p.o.v., PASIDs allocated and managed by external components
> (e.g. VFIO) will be passed in for gpasid_bind/unbind operation. IOMMU
> needs some knowledge to check the PASID ownership, hence add an interface
> for those components to tell the PASID owner.
> 
> In latest kernel design, PASID ownership is managed by IOASID set where
> the PASID is allocated from. This patch adds support for setting ioasid
> set ID to the domains used for nesting/vSVA. Subsequent SVA operations
> will check the PASID against its IOASID set for proper ownership.
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
> v5 -> v6:
> *) address comments against v5 from Eric Auger.
> 
> v4 -> v5:
> *) address comments from Eric Auger.
> ---
>  drivers/iommu/intel/iommu.c | 23 +++++++++++++++++++++++
>  include/linux/intel-iommu.h |  4 ++++
>  include/linux/iommu.h       |  1 +
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ed4b71c..b2fe54e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1793,6 +1793,7 @@ static struct dmar_domain *alloc_domain(int flags)
>  	if (first_level_by_default())
>  		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
>  	domain->has_iotlb_device = false;
> +	domain->ioasid_sid = INVALID_IOASID_SET;
>  	INIT_LIST_HEAD(&domain->devices);
>  
>  	return domain;
> @@ -6040,6 +6041,28 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
>  		}
>  		spin_unlock_irqrestore(&device_domain_lock, flags);
>  		break;
> +	case DOMAIN_ATTR_IOASID_SID:
> +	{
> +		int sid = *(int *)data;

> +
> +		spin_lock_irqsave(&device_domain_lock, flags);
> +		if (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE)) {
> +			ret = -ENODEV;
> +			spin_unlock_irqrestore(&device_domain_lock, flags);
> +			break;
> +		}
> +		if (dmar_domain->ioasid_sid != INVALID_IOASID_SET &&
> +		    dmar_domain->ioasid_sid != sid) {
> +			pr_warn_ratelimited("multi ioasid_set (%d:%d) setting",
> +					    dmar_domain->ioasid_sid, sid);
> +			ret = -EBUSY;
> +			spin_unlock_irqrestore(&device_domain_lock, flags);
> +			break;
> +		}
> +		dmar_domain->ioasid_sid = sid;
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		break;
nit: Adding a small helper
int__set_ioasid_sid(struct dmar_domain *dmar_domain, int sid_id)

may simplify the lock handling


> +	}
>  	default:
>  		ret = -EINVAL;
>  		break;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 3f23c26..0d0ab32 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -549,6 +549,10 @@ struct dmar_domain {
>  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
>  	u64		max_addr;	/* maximum mapped address */
>  
> +	int		ioasid_sid;	/*
> +					 * the ioasid set which tracks all
id of the ioasid set?
> +					 * PASIDs used by the domain.
> +					 */
>  	int		default_pasid;	/*
>  					 * The default pasid used for non-SVM
>  					 * traffic on mediated devices.
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4a02c9e..b1ff702 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -124,6 +124,7 @@ enum iommu_attr {
>  	DOMAIN_ATTR_FSL_PAMUV1,
>  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
>  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> +	DOMAIN_ATTR_IOASID_SID,
>  	DOMAIN_ATTR_MAX,
>  };
>  
> 
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
