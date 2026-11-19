Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101192;
	b=XlkLROQ9c43iC03+OVbx8op0SVA5Gol43GpVZguhZtboMUul4ICtbKKAfkH8VSy2fPgA
	 sd6HAkCAuHKzSvb9TFuX9PAZPQdupdG5ENcPZkbP+cvCAfrtOfyWvw7Zocj1iHUWOEE0X
	 vpM47hBk61aHUmOCt6a6jTIrV8/FZaFziAh0JoULTskQRexWT9lU4tR/Qg/JLSCPkDM7Z
	 wYO1NV27/uG5KU4wmsTRCYGXPGgEHCdBTHM7s1VvKgwyeL0TyPZ1XnNKBwtP0jLyoz7TW
	 zSg1K7vgkNqWs0fsolkoQd0sbtK/6hJAVUJn0WKdDnxuhxagDkIMFzGKMV5AuISrzew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101192;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=aUaUnGVOD0AnB0qQi2tHlDtmvMhT+a6tdGKKo0EDxDI=;
	b=rLPOOD9LHl2CAUtqR3kb3I/DYZ0siCX4WjjdPJRVUgstD2Wn61barjoSqPGiWGsN5qDa
	 cw7lZSUW/D/71xRaB2zwM0GcSfd2nc3xG+YV97UQuF1XfrLR5QaknxLvH/CWKgub3hRsj
	 bNzySYunqRidrppg08wHDEczpnk7Ix+hBwpwv0CvRrmXmQgWqWjCAq2dxz9T5GEeldbDr
	 qBV+N14eMwwDwZzGY+7w8xVQZ9HGZK7ia+zcR82kDr1E7DF4m1uRs4VZVkQPqKBDFUz+y
	 LhLpFTd83zpZf9txJxy7SK+8QU0DVfC3IWv3XzsQp6/20hAQ7MThc3gw16ouP5r/6Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b7pFSSAx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34860A2602
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D34860A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b7pFSSAx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795101191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUaUnGVOD0AnB0qQi2tHlDtmvMhT+a6tdGKKo0EDxDI=;
	b=b7pFSSAxI+E9EaZtsEfbolehGk2Tu+XE3olI4Vs/ypKruP6HT5txdO/AAW6Kw6DOBoGuQD
	KjM+SJ9zqBvEX0Tf2YD1b2Ppz8GrMZzCjINvDF5x6gQW6ncfqjiD7zXGFlsYZrAVw3vo4j
	GJuplVbUUZPlYyzsJRv6NkbPDFHGjvI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-UUBrjqt_MoaGUKYM-mmXkA-1; Thu, 19 Nov 2026 10:13:07 -0500
X-MC-Unique: UUBrjqt_MoaGUKYM-mmXkA-1
X-Mimecast-MFC-AGG-ID: UUBrjqt_MoaGUKYM-mmXkA_1795101186
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb6bac1e84so16612755e9.0
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 07:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101186; x=1795705986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aUaUnGVOD0AnB0qQi2tHlDtmvMhT+a6tdGKKo0EDxDI=;
        b=QUdA0j2wjw0jy8DmEmTmJQzBAFGkjaZAKUijfBFHK5XQtMY3cTs+3rY7eLTZa6XakM
         3QFE5sxJqQryonNmy1UqCnx/enSraOerXDozRHVRTE7J2ScB0EDIp8NUsOMmI+zCOApH
         VhQgy9cWSfh8AUNmJsEPI/zKi8UNLfhEm0MvLGt74Qi+rcJnbtjcbL1U+XyxQGv2Bv8H
         S2Z+C4+gJv+UtbDrbw4rJ6n5W4viz046m/5WaLlYHlU43COv4qXepWMjW6oHwUpXEcRr
         VZ1sw4SOJGKUZSHOBvzP01HZPoAEk3apdRZwxrhz/7p8N2vrD4R9akhawir3ifxg59xC
         5jBw==
