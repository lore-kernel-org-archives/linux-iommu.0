Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A5314B6D
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049149; cv=pass; b=oqo6GVH8CyoHfoCLtbpvKLPRWNo3hkXZ37jHJIs/WIyjyxDI9aVqSiojd2u8jS3oMwM4mjnTFI1I0bPoZC747jNwQl/o2+IGVSBgw7Y2IzjBcYfhwQaf3LvetoX1WOfSxCoGDOPkKFs4LuzYNS1ks46LnnYIKCiHkYPagBk64W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049149; c=relaxed/simple;
	bh=GOCqpqP4xulPNkLV+0mavDjGZp2jPKuE2l1wLsJLWlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkCZ2h83xO81uhFyDCQ+LPd6Ayblu3h5yeh+Pv56is7HA+y+roxYBkcjQE8FmCSln/8arJaY0Z+u/fOAF3T71SE/7kpIWiTVJcRhC2iZWza7hvJPn0HsZlU/hLOKdzt1xUmBcItTvJ3oZgQtaCdnjoVoKTbQ9kvFjkGI7iammYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUaHB9wY; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUaHB9wY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so15825e9.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:52:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772049147; cv=none;
        d=google.com; s=arc-20240605;
        b=cfUxF4QgTT9oMximxVsgpsGfcgr2n2+JheDuDIlMrrbHFLq/OQ1En+u4o15z8H0Qkt
         Bg7ScrnN3vo+7a3NfMTfzSan8umH4aDyMNJPr8pKH++jES+utSELR2Du2WF2ueMRo+wf
         ehuj522JYfQimcW2jN+uPwO+5KMK/MMt/IThFiUXioKPzNfHr168/ua+YvoajHt5VKau
         hjusK3oDGHz7aQLbhxubIXndn6qrKzWHm5y3EJf2PpwfrngAxVDpQPTY2lW4M49uHC0K
         0dRXqk2HeBCQjNSnCLDAiouDmOzbLy2fe94a9cWRVMJ0yNeen/dLvmjG9YKSfYBhnbM8
         2ngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOCqpqP4xulPNkLV+0mavDjGZp2jPKuE2l1wLsJLWlw=;
        fh=1Y0tfkBVg79esKXX4sBqeksqF3UQfJrnBqTs4FHJfLY=;
        b=KMBju9M1sG9GprYLh0zJCph81ecn3cJjTRf0nnVvHl32e6I/tRbMGliQHmexMoayWK
         +HKssFPV6xpShhvpXcpRP9uyj87MNECUZUvgqLJ1IfYIaISfab/LfGMhwYq4VJEi1b5q
         GZgDnkqcb++wbNaV+H1W0xDyLKv5L3kDcJM/k4Mhk7Cy6bdUstlTSVn+aEUy3PiA4K0t
         yVid8E6tFXHlUBmmJ5ev4jyPHngdu0oRvcAqFsqbYwV68Nhf/fTYvIaMFEJFiaYCFIuG
         chNPOeazb54MB+pxCSYB/dsG06xWWPInkE3u7PZZRgyn5W0jkR4HZgqrae34OBR2x6bo
         x8YQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772049147; x=1772653947; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOCqpqP4xulPNkLV+0mavDjGZp2jPKuE2l1wLsJLWlw=;
        b=QUaHB9wYYnQawUUkQhyL9Hzp0l1LD5C4ylmGxNMdexI2I/jbw94zwqmC9VHjAdz5Dx
         Nb9BX/hMJOXzWhH6QoKfDcUrYHTIaQ0w2KYQihkl/URxUCe0jn3oyWaN2TJ90FkC/Ojs
         SGMVHWZBhhTUN7fxyRaA5eEZF9305CE73k2yFhkplGaIrhfQJYfwKQCwE99MUueF7gfs
         YIUMc5Jf05Ev9xO5dkIZtGvUyMWZBbTjrvRntaTk8usKI1wy5XG5jK+F6L8GzPCVFBtF
         2wHeaswgbrnkC0HNZ7yt2jk3pUINek99gicswIAM8ptHOd8yP6jYqe3RVVRnUcc4V0Ly
         TaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772049147; x=1772653947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOCqpqP4xulPNkLV+0mavDjGZp2jPKuE2l1wLsJLWlw=;
        b=fJa3VBGiTkZLAh8bgYJ1UmvVK1+HNQ6kkrqMXOWGh5fsry8Lbc4bOHwGsCDGVe/i4i
         FnMHztlB44Seo6te3oJwL5HgZBcnFvH2KajpXImVBbCUqeLR3r9VlCqL1RVKzns+cvwb
         HUQFdXv633WIFf7PLQY/bB9xKmLLeGpRGXPUPR6KChWM4ZdO1/YNeCDdS9lOtlEpZTGt
         65RiWkb9nenC7I4wRe6iMZw3d1+Pn6+12KOgPTQNpeYaZrkU6Hwoh40N9lOroUuzCcSk
         u9iRs1C09Rsx8dVGXr4yQkPgG5rvdFKRvnseCxDY19eRPVkq1TrHSocx55Nixrkh71wA
         x74w==
