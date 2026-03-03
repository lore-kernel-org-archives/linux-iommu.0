Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64637CD52
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571332; cv=pass; b=Fmpsk/0hqifHE+zo4bDhEvdJfIzkw+ynDTRqPS9+vKxFSThIU+9u1UuXVbimFjDOUhZ1FVxu88Dam5EccDGwa0UhMItZWxwPYNmwaTBecnKLYNLln2YKMaXFAUgF1gzzB7aOIT5R5Jx7ovjKeeelZkA48S6ihsKpX74rDP1uqsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571332; c=relaxed/simple;
	bh=QTcUFUPPKl9O5H+yEy/BveB8689m0SStI46+e//eW5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkowcOsY7mV68xPO8v/i/snxL14zihxOo7sJWLWtjQfoI97rzK3W0WRRyBPtRtXkGi2c5cJInFxxDOcq04WTQfjcq0te0W6+DhpDJ5ENqOR2DtgO11ICXwF6IzpFEyKY8JJ54WcsK9SFH+2bg4v6b4Yl3rDrJBs/oG/193gTBWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyaqRI1o; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyaqRI1o"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9382e59c0eso727210766b.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 12:55:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772571329; cv=none;
        d=google.com; s=arc-20240605;
        b=YNzFbp2rpaIidP5cMCQSzl3Mn4+ULkg5dsmTrmPGpe2uOy7USktjWTxaDG7E6s6c5X
         oIqDQTzuf8irprZ/L7QscfuJw5dgZ75nX8haeLnpumTvmoOvWazra9A9+Kwg7hA7do4K
         xyOyCbtihfWoOPXnPzK5zzG8AkDbZTbbdcUJVOerfJTrlbhYOjWXSgYCQiNszkzF2j9G
         KFhuBqJWLE5nxj7ouTPWKgFD2rfsuyaX0gZ9bgWBj/MVILbn4A+wJwRksOVVJzlZg0kD
         X4ot4j6N20QdSMH/Q5QaUDjT2UCF3fuSW6LvlsUm8+rjKUk0/jsiMSIfyIDerQSNCC/E
         x0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QTcUFUPPKl9O5H+yEy/BveB8689m0SStI46+e//eW5M=;
        fh=Me/OSJH8f9MoSBS8E1YTYAm6mK992YaTSDpJgy8UoK0=;
        b=IEtQacm+lq4iFkLL5m/Fy2wh11Fu7jqHp8II+UP6VZTOYamrS0FC5JOOImSRMYP2C1
         an6hBDeyGVYvfNnx0qCDesM+tnFrnvYHag2q7vk+uz4zAMcFRvYZ9VIcwrMeuKDhzDev
         TKKZmbHy2vatcul1ItC6V4iT+AmBK7F64X28o1OD+EseojD101UQEGvBlTQt2PelGTce
         R4V4jFBWxkD4lmqRQbkOpEkeaBn6yHs0N2Fvy8QpY41NT5KKfxLV/W516VHs07TEkT0d
         IcSLfd8QMl3o10PMSlKH2HqeA1U00AqCXcxBin9S9Fi+CA3V/A4iqeo7t0EPnLi03jS3
         N7xw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772571329; x=1773176129; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTcUFUPPKl9O5H+yEy/BveB8689m0SStI46+e//eW5M=;
        b=eyaqRI1oS5IVz8fsFPsJ68r6uA507uBxNk6tYb4O2bF52n2PYw95crZ2V8JCAhJNbG
         uhaJxd9Y6IKpLCEKWy8vJ5+avv8U746P1D9Okp2XdBAj3FcazAm3gpLZcBlJXdHnxMXc
         6vVf97lJi573VohM+myDyl8bRm2zuw6dQLHFXp+QY6pc33o8zviC5wcWHFEHOM5VYGN2
         D5bNapPOo340PUMxx4RFQs5Op8wc+8giaxaUuPAztLl3j6VgxK42pDrtfdhCxjrhn0TI
         QXLMFRLojSVnKMTWRsdbciO7yXJHrzu0s8E05eti92G0pgMr7FI3a9OsCOFcDt3dAYpr
         5QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772571329; x=1773176129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QTcUFUPPKl9O5H+yEy/BveB8689m0SStI46+e//eW5M=;
        b=MXVvuLTZ5jj19rlYQEQ1hpKdQkVejBAPDuOwGIlQFo3Fcuam9HHBeozxwi8j3WIOPm
         Y8CENlnjUIjTHuHie7HULBPc33zpzZmSYsCMVAMSpaNEVe+O8g4I2lftR6yzcMidJwJZ
         QzhLRNaQzsK89EN2SKkU4a9FUe/B0fGdVL3RQrbpP2yIgbAjG9ZGGlIC9SFia03pXc/Y
         pHyHAtgbsiUfoig4w6RrTvL3n8YbLtvHBYR1dhz63YG2SIwREkoZOQSC/juXZm0F8/7u
         Q2JlwODBETIGrA51UyI+jmqZ7OZ0sacBqJTkwIOQtpmzRaxe4NXOFKs88/2x5x3AKx4G
         CalQ==
