Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851914A09E
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941650; cv=none; b=FZIar/tN0vn1Mc1EfS9iiyhGsmfdkhmQ4P2YEDPNenlJ+jUQM7ldFWpLEXyAFAQfwKhW8vqKZC011akVSLVs4kd2SHPHrS4ChtYHSBiFXpqh8GNnnMbKPeVQUduqFAxDjNUHLvC3Eu680STQntrDmJ11tInkV6UDLsOBohTqaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941650; c=relaxed/simple;
	bh=5JFuYVePpmhoWdZk8WbeOoqlnSWSkoUYiXSyfRvyGWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii7ELmMO6H5RwV8ZQYW66t8iJM0933uSE7mv1OQRG0gilmOzHuiFq3gljQalcCPSHmYbNR1YpLj1Fu8r6Pgz9RZIjF4ru0CJv5zq5WMugmb5hyrwPcsDNcN2AsCp/OVg8+0eYXGe9hQwHAMrYNMTQmv5mzahZ1lf77CM8VJ3dr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=NHlkspaW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="NHlkspaW"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-434da723234so2370921cf.2
        for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712941648; x=1713546448; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ICZfIsGcQEVbd3Zt1qoYBnvko2GDh9Nz2dJVHbfGpSA=;
        b=NHlkspaWQX9FJJosTayErKC8rUY0/QrkhzaHcvUVug3IhOfoYmLw5RFsLg1dB5dMyk
         OXuITzcrnEL98pK3QyREnum12sR0rcJMv2qdZhy9Ilja6PFsfSIdoXL2lqpuukjLGL0Z
         fZEmJ+Ky4/LCsqmQHbtGKaSSFA22HPaVgEL4rDW3L0pR2Zc2ghwy6nyD4Iv7O1LNv6hA
         lFOllqXKmjUNeUVAsEABAopg+cQtBflDQyJ0neTWnbDaEANoSJLgEumM2ErQC8eGi4kR
         P7vhfx51tvCJONZLuMbqJy98SzoQuykUXdlg/P4YZiVojW7zp+tZ2BCewUbPtM6ulhlj
         I0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941648; x=1713546448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICZfIsGcQEVbd3Zt1qoYBnvko2GDh9Nz2dJVHbfGpSA=;
        b=suNQNN1EhE5rjdJn22/Mj+JQ+LHoIySIHRsT7laYaTAp3WsIWxEbG3eOxLv8zbQJ8H
         mnJU8YifBG3K7zmcQUxsLaWsiCAVf+JaHkQLgP81KRGGylqga9aVx1eZn69izaT0buww
         HRfTESKHajRqzNGn0yjv8hhZLbC2FdwuI9a/y6xVy7icSVmWdYZlcXguMeo99wTeTmim
         +XPssuzZhdoRWwXbTeTJei5HXZt+lLKyOZS4fcj9rIALQTazluIpj91LJUKR4FOJXoN9
         Whf/GxeVtr9ROHQlSaBG+yzQjNH1GZNpl3PP1T8kC/yOhFuxB4nDI8gSnIg2u4nc4rkR
         zfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa66QSNrgPnGx0HGxYyyEPQSnL7DYq1tZM6KVvThptUh078IUhUBAw8jzUoPIYWaaGaCDPPLLdSXYpn/Qy/YWOIViKZOk=
X-Gm-Message-State: AOJu0YzKk1hnOrV65xPfBsy8oibTjEs8QkYFyfQhKNnqS4YAf0sBpED+
	pD24H3D1/FYlgrLTNL9YGTleLnWDV08I6QrL84o2uBGffAfySMWYGw74BK9ILuKCAP+gbUjXSuA
	zCQPQxULkXSj1+kMZib1xaLgtg2MF8sAbwsde0Q==
X-Google-Smtp-Source: AGHT+IEXzcV5Ah/di4pWjeRuzI8bp8L5qdlySBiHU1tn4/tN30fitecIDCoiEvXNx6whVxsKgO+qRvqVW4OxECf95F8=
X-Received: by 2002:a05:622a:606:b0:434:89af:bd3b with SMTP id
 z6-20020a05622a060600b0043489afbd3bmr3794375qta.40.1712941648259; Fri, 12 Apr
 2024 10:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com> <ZhkIhtTCWg6bgl1o@8bytes.org>
In-Reply-To: <ZhkIhtTCWg6bgl1o@8bytes.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 12 Apr 2024 13:06:52 -0400
Message-ID: <CA+CK2bCjXGTP7ie=rFtXrmRaWxn_6VmfZb5BXR13z9a3scfETg@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] IOMMU memory observability
To: Joerg Roedel <joro@8bytes.org>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com, 
	bagasdotme@gmail.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"

> Some problems with this:
>
>   1. I get DKIM failures when downloading this patch-set with b4, can
>      you please send them via a mailserver with working DKIM?

I was in the process of migrating from google domains to a different
registrar, but I think now the issue is resolved. I will verify it.

>   2. They don't apply to v6.9-rc3. Please rebase to that version and
>      are-send.

I will.

Thanks,
Pasha
