Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D975BC433E3
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 08:59:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88D820781
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 08:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvVLdkis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88D820781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7993B875CA;
	Thu, 13 Aug 2020 08:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jQ4K0HxCc+H; Thu, 13 Aug 2020 08:59:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E87C875AD;
	Thu, 13 Aug 2020 08:59:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CDEEC07FF;
	Thu, 13 Aug 2020 08:59:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3229C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 08:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7E9A2875BF
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 08:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nZXkeGQxeevl for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 08:59:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9A151875AD
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 08:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597309148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xplidKiAunMjEmfmobXpSZSbiqFpNVbmoHS76yAqyR4=;
 b=NvVLdkish7ChXd6EjG2ia7GZ0fbnpJDDuXLz5rXFv0LBnwQOR8xDwofS3tPhqQ2sjTZgtd
 46Kuf88Ed2uLchJ82DuMCWyK7ZaVdQlOa7jABoLV6Bih4sEVKjPkPE2U6GqXlp0XW/fLyY
 L0DrqpjVflMEVhiVjOCYxmyYAhkc2mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-tnH2_dRBMLeGslfaYettJA-1; Thu, 13 Aug 2020 04:59:04 -0400
X-MC-Unique: tnH2_dRBMLeGslfaYettJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 602011005E5B;
 Thu, 13 Aug 2020 08:59:01 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E7D370106;
 Thu, 13 Aug 2020 08:58:54 +0000 (UTC)
Subject: Re: [PATCH v7 5/7] iommu/uapi: Rename uapi functions
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-6-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <310ebf1c-02d6-b31f-e92e-619d46fa94aa@redhat.com>
Date: Thu, 13 Aug 2020 10:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596068467-49322-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,

On 7/30/20 2:21 AM, Jacob Pan wrote:
> User APIs such as iommu_sva_unbind_gpasid() may also be used by the
> kernel. Since we introduced user pointer to the UAPI functions,
Practically this is done in the next patch. What about something like:

We plan to have two flavors of the same API functions, one called
through ioctls, carrying a user pointer and one called directly with
valid IOMMU UAPI structs. To differentiate both, let's rename existing
functions with an iommu_uapi_ prefix.

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Thanks

Eric
> in-kernel callers cannot share the same APIs. In-kernel callers are also
> trusted, there is no need to validate the data.
> 
> This patch renames all UAPI functions with iommu_uapi_ prefix such that
> is clear to the intended callers.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 18 +++++++++---------
>  include/linux/iommu.h | 31 ++++++++++++++++---------------
>  2 files changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b6858adc4f17..3a913ce94a3d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1950,35 +1950,35 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_attach_device);
>  
> -int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> -			   struct iommu_cache_invalidate_info *inv_info)
> +int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> +				struct iommu_cache_invalidate_info *inv_info)
>  {
>  	if (unlikely(!domain->ops->cache_invalidate))
>  		return -ENODEV;
>  
>  	return domain->ops->cache_invalidate(domain, dev, inv_info);
>  }
> -EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> +EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
>  
> -int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -			   struct device *dev, struct iommu_gpasid_bind_data *data)
> +int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> +			       struct device *dev, struct iommu_gpasid_bind_data *data)
>  {
>  	if (unlikely(!domain->ops->sva_bind_gpasid))
>  		return -ENODEV;
>  
>  	return domain->ops->sva_bind_gpasid(domain, dev, data);
>  }
> -EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
> +EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
>  
> -int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> -			     ioasid_t pasid)
> +int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +				 ioasid_t pasid)
>  {
>  	if (unlikely(!domain->ops->sva_unbind_gpasid))
>  		return -ENODEV;
>  
>  	return domain->ops->sva_unbind_gpasid(dev, pasid);
>  }
> -EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> +EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
>  
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5f0b7859d2eb..2dcc1a33f6dc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -430,13 +430,13 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>  			       struct device *dev);
>  extern void iommu_detach_device(struct iommu_domain *domain,
>  				struct device *dev);
> -extern int iommu_cache_invalidate(struct iommu_domain *domain,
> -				  struct device *dev,
> -				  struct iommu_cache_invalidate_info *inv_info);
> -extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -		struct device *dev, struct iommu_gpasid_bind_data *data);
> -extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -				struct device *dev, ioasid_t pasid);
> +extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> +				       struct device *dev,
> +				       struct iommu_cache_invalidate_info *inv_info);
> +extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> +				      struct device *dev, struct iommu_gpasid_bind_data *data);
> +extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> +					struct device *dev, ioasid_t pasid);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> @@ -1054,21 +1054,22 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
>  	return IOMMU_PASID_INVALID;
>  }
>  
> -static inline int
> -iommu_cache_invalidate(struct iommu_domain *domain,
> -		       struct device *dev,
> -		       struct iommu_cache_invalidate_info *inv_info)
> +static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> +					      struct device *dev,
> +					      struct iommu_cache_invalidate_info *inv_info)
>  {
>  	return -ENODEV;
>  }
> -static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -				struct device *dev, struct iommu_gpasid_bind_data *data)
> +
> +static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> +					     struct device *dev,
> +					     struct iommu_gpasid_bind_data *data)
>  {
>  	return -ENODEV;
>  }
>  
> -static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -					   struct device *dev, int pasid)
> +static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> +					       struct device *dev, int pasid)
>  {
>  	return -ENODEV;
>  }
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