X-Forwarded-Encrypted: i=1; AL+hErFEPDADM07k+oq+Xe3BBg3LxtDv1FuzXPfRkNN5/N0m7zUaCsS6nYSEwpfOJNKdP43hbIhMDw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+esUeNp3xH+HCzeT2jrWETjjAFDXVVf05LCf902NLDfDKrrx3p
	435fCxq28AUP1cxsw25S/U06w/6QiLeNN0SwWUbXZA5gDOcX2Iwr4TYqtn1EAQ3gYzsb7wZxlYw
	asu2Pz8ttlz2/eTvKvYwv6U202scaapan+8ruerloG9bfj95Vg08kmRfq
X-Gm-Gg: AYBFou1Uorwg2HX5zCS3Yj6HX0GaHT7PkTJrq3UaQ8F2gLXVjrrJiR7e4CyveBrQypb
	MuA0piZsD7JgmRsOHgmVbZ5N2fhPVo+q7JCi6JWetUtkoyNYIVHeUpUSUatuIWYIs3DUbptjlZ4
	X5U3SGoR72WROwSbp9U0Bm4qtDiVmqq8TGU8ZbQ1h5pBqE/MeT3FN5tiOKAl8qKhd40fukxxkua
	ldw39EJnHghUYajHXlY32DB9DslE9AywG1Je5A86/KYInA6QABSLfx1RAM6XkUXGWwEKaBTmp/G
	FGFa+d3uqksWnmN3HgoFhgqJwi+45e5PfzWbvLsn7SupxJCw4zvGVWzynRI585ijptAOzP6dJ1O
	KcmX3BEgCze3RhOHS28X8aEgsb+5clzkuxq85/xMFZQ==
X-Received: by 2002:a05:600c:3107:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb7da1272cmr124141825e9.8.1795101185741;
        Thu, 19 Nov 2026 07:13:05 -0800 (PST)
X-Received: by 2002:a05:600c:3107:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb7da1272cmr124141275e9.8.1795101185168;
        Thu, 19 Nov 2026 07:13:05 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm3221365e9.10.2026.11.19.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:13:04 -0800 (PST)
Date: Thu, 19 Nov 2026 10:12:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
	jgg@ziepe.ca, kevin.tian@intel.com, axboe@kernel.dk,
	linux-mm@kvack.org, James.Bottomley@hansenpartnership.com,
	sumit.semwal@linaro.org, christian.koenig@amd.com,
	phasta@kernel.org, joro@8bytes.org, will@kernel.org,
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev,
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
	bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com,
	robin.murphy@arm.com, mason@kernel.org, aesteve@redhat.com,
	tjmercier@google.com, harry@kernel.org, vbabka@suse.cz,
	cuitao@kylinos.cn
Subject: Re: [PATCH 3/7] vhost: account the per-device kernel allocations to
 memcg
Message-ID: <20261119101239-mutt-send-email-mst@kernel.org>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-4-cui.tao@linux.dev>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261106131829.3228926-4-cui.tao@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MMMssY2v6Ph_f9E9LQpWh9VxAaOSXm7uXWYoVcFKDvk_1795101186
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2026 at 09:18:25PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Everything except the worker struct is allocated with plain GFP_KERNEL:
> the per-vq iovec and log arrays at VHOST_SET_OWNER, the memory table at
> VHOST_SET_MEM_TABLE whose size follows the user supplied region count,
> the pending message nodes, and the vhost_net/vhost_vsock device structs
> with their fallback to vmalloc.  The worker has been accounted since the
> vhost_task conversion.
> 
> A container that can open /dev/vhost-net or /dev/vhost-vsock, which
> device plugins hand out with passthrough, holds roughly 150KB of
> resident kernel memory per device after SET_OWNER.  Charge the rest the
> same way the worker already is.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

should each patch be merged individually?


