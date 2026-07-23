Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BD473C88
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822843; cv=pass; b=gm3BNfw8rloBoUiTC1LbX5y6YW6QoPcB3rJ9iSxxLsRtQ6cuHzpQFj1rBBYhxQVwPoILy7x8eV1z0RRltDpP/3aJBNW6qYHJFHDTG7xqNpApi0wFtZrV9afwztzknQrjK5J00GYod9dA5OC8Ovnf7Mobh7X1KEggDnpuaujHnL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822843; c=relaxed/simple;
	bh=UTDry1jdeZi0acfJhI/YdJG0G3QhaI+y1iFKk3Eurwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgZR54t+8idy8zROdn6tkP92ThL7YGSfpyVSqi4/G/W7v6sQpSHeF/gJmgMXSotu2QU6s9AKkuUuskkPf2O5at0Z+RhfZmNknVsf57k7ygKpsp0Hyprh5SsaI3ln7VHD40AVxCPHWsfLKhmt346VmALEUt3Xiq5A7iuuc05g40Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AlKkGztV; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AlKkGztV"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b2a73da7e1so10912e87.0
        for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 09:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822837; cv=none;
        d=google.com; s=arc-20260327;
        b=AmXST1AM3+82i/ciCB2OR4oTeGgnGiLabY9iLLm2tXOhdIf2z9tF7hkOS1+OtzTf1P
         dHyO4hdZrBi7KNe++DW6QV6cnCaIyHmyhrBcjvwkfViDlE4aPCsrEEfZDJL72Rlgegly
         qXXs583npHYmGTG60278F970ymJMK468LL8iTrWp01vn6Hc0/GBu6Y+L8gSUx2jibtP6
         LAC2W8NZKR8cUhOZ5zAdwNjSXfqsxAhcR2U5ycVKi3n6HKYljeI23XXDiAGvXoNIzDHk
         qu4lmate/Ou7vNgRgxv6KgVVWEcmUV6uhS5xBwIGCEQVXQfskMmF27VI2m4S/Oq5eZMN
         +G4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lLj8QIPDjw+wrnYmjqmWidOihzraKtluDpbS+qkgPXU=;
        fh=HX01KX4/YtgFd3KKCG/piwg+6Zqxdn668Q/EDSW0HMM=;
        b=ab0ld8uuXr2sHO/LzLlCZmy1tNbCv6uMvkvXirfC+3ZhDt3KF8i43zG3J/mr9EAbdC
         +ri7qnkFrO9Gis0hS/cWOBnNiNdc9WsvNzFQ/KDO+zux86B9PCSbImlXt+Z3wSBcZ0M9
         a7PLwzgGHoTQY4YNf/KLbhF3zGkox1y8qUy+h7urDUjtmch9VNakPcrT0HmLohg5EUMi
         2zOkNsaMfjLN2ejRZ9rIxwIcOrp9QVtZpjdVlB9PiCDn2RJSNj0aEmlvmtj9EmaBIWRP
         wScLv4Wp/+wHGSvj/R2UlJTTe6h96+IM+FqB67OzJv3P+aMKSdJsEhxGEb1V1obYeGzh
         JDtQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784822837; x=1785427637; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lLj8QIPDjw+wrnYmjqmWidOihzraKtluDpbS+qkgPXU=;
        b=AlKkGztVIKwrQBE3bkisTLoYXMuhzTCcKvpO2X1OCB9TH7O92A+LJrQXB0gzo4F74/
         j7Fl2LPk+bPaPQtglsPetbWml8tPqlLhGrfn3MTDOCaPCyAVCeshVf0Wo3Mgy4tbKT+L
         RvIIqFbUxlzyjyxbtrglKitBYyh7f/tw0tshDPU9sxVX6wOIaG0srzCBABjKqtyzRz7q
         ow6pusA8b5NE6fbxHRJsxVNS6oIYTqaKjj07JqKMSfLDVTY0j+oLvwtMmlEVCHOUD6nZ
         wbq+xCYS0PGQ99BeCGlDL9mKn+U4JJSoQDcCPyFAlTl7uyjkeDN09UdHYWYNoR1Fw/AT
         u4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822837; x=1785427637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lLj8QIPDjw+wrnYmjqmWidOihzraKtluDpbS+qkgPXU=;
        b=f3V9LKZee8REecFa9jjmRTOK5Y909WP2eycPTLrGNyR3KEyTuw7VaZ7km/hnuiSYWB
         PlvXBBVrS8EXPM3KRlGSvyguy9i1FNniiOy8TeqgY/ozYnG8XUviPFGGKRHeI/499EL3
         4A8S/qOYbfIavxdPmav1gVqgbVGDXhiGifVBNCN31Cv3+Ti8kgzeaODpL5TvgDd+NvRE
         Oq0M2sCQFUdNwlIlH+jTyJJJpl166JigE74FEKsoJ8ilkrjldi/czyt7k2wmxhJOXr4i
         wYYPRRLM30riQRNXc6LrmKuIwBXExQAu0otkD1MLic1D0A0CVUybjZuJkrVz/N+8hbfQ
         JtnQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro01fSJtSVu0i2Lvit2/cxl0gEIaj/2UbJJD+3rJUbnEVV/tHGFFAmbtOKAT1hX0qAWPYQL8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywdzd1w5uGhVFr3S0PJx1eriHfUefN4D72vLBm3oglSuVlAUBhR
	lP+Uqjh1W7PWlePjWGJ+/8rne+1CYelLGedhr8Z7CGeN3HnXxvcQSTYEZk6L+GTaWpp765cHhuW
	JEaBAIcUxQGR8jzevynIA/1+M8P8M1hUqtULS7JI=
