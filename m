Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E833EDAD6
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048098; cv=pass; b=iIYH0EpwNvi3k2ue/iUDgTFkzCgZl4oRiQVq0JjRSIydfysmAr5IzDFez0wvdEPEItUXm3+ReIuvqD0cnWuubNN1yLy27fkauNkyF1SLFphUdOtV1mzbnzCKQLRsnSvRZl6BZtGeNQNKwb+eLt4nDeKEUWsPe6jJHx7l1OiuZbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048098; c=relaxed/simple;
	bh=JcGfZZLTy1EfxpUAiB3PslYr4DWldds2kTYxvCknlIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLwZNspZlvtHc4ob2LpL1PGdRM3Yu3FabV/mNcqLYqDsNJat9yrbd8BzfVTn+ZBLkM2N6xZ0oGQn/U3G8xrCth5Vq+eXulSRHu5CrXNM6ZDKBkfEKFSoAGGGGx6YXkaxLXZkD5ZA6kP9xSzr4ZNb5XTm2IBYP9wWGH2mZha9K/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJ119yLS; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJ119yLS"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so14315e9.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:34:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772048096; cv=none;
        d=google.com; s=arc-20240605;
        b=a2k79h1IB6X9ITs8ebEVT9roGs+oBAju3a37Vvy7007a5gNQ/4agkjYUM3cBDp8z6G
         iirXFDkabTD4NiaRmRVpYFQotH38BRbipDlCxsWDgBcdk+4r4PFtyYS/hi0EiaLC+n2T
         vLoXKaDtBTAoTwTeg7pW53vAMfqvE3QaAuLOGK3Sya/vBgfonAa/gsIWPs5W9L5b46ft
         c33VKRiC87w0vPmZnIYLmPhUWc7WDS0/4jP7USg2taC0JNGKNY6UZ5LqVCUSRIE6W751
         OVGn4ZzGEsCC4bDmHUCOweFKJnyLXOmJWgYSctXURyfAqiBesUbbVFirTq9xbXDrChbp
         ZiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JcGfZZLTy1EfxpUAiB3PslYr4DWldds2kTYxvCknlIw=;
        fh=dQq9YQ4t6q4ms1gxkEyR/lxL3GfI/MDczagkpycAD8s=;
        b=H4CHXtWScONcY7i2ylfTGp7iwfhM6QeKiOocCKWETgqsQKOZ+l0pvDxpXrP78e7G8z
         pEloishpv/nJCzu+tegz2si2vuCPbPE0pDK6iF2k5iDp434bk2sNHYxf+njiID8KQ813
         m0R6J12xwHNkIQFN7QI3IBuWD2WNdQcrUjMU8hYMvhUWSTNSSPIERW0o9R/AYUQmh+Sq
         LVlC+KAbRnLrOPCk89lnPzXtjDRBhnw1hxmL0QLpPRP4LjHUjYjctNFYEB/Sybi/CamK
         u4Wy9yrVpxh/e2Mfnkhu7LOXHhY/ob6bkfAt2tkEY+DwAvo5bhZKqZn+JVkddaxFxqpH
         Ufpw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772048096; x=1772652896; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcGfZZLTy1EfxpUAiB3PslYr4DWldds2kTYxvCknlIw=;
        b=oJ119yLSwsHCrwR9nQkdWBy4UbIWm4rjPeRaKjvSxVdPLayrgjQG4J0iHrxGdrEZRp
         gtiW8To5Wc+xxF4OjxnZtRdNu7S13qr7t3X1WIvuGQ3dUklfVZIPvNmgTVVEEdaaKuTL
         wHWZldLAEoKM+SkYy/U15VHLapYPGuLMp+Gi5ga31BmH4lIhgrh8oNDxB9O4mJXnbEEM
         qMjNlI4Gw90W4RjCZxcFGv7+AjCXeR2ta5VKPvGnNg/3H2FZ5TBKA8NuIBh+aYpAsiI6
         5zEm+3pBs+aO8G9T7C+Yl7Um7focqMgk9Kw1QtDsBK3MiTn/3JmnveifByIbLoUhsdyx
         fpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048096; x=1772652896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JcGfZZLTy1EfxpUAiB3PslYr4DWldds2kTYxvCknlIw=;
        b=EizrnYj5a9qYoOiCn+D4ZcDD6S0P5xc45GPCUwwPcbEaRUI+LKZonanPyaLlpzessy
         VOb4TCU6cWb1l/wj7ZUE/sltesNmJ2+ufl+MSEmwVe0ezH6JGuwIBdo80eO1Qh9Vp533
         c38+WZ4vnzNvPGeewB9u9rif7ZS3MdCFmdc71Hz9gqFq/UyvxLsw8Uc3CyrsazbdSE9o
         QpN3McR4IC0zOc/PBtPIp9ZvJQ9r49JM48HV5SjKHN4BWGCEGEISfAm2qip4UougHjCL
         ZAQw7oL9P5v02QnUOb0wEQ5TkDVxKUvXFUPeIOGaBSjNQn7yWBeDAGGMyvc03d55ZOI9
         z0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNfobqOi0QupPW2seeMp+4f8xLg8V1DTQgZ8+oJBi66tgzkPkJ1KOuLzGSJ/FEZU/NZYaVig==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbhFQyvOkSRs+m3ZwRSJEzHU8RCLZlSoJ3zfs377hZfpRtW58V
	+XUTQoSim9MPIkaUNxJlt4eVP7PRzh4DkDhSliweUxU7Z7DpDrwpfXL0c+LrEboKr6sdChra67J
	9Y0o+LDa7tHUjA5EAyO6PYgWhL+PMJTd2d8apniUl
X-Gm-Gg: ATEYQzyt1/nQEN2haUQ3LPTvjd4NAYLotPuicdE3M5mm1XvBv0gmm5ec1dg9kXdsLkN
	SoueWtNYu3dm+Enc+Sh/xvch/984YiHOxwFepZ1+4kt1kWZwqS2jCCU7nkR6qQkuer3hZ02igfp
	+e10eAzTZf3Cm4zQduzIJIeTlCGv4jm+FXO3GUiwOCA6REMhSeH4tvM1WQ6PdiRx4ls4ocHfraz
	xVpZGo+PL/ZuK0Xgh0gHoTT3ljcdr2RV1R+53gwnn1A+g1OMc3idrxpBWgOIOJjXdvf2poMDTA0
	TZuJH7gMrHlHLKpPxBWk/6/ZiO953vD+HQ92TT9F6lkJ3zieyxMey8UuGxQMMU4LcGgdNw==
X-Received: by 2002:a05:600c:628e:b0:480:274f:843d with SMTP id
 5b1f17b1804b1-483c31b00d9mr66475e9.16.1772048095548; Wed, 25 Feb 2026
 11:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org> <20260225-dma-buf-heaps-as-modules-v1-3-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-3-2109225a090d@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 25 Feb 2026 11:34:43 -0800
X-Gm-Features: AaiRm50gu1dpca-LBzWZRd4gNx9rYHRkdAZSms4Y4Ytlet4IdIIADCtT7UW67vY
Message-ID: <CABdmKX0hGSSbRFwni+Mzq9KbpxwCHzAFPc70RZVv1GmFW92fzg@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm: cma: Export cma_get_name
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
> The CMA dma-buf heap uses the cma_get_name() function to get the name of
> the heap instance it's going to create.
>
> However, this function is not exported. Since we want to turn the CMA
> heap into a module, let's export it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
