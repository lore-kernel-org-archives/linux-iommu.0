Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA64C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 20:01:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB63564EEC
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 20:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB63564EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C2D040141;
	Wed,  3 Mar 2021 20:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G1ZeTdezG71i; Wed,  3 Mar 2021 20:01:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29215400E1;
	Wed,  3 Mar 2021 20:01:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1344DC000A;
	Wed,  3 Mar 2021 20:01:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4F7DC0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 20:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6D8484286
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 20:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PaHCPIGA94MV for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 20:00:57 +0000 (UTC)
X-Greylist: delayed 00:42:16 by SQLgrey-1.8.0
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF81484296
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 20:00:57 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id dx17so17079284ejb.2
 for <iommu@lists.linux-foundation.org>; Wed, 03 Mar 2021 12:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=i2EmiA2OI6AS1yv/kESZ25uJxCrsbJD4OPafUbCob7k=;
 b=G7Wv9nJ4rffonUPHi15xk4myESuF1veXlWxhT6o1EflZeRo7Es0NPuoJvoWKAMFaXn
 a8HSUzKKOdcBC11ggt5ntPm2ZHzRAlrEDwLk+uG+ahMNqGmhdUVm4eyJ9RqUvAM6vrEc
 t8RObshVlZWj7/nsMtM8Qkv0RWNXngpUPL0uTytGMVh8xDFblD332rtFAyE/vEmKLaG8
 ze3Sz1EVrorfCpgAOdVTAhxVf+fTaRyvBFJosrkBHZ/jgD0bOdmdRiIK6FwYGHrh5t/g
 rTr+S9l1vQbvmeZuk4GjEjOv+c6yYz4AYk91JxwmeTOjSHX56NTmPArkkazCvqQGAyH0
 7/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i2EmiA2OI6AS1yv/kESZ25uJxCrsbJD4OPafUbCob7k=;
 b=VUNCvYcMlm2Fmfc9+rPjDqgyibR7TtXRmRyfgN892m3XciwAmom0V2aeSsTTfDht68
 MKiO/S/3lpHNYWTBRoJhqEuhF3kYe8GHPvEk45R6yswk24745QKYWjd8POqNuwECtrr7
 E1POapbP8Jf5znvwXjpEEU9IjehzTvVt9kJr9GNGhA7lSejxRjvQWvcyt74zTXaTbxaM
 FDX3CDs/so91AqioXFCeqgJzfR53Rt1h9YDAK4dlB+uXmTVDa+bfQx+EznkATzcPB2FA
 ijZDc6+n7Kvxv9Om3I1sP0juSsFU6Nc4bTJaXyF1WaHHq6bwDkusCvjo5mB5jbJj76Yy
 iWmw==
X-Gm-Message-State: AOAM532d2xR/LG8rpjbKjteDFvn6yeP05G7m3oiurXVfRDpnq6fYLLHo
 CDjxScU8hcyii04YfNycGRdXohUc9Bskuw==
X-Google-Smtp-Source: ABdhPJxUR+nvbzEW9IaIRVudC5yUeyFpL97Hh5+SHssrit/Q6elP8Y7hyAVFMdldaV9xhDA9NaLjQg==
X-Received: by 2002:adf:f7cc:: with SMTP id a12mr28284530wrq.54.1614791951832; 
 Wed, 03 Mar 2021 09:19:11 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id z7sm4968309wrt.70.2021.03.03.09.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 09:19:11 -0800 (PST)
Date: Wed, 3 Mar 2021 18:18:49 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 08/15] iommu: Add asid_bits to arm smmu-v3 stage1
 table info
Message-ID: <YD/E+XASgn9PL9HM@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-9-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-9-vivek.gautam@arm.com>
Cc: kevin.tian@intel.com, alex.williamson@redhat.com, mst@redhat.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Fri, Jan 15, 2021 at 05:43:35PM +0530, Vivek Gautam wrote:
> aisd_bits data is required to prepare stage-1 tables for arm-smmu-v3.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> ---
>  include/uapi/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 082d758dd016..96abbfc7c643 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -357,7 +357,7 @@ struct iommu_pasid_smmuv3 {
>  	__u32	version;
>  	__u8	s1fmt;
>  	__u8	s1dss;
> -	__u8	padding[2];
> +	__u16	asid_bits;

Is this used anywhere?  This struct is passed from host userspace to host
kernel to attach the PASID table, so I don't think it needs an asid_bits
field.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
