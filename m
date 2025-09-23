Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200430217E
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654186; cv=none; b=mpMaO+CY8czgjkHdNkhTfxswTBzqO/I+ccQQ/PGPR6ED85TH2k6Rcw+ZdCWT1IdeQ279c+1dk/GrjD48hZBEH7nuNfAEOXa05I3y/JOSSJyVil0SzY6tc7Gq2koXFKsPZbA1deqgj0vCu1bc1r37tdQ/JFWvLXuQbstEl6Zt1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654186; c=relaxed/simple;
	bh=ES8bny/uFKCqecBlbpF5uVtDNo2HFYQ/5ff0CMkFSbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z02Z1RSW2uYTZNfYs9mFAyVB0Kpd0kQCPKYLzpXyAtggOHORoWuUkKhBCHBVVOKzpxyEDoDJeRZ/+GrR0M5G5Hvl72pgJa/UkhKgxg4TxP0ugJDPLyudFHR7ZWzc5PG1dNsHMIG4UMwSLw7R77KwnwUBXi4O2UQQE1hvfYzULpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqszevpO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqszevpO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681645b7b6so32645ad.1
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758654184; x=1759258984; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOuC3zAW8kbxrBTL2TNiZ4NT6BGzG/ERW1AmxrJRhXE=;
        b=rqszevpORWgBoVfoWekqt+7vtU135TD4i1lmEg8QBRqRYa0yhls+Cnldjg1JLQMcpS
         hAq4BeuVEsHRDC8kBDGj8NEqZjFBa8zXh+Li56kfgSBy1t/p9zpFxqZKnQ2WpjcW/IP3
         yFyGe0ihJB8RpZEpwBYudfQ5dhjbC9UfJ+t69BcCSN4mOZQvyLmeTQMsmn+UjxG1+fkM
         FoqCYtRNTzqj9wkTicLAZcMJ3w7D6fgh+5NCgx1KnXY2EF/iCEO52mSiCUQ2cFoNUU0r
         /Bogy2UxMdyfwnZY4a8HFz9Db94jRe9L5Wcj2XL2JAhXc1SpMRuRrOeQLIX6OlSYkzmR
         4DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654184; x=1759258984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOuC3zAW8kbxrBTL2TNiZ4NT6BGzG/ERW1AmxrJRhXE=;
        b=d8zlwdc9ba5SKs5VAPuUyvsjwMmO15Z8reMcdurnZvUemKA3Upb162cFcJuc9Xh4Jm
         6AnwYfqB8mjRlX3UdiCQFJqeNtQ+/6UyU6v1x2+vDgrS6TN9CUjeYDKCiDcWZfquEXgW
         Tquu39uK0KxRZEV2+zQ6gvgMfQAjIH6tMyQAc8bE41eGSeD/BXaHMgQwBcXNx1KvwAes
         GGNV9GT12unSFykMkPiL+6oP1jADXB1VjdKKCBLweRsFz8A0tPj5sXBYenjsJcNMdpLJ
         xMGPXt5uEJpIw7sBmcuKdRpr7jhiVl5Q+aPTX4CGI08n1NvDgMaukUYkxK25Ah0dPdcQ
         eGUw==
X-Gm-Message-State: AOJu0YxjqUpBVc5nfzzjg0X0bq5wWymf/LZ7o5etln9WAmzLv+ZRY9ls
	wrjTmS8pNnp5TwJVkB1Ly98WG3Lcd/B2c7e1LHgVnKZ1MBtAGguFW3ct3yPQal0e1w==
X-Gm-Gg: ASbGncsQcWce2hkDvwsLheaOe0AqKLXajsqG/IHRBvtSHZPUOsqxx9Qqu76Bk3xtvy9
	g0D/6AyiC7ctGRHf8kfbny4j3XkyUMZ80Oj1ZBOQU482vNNyERTczqG3+CD2e477qzjMue7wEuW
	0cZx/CPB+xqAYOzFaDcmFFLKnSwxzPraIju9tC3or+qq+D3pAUDyZ81T4vL101RHw+bOdfKCOdJ
	6vNN/Qftz4uIFheNpZsqmNkWpF6t3yJm/T7rw+0BxINfr69ySDxDiBcEfLvCni4eQm66VPLzpp5
	uWwN6Mrx8DaK7FuHcHyL03C1Gkuzqw6MGH1SoXmhhJUkMLIBuoQG2zYAkhQhjCwimgfrwuqTqrG
	jKChAq7KubUfV7xpNUsnXzB4yxaetX/MQZeWb/SFYIWoqnk1lXCxGg3rimQqzsQo=
X-Google-Smtp-Source: AGHT+IFRAqJuhYAhCis6IihkC0Dv0zYrlzWqXDH65c5umCcHF3NmW4wRGvNj5ih/do0Kdj3XI6rCjg==
X-Received: by 2002:a17:902:da90:b0:26d:72f8:8cfa with SMTP id d9443c01a7336-27ebf19022amr553925ad.13.1758654183589;
        Tue, 23 Sep 2025 12:03:03 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273e8fasm19914155a91.18.2025.09.23.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:03:02 -0700 (PDT)
Date: Tue, 23 Sep 2025 19:02:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca
Subject: Re: [PATCH v4 1/4] iommu/io-pgtable-arm: Simplify error prints for
 selftests
Message-ID: <aNLu4R7VKkWNmvxs@google.com>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-2-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:25AM +0000, Mostafa Saleh wrote:
> At the moment, if the self test fails it prints a lot of information
> about the page table (size, levels...) this requires access to many
> internals, which has to be exposed in the next patch moving the
> tests out.
> 
> Instead, we can simplify the print, using ias, oas, pgsize_bitmap
> and fmt is enough to identify the failed case, and the rest can
> be deduced from the code.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>
