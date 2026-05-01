Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41434F462
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639639; cv=none; b=bgR7KcNCDV7V4CF3cIOzK3vUe0g1CiOOICAdp+3yz99yeR1CA+HI2RcW1o75V32SR+qx95usxfcj5vf7Qlw/hM+z2A75oq0VobYs3S+8v4ITZJNQXfIV5jao/HRe62YVDGX/yZi4j5ZXqTFV/FJkMkweOzAXbsQxnu4CqKMcHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639639; c=relaxed/simple;
	bh=GVbC+W+06USeQejyjxxvPv8joUkpomif/D7x44Gf73U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f96Ngwjm5zF4P8Gc3/XonbHMsIkLBGBO6uB97qQf+ENYk20yCSgmPJ0t6SbTDkhVkDOGNoI/z5X4SrjGJciKUUqAhLVr5JJgy68Xbi6G/gbS4cQdLy+kNRVJpxLKQ8T5kYt2ThqJHXbhDI9/cNtTLH9nAgIGlGmjr84uyKPiczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kTE/yRWU; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kTE/yRWU"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a08fa355a1so26925056d6.0
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777639637; x=1778244437; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6VnYrS4OpoYLvnXY1t3ZH4F+GKUvLaqlaowydMT7CM=;
        b=kTE/yRWUkvxNvJ5gMheESjt5qsK2+6p6/5HEFmAJjqnVTjy9jNtmXPqAISIKDpeLXE
         lsV7bSYJvONsevOuxKLEp1llykKGjy5qjJTEqQFXyOu1D+y3Rels0KKa/3nx52JPk58B
         DJAa9LxB0EbPCb+K9zHgwCZm+SU4w8lDfL2+ZJEdm19zD8NyLT5az8vW1/z15U9Jn6UI
         /YjpqKHj74/RqNxP3JenCUDGDYdjALJmhRXWKswqK9VhIVLX2tr5TZZb5nChl1jrfF28
         Cr7PgcUj5rZPCS5ePpRMS+PquRf6vZJ6/nY+KF7sfTdcXJphSvr3oBsz2YUgNLFS+aPe
         HhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777639637; x=1778244437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6VnYrS4OpoYLvnXY1t3ZH4F+GKUvLaqlaowydMT7CM=;
        b=WvppMS5h5qDI96bEiUjgJDpr46jhLeqM1WimHtWqn24kGBsx40WK+pCm+ldOzGhQvD
         FpiY50P4XaFlNozvkz7iU6uKTU95+S1sdJFTCJ4sTmYWGfC4ftGVVQOyU8dYDfEldzA6
         ZoxCynPVmsBBcNg/PouzitUs80jWV67MX+toGKWMv9GvK7B3PmR07mOxWRoshOVH41XG
         LGOa3HYnoWvXCqct+69eLnQLBZzGGB/WLw5XwffpFBk9YBsazErAgGHyqxTHLvbPnQfo
         WcrqcIidau2Fb6ZyJxYf8qsKEWpVJzstD4RlJvLCiI5uietc6BY8XSokUAnOF9v21vh9
         /k/w==
X-Forwarded-Encrypted: i=1; AFNElJ/ze6hWUrZ9FB2yflqQ7irRnlJU6OtYOvaMXdsiD46ZX4/XKtru6bH/mjfEOTrPiJAx6+funw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyqj6EsDtGUu0oY1OLQ16WwyABPnd/EuEThhcyOHmvx45Ujo8nf
	KiwkleA4zM8PiFqKw53PgboqhB8FqwA2+wGNl9pGjCRFG4EO0lO6CqsaSKFaZfjhv4w=
X-Gm-Gg: AeBDieuewjj75Ky0IPGFHLigFxf7+Lflx1kZCgf0KtWOdCoWyf5eNFx6WqEWT8ziXfC
	UHUELXqEH73EMRVZcqByQYSJWkSVOrE5dOJxoWZrHUKNmK1CWSru5d00qn2LdVNiPFw6TttYh32
	80wR8QSzKqSm8E7F5vW+lMXmoFtDrASpUnG9OdZgxCgtACfzsRGgy7Q51rwT3UdLXXqv09X1Usy
	aeJxoBHsGSynfUgFavtvPDBfycniYcK76RakrS7DIoMvX7zu2oL+nmQ4lripAWbQslrsrT9XiPO
	09LyjRCTuRB7DNxTXXVwpD8caDM9hTF0T/su+GxQCFpnqgqWXSA6L6/Mo3VMNhE3jUwKegyBFzM
	+gi5sqR257Rq1mjE4oqNGIL+Q1UITJDsBoslzw0BdROiRgoxqmGYSdEw9Rf/EYEbwDa+JZLtKuw
	BIDFIKP80MlSMJPBWoG9o4egtwbcOL9RI9EAg0XezU1MuCmppvSUJfXgRuM7T2Fx7oEjMRbp+lB
	NJcgPh1Pgmztp/x
X-Received: by 2002:ad4:5769:0:b0:8a1:34df:bbe3 with SMTP id 6a1803df08f44-8b3fe795fb9mr109078226d6.28.1777639637543;
        Fri, 01 May 2026 05:47:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e6d72sm25671376d6.26.2026.05.01.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 05:47:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wInH2-000000059zk-2EQo;
	Fri, 01 May 2026 09:47:16 -0300
Date: Fri, 1 May 2026 09:47:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 05/25] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <20260501124716.GD6912@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-6-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501111928.259252-6-smostafa@google.com>

On Fri, May 01, 2026 at 11:19:07AM +0000, Mostafa Saleh wrote:
> Move parsing of IDRs to functions so that it can be re-used
> +unsigned long smmu_idr5_to_pgsize(u32 reg)
> +{
> +	unsigned long pgsize_bitmap = 0;
> +
> +	if (reg & IDR5_GRAN64K)
> +		pgsize_bitmap |= SZ_64K | SZ_512M;
> +	if (reg & IDR5_GRAN16K)
> +		pgsize_bitmap |= SZ_16K | SZ_32M;
> +	if (reg & IDR5_GRAN4K)
> +		pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
> +	return pgsize_bitmap;
> +}

I think this should include:

> +	smmu->oas = smmu_idr5_to_oas(reg);
> +	if (smmu->oas == 52)
>  		smmu->pgsize_bitmap |= 1ULL << 42; /* 4TB */
> -		break;

ie it should return the supported page sizes by inspecting all the
idrs and don't leave this tricky bit to be open coded..

Jason
