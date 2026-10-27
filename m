Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067370;
	b=ewC6INuAuTv9sUjgw6EgbKi1YFvMGbIx2m7IEU5qf1dp3AWF9p1AWPERqr/BAMv7FgN/
	 w7JzPEbVhReU4cgc6633Ufr2sIa2zmLS8IN7WRE2V5UxmS1bagwIJ7Sy08/1oy/bVTLjH
	 LUK770IjADUXudUYTaXjsg6NZPym3XXttX6NMuKrv1xwui84Kcd9XTmzH/nHdxGMhI5W1
	 T0B0spl9gv59Ef+itP8941ewLFoaOMfFTy/iK39uG6mfXM1uY9NV51NAtem9g4TCgrqUT
	 h6Tu5rSUhONwf7HUOqHeyKeqRCvlVe6Q6EcOMBrfWpHIp+nVT6qQDETRcFeJLgd7oUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=213hVxaY8zz7NJ3gzXzSYUeeO0Hb0kJ1MH6CZUy6aio=;
	b=FMrpWSPJqbGUty02UGWOe7RxCS7lsnfF0YZb8HlZoqaBWimABC5VEPzJTIi239UXrjB+
	 D7P+JNoTywK5gzKJbYAHhFMDj4n3Vn9zD6h6LBMW/LEgyDzjxeheZYZX764Waf4VwyAOk
	 KyrWJKkhEQi1HaV6wqHUdpfehLOiLZBvHrst/SmyRcSsVZwVabWOFVJSDY7n/YPWutSbt
	 cr/TnlkNKFFO2YSX+qL1/8YKePRLRnScvGhK9mlMDzsOguemjzZlpG9w2LVUYvmLFZ+Um
	 cp15ThVSTHPpUncy2T6PZVC1Iknn9vD0LpgfRf+LmMPkvznAWoTzQWU5L9Sc9GhDx4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ENLEJKgC;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C29606A320
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 02:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C29606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ENLEJKgC
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso2159576f8f.3
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 19:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793067368; x=1793672168; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=213hVxaY8zz7NJ3gzXzSYUeeO0Hb0kJ1MH6CZUy6aio=;
        b=ENLEJKgCWoP8HKcjwyg8Asl+qzI+53URFkUzSk9wYsRyDzNcdBZfXu5u/4uNbOR4Wb
         DfLlixxfoj536Oad26a0/pqhOlszgLNLuY5OboV0HRAVndFymxLGiZvUNJZxn72vhhma
         +8t5sj2Cel+A95k+sevPTG4/Y8kNpELrLa2XdT3dMF3pjzu5QdBbZOrv6PTUnPAtF/sQ
         1XpFUF38zzPZI6ZyMpVIcZmQZ3i/hAy2AXLtGbKeUENCB6LHyGJS9F1IDj0ePNpqdZsg
         yRG1TT6vLDZI9cqGRX6738wZCwbSce6NdYBRms9TUNwBLxpfLf5KtSxpq68qubn0qdqA
         yhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793067368; x=1793672168;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=213hVxaY8zz7NJ3gzXzSYUeeO0Hb0kJ1MH6CZUy6aio=;
        b=tMFc58g2nIvuNj/EDTTNLFr0GbQqzvO100Efe6LyeQqKAwyyXmpIW15xDq7hpas2a3
         QQf86LPshezuCaF5D96M5WI7ndfjap9sotWxhRrO/+WED3ELdhDGdnBaUY9XXNpCtNfn
         VAWVZaA7zssBnGLSeHGm/fBMvBLj9WEiqv/KP6URwpgaaDAR6wGSRVXk8JqU0odlv2Dq
         nNwyR4iD4OXgzlzJGDA5Ui4MdpBG7B/oUMmyVPw7iIyjmsc5XIQe1Et3voljUU5kTuGY
         Lk5DQrS3Ok8Q8z2PlzXQ5xf9GjjJZ5YNzLBO2W3LY2X2qqtbZjYOGpWsaFueZbRBZoh+
         b5LQ==
X-Forwarded-Encrypted: i=1; AKwUvBw99+XiaeN+QNes+fzHzvi7K4Y0dR8ZiH2PcoexqqBgr2KnlYNH908zojbjxBx6C8r7U92o+A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKbi7LdOHjyesShjtQrkjeeTDXlxIbNUucZgNM7yVSvqmk5WT/h
	pIa3OOPNL+V3uXnOgd5Y/Rc9Z5ojTSnAJp8gkImaxQCobaBRL8USv0y9
