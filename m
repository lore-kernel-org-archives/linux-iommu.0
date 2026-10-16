Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF033D813C
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792182432; cv=none; b=tThwiqlQS4YqY+7+Xl7OE97oVtaBhFJWG3Bf1MF1Mkhw/jMNj7mhg/fAm5EYUBf0oREpTgtavVbjysImjGJEWwHa6iJl1K/lfKVa4HE4uyi/bzIxk5c1+sPdoPkuRmq5iape5YHzFVDAd9rh9w/lOtCAzbaKrvb9/hdVr1i3uxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792182432; c=relaxed/simple;
	bh=y56vd30Wr7TcmwqX+oaJan1jX2dTu657n7x+TmtkUhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YoH8MswMxPK0Z8uewjwkP/7CfqcKuCOQzkHHJYgxaRVYV6GTSAhadU9gK8ENHUo0wWIZLtyWWP9TEiBFByae7V+Rhzk2Vth/+Mx8f7Krr3HR4DqN8MTqykEihF2ExPaLzX0Kz6krIrHITh9FyuoJVnaGzlAhLRboSEqsDJDjMiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVq9q5Yn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVq9q5Yn"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso3039045e9.3
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792182429; x=1792787229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jqtp5LPxF0IFxOJfCVzAQN6SnoPJKqsXWwttpYr3O58=;
        b=oVq9q5YnxDjFcK9cz4VGUa7dYTiMRAazpCcOzC3lATSjne09kGq/ZcAvOsUl0KeIJ7
         o/irQL6/Ws7BQB/xky3xGaTL6A614BhYdeocSMKmJXhRIYUxz4y1W0Z33MPXLYHxGHeW
         I37m12YQBMKX0OjA+qd/mWrkfIe/8Rgy4rfgkwEQeQQSbLeVPbl8DrGHqMOlqaX3M6wG
         AEgZ37L5mm1NBdHibAGPjWHiabOEymVBUMYoiTezjkPMLVDJKOGsSGSVkxXLhyrXskPb
         YxwbIKCiZtkPJuVDdr0j0IGdC7XN+lPYEwdPK1L2FLRncG5v+TJCqarDqzdMMS4xR8/U
         uFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792182429; x=1792787229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jqtp5LPxF0IFxOJfCVzAQN6SnoPJKqsXWwttpYr3O58=;
        b=VaTzPBP2hHBDofF340PS+cFTiyB3D4ifD0Rp41mneXbMbpHvT+8xJ7IFlYcoz0eI1L
         jq9As8gshw0cYVD5WPEPVdbC5+dDiDY7KEB2HsvC8kUcH+M+OUhUtF4AhS9YHV+AZUUP
         +jSjLiCU1iBEXPqLC/qDstjxR4eljYQz11l+xuS0mpAEpDfUIoMU8lh8Pr3Bn8g0WgsR
         KP1ntFcnQVLjyoOCboMTpaZ69d9kMRzEEIYSb3LqTZ64o3eAlozziXIqOYnDfFQ2/tt2
         1qO1L476UIvPEYDHAUMjalIuMRwwiMdQWFo2JMOR6gWMSFpj7r2hFeHrDAn8G5/iT+1E
         57Zg==
X-Forwarded-Encrypted: i=1; AKwUvByHwoPbfJgGpm9ydYdZo+UBT2cJqRjbw0WFGjxNqph8dmHxwoxtrffqPdkKRjSbE7K2fCNpVA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJTca3rCW+KafN3ux9upobdtyBiyteANan5/9k3VM00SNNjUUM+
	Tt3b5VtJOjXGCDy+YQqHQUNrv0opksncueKruDgPc/IdUCOgK2ZFqxy6
X-Gm-Gg: AYBFou1GceQjSEJ4IzprHCDuaEFP7q2T3uC9530/bqEQkLXrfCnzklSmjH0gvaISsnr
	ZpXiVLdSLS9+f2gwEPYjqJSIuvjWcDyLL80WQxPKo98HMxVmuKcv1A6gE1LKD7/FtGM/5VMcUjC
	XJaN3jIlt/ySYGZysFVk1PRsXTgul0+pj96feqYnMm4GejQpG8BYPrWlvVeaA8ktqls4WRo1J0H
	bWsWN6XSbN1KxV7k7GXmpMl9oDy/KOmpb1MU+hr6APqOGTZ/D6asNASao80ZnwC4xYSzP9DqDo0
	LPiuSFbippOI4Qd5aZnB/zmltQu4JD0dWhoSTUn/EuEJBLGm9eLtFTzg7Dl2DeBZRQcjhSMbmiX
	ZtDV0nu4SFRepYkZyYKk+VG4M7imm4k9joqm+xAxINImaxNce+jJ/kZ1Ooql5Xdvub4tKcIlhCV
	Ay9oDlJGsEErpk9D04pCjqamjfbxqPQkq0GhRFddxnO4H59tCbK/3t+IJUu8qSShTY85+gjTw5T
	l2ec8vYk0qlhUBYmm11gzA3bTQzTO9Li4ebSDjdCnJF4T2f93/5Tub++hf+JV4ChRlRNRQB4W7t
	r+grbryHf+1IF6lrI9LoyCxdgdejXHydUvmOzhHOK4LyiQR1Nd6/2XKHyRaj30258hYA1UAX+TU
	Hdw==
X-Received: by 2002:a05:600c:1393:b0:4a1:d248:25b5 with SMTP id 5b1f17b1804b1-4a1d760e327mr19553895e9.24.1792182428699;
        Fri, 16 Oct 2026 13:27:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a951-9501-1471-d90c-a21f-9dd7.310.pool.telefonica.de. [2a02:3100:a951:9501:1471:d90c:a21f:9dd7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d7659805sm22421075e9.7.2026.10.16.13.27.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 13:27:08 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
Date: Fri, 16 Oct 2026 22:26:53 +0200
Message-Id: <20261016202653.97339-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com> <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Feb 17, 2026 at 08:11:34PM -0400, Jason Gunthorpe wrote:
> +	match_args.attach = attach;
> +	if (dmabuf->ops->match_mapping) {
> +		ret = dmabuf->ops->match_mapping(&match_args);
> +	}
> +
>  	attach->dmabuf = dmabuf;
>  	attach->importer_ops = importer_ops;
>  	attach->importer_priv = importer_priv;

I may misunderstand the intended contract. match_mapping() runs while the
attachment is still zeroed and without dmabuf->resv held.

Patch 11's amdgpu callback needs importer_ops and importer_priv, so its XGMI
match cannot work here. Patch 12's VFIO callback asserts dmabuf->resv and
reads priv->vdev, which cleanup changes under that lock.

Should the core initialize the attachment and hold dmabuf->resv for
match_mapping(), or should callbacks avoid attachment and lock-protected
state?

Thanks,
Karl
