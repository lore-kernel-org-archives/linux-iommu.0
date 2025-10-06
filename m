Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBA27EC73
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753725; cv=none; b=A7l9PZTFYEZMb5FqaqrdG3Xj3PImLSb6CPUebBmlS8M5q4Eug6BONvCy6Jf5Q8gFYJZh3yRWvtXh1GskuvNZpO5gZnfPLnFzPyEzbb9rhRX1jg+Ox4Pw2fCVdB3pHBn5dDLP+KSXczw3lpdTwxwHPiHyBNJvFU44znKOTq05djs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753725; c=relaxed/simple;
	bh=bPX8VOTp1QfrXY7HdhLNzpQot3DGo5pIjjpBJLvaxCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZH1LUryJaOoCD009021OsdwoWyotHt3XiOo6ackILkVExbSTXJYLuW9c+tnyD63cXMmOolmJ+Kk0Q5B511iYHKeaiC1/RGxOaGUBf0onWzGHO+jKrMCboXZ470ZK9Dw3Nlb2GaCgbyZYJPrfnUBlIltFhD4gx+FVsWDepv9YvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IvqkgSUn; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IvqkgSUn"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-799572d92b0so47249936d6.3
        for <iommu@lists.linux.dev>; Mon, 06 Oct 2025 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759753722; x=1760358522; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUbpXXQ4yyj3v4AWvLzyWTF3lr3DrlW7tjo7gZaO9kc=;
        b=IvqkgSUndk02HaCRhAXDB7HbytfC/lRiRpsr5fmvcl+rw3SD0Ox+cYG/c9orn7TiUO
         txbMr/0P525D3o08Je+WUEcBLOmm0hh1dkQbUdhjOSBJeleqT8wc+fxBaqrbWuaIpXOX
         1jmR7p3qPWP2iyr8rYOMTWZwtNOwqpyUi/VnFLTLMosYxorWlBgeY5QkXQtzQ1Nmp6Or
         bL5qN6xOImBU2m51suswua7qNSzQ9Jxf/DWeJxkSnOeRnQGKLmb8bggfsFF25E7fDfL0
         XbC+8OA256uU7Rs0GHGeI4itkCp9SuVsRYzJc6z+UI36pQ4AuqQ1OKUbMRtO9MWbxgOF
         +FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759753722; x=1760358522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUbpXXQ4yyj3v4AWvLzyWTF3lr3DrlW7tjo7gZaO9kc=;
        b=weXX/q8CBg9APj8Jz1H1+fqxniO9ewlYEtuwQ5ul/Mje6B0wuBWdfe+anyiITeaGi+
         aLhJjGPizp/4lFV9AGhxUflmtatp6YvrbiZRSmrLPQ4MXRbWAzd/PtmBdIoil6gvKdpy
         ALxdq5EjJ6cydWnoj0Xy4/fPF6ztm+KA5SmrGmsVUyCOMxFTcHcxVfCl7PZyOaJCoh/S
         V7ChDfANud5dKgE1eI+aU3MXBZRCTnPRv26Q2HKHTrF2D5033ucyUO4SuNFtkBh/7Hs3
         wvxEY38EPBs5007w3PeXZGpQryfMz8U1UQiTUiG7Qh2+Ngu9++F56YG+8PGBetrrdHdD
         ZgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt2AxCDSg31tQjbuWWrDnyj5j5t6Adsod8J4QGSSSD+U/19zu+N+f/mofp4itT5iogxYIeqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaZhxLwmg+5/qsn3d3TeYblBz000X0tReJj6xeeDw7tdf6eHyb
	aju5my0AQUuD8wRcdMBjR6R6CuN+o8fliSrbtT82DWiBbNX5u4g8K/UegU+YB0O+y/w=
X-Gm-Gg: ASbGnctaDdkIPyDxejXUMm2Bt+DyRYo5xjWcDJIIZ66FBMoN7ctLA/cUqoaAFYVbpe4
	Df5rYrHOYA22SZc4nAvbvxkluD48R9Ww89zLzndqf0vofnNmj6TVApgoGfAdoswUraox4h6oQo8
	z2ibH6mNwuGHF2so6w2altaLBboxfdkJ33gWqCK+UwPN61SGhY1et6BAtILC9aNrw10JNnn58jb
	RnouuDQYFvleeUJeQoinRXJ4hFupZUssav9b2WYYBS7GDUsC349Yi6JUMQwIpzUemZ9h1sadKp9
	VJ5CofCzqymnTnsjhhdA3gDvi6+cbwAhfUcPUlK5m5AxJ1S/Y2MZ5L1G+l2XezyjZSOHwZzNcpN
	VwQeUvRjXEpEQbilABLNXOTFaR9BIfqlQAXQbtrD+tMUQrL76LkF+KQqR24O+dAYBeny1VMRDxk
	1fBxCKRFrZ/9rtl4ZY
X-Google-Smtp-Source: AGHT+IGZNLqfnr5O9iQKw3AGZpaVITwpLyAJ8L9qbJLvT8gNt+m55TMXIYqK3nE9Ei6s2lIpIel3tA==
X-Received: by 2002:a05:6214:194f:b0:7f1:62a9:ea2f with SMTP id 6a1803df08f44-879dc8829a6mr164160916d6.52.1759753722161;
        Mon, 06 Oct 2025 05:28:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60df0sm116491006d6.3.2025.10.06.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 05:28:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v5kKX-0000000EPrK-0UTN;
	Mon, 06 Oct 2025 09:28:41 -0300
Date: Mon, 6 Oct 2025 09:28:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/pages: use folio_nr_pages() instead of shift
 operation
Message-ID: <20251006122841.GC3365647@ziepe.ca>
References: <20251004032351.51150-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004032351.51150-1-pedrodemargomes@gmail.com>

On Sat, Oct 04, 2025 at 12:23:51AM -0300, Pedro Demarchi Gomes wrote:
> folio_nr_pages() is a faster helper function to get the number of pages when
> NR_PAGES_IN_LARGE_FOLIO is enabled.
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>  drivers/iommu/iommu-pages.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
