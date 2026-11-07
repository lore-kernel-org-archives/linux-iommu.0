Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794041877;
	b=H/o9FD+/up74m8jjRhDQ8w6VWFEubu2szsQqki4ngSfIfMK3bNSa/7pg8kRKOGKO5aCh
	 MsavHgJ+33DKP6SouQ19UxsNMnEXhpCdNrrlQ8hF9gxuodPwUT/s/MMdAPoLKPvLSyt2i
	 IgRd3GtU91nWu64A3544dBq/MCnwO8y/i13Zjmvy+0Fy4u9tAtLMolKHUs8InuzQ1fjic
	 Lbeu9/kiEcOSTd4QE2v1Cw/T0fo5u32sWQ8Cix5/OBa15rFFN02zUnmnyy56sgk/Ml4rt
	 f/4wMeMZ5cMcU3li2LPqj8bkWJi1E8Qe5mTeTAscOQWoDKMK7T2r8TDS6iRbsMput0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794041877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kw2zLGhVUDQnO5rFq8cwt1gUENr7fOzbT4vb4xG8V9g=;
	b=plbPmDCUilDSDx91kIGjiitFLHRhFlS3eqhUhZLMezR5K1aynqo8+j7T1R0XyYqZUr8P
	 dyHvzYxsR6rXAHFHJvIDr0LUiRzDMXJim9IHrElV1BrnXdCjnUmX2lM1MDYBzQuue6N7p
	 0SCDOt7Q/B8NjS1YExDz1uGOEKU9oTQ6XxEIpUFPSHh4QYFianvMz1kCdIuK9eGWr4Th5
	 gFVZYc4ETg2BK1MvaIwfgyE4dsEFEVa2iq0qQdEgLpa5oWDxdUa93wXu7e+L9L7ECxq5k
	 MpbP3OEwJo9SS1bc7I4A1xAV2YDjZ67TMypuRyAPccJlYct7V3dtBmEqDPTWxmN3nSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yp7ZdRqS;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E2606A326
	for <iommu@lists.linux.dev>; Sat,  7 Nov 2026 08:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E3E2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yp7ZdRqS
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so14989515e9.2
        for <iommu@lists.linux.dev>; Sat, 07 Nov 2026 00:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794041875; x=1794646675; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kw2zLGhVUDQnO5rFq8cwt1gUENr7fOzbT4vb4xG8V9g=;
        b=yp7ZdRqS26hYrv508ns2edhWo9KlCD0rRjcF06iETxGw2lgwDrut4sSq6ZMW1OerXp
         VRc1LR3C8YvYLTzO3p+OmUK26+2B+xu3ulIQrp01TrSyHnglNre2VG7aIQ+emf/jkSBY
         BPu5WbHBBZfAEb2MlxcxCweeM7AT0bxP+MdDwXMiAZrbMwSgfj6m+wD0XSrA+1H4DkK6
         ngbKPvFWFfLMuz3OSPexog6QlZoNytIAU++BHEdnBk99q7JlsSdN49tbeSO6qINge/5L
         dyPowG5xOlvnyW73Nhdoy+FKpREM10GEEMGlCOkdObFGElP66JNcfFhfi8dooM8EdVX7
         e+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794041875; x=1794646675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kw2zLGhVUDQnO5rFq8cwt1gUENr7fOzbT4vb4xG8V9g=;
        b=z7EoLV4zEXlFYkKEYtOkkWD/tAM9HMka5w9La3AUEm2clLCGSu6+mmBz5uggkrbErV
         PhbZFrO0S6w6UReQKHSU7wSx+A8YPgfTeGWVbrZzfpkL/ACwDlXzz8EG9KD4sxeHCziK
         LBKkXvfkyTJeH7aOCND41gB77rAO98tDXD2K1iiNPp1xmsEU1skdTXFbgIiQNhf1ssig
         Xx1u7ssFiY5nBpmgl4c6dbFh/R/Q5Jh/XEI6grsdKKjWc/+d0v02LOIkhJ7R+SUQQhLN
         NiEy39CEj0sn//wV82TzwaDcF8nF0X80/peCbZ/R2hrJx3iAfwoRPhxJR6izbeaUvb+I
         exgA==
X-Forwarded-Encrypted: i=1; AKwUvBxBCdIFeHuSmtg+K3LDZmszUy23fzm0+DLQ2YCErrhZNGfMsCgJhJYm6E7TAOMYkNFo5BQmfw==@lists.linux.dev
X-Gm-Message-State: APuU4Z97hCdLoBBwqbldIcZf4z06hWgcXUd/fqujLcrNqcTsGylDBtRe
	GGNN8KUXpoQtRU1SCh4+6cbDgtYcY7e2YkZ3eZVyImSh9WmtcF3Mngk7