X-Forwarded-Encrypted: i=1; AJvYcCWShj2uRrg/fYCYM86HPSnFX065ZkEy6YBY+FiM/9scbWyT7KSNT/FcGuElzS5bh18BXG3WfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwV/CbmzdAxUOzMbqEEhLYQF6k9enm7PeajgJgv02mE67S3R2yu
	BqscrHIHxGc6aU0O8sYZqiWcjAkvaDfJffNFtTMQTUPEyq/dFq8RLOId4GQSPymGFTPfLWO5HB4
	cz5wjTu7dHi0cf4LO5ouaXiMvCvfryjemyRMyEAk=
X-Gm-Gg: ATEYQzyDl9vIxjilq6hcM8n3NvSvhyp/8LoGBuFi+IjJ4VqZvN9H0yKXS9OPsUwEdoI
	BbdYrAQj7XuFZ64p/+GRkQp0L1cjWpq1qWlQlcvWVYDtG6jVgF6bY3Q5VGRZ3NHkTBBhsX2bR14
	wd4chU4U45t4KoN14abLGSLx5irjcrWqRDcQ/bXZ2ObfwlJIzkrGk38A5v2vdbakJhWESZBqjBl
	Z48j7ADpU+YKOWMKhRYSQcC+heuV3wbiiwgSAlWXskxTMfI11NuaYctLDTVu1w1Knt6tPKvOyNW
	4W7haaKa/PeVPyLu5En0YEpnS/JCbqb5RX+O
X-Received: by 2002:a17:907:3eaa:b0:b87:117f:b6f9 with SMTP id
 a640c23a62f3a-b937636cd7amr1077404066b.8.1772571329176; Tue, 03 Mar 2026
 12:55:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
In-Reply-To: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 3 Mar 2026 12:55:17 -0800
X-Gm-Features: AaiRm50eZ6b1R9zR4BWk_SQv0E5klHORf7__0-5ZUwkb8RwaEPVqJM-v_erZHak
Message-ID: <CANDhNCrVVGsxEjgRcVJSn_E9WPUVY_9zpd+t0X_Jy7JqbcHDqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] dma-buf: heaps: add coherent reserved-memory heap
To: Albert Esteve <aesteve@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, echanude@redhat.com, mripard@redhat.com, 
	John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 4:34=E2=80=AFAM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> This patch introduces a new heap driver to expose DT non=E2=80=91reusable
> "shared-dma-pool" coherent regions as dma-buf heaps, so userspace can
> allocate buffers from each reserved, named region.

Just a nit here: Might be good to provide some higher level context as
to why this is wanted, and what it enables.

Also, "shared-dma-pool" is also used for CMA regions, so it might be
unclear initially how this is different from the CMA heap (you do
mention non-reusable, but that's a prettty subtle detail).

Might be good to add some of the rationale to the patch adding the
heap implementation as well so it makes it into the git history.

thanks
-john
