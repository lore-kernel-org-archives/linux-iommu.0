Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2233AC433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 14:39:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9711206F1
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 14:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1P4icbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9711206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 980ED20411;
	Wed, 17 Jun 2020 14:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ryi-noCB5LB; Wed, 17 Jun 2020 14:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9BC032039A;
	Wed, 17 Jun 2020 14:39:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82E71C0863;
	Wed, 17 Jun 2020 14:39:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7522C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 14:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A1EE288F5B
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 14:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dxggeNRXtFEl for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 14:39:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9C54D86FE7
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 14:39:22 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id q19so2590544eja.7
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Hp21piGHsn7agUSyXFgTrryIp2qf2aW4dX8w1tTdFAQ=;
 b=K1P4icbmrpXAkcV9YDVqQ37pfEGBzuBW3Ramc+WC17uKN5rl13MHwBI51R3kWEeHD1
 RPShy1U/CpBqrsloZYaVylODq+KGw2xSOkKxF2agc/KVt1EKIval0NZumgyRJZELNTgO
 190/ZjceYSb3+Ip+Y8Y/5she3fLhpEoXh4j5/sC6EU6bI8B7i8haV1/yDLMRmuJeGppO
 yhS/D19DQVPGoOMCgXjXv8KXT+n9ApVTB1WI38fs1ObO2AGLTUvxNnFMIG7exIFmMw9V
 4nJz/h4/nl7PgVf2CCGEYD9TMF7cxq7cZqjg6tdphAwY2Rz9KSYHv4+s27XlDiuF3Do0
 LWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Hp21piGHsn7agUSyXFgTrryIp2qf2aW4dX8w1tTdFAQ=;
 b=U1LnsnXfmKOc8lz7oWaXNHKd/O6RDFXQinict9C9Gq9/v+ZOmXa0j1aDHIvup2FL71
 HVU0yiPC/PbY3cJoIXUlaC0Cfzaf5xvS/zlICb4Dcl6rAl7Bugl03k4AgrABnBORN/KF
 7pAXDHMIEn8U7xRYYCAgxbVdeUDfqKY7cFfSsXwz2kDdf0KGqLTGJiqq3EAa2E/mhv7v
 xZcpLA4OtD9Jcvv6VJtB7JuJ4Gb4B3JLYfK4r94stC2OW8XQT7OtUp8NngZeUegggIBH
 rNNuOGxckFRl5F6JyIt3CAfqanpbiYDI/ykKJgZKcLVb73AV8vOI/DCVhzLmhCG2pqB/
 h8zA==
X-Gm-Message-State: AOAM533R9+JOicGsfPc2TZJnWcD13+nc3LIwRf74tXmHQdBUmJHpOK/h
 /2dlVXUauC52zqQz/HdUTIwXoA==
X-Google-Smtp-Source: ABdhPJxLaOaRToMf9UF6SdNB0Ecr2eORyxp0pZiau38To63+9MZNptlFFfGl++IztCMMaBaouHNWgA==
X-Received: by 2002:a17:906:22d0:: with SMTP id
 q16mr7685367eja.455.1592404760889; 
 Wed, 17 Jun 2020 07:39:20 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id dn17sm12374349edb.26.2020.06.17.07.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 07:39:20 -0700 (PDT)
Date: Wed, 17 Jun 2020 16:39:09 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 02/15] iommu: Report domain nesting info
Message-ID: <20200617143909.GA886590@myrica>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <1591877734-66527-3-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1591877734-66527-3-git-send-email-yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 robin.murphy@arm.com, yi.y.sun@intel.com, linux-kernel@vger.kernel.org,
 alex.williamson@redhat.com, iommu@lists.linux-foundation.org, hao.wu@intel.com,
 will@kernel.org, jun.j.tian@intel.com
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

[+ Will and Robin]

Hi Yi,

On Thu, Jun 11, 2020 at 05:15:21AM -0700, Liu Yi L wrote:
> IOMMUs that support nesting translation needs report the capability info
> to userspace, e.g. the format of first level/stage paging structures.
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
> @Jean, Eric: as nesting was introduced for ARM, but looks like no actual
> user of it. right? So I'm wondering if we can reuse DOMAIN_ATTR_NESTING
> to retrieve nesting info? how about your opinions?

Sure, I think we could rework the getters for DOMAIN_ATTR_NESTING since
they aren't used, but we do need to keep the setters as is.

Before attaching a domain, VFIO sets DOMAIN_ATTR_NESTING if userspace
requested a VFIO_TYPE1_NESTING_IOMMU container. This is necessary for the
SMMU driver to know how to attach later, but at that point we don't know
whether the SMMU does support nesting (since the domain isn't attached to
any endpoint). During attach, the SMMU driver adapts to the SMMU's
capabilities, and may well fallback to one stage if the SMMU doesn't
support nesting.

VFIO should check after attaching that the nesting attribute held, by
calling iommu_domain_get_attr(NESTING). At the moment it does not, and
since your 03/15 patch does that with additional info, I agree with
reusing DOMAIN_ATTR_NESTING instead of adding DOMAIN_ATTR_NESTING_INFO.

However it requires changing the get_attr(NESTING) implementations in both
SMMU drivers as a precursor of this series, to avoid breaking
VFIO_TYPE1_NESTING_IOMMU on Arm. Since we haven't yet defined the
nesting_info structs for SMMUv2 and v3, I suppose we could return an empty
struct iommu_nesting_info for now?

> 
>  include/linux/iommu.h      |  1 +
>  include/uapi/linux/iommu.h | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 78a26ae..f6e4b49 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -126,6 +126,7 @@ enum iommu_attr {
>  	DOMAIN_ATTR_FSL_PAMUV1,
>  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
>  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> +	DOMAIN_ATTR_NESTING_INFO,
>  	DOMAIN_ATTR_MAX,
>  };
>  
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 303f148..02eac73 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -332,4 +332,38 @@ struct iommu_gpasid_bind_data {
>  	};
>  };
>  
> +struct iommu_nesting_info {
> +	__u32	size;
> +	__u32	format;

What goes into format? And flags? This structure needs some documentation.

Thanks,
Jean

> +	__u32	features;
> +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> +	__u32	flags;
> +	__u8	data[];
> +};
> +
> +/*
> + * @flags:	VT-d specific flags. Currently reserved for future
> + *		extension.
> + * @addr_width:	The output addr width of first level/stage translation
> + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
> + *		support.
> + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
> + *		register.
> + * @cap_mask:	Mark valid capability bits in @cap_reg.
> + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> + *		extended capability register.
> + * @ecap_mask:	Mark the valid capability bits in @ecap_reg.
> + */
> +struct iommu_nesting_info_vtd {
> +	__u32	flags;
> +	__u16	addr_width;
> +	__u16	pasid_bits;
> +	__u64	cap_reg;
> +	__u64	cap_mask;
> +	__u64	ecap_reg;
> +	__u64	ecap_mask;
> +};
> +
>  #endif /* _UAPI_IOMMU_H */
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
