Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429F2DC788
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986884; cv=none; b=Cq/Zel/02x+q3Sol/oZmPDbnM1DuHXIedqihB9bhYtX7Uv0tNPWAkf4BVvGx7eidwL/H/mwboErd5vtc+GUESVVOr31zXLmp+mEiY/eA3ZlVUNcbdguDf4Fhy7EHWdXtWMwQ4lXBPXVDlUH5P6cqakfIUtqhak2Xrw25PgeWUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986884; c=relaxed/simple;
	bh=rNIf3bi2IMoCRnWEY1hQj0XxWY58P6mSYvKdF2Iay6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=achBiGkkhWlShEKrqEW5w3VmMxUpqx24hKxLu5W5PduPOc06yYt51vge3G4I34jWJWDcBrbVO3j+N17ixj6i4wUkC3bwilsJur7/2Z6n4HyItQu9modMpAyrsr7PAQxxJaGGXP1fPkbsLbykrHpj23V3m2hBbMKYbE3/9AoTkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hBJRRzSu; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hBJRRzSu"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dde4444e0cso85637137.0
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762986881; x=1763591681; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDBZhCwNxVXaARp2KU6VbEkAStKufeq/r52aZqJipig=;
        b=hBJRRzSusTnJHFuVGLkTuldu9FnFr9lUJSLZomd9LfTDzLJykY7SR3Wtg+RCVGYHSS
         gfVwS9NQtKrhyp1mbSZ6HkFldXMXcVnL5Z6FG+sjLJpcXv7ZMoo7Ix9PG01dirKjQwvA
         OI3qtxLetXOqfvSBJi9oFD3pkb86DWhSPAZ0YS4DnE2R5BeTQ0DQcXIIhUhnIeVavpmW
         l19aUHAxUlJ7uYN6Fx9ysMEL62Bm2ABSRqlI+Bg5Nzb0DGIXLAhOJ2ifFWctt15C5siA
         BLJ5r2PM3/B6X7E5tYYno+EFL+L/wfoqvrSMjEc2cwWxIbg/nKn3DHYSuk8McCHWfudQ
         6a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762986881; x=1763591681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDBZhCwNxVXaARp2KU6VbEkAStKufeq/r52aZqJipig=;
        b=WJfYy+3/RTFeAhyksRJXdDUIaG+AmzTM8xVQVjq8rBCXZXi7WUEeoIj0sZgi79XFM4
         RoQ+xMVTozsmOsR/Z9vi/64zUNg4M/aUUhfo1kHSX9oSR+HDouxtOufnxAfV19o+YNb/
         9Km2oRrwM50ZLjVyeE9RjD8nSP3Ncuw5pwEXQpr8UW3OxRyGIcio183IaUZGBhW9aKOl
         Rkj4t+NJu9yxR8ng6FsznYiT8Ler1bGTEK90h4OxzOVPhsdsLkLATFbdeGoDGdILTZqd
         psusEAk49ihJGPe30ZRr4pl3J0FXBoE1vHAlwthSMf8lCa/hecVz3GEtApkgeZemMWz0
         pK+w==
X-Forwarded-Encrypted: i=1; AJvYcCUki0ZjAg0qJP8yWHggSm+wES2bvQJhvOrpR1C1Ur7wNM0bFoIThsHIMterL0utPpbkc+oMNg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv6xQ8k5uYeu5M77bY+3T4nI7ssGsjneCcU8JHAHR4D1ZohElm
	TvoXawWbmSNtCwVRo4ZvVJdXU+h5E2Hm/vfwjJYD6GOr7mzB4eSRPRGS3La+ayef6hY=
X-Gm-Gg: ASbGncu5P7+adoldDD5VcqAvYxOn+XCLGB+kkP4c0M3zNspMBApLBZ9tlrre9BsLU/z
	/Iu+VyQu53DoPH6SwqI0c5X2BIe6q0TXEUBsszGqrQeavAu76aY16qdLt+YQwzB1DNLTCMJVV4Q
	fSLU7nPnSTRuOArQLeFoCF6QvLItwOIEQMk0ZDd9sjqn0CpTnpE9neZpsAdsyxN3oAgO84DfW8G
	t518q06cDe9nsiZBmW9UehrA4PRniKRBu3kdl2qXrZOPSY11dG880IRk6uSGoRZHYojm3Wacr6B
	KNyJeux38LYQNIRxYBe/GuzPNMi4riFnecthG+VpvyaOay+Mdb7U3BtnrbwDIXV/jp66W0hEsQ6
	viBhTRyugM1/COsISy20tO1KsqAzqEmnpkL8uO3R3bJDzf+1LtFjnhdYkKolRn/vu
X-Google-Smtp-Source: AGHT+IGPfWBm38H3nRt+xzXpPbjxePsYgXweesLX/CiW1OacEQJsPx7V8b0B096XC3jH0cYT28BRPw==
X-Received: by 2002:a05:6102:54a9:b0:5dd:c569:a797 with SMTP id ada2fe7eead31-5de07e05c9amr1609473137.23.1762986881328;
        Wed, 12 Nov 2025 14:34:41 -0800 (PST)
Received: from ziepe.ca ([168.228.234.210])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937610ce6f5sm118250241.1.2025.11.12.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:34:40 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vJJQF-0001NR-Po;
	Wed, 12 Nov 2025 18:34:39 -0400
Date: Wed, 12 Nov 2025 18:34:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
Message-ID: <aRULf65eNaRIVEHN@ziepe.ca>
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>

On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> There is no point in asking the user about the Generic Radix Page
> Table API:
>   - All IOMMU drivers that use this API already select GENERIC_PT when
>     needed,
>   - Most users probably do not know what to answer anyway.
> 
> Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/generic_pt/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can't check this right now but I do recall trying to do this from
the start and it was not working out, it ended up not being
automatically turned on?

Did you test something like menuconfig and the IOMMU drivers are still
presented starting from an allnoconfig?

Thanks,
Jason
