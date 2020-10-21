Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EE8C55179
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 14:55:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976CD2224E
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 14:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnlFBdD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976CD2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17B52870EF;
	Wed, 21 Oct 2020 14:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EeT+mit9h-jo; Wed, 21 Oct 2020 14:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCEED870EB;
	Wed, 21 Oct 2020 14:55:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADFD0C0052;
	Wed, 21 Oct 2020 14:55:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED0D1C0051
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DC460863D9
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eeizBfo55PcK for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:55:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C34CE863C5
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:55:17 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id dg9so2843402edb.12
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TT/hPDcCjkJCenk8sLHU1Sek4T/MxX3FitCsX0otRRc=;
 b=tnlFBdD60NP1j8CKi3rq0v7z4WCacFdpguP+kTr9uz2MOzLrWy6v9UfR2aViCYoEs4
 KNgexySZD6t48QEV0KYpCSCJQr1dAfmO5L3JY6/orVfiif1vNz6RTPCvO2z9suGyggQw
 ZP7CkNfToa3mHdlDo9xnCOF8GRwUleHlkUAmIJY9zZHgUqvebiMZjqJ95PTq4lJptC93
 7btioFs3fVFwa26j3dBRkvE3qpbk/irVE/8cZeZbxswjcfy1LhRk2cTmiwobkzVVMqki
 nhvW//0XltzV4dYBqGiG2MrKzCNIfn0BDtzQ4Z1etG4sws1lKittG2ZNKnfwqBjJhYBx
 izcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TT/hPDcCjkJCenk8sLHU1Sek4T/MxX3FitCsX0otRRc=;
 b=MYDFc+Ke1dxEcCSDZv0aEZb9ITVyCbSWsvROrUvo0Hf4cc5a5KWSQheVi5MWyCXem3
 JWblym/u8HDiCxTwuhVX7ue3N1Rl8R5SzTc3dSKOOwydCTY3pTGIkJf2wLHcY5Ee2cYg
 5CnPsd/6gPK3et5XaQORU+UhQ9UwSM1r3/daa+lXKPhozrHpSctODBSnvZCGAk/scsxL
 VpUjTXZSC/pV3dmyanKrgiSEstIvo1UdbeWtv2y82RvXTVF2vfeR1O7xoiiw81ZhyjU4
 Pyi3X8F1ALo69e6bRtv5CJNZ+OAkumethSmUHwDh905Sa8vy8wgddodnq96wztiWktFE
 0pZg==
X-Gm-Message-State: AOAM532NBXIbmHfl3x84OMJ7OoJZY4216q4caRKeNd53zjFAQIsIsJQT
 zXPRpXAPMUIUqDkUStbi8ARNYg==
X-Google-Smtp-Source: ABdhPJxO/uNuN/kb6YExIPr9kYKJ7e7ROpNtyXJhX1g05ieAZquuDAeeEqFw/4xdqCfGl12l+fr2xw==
X-Received: by 2002:a50:8acf:: with SMTP id k15mr3413516edk.351.1603292116012; 
 Wed, 21 Oct 2020 07:55:16 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id lb11sm2406579ejb.27.2020.10.21.07.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 07:55:15 -0700 (PDT)
Date: Wed, 21 Oct 2020 16:54:56 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v3 04/14] iommu/ioasid: Support setting system-wide
 capacity
Message-ID: <20201021145456.GB1653231@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1601329121-36979-5-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Yi Sun <yi.y.sun@intel.com>
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

On Mon, Sep 28, 2020 at 02:38:31PM -0700, Jacob Pan wrote:
> IOASID is a system-wide resource that could vary on different systems.
> The default capacity is 20 bits as defined in the PCI-E specifications.
> This patch adds a function to allow adjusting system IOASID capacity.
> For VT-d this is set during boot as part of the Intel IOMMU
> initialization.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/intel/iommu.c |  5 +++++
>  drivers/iommu/ioasid.c      | 20 ++++++++++++++++++++
>  include/linux/ioasid.h      | 11 +++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 18ed3b3c70d7..e7bcb299e51e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -42,6 +42,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/numa.h>
>  #include <linux/swiotlb.h>
> +#include <linux/ioasid.h>

(not in alphabetical order)

>  #include <asm/irq_remapping.h>
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>
> @@ -3331,6 +3332,10 @@ static int __init init_dmars(void)
>  	if (ret)
>  		goto free_iommu;
>  
> +	/* PASID is needed for scalable mode irrespective to SVM */
> +	if (intel_iommu_sm)
> +		ioasid_install_capacity(intel_pasid_max_id);
> +
>  	/*
>  	 * for each drhd
>  	 *   enable fault log
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 6cfbdfb492e0..4277cb17e15b 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -10,6 +10,10 @@
>  #include <linux/spinlock.h>
>  #include <linux/xarray.h>
>  
> +/* Default to PCIe standard 20 bit PASID */
> +#define PCI_PASID_MAX 0x100000
> +static ioasid_t ioasid_capacity = PCI_PASID_MAX;
> +static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
>  struct ioasid_data {
>  	ioasid_t id;
>  	struct ioasid_set *set;
> @@ -17,6 +21,22 @@ struct ioasid_data {
>  	struct rcu_head rcu;
>  };
>  
> +void ioasid_install_capacity(ioasid_t total)
> +{
> +	if (ioasid_capacity && ioasid_capacity != PCI_PASID_MAX) {
> +		pr_warn("IOASID capacity is already set.\n");
> +		return;
> +	}
> +	ioasid_capacity = ioasid_capacity_avail = total;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> +
> +ioasid_t ioasid_get_capacity(void)
> +{
> +	return ioasid_capacity;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get_capacity);
> +
>  /*
>   * struct ioasid_allocator_data - Internal data structure to hold information
>   * about an allocator. There are two types of allocators:
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index c7f649fa970a..7fc320656be2 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -32,6 +32,8 @@ struct ioasid_allocator_ops {
>  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
>  
>  #if IS_ENABLED(CONFIG_IOASID)
> +void ioasid_install_capacity(ioasid_t total);
> +ioasid_t ioasid_get_capacity(void);
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		      void *private);
>  void ioasid_free(ioasid_t ioasid);
> @@ -42,6 +44,15 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_detach_data(ioasid_t ioasid);
>  #else /* !CONFIG_IOASID */
> +static inline void ioasid_install_capacity(ioasid_t total)
> +{
> +}
> +
> +static inline ioasid_t ioasid_get_capacity(void)
> +{
> +	return 0;
> +}
> +
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>  				    ioasid_t max, void *private)
>  {
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