X-Forwarded-Encrypted: i=1; AJvYcCXQsvlhKYxBKFxX08MTE/BVpSfXt4lXu7M5NwB9MYzgOOg4BfdA2mZ+j/4eGnIxjdczNoUclA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzohAgG5S3fmxLegXlDhhIF9pIHcNGRBQuyBcSZJWFER2G2HnFY
	PxiJiIV32imiDHWClhboYYQGG5wzeYZUGy3XohzKVO+qL9NHLcpKfEW3aJBGJc7YBBWo1HM9x6Y
	fE5ODoh76am6JkQpbaO0YQlQVphBkFxAHMA7RtFio
X-Gm-Gg: ATEYQzyWQoEAYo19IGPr40NxlS/Ro5zPxUV2EtW4AHPxYgxFrX8yLYUBHWLKd+915gF
	dfnXOQXt7K8PrxBMUcvt9AeV+3fAYebiFyyFkVfXyy8qvAiC+NbnDTkgUvUUCCwjzhjgzwU9kY0
	kngfYMy8vtgTfzOVBf7APeOx5Q4WAKy1/E1G0nkKOTq/sxn3hXJV0fd7yRcA/iNVFZC+GW//yew
	ZxVCXfnxNs313u3DfeUq0I67lfKHJgiFH8D5spWthPWennc5HvZsVYc9eOW+28GcfxioLLHedn9
	OVmCUj29mkM1Q0Mfkc42fSLkSEXqRArZQK+c+WAHJL7CpNTrJNRP6G0Qe6tR2/1Ovuao1w==
X-Received: by 2002:a05:600c:5702:b0:477:95a8:3805 with SMTP id
 5b1f17b1804b1-483c31cfb56mr70235e9.15.1772049146264; Wed, 25 Feb 2026
 11:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org> <20260225-dma-buf-heaps-as-modules-v1-4-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-4-2109225a090d@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 25 Feb 2026 11:52:13 -0800
X-Gm-Features: AaiRm517LrodfDPDmk8aF233zMemSo71i-_zn9eOj5ImN-lsr29tVaebY-ntsoQ
Message-ID: <CABdmKX1piZByQvx0sYbO4R=f1rdZKmYS5R0EcChBv22cAUvCUQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] mm: cma: Export dma_contiguous_default_area
To: Maxime Ripard <mripard@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 8:42=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The CMA dma-buf heap uses the dev_get_cma_area() inline function that
> would either return the content of device.cma_area or the content of
> dma_contiguous_default_area.
>
> The latter holds a pointer to the default CMA region, and is stored in a
> public variable. However, that variable isn't exported which prevents to
> use dev_get_cma_area() in modules.
>
> Since we want to turn the CMA heap into a module, let's export
> dma_contiguous_default_area to allow modules to use dev_get_cma_area().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
