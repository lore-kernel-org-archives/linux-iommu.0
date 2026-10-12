Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F7449481E
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816570; cv=none; b=H9+pkSK4zmScy1dDP7jML1xD6gc1iT2F48bFe9/KolDPR0DljYiw26Uh24der/bb3toNtBjDjV1FS+uofnlp+cogzgW90+5+kSdqgAnLdzNj1yDXjtyfGAowpImMD4v+F0JvqQEqCGbFRivK1tQLwsLPVnfcGk1pHFaQcbYFXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816570; c=relaxed/simple;
	bh=9zUPL5NVEOabXBETdoVcRvq0NcBLE5K5KiwUVsZ6rXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOQoTPPjQnAEFkzL4YcNggAawxdaRHpS/WEzbUZOZ8n/ZTuswDmo+tmCDIbKNipi2IqEFRX9nlzkn0y8wQVPlvNi1mMMudRmCA9JbB8lO9fR1BNpU9p3gHV3Yf609OW+1YZDoLexmE/EyVfE6KspsW2UWmx+lQb50GCi7HCzdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuDs1W7e; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuDs1W7e"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a021c28046so57225e9.1
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791816568; x=1792421368; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8W07NsiEHCJwsJueJBy/t/T/wHddWfvjW0+P0EskkyI=;
        b=tuDs1W7eNh+eGFUcttMjt+OqSARUelnqANs7c5T3hNckA4uXaL5gRY3YUGpxFRErkM
         J+g1Qd6eem7fmPTK06S7wf/b2XacLNuPGlV/pBCr6bQWDnFeofPQn01saViXn0obSUsq
         bnh6DDh1ofl265xFGeLLCnRBCc/5ICkve9Gp16r72tHz4eP8Y+rYHNntlXzzxE/u6Ijk
         m8G6WYNYQ3SGWal2ZYjw1ykO9T7OsLElef7/91FtoCNKWdVOD6vMGEQkHXG74nLlpqva
         t4baYO2WFAD6bhVW79g1nRsi4/ow/ytRaB+zxAALIMlvlkr7p6ebql5sNcRdnyAlNfdz
         ddzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816568; x=1792421368;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8W07NsiEHCJwsJueJBy/t/T/wHddWfvjW0+P0EskkyI=;
        b=xEqNSwU7zcDsj94+ON1JeANbjsWsDeLbCcuujGIt5kJLI8GZ2dKr9V9MmojKr4sk1B
         a7Jw7KtwUQA1GBGHRICgkf5DN1BVz91zTxvFsKXKalQMZlR9OoVnYQNqm/zGdhZ0Prn/
         TEthNH26JuxfgG1Bze/TVv0o0eJTtCj3YzCVPayL0bcn1jW9K8NzRU3NSe/21Vo1ra6O
         ygjt8ieAMhjj91ytggGuw61tQAqUtmH+MtXT2SLJB7aRRPQ3ehNxVDvmTv44z79BMZJU
         HAkZWtcT7c/HwUljlFjl2ZcVzE7MkIkCpRI9hbIBg8DQOKlQmXKTT29/AQlng9BewbhG
         pRxQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0OatqfXPUkTadnkL8J+NGPIllBEgnn6Ltd9F9L22duXWccuyw6peGa41g3W8ZVF64Z72LLA==@lists.linux.dev
X-Gm-Message-State: AFq9FYInSiqphJYo/1c9jiyKoxCkyL8261Wv8dY6rjvRIT1MHjla4LQc
	N9B4PMumCdRVdfivfLkPLBgViY4DuhiDBKj1PGRhgsiwS9rodP1zyzj2GwmlwJZ68Q==
X-Gm-Gg: AYBFou31hNhDyATHSr6yrGqdd+HOJHI0eFmcYB+M52LOhurUqXQNtgEnwUin7mElx9F
	x5i8JQO50YzSeZf+ZYFek3962S9reohdaC4+9HzgcHI2X3f5/3jvLiqrxLScE1fuQ+f7cebZ5id
	Xk6dKl7zmynvHc4NKm8/nIiYjj2xRZUbNYprylC9lhVylVGEya7qUEU/vdV4zwoUzNtg7Uz5A4h
	GaStqH3tWv8Yff1+9spJbUEh4Sv/LR0nf/SO+gHgq1OIwszk5EYXy3sd5aBxVzcRi5QpqPBkAJi
	bGviuMG4n5rRTnbC+ajePnB9Q7KcKVI/LaZyg7OGQ3Lfsh6RUBWPCdvRiFdHO8I8tXchY9qPRt6
	2m9nck5TwZohfHDCuqTnwOTOyQxdCgibV1/pQ/aL+grYX7DAw/A9iMrSO1HaJHwx9rM6W3WR/7c
	PysNwIAY7QahD8wJZuzaNd7iyrPu0Z1mmm/NhwyRClGg4Oq8RUQlXmccsvzJv6ehjOGLYSdD4jQ
	mvsFvRUGpiVNd10/hYPQzwCKAAdRkYrEJ2itH9KNphcS8P8wNg=
X-Received: by 2002:a05:600c:8b54:b0:49e:b733:7277 with SMTP id 5b1f17b1804b1-4a19d710a67mr1241395e9.2.1791816567153;
        Mon, 12 Oct 2026 07:49:27 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm172738315e9.3.2026.10.12.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:49:26 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:49:22 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Luigi Rizzo <lrizzo@google.com>, Luigi Rizzo <rizzo.unipi@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
Message-ID: <aszzcpW6fJWGcQCZ@google.com>
References: <20261003212241.3432303-1-lrizzo@google.com>
 <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>

On Mon, Oct 12, 2026 at 03:51:39PM +0200, David Hildenbrand (Arm) wrote:
> On 10/3/26 23:22, Luigi Rizzo wrote:
> > Here is a subsystem called DMA_PMD on which I would like feedback on
> > architecture, possible enhancements, or kernel components that could be
> > reused to avoid duplication.
> 
> Here is a feedback to a subsystem called DMA_PMD ;)
> 
> Why is basing this on PMDs (and embedding it in the name) the right approach?
> 
> On architctures with large PMDs (512 MiB on arm64 with 64k), would we really
> want to use 512 MiB pages, or rather something smaller (e.g., 2 MiB) that might
> possibly also have TLB benefits (cont-pte)?

+1 I raised the same point in the LPC talk.
AFAIK, this series tries to solve both IOTLB pressure and CoCo bouncing
at the same time which might be too strict; as for CoCo there is no
actual IOMMU, so there is no sizing constraint.

Also to reduce bouncing, I think it is sufficient to use the SWIOTLB
instead of having a new pool + recycling, the tricky part is how to
abstract that to client drivers as this would be needed beyond SKB.

Thanks,
Mostafa

> 
> -- 
> Cheers,
> 
> David
> 
