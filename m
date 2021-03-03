Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D08DC433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 17:51:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E090764DE8
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 17:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E090764DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A4E28425B;
	Wed,  3 Mar 2021 17:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZLiGLzAMZrQ; Wed,  3 Mar 2021 17:50:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E5768426E;
	Wed,  3 Mar 2021 17:50:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBDC4C000A;
	Wed,  3 Mar 2021 17:50:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 531BEC0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 17:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34E188424F
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 17:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M09AI2Ug9HFm for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:50:56 +0000 (UTC)
X-Greylist: delayed 00:24:58 by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E99EF840B6
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 17:50:55 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id l12so24649412wry.2
 for <iommu@lists.linux-foundation.org>; Wed, 03 Mar 2021 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sTamhW9kBjxgzkEQoLRyMj5hVf4Faxe5WhEqC1E4/4A=;
 b=PvFI6RNC5gKkiR4uElMabw36/xB+ietKweTBJ4T98xol1ziCDi0AA0R+IDtXnc5Jsx
 qEao7IHKNQZLfegHpIDSWl1V+a11e0koptzY0nszPgQYWuyYf/+Doh9jF0vbrOgXMYlz
 21Z7Ygx6i3E7XgJgk8INKMwhBKsm7Ca0oNMrRDvzpjSda8mtQal62NDw9tqiXVTvxcLr
 fElIGrLQ9ltww+SCGkRKjuCTlAVc08d+qT8iG9D9f/PybhIBuHYcPh4JbOcQgQQ8Fasf
 X3HtjnlV2CK5gJ1vnSd5P+azVJpctQJFhMYAwenEGER4nvRFIO6/9NXh2sN5GzhjuSk4
 a48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sTamhW9kBjxgzkEQoLRyMj5hVf4Faxe5WhEqC1E4/4A=;
 b=kOOlO/RiHkb5dgg2KK8XHNIIzVdpTqsvAFjNpO/jlrrlGIaydNQjmnpbXmgA5BiNHJ
 ljbVXrcH9E569k7zJDNa6iS9xKZZQh5Qw6Kaffv2/MaDdcB/qaUlzQ4FQsKjaP5SuUjE
 EzpR04hMRxQURApncUMEQuNNuiLBWPO2NEsjP9IEyqCRP/nd7kGIa+aZYVrDQ/T08AGq
 e/wIFyQAkjMo994j0/O/Bag+QidOlugusPOQQ0rfM41d7y12URhs37dd4Pt4SO7MSBJE
 b29PSRzV07J6AVf2Mc7mce76N7Vj68XAJE0qZNZDEUuRldsbVVwQAuaeGvcxJRDyDTox
 RsAg==
X-Gm-Message-State: AOAM5312f0rVhT/RQ2jRY5eOuEI8TnUiDmE2FDYy47/oeq/eoAohSITQ
 FuXbGk4+RKZecovzh634Tu2YOKCYbw/L7Q==
X-Google-Smtp-Source: ABdhPJxEGN1rH8+VtjTLr+Dh5jEKvGOweEYJsKpNFFpw9C+4jgIY35xjxjoSoEJ/Son74X8HB1937Q==
X-Received: by 2002:a5d:550b:: with SMTP id b11mr24476367wrv.313.1614792355644; 
 Wed, 03 Mar 2021 09:25:55 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b65sm6127924wmh.4.2021.03.03.09.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 09:25:55 -0800 (PST)
Date: Wed, 3 Mar 2021 18:25:33 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 15/15] iommu/virtio: Update fault type and reason
 info for viommu fault
Message-ID: <YD/GjQIKkaJ5+UJM@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-16-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-16-vivek.gautam@arm.com>
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

