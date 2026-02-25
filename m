Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149A395D94
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047946; cv=pass; b=rMBX/EgFboJFlyAvtoylLD7GL9PZnVZxJ187EP2EO3rpLMQINrHhRnyw6YRmatUZV74RNPNn2G6XI+c8XAlZfXnP20OsXR+QB6LV2neHganvxmt9tUNOJ0JGnjoYYtEqJ8LfixsnI4MKdmZVOfBRtT4ZxZ5XOKm+JvLcl24UQ3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047946; c=relaxed/simple;
	bh=jgvQ9LOkQazsPmWMTTjFvYurOXwrvdriypbs6xoQIpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaWtZYPY9Ej+lve4tszjQSGPiTm7D2f2Ai3Zy86hJAbsANT5I/cISo5iqvWd3ZYruSgTElWh+Iznfri5bsFWTa6Mp/gjAnhhJqK0T9yhMj4yLt3r7k1OfdHjEX6w8T4EAS0duR1Uwu3Wof2g6pWXFlatfBk8X7Ek7pIXlC95RiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qS88+6qt; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qS88+6qt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so14155e9.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772047944; cv=none;
        d=google.com; s=arc-20240605;
        b=GfaYNAeQGayn93TpnwA4OTY3OwFG07/zcBIm6/P0o+kLba+jVaEXbtfttVzOAaWWX+
         k9FAGYi89ijyT6AZk2KoS+mR1WSYs3lB1PgcifeAUOfho+tgmLyaUrz8ZwHChayPKPiU
         Ieiy7NeReu6Flurdk14+FvyKwJtoHPTosQUA+2JQqhAAvDlhMtXPywcJfuTlE1GYW4U6
         ORi+bZ5kUB/6Nmt8JYAzHSxtasKJWODT0jyO7MTSIU++vxMYvVT4cy5V6+OAw697QK5u
         xyKJxr3DH2nGJNQDPbziAtKGuNq/1Hvq+LHzBVmeajMENrtAFllYpDR2bhZtCJOUdIqF
         iLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jgvQ9LOkQazsPmWMTTjFvYurOXwrvdriypbs6xoQIpY=;
        fh=BB9NTbM5iSw6tRNOI+agG6mf2caffQlt1D9dN4mRjw4=;
        b=aWT2LrabIGKHbJ1mVsjjawrbZ0o8iw9xF/uryU90eLjEOkpPH93O8o6DQTlD5ONAY0
         Czhg6ROAQpMQkdg2ayCwZAP/mz6xxgGClc3lQlPDIUevBFb27kEcSmA/xHU+KwhUlruy
         zO4fL8Z7I4py19ZXvHxA9pftx4kU7U2PPn4/ElmNtWeiCAhUiXf4SfiTdOIYaBHkA9TN
         4IbJ7dyq0oOTcgEhZ8VdH/DvGlk558U3rbHrjnfSS+DFWP7MwZqzeVeSsV2++KJlePmP
         C/uMwUOhmH0QZhWNPeF1nggFVHdY3JcwfHCjQ41JTpgRFSxMsiy3pCeCIqyH5a9zQfze
         lhuQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772047944; x=1772652744; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgvQ9LOkQazsPmWMTTjFvYurOXwrvdriypbs6xoQIpY=;
        b=qS88+6qtHysWehYZnm0QIagnX7iV/iglhG8z1ruSGU2cvW0r9b50VAwc1qVPYk71z2
         rZ0OAopc+sDLhRjDBuHfHG/wPgHLKz+IbE1nD7wB0IVEIHSbPeMNkV7rV1KvrKVUe/Qg
         x2aqSqWuAe4uyiMPAqSTQMJ7alpKJOfrNsSCi5LvGL7C68NRTvkjXttPmCxtNKNQtQSZ
         H1beMUCBxOksXtvwwJwwxcx8VfTknuhDXSOztntMFmUfRYW3fcdzdNhMbCY3KWL61WlX
         iOzXVEGiOvNNT2s/4WqvdurzSojTroCaXPQ4K9McGIL/4/UdUE0mY9KZFXTHz8N4MPtB
         cOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772047944; x=1772652744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgvQ9LOkQazsPmWMTTjFvYurOXwrvdriypbs6xoQIpY=;
        b=PRhIytNbh7ipqoIirbxWjTy9RfMhfVPQam8t3uLx8Z1OsSTLOoSVsflKmFdj5nkEnp
         jXEMmx5VlgH5lqCAz4vHBPLMjUnCKSHJ2a9fqo2/zqMKfdh2KDCGLm23fLGYNUW/WFwZ
         TrPmkaGokOzJxTx4l2vZSL+ZC7MmxshYsBFVjtQFzTubKvSn5KrBEWQMCbdDZX1WSpsr
         Ry/S2q7ozIm0r8hI4wgrgA2Dcdoiotbo+h5matiV7JMm7QKqqO16rEEOK+CrbCNYRzE+
         zWcaW7txSobokL1JXnXttPbUIc0DprXfDyd8MqHAGmzGcWzT2spgWUF7EK5Ek1Q5LABH
         jMqw==
