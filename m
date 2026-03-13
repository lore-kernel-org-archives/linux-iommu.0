Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D534C815;
	Fri, 13 Mar 2026 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443191; cv=none; b=OvPgchGnjuzW37tKyfgDuSpv+OYbNNEkpjJCeToCImBcyMT5swStn5xaafLlKS1787FYO+pjTJQ+AJPQv5rdT7BaMt/0uMGahKmO8pjODquWxIB4NZ2/4B2itsvmKUfxN5Z5hc4BQqojqBBFFRw7t9sgvbMzMD3UZ6TwQL4TVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443191; c=relaxed/simple;
	bh=yFVSBh4WIS/NwxjvqQ8QJjFjOyTSxSn7QLtwu40ICpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEEXh6HLzOYYEs6DEHx7FlczvxZqTwtcAw4hSg2F/xNh+/0z0Y2Qn0Zn1CUUE82Fk37JpWnOshoHZds2isVA6J+MLCnmE+mO4OshVHT5JRo60Cz7/leE7lYWkI3sJWSduWbQc37/cLzj7HQPKCp6HB/YANl3MC0DLXkmXmmgpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jt2I9UnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt2I9UnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1AAC19421;
	Fri, 13 Mar 2026 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773443191;
	bh=yFVSBh4WIS/NwxjvqQ8QJjFjOyTSxSn7QLtwu40ICpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jt2I9UnZ2kDKSz/mk7fs/bJcvr7jO5ba3GhlsVjWsZKxKnz+Mi5/wklcExgENbE0w
	 hPsMhYavxA4/Ii3mKP8MxniNHhQx5gBjDs3C2TLn61IuVVhJwW5sAH3qjrGKXao+M5
	 KVlpVwH9xej7Bczoui+2oyTP8pLjAoAHmohs9xSiZQFf4qtSaeleG65oJ9dBaNMG2r
	 w0P3Vvwc99eHe//v5RRFJP1t6Oxwo7YfHhVRjCwg3/sbqN7eg6WnOmaUA3lzASbaaQ
	 wKMC3VLWgyT2l5v95CGEo6Jf+yK1w2fJtEGgVP80Toc/pboqWhkx9R+MBovmhfyGL6
	 NVi4he/PVvSQQ==
Date: Fri, 13 Mar 2026 18:06:29 -0500
From: Rob Herring <robh@kernel.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	mripard@redhat.com, echanude@redhat.com
Subject: Re: [PATCH v3 3/6] of_reserved_mem: add a helper for rmem
 device_init op
Message-ID: <20260313230629.GA3603067-robh@kernel.org>
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
 <20260306-b4-dmabuf-heap-coherent-rmem-v3-3-3d00d36c9bc4@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-b4-dmabuf-heap-coherent-rmem-v3-3-3d00d36c9bc4@redhat.com>

On Fri, Mar 06, 2026 at 11:36:34AM +0100, Albert Esteve wrote:
> Add a helper function wrapping internal reserved memory
> device_init call and expose it externally.

Why?

The diff tells us what. The commit msg needs to tell us why. Maybe the 
rest of the series explains it, but this commit needs to stand on its 
own.

> 
> Use the new helper function within of_reserved_mem_device_init_by_idx().
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

Version history?

>  drivers/of/of_reserved_mem.c    | 68 ++++++++++++++++++++++++++---------------
>  include/linux/of_reserved_mem.h |  8 +++++
>  2 files changed, 52 insertions(+), 24 deletions(-)
