Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236D3DA7C7
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049197; cv=pass; b=As5bkKvsaA/mSc3WgyjhiGN0KItvnHn8g8GYpU6BJbxOAQYxXmzrZQafpPj+3fdmvMst29KYo/tJhAH/1A+cWFdgXk3heqEY+/N7bdDy1sapq3wabrrJ0b9qMNrN1toer240jLFe0MiTGkH6BpfSIkxxBFXe+lK3m1DCTAjKcOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049197; c=relaxed/simple;
	bh=hACZJJD++mSXl52TK006Yejdc4mpWUq5FI/WaqBAg/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=na1YCO+39Z/sas9ZeR/LN99RUUJdv81Prne84bTserrhp1d7Wut/dxb/6YDb9hov4jYHHJmA5mGBywZ9ba5HRDAbE6nNu7tzOa1WvCtQk8rMwpxxrXsyvKbphNY9YP1wZY9zFUcGtLANc8GjmlZ2mbK6llZeqpmqS6JSeg4oTpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrINBSWS; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrINBSWS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so14315e9.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:53:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772049194; cv=none;
        d=google.com; s=arc-20240605;
        b=lj6Vmau73lWvGQHcFdxFGXr6DIg7CdVRkGAeUltPVl4We2RnJzmxQtKbQOhDDaq6Q8
         P4RZfW8kJd3RsFcsNh4mMAGUdf5blPSym6+DuO6obFUtsbGQWWOx9Ly4Pt413Np9bIjj
         Fw3Ch/jzJ7jisjq1usiJYp7VQTnvuW06aA2M5J+BtPx5Zk+GqO7FeZTzfSjyHKsss8Y1
         RVvpnsHt4PxN/Lwba7t8riUWzCMAe3SWjKJsdosa45OGrUckQZ4TY3uMSgNRJniNjPTO
         K0MBIT9q7yrPARCy6mTQXriN3Hjb2PDsKr078DOLRk+/LOfHLcE4tOonNohQUupkoxJ9
         lKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hACZJJD++mSXl52TK006Yejdc4mpWUq5FI/WaqBAg/g=;
        fh=vfcFlo6xtfvTrqmk/bqPAFZw18eGdW9Da7cv40gnrK4=;
        b=c9ZlfoDFwRGyTWRnsd45nkU7cSluT9vYPrAmkxXr5s66IEsh8J9Xk/s0HA5C2m/H73
         Kjc4CZv19S+BrYNA914YJV1FseYk8iHgjvg8e3fWtf4qCVPTfpLhzzNcyE0yNhFxwpOw
         tWOrgdRfVV+UfZrpW+mNBSRASJDt9XleDfd20OsOcY7B8ENU35b1voVrzZbmFKZNQa1k
         /jk6acBULAzy2UybhyvgUJofQHgQ8LX+EwNBliLzk6+F8VD+lmwCFPZJLqqeB915lEVr
         Acw0FR22G9iIoDBwP6WV/ATjoDgXFRLdogJU+j0eMWq9cXiDfCnLqeMVvak+3xQB8iMx
         mSJg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772049194; x=1772653994; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hACZJJD++mSXl52TK006Yejdc4mpWUq5FI/WaqBAg/g=;
        b=UrINBSWSGbqLkfj/CfiyxcwQEWdiacWpaMiXyvQC/fesP0LQoAcngfLDL35vhFM60q
         K41BFIztTpZC0g+Sn4/LY4s0r1gh8wkkWCbAdwr1mnjLpi4uhfw+pUp4KniNr7eQrDtY
         PvVvYOS8IQRsEibI+Eoj3p3uSs5WE1sGuL5qkE6K11bWJtzx2SbvJqzlfJjeDAtbG/04
         qSZnwuidiYASHb3zVEdyJVqayq6tMiPlH6niFSt4vJ+TRd82DdsZ1fOC9SAMSvq/Q20p
         xhILlrMPgtzYBqJXV1RK6aBCf+LkrFaMogzglHhmh01r6z9vkhgcNBKVRqPMMTJv05kE
         Hx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772049194; x=1772653994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hACZJJD++mSXl52TK006Yejdc4mpWUq5FI/WaqBAg/g=;
        b=R9f/L7VXYfUvbmFJEwqB7WkWU131gRfc7+2sREhbVfl3EJyBXgL0Dpo24TA4PrH297
         N65b3RRDMZHiOhQp22IRpk2qufjERgViTD7qQ17sC4EPGuvPZqC2hE6hMqcyppNwinsW
         FOzBKXyHzhzfnZBVUcfrXbKmVeIR9eigczlHqEJwfVyXkc/tw/yJDWLQ3s00+ZCvXXnO
         RU0671IDJyxwJtsoLALKLx6L1jVhP6QhOcdn+7RJ/XvMqUB/4+Y1/AzsPovWhqRQLVKX
         n4D+hr+xodi1v0axFbvkiYCU3VpdJaARD3liQLtZpoe2qU70XqWuAhhvba9Vyu+o8eBr
         xC5g==
X-Forwarded-Encrypted: i=1; AJvYcCVx7UJzKTcVFILiOF53kI+wWbczUristba6NxF6tM/5HMwhyiuvDloxBhITS4OdUM/gi9SnnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEBVRgRi1VLa3uyNBAxUsrfdZUhVCLyfX+7BECFEkTBilcXtKq
	wFozWHRjuMQq5TxPquK+TBmV/2kJNwSujV3gnJkq9MPzDkvvbQ9zfgj3wHse/UubIYDisN3ZMgv
	BoFhZ2Dqbv2JL3v5PcgAKfjaDBwF9EjVWn8YGURfo
X-Gm-Gg: ATEYQzz/dX6C6+d+H/l5PSQ0RCaqcHV5HRhHy5nE+A4dQ4kjt2B0Iqa1hncx0rBj8EQ
	5O8doZWEyKS6eRX2X1cLT2ghYESPzvf9DprLVioDWNylfUBdJy2AzppnSaPjo5b+eiaZ1c4N3Nk
	pFeuCqgMQpEIEa+hajfeJdNflTpPd1+CJGO7RaUrB2c+5PBJf1p1HRL7yYmQvVxKzny/clM37sK
	yblQPpFRlPsgXF2aFkCv+0WOoW74DmBBhjYwSMA0vmW8o1x3vol4kwcaJ+lR0egtWuB7DoxQ2Bh
	BV5QRTPLY/zt/rv3LVSYaCDgiwONjZytOk+VtMJQMPyiycMgB39jMcFxJpg2WAM5Tae6XA==
X-Received: by 2002:a05:600c:214:b0:480:683f:743d with SMTP id
 5b1f17b1804b1-483c318c6b5mr64755e9.14.1772049193912; Wed, 25 Feb 2026
 11:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org> <20260225-dma-buf-heaps-as-modules-v1-5-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-5-2109225a090d@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 25 Feb 2026 11:53:01 -0800
X-Gm-Features: AaiRm53o2gSjT2_weYbg6Rd6sN6ASK7REyXNCnGoEQl1VXmkJdy1tVVm-ZBs7YY
Message-ID: <CABdmKX2KfL6q2nNAkZJ3r-Pp5JPq-sj2VpQp5bU5Hct68bedwg@mail.gmail.com>
Subject: Re: [PATCH 5/7] dma-buf: heaps: Export mem_accounting parameter
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
> The mem_accounting kernel parameter is used by heaps to know if they
> should account allocations in their respective cgroup controllers.
>
> Since we're going to allow heaps to compile as modules, we need to
> export that variable.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
