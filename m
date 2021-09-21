Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB7BC43219
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 16:16:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287C26109E
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 16:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 287C26109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19951402B8;
	Tue, 21 Sep 2021 16:16:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fg4eAjoU_yRn; Tue, 21 Sep 2021 16:16:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EDDFF40330;
	Tue, 21 Sep 2021 16:16:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6303DC0020;
	Tue, 21 Sep 2021 16:16:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33AC0C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 16:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23197402FF
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 16:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRCpEorXrKXx for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:16:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55CA3402B8
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 16:16:34 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id d6so40653078wrc.11
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+CTxDiEkqYMWmqQPeOUmYqmKLKbBDgvYPDzOPQ78M/0=;
 b=h/rwkqxZm7jxTW5tYuKGJvhiOpQKscVTAw6so0UV+1eUyfAc9/yjPN/ZM3WLbY8iwh
 65iYfaYWcSfjg2hGOG+518L7lt/uPjiGa1WRVMOOZUl/YG+Kv05PAepY1+nrs1KS2p8L
 pyePyNyB8emOr3i+5OC8ycyenvzVyyPaCiWTJIrroJ6Jzlau/5oClySBRLY4LjksIU2D
 SI9hiFZMaa2E94FcUFlIUv/fDiVuT8NrrDMPbdDhS/JXqfoC7Njba6pNwxKWD461Q7E1
 J11em3q6lY1YGQ4L5UDGKU+db6rcp+4NggWADyFIHJsFq7ETh6XGhc9MashKivzDQdWI
 nmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+CTxDiEkqYMWmqQPeOUmYqmKLKbBDgvYPDzOPQ78M/0=;
 b=GIPPJqdmIIr8UrSk0+gkOLmHXmWtlOPGOSep0udB2F2jxhtNcMlufzZZ9FbMjo66RM
 3DP6MtcS5WckQDsn3hxBDJjkIPEmbGiVd3Wh4+C+V05dvGR1X0b9twbKQyg4fc0vh2HA
 wByMdwBUULH7xY0sKEfiOqHs+xifaDTBJQIVpPSYSBjNoTOmvJYfs3f5lnI9qEgAcTsK
 XCOeaB+v0T0GaS/Cfds9HImesfURy9+tAY7Ch0n55DEOio1qxaIqnvOSuXYLOpv9sJEK
 5FIfeFOnY1JmuyWrBXPZj26BuHVJ/DfFU4+4Gv3lXMSkcBDFysjMIUsMk2xpD1NLSJDY
 CQgw==
X-Gm-Message-State: AOAM533TjllMmFFTYzDAW5I1GZv1zc6tD9ZpibrcwntB607hcuTbF7hP
 O5zSJg8ufVPqtrspgxiQ8DnpYw==
X-Google-Smtp-Source: ABdhPJyYy8Ov1VUqZi4K/daddChZpP5kpZm/UL9IHwusTYbuOtsRpmrZUam946gjF4u3xlJ0JlVyRg==
X-Received: by 2002:a1c:7f11:: with SMTP id a17mr5602673wmd.166.1632240992327; 
 Tue, 21 Sep 2021 09:16:32 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id v10sm20755353wri.29.2021.09.21.09.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 09:16:31 -0700 (PDT)
Date: Tue, 21 Sep 2021 17:16:10 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 10/11] uapi/virtio-iommu: Add a new request type
 to send page response
Message-ID: <YUoFSrAK2gi3GWp/@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-11-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-11-vivek.gautam@arm.com>
Cc: kevin.tian@intel.com, mst@redhat.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Apr 23, 2021 at 03:21:46PM +0530, Vivek Gautam wrote:
> Once the page faults are handled, the response has to be sent to
> virtio-iommu backend, from where it can be sent to the host to
> prepare the response to a generated io page fault by the device.
> Add a new virt-queue request type to handle this.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  include/uapi/linux/virtio_iommu.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index c12d9b6a7243..1b174b98663a 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -48,6 +48,7 @@ struct virtio_iommu_config {
>  #define VIRTIO_IOMMU_T_PROBE			0x05
>  #define VIRTIO_IOMMU_T_ATTACH_TABLE		0x06
>  #define VIRTIO_IOMMU_T_INVALIDATE		0x07
> +#define VIRTIO_IOMMU_T_PAGE_RESP		0x08
>  
>  /* Status types */
>  #define VIRTIO_IOMMU_S_OK			0x00
> @@ -70,6 +71,23 @@ struct virtio_iommu_req_tail {
>  	__u8					reserved[3];
>  };
>  
> +struct virtio_iommu_req_page_resp {
> +	struct virtio_iommu_req_head		head;
> +	__le32					domain;

I don't think we need this field, since the fault report doesn't come with
a domain.

> +	__le32					endpoint;
> +#define VIRTIO_IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)

To be consistent with the rest of the document this would be
VIRTIO_IOMMU_PAGE_RESP_F_PASID_VALID

> +	__le32					flags;
> +	__le32					pasid;
> +	__le32					grpid;
> +#define VIRTIO_IOMMU_PAGE_RESP_SUCCESS		(0x0)
> +#define VIRTIO_IOMMU_PAGE_RESP_INVALID		(0x1)
> +#define VIRTIO_IOMMU_PAGE_RESP_FAILURE		(0x2)
> +	__le16					resp_code;
> +	__u8					pasid_valid;

This field isn't needed since there already is
VIRTIO_IOMMU_PAGE_RESP_PASID_VALID

> +	__u8					reserved[9];
> +	struct virtio_iommu_req_tail		tail;
> +};

I'd align the size of the struct to 16 bytes, but I don't think that's
strictly necessary.

Thanks,
Jean

> +
>  struct virtio_iommu_req_attach {
>  	struct virtio_iommu_req_head		head;
>  	__le32					domain;
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
