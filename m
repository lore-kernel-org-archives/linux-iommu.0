Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E956C433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 14:52:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B1E206E6
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 14:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKRePbTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B1E206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C2E7D2614D;
	Mon,  6 Jul 2020 14:52:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2t0VLQtjnWlj; Mon,  6 Jul 2020 14:52:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DF91226016;
	Mon,  6 Jul 2020 14:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2683C0891;
	Mon,  6 Jul 2020 14:52:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73A63C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 14:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6297E86B33
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 14:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yOVl4f2DqwtY for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 14:52:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6A1BF86B15
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594047149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKdVspges85ZduPH9Q6FYljsttWOZWyavYYfs+vHaPE=;
 b=ZKRePbTZmTkdHnehH0cvK7nCSpzk7fHYlLRFi01RBDowCBUypg922kwEBUtNefXPtOjffv
 TywU7SaFEdtyyhWWenInk3kkQru2wlOB9VvsKroF3UyWRHVHSCNVb82os/pkbz0pTo+hoK
 l7CxrHZ8aCq2ruxmQq65Nwnq3nNZwU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-6abRn3w7MLOiHY4XoIRN0w-1; Mon, 06 Jul 2020 10:52:27 -0400
X-MC-Unique: 6abRn3w7MLOiHY4XoIRN0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97E93107ACF9;
 Mon,  6 Jul 2020 14:52:25 +0000 (UTC)
Received: from [10.36.113.241] (ovpn-113-241.ams2.redhat.com [10.36.113.241])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 500D260BF3;
 Mon,  6 Jul 2020 14:52:16 +0000 (UTC)
Subject: Re: [PATCH v4 06/15] iommu/vt-d: Support setting ioasid set to domain
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-7-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d47367ab-f986-4c09-2578-3e364aa57835@redhat.com>
Date: Mon, 6 Jul 2020 16:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593861989-35920-7-git-send-email-yi.l.liu@intel.com>
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

Hi Yi,

On 7/4/20 1:26 PM, Liu Yi L wrote:
> From IOMMU p.o.v., PASIDs allocated and managed by external components
> (e.g. VFIO) will be passed in for gpasid_bind/unbind operation. IOMMU
> needs some knowledge to check the PASID ownership, hence add an interface
> for those components to tell the PASID owner.
> 
> In latest kernel design, PASID ownership is managed by IOASID set where
> the PASID is allocated from. This patch adds support for setting ioasid
> set ID to the domains used for nesting/vSVA. Subsequent SVA operations
> on the PASID will be checked against its IOASID set for proper ownership.
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
>  drivers/iommu/intel/iommu.c | 16 ++++++++++++++++
>  include/linux/intel-iommu.h |  4 ++++
>  include/linux/iommu.h       |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 62ebe01..89d708d 100644
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
> @@ -6039,6 +6040,21 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
>  		}
>  		spin_unlock_irqrestore(&device_domain_lock, flags);
>  		break;
> +	case DOMAIN_ATTR_IOASID_SID:
no need to take the device_domain_lock?
> +		if (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE)) {
> +			ret = -ENODEV;
> +			break;
> +		}
> +		if ((dmar_domain->ioasid_sid != INVALID_IOASID_SET) &&
> +		    (dmar_domain->ioasid_sid != (*(int *) data))) {
storing *(int *) data) in a local variable would increase the
readability of the code I think.
> +			pr_warn_ratelimited("multi ioasid_set (%d:%d) setting",
> +					    dmar_domain->ioasid_sid,
> +					    (*(int *) data));
> +			ret = -EBUSY;
> +			break;
> +		}
> +		dmar_domain->ioasid_sid = *(int *) data;
> +		break;
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
> +					 * PASIDs used by the domain.
> +					 */
>  	int		default_pasid;	/*
>  					 * The default pasid used for non-SVM
>  					 * traffic on mediated devices.
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 2567c33..21d32be 100644
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
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