On Fri, Jan 15, 2021 at 05:43:42PM +0530, Vivek Gautam wrote:
> Fault type information can tell about a page request fault or
> an unreceoverable fault, and further additions to fault reasons
> and the related PASID information can help in handling faults
> efficiently.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
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
>  drivers/iommu/virtio-iommu.c      | 27 +++++++++++++++++++++++++--
>  include/uapi/linux/virtio_iommu.h | 13 ++++++++++++-
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 9cc3d35125e9..10ef9e98214a 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -652,9 +652,16 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>  	char *reason_str;
>  
>  	u8 reason	= fault->reason;
> +	u16 type	= fault->flt_type;
>  	u32 flags	= le32_to_cpu(fault->flags);
>  	u32 endpoint	= le32_to_cpu(fault->endpoint);
>  	u64 address	= le64_to_cpu(fault->address);
> +	u32 pasid	= le32_to_cpu(fault->pasid);
> +
> +	if (type == VIRTIO_IOMMU_FAULT_F_PAGE_REQ) {
> +		dev_info(viommu->dev, "Page request fault - unhandled\n");
> +		return 0;
> +	}
>  
>  	switch (reason) {
>  	case VIRTIO_IOMMU_FAULT_R_DOMAIN:
> @@ -663,6 +670,21 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>  	case VIRTIO_IOMMU_FAULT_R_MAPPING:
>  		reason_str = "page";
>  		break;
> +	case VIRTIO_IOMMU_FAULT_R_WALK_EABT:
> +		reason_str = "page walk external abort";
> +		break;
> +	case VIRTIO_IOMMU_FAULT_R_PTE_FETCH:
> +		reason_str = "pte fetch";
> +		break;
> +	case VIRTIO_IOMMU_FAULT_R_PERMISSION:
> +		reason_str = "permission";
> +		break;
> +	case VIRTIO_IOMMU_FAULT_R_ACCESS:
> +		reason_str = "access";
> +		break;
> +	case VIRTIO_IOMMU_FAULT_R_OOR_ADDRESS:
> +		reason_str = "output address";
> +		break;
>  	case VIRTIO_IOMMU_FAULT_R_UNKNOWN:
>  	default:
>  		reason_str = "unknown";
> @@ -671,8 +693,9 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>  
>  	/* TODO: find EP by ID and report_iommu_fault */
>  	if (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS)
> -		dev_err_ratelimited(viommu->dev, "%s fault from EP %u at %#llx [%s%s%s]\n",
> -				    reason_str, endpoint, address,
> +		dev_err_ratelimited(viommu->dev,
> +				    "%s fault from EP %u PASID %u at %#llx [%s%s%s]\n",
> +				    reason_str, endpoint, pasid, address,
>  				    flags & VIRTIO_IOMMU_FAULT_F_READ ? "R" : "",
>  				    flags & VIRTIO_IOMMU_FAULT_F_WRITE ? "W" : "",
>  				    flags & VIRTIO_IOMMU_FAULT_F_EXEC ? "X" : "");
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 608c8d642e1f..a537d82777f7 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -290,19 +290,30 @@ struct virtio_iommu_req_invalidate {
>  #define VIRTIO_IOMMU_FAULT_R_UNKNOWN		0
>  #define VIRTIO_IOMMU_FAULT_R_DOMAIN		1
>  #define VIRTIO_IOMMU_FAULT_R_MAPPING		2
> +#define VIRTIO_IOMMU_FAULT_R_WALK_EABT		3
> +#define VIRTIO_IOMMU_FAULT_R_PTE_FETCH		4
> +#define VIRTIO_IOMMU_FAULT_R_PERMISSION		5
> +#define VIRTIO_IOMMU_FAULT_R_ACCESS		6
> +#define VIRTIO_IOMMU_FAULT_R_OOR_ADDRESS	7
>  
>  #define VIRTIO_IOMMU_FAULT_F_READ		(1 << 0)
>  #define VIRTIO_IOMMU_FAULT_F_WRITE		(1 << 1)
>  #define VIRTIO_IOMMU_FAULT_F_EXEC		(1 << 2)
>  #define VIRTIO_IOMMU_FAULT_F_ADDRESS		(1 << 8)
>  
> +#define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
> +#define VIRTIO_IOMMU_FAULT_F_PAGE_REQ		2

Currently all reported faults are unrecoverable, so to be consistent
DMA_UNRECOV should be 0. But I'd prefer having just a new "page request"
flag in the flags field, instead of the flt_type field.

For page requests we'll also need a 16-bit fault ID field to store the PRI
"page request group index" or the stall "stag". "last" and "privileged"
flags as well, to match the PRI page request. And a new command to
complete a page fault.

> +
>  struct virtio_iommu_fault {
>  	__u8					reason;
> -	__u8					reserved[3];
> +	__le16					flt_type;
> +	__u8					reserved;
>  	__le32					flags;
>  	__le32					endpoint;
>  	__u8					reserved2[4];

Why not replace reserved2 with the pasid?  It fits perfectly :)

Thanks,
Jean

>  	__le64					address;
> +	__le32					pasid;
> +	__u8					reserved3[4];
>  };
>  
>  #endif
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
