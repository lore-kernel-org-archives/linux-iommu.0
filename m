Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCB6C2BB86
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 13:22:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5638C20692
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 13:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDLc1NYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5638C20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1E64620400;
	Mon, 13 Apr 2020 13:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TFjFu7Trvi7K; Mon, 13 Apr 2020 13:22:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1A23A2000A;
	Mon, 13 Apr 2020 13:22:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 020E6C1797;
	Mon, 13 Apr 2020 13:22:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52097C0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 13:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 40D8A878A0
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 13:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mAzQZ6tU6cOF for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 13:22:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7F9618666D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586784152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0PdiEszlmuGkdCTdCPanAdeTLpgTEN2jG8uLZ7FuSm8=;
 b=hDLc1NYKVNGeycguxmXSYnt67NmWEuCHfRwdSB+lhculE6vx3eN90MX/Mp8yMax7j5ox/t
 R4NL7NN1HHspEEhPnF3PC8x0syrVKMmwETDuO3dPBQ6RA9ZUNMBhXDgOlbF4I/GPNtU+rc
 2MRJT+6ozvgqipLN5wjErDxBLJVpEJM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-E_2yA9pmNUaccu4kyrTYzA-1; Mon, 13 Apr 2020 09:22:30 -0400
X-MC-Unique: E_2yA9pmNUaccu4kyrTYzA-1
Received: by mail-wr1-f69.google.com with SMTP id j22so6726683wrb.4
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 06:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0PdiEszlmuGkdCTdCPanAdeTLpgTEN2jG8uLZ7FuSm8=;
 b=qKk2FsH1CA/XG9lOWJsMaliEf2J0XYBdDnYknF1Hj9dnCzf6EZNNVqWE+dC9GVqXpZ
 kFzhcCFcJo3efhU9Z9fYSz7GuCTpEYcMEVQZOlG3oWUhrwKVpDqogCAuI7RHrqXfETYG
 GAxPezRKgz71gCBR8aTWAQPlJX2fAOpjotRSO7r93ytjaYrm69gpX1FV6tITnlQ26TfP
 o3XM3sYHPQkdkShZO92QWF9J2L47gliuS85UEwoSdweRHhwyrNoAeyGknIp1v28kWYJq
 buY5GuVtDZjyghxoU3jgacgzQOwC3eCRsgYKoSIISDyehgDXzSn1dqwPKZprrJq03te9
 IVcg==
X-Gm-Message-State: AGi0PubAMKa2FyHbTsiGFwTPSiq/f4tfYSfVtbGWeEh+fm8q0SHRab7S
 Fi9il0Pm29HGH5OlsdJQdo+kjJ+5rK1vocjXvNSSdrz0ILmQZyl2caivcIlhZBRN5ipVidIg8LP
 viMnJzNzesxD6NFiHmLqXvPp3ZM4HGg==
X-Received: by 2002:adf:f343:: with SMTP id e3mr10209312wrp.51.1586784149299; 
 Mon, 13 Apr 2020 06:22:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJEAGSwrzL3vQ67rkOtqT1/sfEwf7eMuRq2HTHdDqkOFbKnqIPy+fW8j5vivRuXTGBlXzeIlQ==
X-Received: by 2002:adf:f343:: with SMTP id e3mr10209287wrp.51.1586784149081; 
 Mon, 13 Apr 2020 06:22:29 -0700 (PDT)
Received: from redhat.com ([185.107.45.41])
 by smtp.gmail.com with ESMTPSA id b82sm15672990wme.25.2020.04.13.06.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 06:22:28 -0700 (PDT)
Date: Mon, 13 Apr 2020 09:22:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200413091355-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200228172537.377327-2-jean-philippe@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kevin.tian@intel.com, linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com,
 robin.murphy@arm.com
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

On Fri, Feb 28, 2020 at 06:25:36PM +0100, Jean-Philippe Brucker wrote:
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..ec57d215086a 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -16,6 +16,7 @@
>  #define VIRTIO_IOMMU_F_BYPASS			3
>  #define VIRTIO_IOMMU_F_PROBE			4
>  #define VIRTIO_IOMMU_F_MMIO			5
> +#define VIRTIO_IOMMU_F_TOPOLOGY			6
>  
>  struct virtio_iommu_range_64 {
>  	__le64					start;
> @@ -27,6 +28,12 @@ struct virtio_iommu_range_32 {
>  	__le32					end;
>  };
>  
> +struct virtio_iommu_topo_config {
> +	__le32					offset;

Any restrictions on offset? E.g. alignment?

> +	__le32					num_items;
> +	__le32					item_length;
> +};
> +
>  struct virtio_iommu_config {
>  	/* Supported page sizes */
>  	__le64					page_size_mask;
> @@ -36,6 +43,25 @@ struct virtio_iommu_config {
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
>  	__le32					probe_size;
> +	struct virtio_iommu_topo_config		topo_config;
> +};
> +
> +#define VIRTIO_IOMMU_TOPO_PCI_RANGE		0x1
> +#define VIRTIO_IOMMU_TOPO_ENDPOINT		0x2
> +
> +struct virtio_iommu_topo_pci_range {
> +	__le16					type;
> +	__le16					hierarchy;
> +	__le16					requester_start;
> +	__le16					requester_end;
> +	__le32					endpoint_start;
> +};
> +
> +struct virtio_iommu_topo_endpoint {
> +	__le16					type;
> +	__le16					reserved;
> +	__le32					endpoint;
> +	__le64					address;
>  };
>  
>  /* Request types */

As any UAPI change, this needs to be copied to virtio TC.

I believe an old version of QEMU patches was published there
but I don't think it was the latest one you tested against.

Description should preferably be added to spec too.

In partucular please add comments (in this header, too)
documenting the new fields, values and structures.

> -- 
> 2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