X-Gm-Gg: AYBFou1FpJh8zQi5BnwTUOPfnCEGN3tgOpphIdCWwD9EoDOp23uYa5lCdah6ITicrCM
	wvmXTIK4s8r4Z/lAqFXpCUqUOWM/7wGpL+2BwpFSp7QGnW8d7TPPm5erMdLGvmlFr7/9SyK/DJj
	QUW+YOQY5Cencz1HnB6CVdwQWkWgleRITIykX2RFQj9Mseht1UIXToBji1QLwlyBocNMd6ID4fv
	OA2t8MJUtCOkk9kFn0xgL2tAKM5zz+4OqHCvLvUIBaip2C/brVbsTYa6RK1GdkX4Qz+/Kp/Dp4C
	zF+sjvXH+9IdyG/yKxFxC8VdcqHRYQpATjtzKz8jOwwm7syPb1MiW54xFu22/WX+7jKdCyb2/pG
	6rx0QWsL3z6sC9DdYGrkHbA+bUBCio9fhJidbVOWnlbE53h2U9d1U6R/N0+nr/Aj1Hu6vqDwGKI
	OAkiqajw6azPJoNKrqzZ8q5Wr+lxS4PZWnwWyEEqG/0KC1lb1bx+OFbNvLI8A4ZXK1hqSaLF4bc
	vVh1kRMND57O8/PFEdgo6yD55FNPx6bBzBz1SA9TSCaO/1S7oAkQqrvsDPx242ijYSFc1YRQPw7
	QrI96yR4TQe6uWhhE4Gufzpns0uBlB3v12QQJZ9D2l7Ffm8U3Ye7s09EBDoRr8qu0CuTGz/cag/
	kNhre1A5ISTrfpGdFEmRRdWYcgTfmGcnHuWJpqbz3uZKJP38g/5eC6I26ToBDzMb1
X-Received: by 2002:a05:600c:a015:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4b6df028f04mr88902585e9.14.1794041875269;
        Sat, 07 Nov 2026 00:57:55 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-095-114-115-226.95.114.pool.telefonica.de. [95.114.115.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7701af6sm8597238f8f.38.2026.11.07.00.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:57:54 -0800 (PST)
Date: Sat, 7 Nov 2026 09:57:22 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Matthew Brost <matthew.brost@intel.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org, 
	iommu@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>, 
	zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/23] dma-buf: Let the exporter select mapping type
 at pin/map
Message-ID: <au7mBMbRC8q6NILj@gmail.com>
References: <20261105-dma_mapping_type_v4-v2-0-78b8dc9ae80a@nvidia.com>
 <20261105-dma_mapping_type_v4-v2-6-78b8dc9ae80a@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-dma_mapping_type_v4-v2-6-78b8dc9ae80a@nvidia.com>

On Thu, Nov 05, 2026 at 05:40:41PM +0100, Alistair Popple wrote:
> + * A pin or map that fails after dma_buf_mapping_select() may reopen the
> + * choice only if it was the one that made it. A selection that predates the
> + * call belongs to a live pin or mapping and must survive, otherwise the next
> + * pin or map would reselect under it without an invalidate.
> + */
> +void dma_buf_mapping_unselect(struct dma_buf_attachment *attach,
> +			      bool was_selected)
> +{
> +	dma_resv_assert_held(attach->dmabuf->resv);
> +
> +	if (was_selected)
> +		return;
> +
> +	attach->selected = false;
> +	attach->selected_idx = 0;
> +}
> +

After dma_buf_invalidate_mappings(), attach->selected is false while
attach->selected_idx still holds that mapping's entry for a pending
unmap. 

If a pin/map fails before that unmap runs, was_selected is false and
dma_buf_mapping_unselect() resets attach->selected_idx to 0.

A subsequent dma_buf_unmap_sgt() then uses matches[0].

>  int dma_buf_pin(struct dma_buf_attachment *attach)
>  {
>  	struct dma_buf *dmabuf = attach->dmabuf;
> +	bool selected = attach->selected;
>  	int ret = 0;
>  
>  	WARN_ON(!attach->importer_ops);
>  
>  	dma_resv_assert_held(dmabuf->resv);
>  
> -	if (dmabuf->ops->pin)
> +	ret = dma_buf_mapping_select(attach);
> +	if (ret)
> +		return ret;
> +
> +	if (dmabuf->ops->pin) {
>  		ret = dmabuf->ops->pin(attach);
> +		if (ret)
> +			dma_buf_mapping_unselect(attach, selected);
> +	}

dma_buf_mapping_select() sets attach->selected = true before ops->pin()
and the map callbacks run.

In patches 14/15, xe/amdgpu migrate a VRAM buffer to system memory
during pin and map when the attachment does not accept P2P.

That migration calls dma_buf_invalidate_mappings() and clears
attach->selected on every attachment, also the one being pinned/mapped. 

When the callback succeeds, the attachment stays pinned or mapped with
attach->selected == false.

A later map/pin on the same attachment can then reselect without an
invalidation.

Thanks,
Karl