X-Gm-Gg: AYBFou1Npm9QZy5stRh6sC0UH7DZfTUQHKYGTgo9H1POhGBhjCpLkjTGjXNIbW8pCm2
	hFFBcRpdTf0aYx1m+qJd9i1kMj2Xc95FMaZyC6B9gGP4aF+KE1Kl8Vb7WpLltcJE1vpvyUgjCuk
	LztSTfSg3H0SRRdTvzdoE0ovAq32he5Mvq6/yfWiAtU87LkgUmIcN6q87CXvUqJnMgBVIVYqFbL
	GRegH29CA3iiri7SoHlqSGynAXe5trAezdVm5mZ/qkmqw7wHciLOtgkrYgT2K/8brKVqcjrgiX0
	1Iv47LMSwI/A9pEwJH2rMVJkThbBjQjBYmLX4pO6EWJFacZmu8M8Xnx7TpTFUuZUjdwsL1h8q/v
	Ub5/VQfcUJCXqMhYXPxULPD8q5WnmOdI84g5kjbAMn74BiTWD65yoP2X7cL3wy7GniMXvui9Rq+
	+vq5Z9BVQcViBqFsb4EJA0swomTLaH3TAi72tSjfT0YkA8QuWMm9nbFv/pGDjh4eY2gv673a3Gy
	duazjTGDCxWPpXFvG4XyMNXd2dVSHgjO4pDcm6tRgYuu+hkOGdZHzohD4nm6raBKTQDU15ghNkT
	vcYlqzXEyBVg+fdSWGZzj43K+ecy+0CZS84fV5a5AhaOHUmBMhHIdsSbWSgkz9Yd0GPGD6hFfJF
	T9/aYJeBEx/ok2UZ/cN5XEX0835aNyzrPkM7CssVc
X-Received: by 2002:a5d:6406:0:b0:48e:202:6718 with SMTP id ffacd0b85a97d-48e3eb8bbe9mr13317253f8f.25.1793067367758;
        Mon, 26 Oct 2026 19:16:07 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-117-118-122.95.117.pool.telefonica.de. [95.117.118.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm19591505f8f.14.2026.10.26.19.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 19:16:07 -0700 (PDT)
Date: Tue, 27 Oct 2026 03:15:34 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, christian.koenig@amd.com, 
	sumit.semwal@linaro.org, jgg@nvidia.com, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Matthew Brost <matthew.brost@intel.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Dongwon Kim <dongwon.kim@intel.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Felix Kuehling <felix.kuehling@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org, 
	iommu@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, 
	treding@nvidia.com, jhubbard@nvidia.com
Subject: Re: [PATCH 23/26] treewide: Rename dma_buf_attach() to
 dma_buf_sgt_attach()
Message-ID: <auAIO0y09SXk34CN@gmail.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-24-apopple@nvidia.com>
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
In-Reply-To: <20261026053623.202642-24-apopple@nvidia.com>

On Mon, Oct 26, 2026 at 04:36:14PM +0100, Alistair Popple wrote:

Testing the series on a Jetson Nano exposed this path. A 3 MiB system-heap
buffer was imported into Tegra DRM and scanned out over HDMI. With
CONFIG_DMABUF_DEBUG=y the PRIME import succeeded, but scanout immediately
produced display SMMU faults starting at 0x300000.

Tracing the fault led here:

> @@ -475,7 +475,7 @@ static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
>  	 * domain, map it first to the DRM device to get an sgt.
>  	 */
>  	if (tegra->domain) {
> -		attach = dma_buf_attach(buf, drm->dev);
> +		attach = dma_buf_sgt_attach(buf, drm->dev);

tegra_bo_import() passes the attachment SGT to iommu_map_sgtable(), which
uses sg_phys() and sg->length. The SGT mapping contract only guarantees the
DMA address and length fields. The debug wrapper clears the page-side fields,
so iommu_map_sgtable() maps zero bytes. 

Tegra only treats negative returns as errors and keeps the reserved
IOVA, which scanout then faults on.

This page-side use predates the series, so the fault is not itself a v2
regression. Is dma_buf_sgt_attach() valid for this call site, or does Tegra
need a page/physical mapping type first?

Karl