X-Forwarded-Encrypted: i=1; AJvYcCUr6TLpxH89KwiEgVJpNz+UsKUymVuO2wpeLjxUSnO5xks1WYFrVf1T4Agj0jKOnRDHBXaCtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKDmLNjuLmtzq2RcLNl03UY9fdidQnJphczFV3Xh9qMDa/Uet9
	D23PqNd2KYH2KUh91vudPcfGkWVOHiOUcoXchE7A+h45cW4bWkl+Pd2sxX7mfv+biMwvxmre1Yq
	KQR+n34ZC564Tj/zF9SnjDjQ4OnHJqyWr9SyLy9P7
X-Gm-Gg: ATEYQzzCILqXRLT/Tw5M8nYq8XEAyaZGGhPaCf1EbUAo3mkZUj+lvihtmQyFdDVt2F6
	V+K5spZEOIQtenzh2EX+ivgnYoWrjaVWTnjNxeYJaMw1OPeadyyNitguDkmhNzPOkALI0xKOkfZ
	ztlTi14Yo6J1AjjBjHm2dgyO2lWh/ODVHqn2XbCITkZU4+e9vnjdP+seP6eAB26gPuPMeVkHVcR
	0SZwLGP75mJoM32Mr8EhUBeW7r6vsfxmI2DCRA87rl5r8S9GKawJvjbATOAGzzSXgx6nPK4OZLO
	PFXJvrMBZcPJ5XX39U0pWV598BRfN2oHEoM/SZkh+6luWK1oxyC9+AVA3/xz8asQiKqKbQ==
X-Received: by 2002:a05:600c:628e:b0:480:274f:843d with SMTP id
 5b1f17b1804b1-483c31b00d9mr64725e9.16.1772047943193; Wed, 25 Feb 2026
 11:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org> <20260225-dma-buf-heaps-as-modules-v1-1-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-1-2109225a090d@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 25 Feb 2026 11:32:11 -0800
X-Gm-Features: AaiRm50SiWoOS9CfY38Fs_M7N-g3DOx_BZCYfNv6nN_YOmBm3wEPmTfvWS_ulms
Message-ID: <CABdmKX2_+zh9jg+Wc9iS-YndB1KefC6+fQZ5G7f1LyyCtuP67g@mail.gmail.com>
Subject: Re: [PATCH 1/7] dma: contiguous: Turn heap registration logic around
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
> The CMA heap instantiation was initially developed by having the
> contiguous DMA code call into the CMA heap to create a new instance
> every time a reserved memory area is probed.
>
> Turning the CMA heap into a module would create a dependency of the
> kernel on a module, which doesn't work.
>
> Let's turn the logic around and do the opposite: store all the reserved
> memory CMA regions into the contiguous DMA code, and provide an iterator
> for the heap to use when it probes.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

Thanks! I disabled this registration in the Android kernels where we
build all dmabuf heaps as modules instead of built-in, so I can undo
that if this is merged.
