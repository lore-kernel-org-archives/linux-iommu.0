Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5980C1B
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505277; cv=none; b=YhcAaUlQun8SZ05G98XMVbtHm6mkw6TBZCj5jmMDFSzX/Po/+0dLw1dDNQ6r/ff/sHQeQW7KRx0DH+HtBGOhA5XBUxJx5wf4/eyZZbLwA+zePFupOmFd17BiqmPt78NbOO1spUsvKJGQoCzdZxwLNjtTxXw5iszGD+DtAoMevuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505277; c=relaxed/simple;
	bh=A6nixm9+pytVx29gZ1u6InMe44RI3ah/j/zSFqY5qPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdivthW3pugWdJOlJ4TWDOkFDn/vYR5evsPJf8Xk+Rsu9Bf1Zp/jnxGMXZcxu89rN4zwsgP4epuskj9aJw6fEVsoYdJpYUt9c+VORUMexEDIljWCggOuV761+EsRMioDn3bgUq/a2T3aN0JmgoxsMa2QwIjOB4LkTY+uAXnlBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=cI+ABtlo reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="cI+ABtlo"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2bd54b7f6so683078a34.3
        for <iommu@lists.linux.dev>; Fri, 09 Feb 2024 11:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707505275; x=1708110075; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6nixm9+pytVx29gZ1u6InMe44RI3ah/j/zSFqY5qPg=;
        b=cI+ABtlos5A2V4TBxvKRaM0iZdnZC+aCcF7aDMXhgpJJcuv7tiNEuuxZCYY887KFQR
         f3fgSQclcmTqmlu+wM3O1NKWNxr4c16aeG6e7pXcq3Rkg/ocXNY08yqijtAP4wjqvNYe
         mGcS+Z35nL4pohdSzbd++2r5bpWcWWVI2KOJM9jZW5ei7/HxZXsGD7CPeVu8n8u3KfqS
         P6GkAQUaBHwEjwFMwMOXt/squB1/ipg9Qpo1CmLkJujhClCpECdH7uZPojS8jHFKdT34
         aQwYfMGMwNX9c0ZI8bbYQvYNZ/uV6NE+ZCTSWEQZ3lyrAUKjs8edGULX0IZ6LxqxNVcU
         ETIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505275; x=1708110075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6nixm9+pytVx29gZ1u6InMe44RI3ah/j/zSFqY5qPg=;
        b=w/fOiw2HT9mJIjaMmqVKg5o9RQoXl3F8DVwC3ml7yQg3nOaONKoytzHlJEdod72DMN
         UkgLQh+J/pfoC4Oy96EtB4g8alByagJyLqsgkuJtBA68Fwf3ibc4sEAJOcwDEnD3M3eQ
         8nVD9ejuz+juptZv3IGzywuBotpceyimuycXziry5iXndvQxog1Pq/W7uNHvMRVOj1WN
         qyb2sYX0O/9LbBirIli0w5BFcAmnZg9pYFEWzFSVtSuKkO160r8BoBw+Pf5w9o02VLZy
         P6q5+3mnVU2SgPbzdfGqwnYtAnB7TGMx6zO8Pd7EQ8A7nTm+LdPKxYslzQ1CBY2dvuao
         0s2w==
X-Gm-Message-State: AOJu0YwX5HUDGeBAILe8GlRe4zPp8ReeKNkZDZ+PHKqytpiYCgqCoJJj
	fnJA3U3mSq//5ZE3RYsvfgl+MokGRrtEXC7grnfkc/25IXW4E44C0EysmcztP37tYNZTdFNy7Yq
	iFylyvqhaSYPWGescmBu5BvhGd1oX1ERLBhTaoQ==
X-Google-Smtp-Source: AGHT+IFk85AK/GUYg3sBgSG/PbDJz6nuE4vk8ZoEGio36nkbZvD4VZo1ESUanwCzArrVosJa8bsMEnRS+HyilbasQKI=
X-Received: by 2002:a05:6830:141a:b0:6e0:faab:cff4 with SMTP id
 v26-20020a056830141a00b006e0faabcff4mr3036212otp.13.1707505274772; Fri, 09
 Feb 2024 11:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
 <CGME20240207174117eucas1p237865b0a39f3a6d1a6650150efe22e83@eucas1p2.samsung.com>
 <20240207174102.1486130-6-pasha.tatashin@soleen.com> <a1c452f9-c265-4934-82c2-8c9278d087ec@samsung.com>
In-Reply-To: <a1c452f9-c265-4934-82c2-8c9278d087ec@samsung.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 9 Feb 2024 14:00:37 -0500
Message-ID: <CA+CK2bCax2NVhVwiVdyWG0Fpj7W8gi2Tmz1guNKOFNf9O1tfng@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] iommu/exynos: use page allocation function
 provided by iommu-pages.h
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com, rientjes@google.com, bagasdotme@gmail.com, 
	mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:26=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 07.02.2024 18:40, Pasha Tatashin wrote:
> > Convert iommu/exynos-iommu.c to use the new page allocation functions
> > provided in iommu-pages.h.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thank you,
Pasha
