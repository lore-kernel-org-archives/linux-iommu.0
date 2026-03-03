Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AF6347C6;
	Tue,  3 Mar 2026 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543406; cv=none; b=PPcoXaFdSoJD/cavFo2LQrOVs244ktKtwAkI4N8vezPSitl29vQZwPqOHCGbyNTfStGZ32JtIwWvf56lSE0dKhYivMb4dTWOkw5g+CtKSVda7zUUfe4tN8ThGHCJZ178egjBbkKq+uoxExh0ZaNZ0ZBKQi5ER49jx0EiZAOv2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543406; c=relaxed/simple;
	bh=HUeuT9h9PdBSYE/DGwyF8wqKXoc/6Qk3eot9qc8dq1Q=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=LrGHrfK3mYF1AvfK16xpAE0j2cyyCBVAKsDi0hU7L8KJpSm7YkRGRz32IHzx38lUOCYpN9gB9aSqeYJWGiBHmRkEbkXfgAKM61HzoLFze0V0/HTF0yTqmIhberLsgssgUAy/UwOH+r1C1yyvQOXwMaDNPVXzd8POAjNdTrLD/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXOwY/0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXOwY/0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55358C116C6;
	Tue,  3 Mar 2026 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772543405;
	bh=HUeuT9h9PdBSYE/DGwyF8wqKXoc/6Qk3eot9qc8dq1Q=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=mXOwY/0lplsiNBAMoUcSfq5Gwic6Za+XuOA1oLsfQdiFpSsLDlzGt1nefY+6wghA0
	 VLzRclPrmUqz+5UTEojQIBZR5pkNzIVEBrIwRYPzyrZlHmmIZLreMSCjQQ4O55K6rU
	 vPoeV6OLrkRS1+bVJBZty9hADMJKUSsS3HWkwun7LNwoavmW/L8Lhl21Msx0l6YioM
	 V2fnlfvRGB45l/9rfS+tQJ67oQkwcgghmwyRGQ5RT1vBrDqGvzTNUMf2Imw7xgYGTZ
	 IcWpRccSLY0JTfuwlir3UupYNA3SUZHb9tWuY7iozVab7TzcK7ND7cMR74CLuB0K1J
	 D+2LRd2meA+1w==
Message-ID: <ec1b4d750ae4d87d84d8a751400f468a@kernel.org>
Date: Tue, 03 Mar 2026 13:10:03 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Albert Esteve" <aesteve@redhat.com>
Subject: Re: [PATCH v2 1/6] dma-buf: dma-heap: Keep track of the heap device
 struct
In-Reply-To: <20260303-b4-dmabuf-heap-coherent-rmem-v2-1-65a4653b3378@redhat.com>
References: <20260303-b4-dmabuf-heap-coherent-rmem-v2-1-65a4653b3378@redhat.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, echanude@redhat.com, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mripard@redhat.com, "Benjamin
 Gaignard" <benjamin.gaignard@collabora.com>, "Brian Starkey" <Brian.Starkey@arm.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "John
 Stultz" <john.stultz@linaro.org>, "John Stultz" <jstultz@google.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Maxime Ripard" <mripard@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Saravana
 Kannan" <saravanak@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>, "T.J.
 Mercier" <tjmercier@google.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

On Tue, 3 Mar 2026 13:33:44 +0100, Albert Esteve wrote:
> From: John Stultz <john.stultz@linaro.org>
> 
> Keep track of the heap device struct.
> 
> This will be useful for special DMA allocations
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