> ---
>  drivers/vhost/net.c   | 14 ++++++++------
>  drivers/vhost/vhost.c | 16 ++++++++++------
>  drivers/vhost/vsock.c |  5 +++--
>  3 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 4570a4ffbab2..bab6597c696d 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -249,7 +249,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>  	/* No zero copy backend? Nothing to count. */
>  	if (!zcopy)
>  		return NULL;
> -	ubufs = kmalloc_obj(*ubufs);
> +	ubufs = kmalloc_obj(*ubufs, GFP_KERNEL_ACCOUNT);
>  	if (!ubufs)
>  		return ERR_PTR(-ENOMEM);
>  	atomic_set(&ubufs->refcount, 1);
> @@ -302,7 +302,8 @@ static int vhost_net_set_ubuf_info(struct vhost_net *n)
>  		if (!zcopy)
>  			continue;
>  		n->vqs[i].ubuf_info =
> -			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV);
> +			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV,
> +				     GFP_KERNEL_ACCOUNT);
>  		if  (!n->vqs[i].ubuf_info)
>  			goto err;
>  	}
> @@ -1344,17 +1345,18 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  	struct xdp_buff *xdp;
>  	int i;
>  
> -	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> +			 __GFP_ACCOUNT);
>  	if (!n)
>  		return -ENOMEM;
> -	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX);
> +	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX, GFP_KERNEL_ACCOUNT);
>  	if (!vqs) {
>  		kvfree(n);
>  		return -ENOMEM;
>  	}
>  
>  	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
> -			      GFP_KERNEL);
> +			      GFP_KERNEL_ACCOUNT);
>  	if (!queue) {
>  		kfree(vqs);
>  		kvfree(n);
> @@ -1362,7 +1364,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  	}
>  	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
>  
> -	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH);
> +	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH, GFP_KERNEL_ACCOUNT);
>  	if (!xdp) {
>  		kfree(vqs);
>  		kvfree(n);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ea127af58ada..d1274106ad5d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -526,11 +526,14 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
>  		vq = dev->vqs[i];
> -		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV);
> -		vq->log = kmalloc_objs(*vq->log, dev->iov_limit);
> -		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit);
> +		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV,
> +					    GFP_KERNEL_ACCOUNT);
> +		vq->log = kmalloc_objs(*vq->log, dev->iov_limit,
> +				       GFP_KERNEL_ACCOUNT);
> +		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit,
> +					 GFP_KERNEL_ACCOUNT);
>  		vq->nheads = kmalloc_array(dev->iov_limit, sizeof(*vq->nheads),
> -					   GFP_KERNEL);
> +					   GFP_KERNEL_ACCOUNT);
>  		if (!vq->indirect || !vq->log || !vq->heads || !vq->nheads)
>  			goto err_nomem;
>  	}
> @@ -2053,7 +2056,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
>  		return -E2BIG;
>  	if (max_iotlb_entries <= 0)
>  		return -EINVAL;
> -	newmem = kvzalloc_flex(*newmem, regions, mem.nregions);
> +	newmem = kvzalloc_flex(*newmem, regions, mem.nregions,
> +			       GFP_KERNEL_ACCOUNT);
>  	if (!newmem)
>  		return -ENOMEM;
>  
> @@ -3405,7 +3409,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>  {
>  	/* Make sure all padding within the structure is initialized. */
> -	struct vhost_msg_node *node = kzalloc_obj(*node);
> +	struct vhost_msg_node *node = kzalloc_obj(*node, GFP_KERNEL_ACCOUNT);
>  	if (!node)
>  		return NULL;
>  
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 0cb87971d749..600daeb05e7b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -721,11 +721,12 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>  	/* This struct is large and allocation could fail, fall back to vmalloc
>  	 * if there is no other way.
>  	 */
> -	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> +			     __GFP_ACCOUNT);
>  	if (!vsock)
>  		return -ENOMEM;
>  
> -	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs));
> +	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs), GFP_KERNEL_ACCOUNT);
>  	if (!vqs) {
>  		ret = -ENOMEM;
>  		goto out;
> -- 
> 2.43.0