X-Gm-Gg: AR+sD11QHm5DdGBXN6fmVkhRQffcGPBpAGDy6sbCVuJtZUvxckcrXYWUoFIX3R8/151
	tSfYpUhspPisz6t1kVo6FxXHATNllfy88Zl974laqkFR7anH++OP46wzzX5Kk2hkWWVBPyDY6Ig
	LRhGoX1uDk+MPcTmmzyNcS7LBrJ8iMU9HjDJ6pNUT7o8Iuiq1HoGj7AkkZHaO3LKiB8UvQ0zf85
	aYwUmHrrP6RjjvSrrmjzCo6xrwWBXHvQCj/NR2AMeU9fSlYGaVDFQu28EFCcpT9MccNCSL/N10h
	chAIr+4W/oqJrZE=
X-Received: by 2002:a05:6512:3c8f:b0:5ae:a4e8:47be with SMTP id
 2adb3069b0e04-5b2b2968164mr196065e87.7.1784822836866; Thu, 23 Jul 2026
 09:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260623015459.1153884-1-xuehaohu@google.com> <20260722233932.3997681-1-dhu@x6u.co>
 <20260723094625.GE110966@unreal>
In-Reply-To: <20260723094625.GE110966@unreal>
From: David Hu <xuehaohu@google.com>
Date: Thu, 23 Jul 2026 12:07:04 -0400
X-Gm-Features: AUfX_mxZfBk3L4aJdDJNuS21FbP4tt0j-EIQJVeIi7KxTXcs6-s6PmQ53scVb6g
Message-ID: <CAPd9Lg9ZL9VwubYbn350pdUbQnnfc7FwXoPU3nPgvBHWRxLOyA@mail.gmail.com>
Subject: Re: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
To: Leon Romanovsky <leon@kernel.org>
Cc: dhu@x6u.co, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Laight <david.laight.linux@gmail.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	Pranjal Shrivastava <praan@google.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org, 
	jmoroni@google.com, kpberry@google.com, chriscli@google.com, 
	viursachi@google.com, sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:46=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Jul 22, 2026 at 11:39:32PM +0000, dhu@x6u.co wrote:
> > From: David Hu <xuehaohu@google.com>
> >
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
[ ... ]
> >
> >  drivers/dma-buf/dma-buf-mapping.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
>
> Could you please avoid sending patches as replies? It severely disrupts
> the reading flow when using mutt's threaded view.
>
> Regarding the patch,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>

Hi Leon,

Understood. In the future, I'll start a new thread for new patch revisions.

Thank you for your review.

Regards,
David
