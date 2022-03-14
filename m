Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DA4C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 22:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB38D4157B;
	Mon, 14 Mar 2022 22:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cbYurmwF2pQm; Mon, 14 Mar 2022 22:50:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C8914157A;
	Mon, 14 Mar 2022 22:50:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A5DDC0012;
	Mon, 14 Mar 2022 22:50:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40229C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 22:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F30B4055E
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 22:50:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TGdzpafCH8dB for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 22:50:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A1FD40526
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647298237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dr8vjVeMC0DL0KsvggB3fHeVAbBUF+c93QlSTnv4NdI=;
 b=U7Wn+0ikSuIU5tjeAQL8EQIug7bI0u2IV4P+O52kphoJCPM2jxKLjVeUpEJBAi3ObrWhv0
 GEV9RA3Nzw5c6ec0wEK18MUUWY6ZzZ3awWf4b88QhBo7UijhByFo/pxT667eCIfyjf6IEP
 wnVN8+nNzJ7ZE2RXkPEYOsBdEdUtXtI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-b2nJz4RHPLus1YcT2o2HXw-1; Mon, 14 Mar 2022 18:50:36 -0400
X-MC-Unique: b2nJz4RHPLus1YcT2o2HXw-1
Received: by mail-il1-f197.google.com with SMTP id
 t16-20020a92d150000000b002c799d354a8so3205297ilg.9
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 15:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dr8vjVeMC0DL0KsvggB3fHeVAbBUF+c93QlSTnv4NdI=;
 b=MnIBpN3fKF5saQbX4L5ajtsWB/t83rZFsKja+qX13rru7lOjOVk3HPabIxYtSS1wQB
 B3/T5Y8xs/tuflybFyCNoeE06vkCWoymejGrbB3AODXCdccGwhArfKkX7BL1ck7eeGXB
 aiX0/5FUu0Fb0nYHgQi74xmsP3o6CXl+D/PwWjB890cy61bMS7C6SBO2h7yLB2ScAHZe
 1svEK5xT0RpNZrO56wlAZTrovAUHP4px/v+bgw5HQ4i0A8Y5cTwco0fP2hrISq+ADVvq
 86CPJo63J3sORZ8AvXkvox8jxoNLKl1qF+N6s7gjPJ/NAmaM21GWbyXBWXzo/zOTQ+fg
 4s/w==
X-Gm-Message-State: AOAM531i9oM2W7Gmk+ZPBa2Ww3CZvjoM86exM1OTydRFVxxWEElPmUt/
 HEQckzAyn9QJMST+1gca+q0hAwtByutBsEHSWwphQfkogsEkIgcfremxe555DX691BQnH5/t+R1
 ZfJXZ3WlCV27A48QQRHouOKTkNNCjRA==
X-Received: by 2002:a6b:620e:0:b0:611:4b19:6ca8 with SMTP id
 f14-20020a6b620e000000b006114b196ca8mr20995643iog.49.1647298236055; 
 Mon, 14 Mar 2022 15:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg8HJ/3lVgtLPe6Yd5ht2l45iOmV2X8AafJZFuKi1YIsK1jkfd5ZA3a4unIG0CxlWIAReolA==
X-Received: by 2002:a6b:620e:0:b0:611:4b19:6ca8 with SMTP id
 f14-20020a6b620e000000b006114b196ca8mr20995618iog.49.1647298235835; 
 Mon, 14 Mar 2022 15:50:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 g8-20020a056602248800b006409fb2cbccsm9036619ioe.32.2022.03.14.15.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 15:50:35 -0700 (PDT)
Date: Mon, 14 Mar 2022 16:50:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 15/32] vfio: introduce KVM-owned IOMMU type
Message-ID: <20220314165033.6d2291a5.alex.williamson@redhat.com>
In-Reply-To: <20220314194451.58266-16-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-16-mjrosato@linux.ibm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 linux-kernel@vger.kernel.org, vneethv@linux.ibm.com, agordeev@linux.ibm.com,
 imbrenda@linux.ibm.com, will@kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 pasic@linux.ibm.com, jgg@nvidia.com, gerald.schaefer@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, gor@linux.ibm.com,
 schnelle@linux.ibm.com, hca@linux.ibm.com, freude@linux.ibm.com,
 pmorel@linux.ibm.com, cohuck@redhat.com, oberpar@linux.ibm.com,
 iommu@lists.linux-foundation.org, svens@linux.ibm.com, pbonzini@redhat.com
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

On Mon, 14 Mar 2022 15:44:34 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> s390x will introduce a new IOMMU domain type where the mappings are
> managed by KVM rather than in response to userspace mapping ioctls.  Allow
> for specifying this type on the VFIO_SET_IOMMU ioctl and triggering the
> appropriate iommu interface for overriding the default domain.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 12 +++++++++++-
>  include/uapi/linux/vfio.h       |  6 ++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 9394aa9444c1..0bec97077d61 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -77,6 +77,7 @@ struct vfio_iommu {
>  	bool			nesting;
>  	bool			dirty_page_tracking;
>  	bool			container_open;
> +	bool			kvm;
>  	struct list_head	emulated_iommu_groups;
>  };
>  
> @@ -2203,7 +2204,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		goto out_free_group;
>  
>  	ret = -EIO;
> -	domain->domain = iommu_domain_alloc(bus);
> +
> +	if (iommu->kvm)
> +		domain->domain = iommu_domain_alloc_type(bus, IOMMU_DOMAIN_KVM);
> +	else
> +		domain->domain = iommu_domain_alloc(bus);
> +
>  	if (!domain->domain)
>  		goto out_free_domain;
>  
> @@ -2552,6 +2558,9 @@ static void *vfio_iommu_type1_open(unsigned long arg)
>  	case VFIO_TYPE1v2_IOMMU:
>  		iommu->v2 = true;
>  		break;
> +	case VFIO_KVM_IOMMU:
> +		iommu->kvm = true;
> +		break;
>  	default:
>  		kfree(iommu);
>  		return ERR_PTR(-EINVAL);
> @@ -2637,6 +2646,7 @@ static int vfio_iommu_type1_check_extension(struct vfio_iommu *iommu,
>  	case VFIO_TYPE1_NESTING_IOMMU:
>  	case VFIO_UNMAP_ALL:
>  	case VFIO_UPDATE_VADDR:
> +	case VFIO_KVM_IOMMU:
>  		return 1;
>  	case VFIO_DMA_CC_IOMMU:
>  		if (!iommu)
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index ef33ea002b0b..666edb6957ac 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -52,6 +52,12 @@
>  /* Supports the vaddr flag for DMA map and unmap */
>  #define VFIO_UPDATE_VADDR		10
>  
> +/*
> + * The KVM_IOMMU type implies that the hypervisor will control the mappings
> + * rather than userspace
> + */
> +#define VFIO_KVM_IOMMU			11

Then why is this hosted in the type1 code that exposes a wide variety
of userspace interfaces?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
