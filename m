Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A70EC4332F
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 07:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73CF4606CF;
	Sat, 27 Nov 2021 07:59:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7kZJBLv6WXi; Sat, 27 Nov 2021 07:59:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 54D0E607C0;
	Sat, 27 Nov 2021 07:59:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEA76C003E;
	Sat, 27 Nov 2021 07:59:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C96AAC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 07:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8797401CC
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 07:59:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13im0-GXM_Et for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 07:59:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69A1C400C1
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 07:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637999970;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58Kjh48+rA0mz4yMMMVKby2HPiPhnf/RAdjUHo4rrk8=;
 b=Wjhqm85aXcYC5GLn/pZhrp3OPwiu/dAjoVS6W7S7iCWoJ1x+lmxj1GIo5ENRVK9RI0MZkS
 gtwCHxUJjVXOhrtpSlWRUQ4nHtaYH+XQwvxPR3wp0vE3r2DJLNzvNo74AH40FZaCj6p2lH
 IM69R0ewldSsZU2G82wvXkYDttI88WE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-wN5D3CDDM3i4Du-AyMZYKQ-1; Sat, 27 Nov 2021 02:59:28 -0500
X-MC-Unique: wN5D3CDDM3i4Du-AyMZYKQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 n16-20020a05600c3b9000b003331973fdbbso6670757wms.0
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 23:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=58Kjh48+rA0mz4yMMMVKby2HPiPhnf/RAdjUHo4rrk8=;
 b=rmVW993EbWPQgflMwxNi4WQFE2GgtrWs4M6vn6Yi1WMbDzvQ6wjyYLc9yJTGf15ZNh
 5jkMTHHxmzmjkJMv0t+eFanA+Y3kqQ9r/Oi/EPGNJpSaRUUbhtsGnJ16B6OoN1w4Z8fy
 oBk3XzC4VGHTUzI97zfsVaHuaV6561OeT8r7ycrM/7XoYVc7o8cnxmXLsrVs1iNzssRN
 b8iZSTyZK9Q8UQKjPLf32mvOYqkSL+3xzR9AYcvW3Hx7u1Qs/b2HGHV7OfXFKYUhVq51
 yr6l9ZlJZmA/Y9ypmqr3XX/8Tjmx1iv3i8NJhXReE34X95XF1dlnOtf1Em7Cb/TJ6b7Z
 kDqw==
X-Gm-Message-State: AOAM532FamvM8VvZEm9i1gw+Iwpn0WIrW2rLGuCkaXTwubS3pjev74RG
 N5P1X5T5VkM52fMIay91AZn4T6BXFmReuwFJKV28WXbGvz77qtbXtX1f4bvGYHKPb91xgWH/ZbI
 oc6fV+bLBYM7C1MKdONhE9NR31SaKEg==
X-Received: by 2002:a05:6000:1043:: with SMTP id
 c3mr19152234wrx.64.1637999967651; 
 Fri, 26 Nov 2021 23:59:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoFdzhtbBQJqlr9QWdg9YHontW3Tzr3Rv+AFm3mKY7LUujJNHPKIkOvpyLAG9zOSPSOxJ1Ug==
X-Received: by 2002:a05:6000:1043:: with SMTP id
 c3mr19152225wrx.64.1637999967502; 
 Fri, 26 Nov 2021 23:59:27 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id d1sm7359363wrz.92.2021.11.26.23.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Nov 2021 23:59:26 -0800 (PST)
Subject: Re: [PATCH v2 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org, mst@redhat.com, jasowang@redhat.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-2-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <b9068111-bc1e-cc0a-155d-04585d6f4138@redhat.com>
Date: Sat, 27 Nov 2021 08:59:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-2-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kevin.tian@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

On 11/23/21 4:52 PM, Jean-Philippe Brucker wrote:
> Add definitions for the VIRTIO_IOMMU_F_BYPASS_CONFIG, which supersedes
> VIRTIO_IOMMU_F_BYPASS.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/uapi/linux/virtio_iommu.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..cafd8cf7febf 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -16,6 +16,7 @@
>  #define VIRTIO_IOMMU_F_BYPASS			3
>  #define VIRTIO_IOMMU_F_PROBE			4
>  #define VIRTIO_IOMMU_F_MMIO			5
> +#define VIRTIO_IOMMU_F_BYPASS_CONFIG		6
>  
>  struct virtio_iommu_range_64 {
>  	__le64					start;
> @@ -36,6 +37,8 @@ struct virtio_iommu_config {
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
>  	__le32					probe_size;
> +	__u8					bypass;
> +	__u8					reserved[7];
in [PATCH v3] virtio-iommu: Rework the bypass feature I see

+  u8 bypass;
+  u8 reserved[3];

What was exactly voted?

Thanks

Eric

>  };
>  
>  /* Request types */
> @@ -66,11 +69,14 @@ struct virtio_iommu_req_tail {
>  	__u8					reserved[3];
>  };
>  
> +#define VIRTIO_IOMMU_ATTACH_F_BYPASS		(1 << 0)
> +
>  struct virtio_iommu_req_attach {
>  	struct virtio_iommu_req_head		head;
>  	__le32					domain;
>  	__le32					endpoint;
> -	__u8					reserved[8];
> +	__le32					flags;
> +	__u8					reserved[4];
>  	struct virtio_iommu_req_tail		tail;
>  };
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
