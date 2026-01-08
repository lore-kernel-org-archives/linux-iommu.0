Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751540F8D9
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881521; cv=none; b=iMnsyij8LDZoNCDFvdLLx/a+VpIAMtla+TN4PA1U+hHT9EkpLzuzYIIvL/PVO8I4pxVPD2zG/sHjeSUYsYqN/e7FfZy8MqK3f8FD6HdyH+/QbKmFHazTDaTgMLdX/TwBzY59ct0F2WcAVyuUKXZALMopJHwcxTqaDrsGUFHYy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881521; c=relaxed/simple;
	bh=AFb8yUemGFVP+E1zn7JOJ8f6bE4z7sRVkT9bi0zm4eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nuRtiNluDNFcnMq8o8an56+wzyMkCzcX6gK08bWL0JCgzA+KCHCiiOLaVV9z3oWHyEFYwI/BdFts6yqBfsWgGe2jdXwOXuqXg/DVZeJuT0qt4zn2dxRHSZJ1YiyuP8cMtJi4BWQY6Hy7e+dwHTRM2iZF9wwJZIb0IsHDyja8ohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgtS4Vk6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgtS4Vk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PajL1D9j4AF6hqkkrLXFCZ4j8C7K2WP8fPkzMuDGb9E=;
	b=UgtS4Vk6V6rY72OFl4avXkIA9RzGMp/NFBBcgizG1Fw1T+Gv/i2XjsGWlu2cqPEyHHgb8U
	okeb5B1ChTFY1Tan4NcQjDkCAW/1Nt1SxoOxtzGj++7LjNFfcEzkuWjetilho4tgyMqvBx
	ht6nSYVOB/bjeRu9ENdXLF+oesotHko=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-bOXLNzY0Mti8iwGQJ2-esQ-1; Thu, 08 Jan 2026 09:11:56 -0500
X-MC-Unique: bOXLNzY0Mti8iwGQJ2-esQ-1
X-Mimecast-MFC-AGG-ID: bOXLNzY0Mti8iwGQJ2-esQ_1767881515
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64ba9c07ea2so4537250a12.2
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 06:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881515; x=1768486315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PajL1D9j4AF6hqkkrLXFCZ4j8C7K2WP8fPkzMuDGb9E=;
        b=iErFLhKo4R4xO6VuxrgakvCvJmDk94vg0FYIsZN3GegJQ92IpdaJHqWNcA6LabZPEg
         JZDfSBwZIxBqO8DXh5LvX0kuSFSwdmNCcBqfSKsjO4BqXYYdkz4F1kd8KKMrBkykjO4W
         TGxfx6UVoWLP0n4QOeAdyN6W7awXjS9sUBowZlYNq2WMCuPxQhJTHlNFWNS2tOyu8BTe
         Mzy5PiYS0mpjokfQrrQx7TyQd0M4twgzdmGM8LE6Fw3SQNCzY3rGT43VXLzSILNfxc/r
         rw1RAKQjtjrIGJ6jgehSTPTGfiDr0HDPWbmNM1WmKFQzRwhTdDicn1Ydh4BUOBArpEmV
         VZiA==
X-Forwarded-Encrypted: i=1; AJvYcCWV+/3nYPpdzDt2RomXkPswyKdzvFGIcFYq9F1bJrrAWyU6T3wKJTnrQSiDxuCtgl0TcXlqCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YykdOb40dLYZYKUzjmy+R1lYjiTNoGMTjzkyernTPhZiCzMphPe
	4cGG/QVdcX0RTz1mBqIZiRABvoUZ9qQUxaCYxnnoDI0c85I/czu6afsYSDYyHzgAFWO2rpLt0zf
	pdh/4tI4muImg+HnIMcLE8Iv4iW61JFGz6NelQ4H5tt4PgqQc12dv5ULc
X-Gm-Gg: AY/fxX72Ddzhot06IJ+W5nKuUyTTDcywVURdqdn8s89ofPjCOJ1ZO7NW+Cr2yPs2ZhE
	EblLW83oGv2kj+vekNe3/bu7C1dy/i/IheTCnYx3UJOkCq4dAyrMCJpYAK+pLeJ89C6t2Pl65X0
	XrDeGlPHJIaXG3z8FONijH1pwZT9onVtm3JbG9O7WdP/2a+83H0Vk5Hq2Mx1l6k0Ravdaw7gS8v
	OuaeuMI1rIpghf8VWGVLTv+WCNRauHjtMkUAiFnAgnV9OMGA7QpM+CX0ei3QYjCDon/XcH1ZgGi
	NQQYj02OYRha73FPaoWnLx6SZHhNA3wNRvBkMUtwc6/GZJYgA/Cem45O2qzE97UJzkaXJ28dXm4
	/RRbxagQHuD/NjHN3
X-Received: by 2002:a05:6402:358c:b0:64d:1bbf:954a with SMTP id 4fb4d7f45d1cf-65097e01237mr6010702a12.15.1767881514767;
        Thu, 08 Jan 2026 06:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH4GSSsuHOuOKzAWjnLjL93ZyftULQdKpADud0o+HUDbYN/JI+jAlKmTdijyyr2Y36a7d4Rw==
X-Received: by 2002:a05:6402:358c:b0:64d:1bbf:954a with SMTP id 4fb4d7f45d1cf-65097e01237mr6010647a12.15.1767881514187;
        Thu, 08 Jan 2026 06:11:54 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf65ca0sm7641163a12.24.2026.01.08.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:11:53 -0800 (PST)
Date: Thu, 8 Jan 2026 15:11:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 13/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <aV-6gniRnZlNvkwc@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lmUCJfAT16GdsxU-Jj-kgirD1hHwUOt-aKtfAfjFgmA_1767881515
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
>Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
>last. This eliminates the padding from aligning the struct size on
>ARCH_DMA_MINALIGN.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> net/vmw_vsock/virtio_transport.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index ef983c36cb66..964d25e11858 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -60,9 +60,7 @@ struct virtio_vsock {
> 	 */
> 	struct mutex event_lock;
> 	bool event_run;
>-	__dma_from_device_group_begin();
>-	struct virtio_vsock_event event_list[8];
>-	__dma_from_device_group_end();
>+
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>
>@@ -76,6 +74,10 @@ struct virtio_vsock {
> 	 */
> 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
>+

IIUC we would like to have these fields always on the bottom of this 
struct, so would be better to add a comment here to make sure we will 
not add other fields in the future after this?

Maybe we should also add a comment about the `event_lock` requirement we 
have in the section above.

Thanks,
Stefano

>+	__dma_from_device_group_begin();
>+	struct virtio_vsock_event event_list[8];
>+	__dma_from_device_group_end();
> };
>
> static u32 virtio_transport_get_local_cid(void)
>-- 
>MST
>

