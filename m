Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05A155A5D
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676140; cv=none; b=U1zwz3V4fSaSDJVFUZ58n1V1N/hVvloyyfNrSG94OMJML7MZRykWfGxLLXJRfXG4sn95JoYoycORjdnVT2VmOj9YCc2UlcAPexghdQyHbaSp55tF7YC53fKFu/SwqBOaN4PXepiuBEPodR0aq4plzp+1OGYSQziCgemH7c8thKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676140; c=relaxed/simple;
	bh=Bs6mTjUeA5qkWiBJBxqsJFMQQCY3VsRZlZa2vBfNivk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kswUXfUFtF2IbqU01zCEXvhsAWdj+R/50xh5vb3wdLSxQHxUW2HY2Ts2n2DiY3jfdI8fJ2fFhgMYPss3O668cZrVk6GMuttGTVbRrE8PlCvIjZOLwH5WhNHLlCQPHTQMnbceGOEyxTBDIE/KB0FpkuV1Qr548G3XeeQ+pYVNOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWMB9joG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWMB9joG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769676137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=THtu/B0OMAesHMQ0Tb4jSeVco+ToRrfio4hfGUipZDw=;
	b=VWMB9joGXYC7p4SXDrqZ3kZ3eOqnv+1+GtytduFRo7jVG9Ybe1PWzU0Bt8QeKVgfkfWdz6
	zmGDLVMkEvnLW0E9bRuhO3BQN7RGMB8HvHXXW10KrTRrtR3xoELejQ01NarfC09UEGnnFN
	zyLUAx/s2WOiULXH4ByRf/0obMLKfDs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-_okSPxzSNOu-P0IUP21bkg-1; Thu, 29 Jan 2026 03:42:15 -0500
X-MC-Unique: _okSPxzSNOu-P0IUP21bkg-1
X-Mimecast-MFC-AGG-ID: _okSPxzSNOu-P0IUP21bkg_1769676134
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso399629f8f.2
        for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 00:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676134; x=1770280934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THtu/B0OMAesHMQ0Tb4jSeVco+ToRrfio4hfGUipZDw=;
        b=poG/V4UCZvyuh5lZgu17+JJpd7QVua15E/eOO3tDLalvnhsNQnv4qL4P8N8KiTXwPM
         Xso/hORJa2DwB0iQ5xy5DcFSwrUBcQS5LJXfzN6F0u5TsGdFV2ZfMuoEvGxRePO4PRFf
         +QbpKuReQ2JiLET5qzUZsZWHZGLLkFXq+k6I0qvVBz9LKjlo5gz1eoUOIwMDIGZBoFzV
         A3+k+W/9eLrzE3nqJXb5gtSov19Xf5ofDIxX+DJmoUwCBCvWcf4cTRKiVS8dK2Kf/iW+
         Fr4BF/XlFBQCGozRIRSBZRopiHwMeln54D2YWyjajF5/pZazDarO0zn6n7l/VJSKyD3y
         9rDw==
X-Forwarded-Encrypted: i=1; AJvYcCXjmqAV1mYaGTlCHUzEpYMwtAhIDafs0ZtpiIASmrNKoMsoeJoMTj5M3ycxqMlaJVLb7ynxIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMfTxqnMfzH1dK0D0MoLgq3NBIIycyk02zpKvwUsM7ep5hI0hO
	+4feZFK9J+RiGh5G/s8XyeKD9UmgfHM4MRT7bdgwqmyO3e1rTLg4MD2g+MWAm/P17tlJPrZfTyF
	kCdc9oJLU+jlAKYc8fG50r2Nobf3n6Qj9FdhNdoWWlSXFCVX+8MZKvir9
X-Gm-Gg: AZuq6aLBfM4SkcuPpFKxCnaWF7IMWPB3BYG1MsowqSRjAKyuQ6+2MKpP/UyHqpzXw0V
	+vbu+P/rlbwdJU9+x2GWLzWy3CHmdymTds1TFsADlK1xXs0CpJ97+O+IOWHQB+Xn6w3578nuJ3p
	tFVEvYU5AHN4TdzFmeVWgJXgPn0hwrVeu3ZPVYPfXFnnlOiRB7L6qJT0QWREdqy93RlpUIZZ+pN
	FAwIadloVM5CwQoDYkCEshorZWTNJENlh5scNKxiUuQlCHXinFX6IOmPCTpXWx9XZ23zICbPUDp
	S7hTUitrBfy3xIFi1kpr2a2nIQj4YmK32iQY5+4eZTpyV30WzCe148A7r/yqWwYcBzjak7StXsh
	odt6fDQcehY3tMCyGVnNe4FV/L+UyU2h3KXUF00GAM7ZHT2T2Jwig
X-Received: by 2002:a05:6000:178b:b0:435:9116:c713 with SMTP id ffacd0b85a97d-435dd02db27mr12237788f8f.5.1769676133911;
        Thu, 29 Jan 2026 00:42:13 -0800 (PST)
X-Received: by 2002:a05:6000:178b:b0:435:9116:c713 with SMTP id ffacd0b85a97d-435dd02db27mr12237753f8f.5.1769676133482;
        Thu, 29 Jan 2026 00:42:13 -0800 (PST)
Received: from sgarzare-redhat (ip110-139-192-82.pool-bba.aruba.it. [82.192.139.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm12807318f8f.11.2026.01.29.00.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:42:12 -0800 (PST)
Date: Thu, 29 Jan 2026 09:42:06 +0100
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
Subject: Re: [PATCH v3 15/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <aXsclvInQFIuFe5i@sgarzare-redhat>
References: <f1221bbc120df6adaba9006710a517f1e84a10b2.1767601130.git.mst@redhat.com>
 <ce44f61af415521e00ab7492aa16d3d19f00bd5e.1769632071.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ce44f61af415521e00ab7492aa16d3d19f00bd5e.1769632071.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vSjceHxJ9h7-iWTvOi7mluIyuoAbmoRiTfwyQjZlfqU_1769676134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 28, 2026 at 03:31:21PM -0500, Michael S. Tsirkin wrote:
>Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
>last. This eliminates the padding from aligning the struct size on
>ARCH_DMA_MINALIGN.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
>
>changes from v2:
>	move event_lock and event_run too, to keep
>	event things logically together, as suggested by
>	Stefano Garzarella.

Thanks for that!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Note: this is the only change in v3 and it's cosmetic, so I am
>not reposting the whole patchset.
>
>
> net/vmw_vsock/virtio_transport.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 999a0839726a..b333a7591b26 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -55,15 +55,6 @@ struct virtio_vsock {
> 	int rx_buf_nr;
> 	int rx_buf_max_nr;
>
>-	/* The following fields are protected by event_lock.
>-	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
>-	 */
>-	struct mutex event_lock;
>-	bool event_run;
>-	__dma_from_device_group_begin();
>-	struct virtio_vsock_event event_list[8];
>-	__dma_from_device_group_end();
>-
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>
>@@ -77,6 +68,15 @@ struct virtio_vsock {
> 	 */
> 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
>+
>+	/* The following fields are protected by event_lock.
>+	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
>+	 */
>+	struct mutex event_lock;
>+	bool event_run;
>+	__dma_from_device_group_begin();
>+	struct virtio_vsock_event event_list[8];
>+	__dma_from_device_group_end();
> };
>
> static u32 virtio_transport_get_local_cid(void)
>-- 
>MST
>

