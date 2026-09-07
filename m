Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD814FDE69
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795828; cv=none; b=SQIdZxBbP3tMREUjN9ZDWuNkiOGS445eGDnOpF924jOjIvVgJItN6JKoF6G7YOG9dGUY6WRNwiBUMh6NEA/m344sSM4fzGWKJn+laE4hOJr8dQxLc0x9Xb+iZJ+cqZy5L4ae8sWm6bVcuLng5njbZO8DQqoYjMsOwQuRQeQmVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795828; c=relaxed/simple;
	bh=J7taEp3WWK+JfNjDguZhCQzDOLADA1gzAyDBmJx4rGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FEXV+XwUA4oUs7LjlIro3vu/S1TEf2qUivYeqmH5pdCZCh4SaZG+b7mnG6+Eeb4aHefqf7Lf0qewdNpjLLZPq7eQhna7olldZYNgCMPzNHojh5idsdIeHfCyOhFqFwAbOtXi/RrrkJE29Rdp6/ZCKhx3wjjz5HYQmO1ectQk+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=k1i3KzLj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="k1i3KzLj"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9475C408FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1788795823; bh=d02QurMiZgM9D+UGeFrSPtXi8CjC/977p0oi1pvWy/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k1i3KzLj8K+5fKPML3y0U1lJdqiznxRzxANxhKLNfrRm1PV5zBt3OebaQQZZz0QZP
	 clbN9lZ2DbJiEWeIDIiBxtaXtWUWqY+qdMgHU/l4xng5bv5EuGgezzwUZSV+JO3MIJ
	 x61sU/D6ryvuVoMYuf8bV5ZIVKWpDFYj5CLVndfqcr4hnMEMQiT08kg82nf/oHQxA3
	 RyZeutWS2FyYqJ4z6FKJe1UYb4USpaF7lNsP1L5jMra1yLj+YhGroy6tzova8ApkXk
	 ltkBRmyn0EeRezDtKdOxj+KTVg6IWHJiY4YTjv4Mb++lN9+7/4tyWnrJ+yLzVADSmE
	 cL0i7o9Qb3b1w==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9475C408FF;
	Mon,  7 Sep 2026 15:43:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karl Mehltretter <kmehltretter@gmail.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH] Documentation: userspace-api: iommufd: Fix the struct
 iommu_hwpt_alloc name
In-Reply-To: <20260905103819.43424-1-kmehltretter@gmail.com>
References: <20260905103819.43424-1-kmehltretter@gmail.com>
Date: Mon, 07 Sep 2026 09:43:42 -0600
Message-ID: <8733vlxe1d.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Karl Mehltretter <kmehltretter@gmail.com> writes:

> struct iommufd_hwpt_alloc does not exist; the name is struct
> iommu_hwpt_alloc.
>
> Use struct iommu_hwpt_alloc.
>
> Fixes: e2d8fe9148b7 ("Documentation: userspace-api: iommufd: Update HWPT_PAGING and HWPT_NESTED")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/userspace-api/iommufd.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
> index f1c4d21e5c5e..763b23339480 100644
> --- a/Documentation/userspace-api/iommufd.rst
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -242,7 +242,7 @@ creating the objects and links::
>  
>        Either a manual IOMMUFD_OBJ_HWPT_PAGING or an IOMMUFD_OBJ_HWPT_NESTED is
>        created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at the type
> -      of the object passed in via the @pt_id field of struct iommufd_hwpt_alloc.
> +      of the object passed in via the @pt_id field of struct iommu_hwpt_alloc.

Applied, thanks.

jon
