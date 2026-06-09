Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE93E47B
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964283; cv=none; b=Qznj1YQt/75UZqEYV5HBliI5mIgZqDDe7B4xbMlR1EDt3Ny/naZI9h4XYWSXTpXirQOuAeHI7nSnT64De9BS8o/YiuNG1Ch9rR0OE0c5HZSG5KguOI6y3KNc2TK2bK0zljtQINH+QL2Xu3q8zriL4EHCuXXTZ52ogJn8x3PTcos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964283; c=relaxed/simple;
	bh=/BzsQnwRFrK/hqvtOlttIJXnp8XCgsxJk1C9zu5/bt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7UEwF4cxmQbCdZ0PU/wz/NmnsAGkB/Hzhg2uI2m5sF45YgXJtvQWsS5DXgVzVJdON3i7MbiXMMVavhd0wmh8j0YZhR1UHM5SKc3FmcA9sg0KoEagxaHTGyj7Sf+7nQKkMC5GxGgxxehIjbMeGNCfnnBH4psAwyy0QtYfl1gX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JLXxXcPw; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JLXxXcPw"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8cd45d4b7e2so57659926d6.2
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 17:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780964281; x=1781569081; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJrcrd97RrpK34MMckrW+u7pfPo1y7Snw62FaBcwTvE=;
        b=JLXxXcPwDEe/HCrdxhORYcGXEyxcCmmu6e5hTFCRti6tL3LxzYnIHXiBoLVk8TWhvA
         7Ai5ghTewt2XQ1Ovvm0y9INfrn5Lqx9gj1kl7zh6awcSfIX5rAJxHoC18P0IZ5pVSj6H
         uDXiENFCmUf6Kb89PQcsZ6K/hfz1Ypk6tqs6P0pldx4sjCsvt8pTu4BqiMomjl9w4gSX
         TIJvKquVj4DVNFlfrx6ZV1lMJA+TJzA2f++CqWbE4ISlrIJ5eNa2VpuvIR3OzHqzmr3N
         4Hz1FcL5Rj3lvB/5lCHgiLocjWIy+iyI6F8o1hfQNmT0epbbKAE8Yi0bjRJFDjTbxnsH
         zI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964281; x=1781569081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJrcrd97RrpK34MMckrW+u7pfPo1y7Snw62FaBcwTvE=;
        b=FgV0amL3PgV1YvSa6+AG/igk+Yc6SEcBLTItPdYfjzBcNhcYm0RUdo1F0F8mnZVupT
         yp/CobnrLyqSPK83bPNBYdSqooCtc6suxwuvfLx5G6KR7gh4NUZfEKuRSG7yJ8K3wka7
         NCFrK2YFcC02ELMX0TG2gSOdz40NPjCLzn4VmnXbGI8GBYsFi3/2yTGuL726OT59MbZ9
         NjZqKb+0Nie6UW8TZlNKXNhntv3s1iMCu5wzFjQhp71WgaPrXHjaspxGgW2I5TM1iZl9
         hfHcnJ9rKCqIwHXdvqx5y6MHQtGUiEJgDlZ4OvXR/N0Xwv5dF0P89ocmxJUoVGdPiaMi
         tbWw==
X-Forwarded-Encrypted: i=1; AFNElJ82UNJ495ZQPv9YxArHl0EZpKLDcPXAu3hljyb80pNu5E9HhIFJWobqhcVNAJdEGwOW4WYjug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5RrEJWAhmup8JkIYBbHjdtdTegdfPIDFQpqaM/Kfin+9dr8kY
	4W1f+25EHVL2MQWNQKCisQ0Dvet6dwGFD29US2V7z5UHLecvwkRh2IEh+Kn9zFN56S0=
X-Gm-Gg: Acq92OERzUZLvYP85zpOi9qDFsFzjuJfwK4UuBNgMdnuqyCVuQsGXzOqI8dc09UU2xG
	fuOLPUzcwxPLezm1LmBn7fK0BRiZ5AIhnhBoVACa5xtF/hLACiJDTdgCCdWPzmNAySKfaZNIJex
	uccE0ohwczDlmeADonE0+/RPs+wpGaUj5QxJCqUNFYRd6h4rVTgqTWhuLG8Xg4E64oWd2rFkZNI
	CaFhwrbHqtSDMIWXf0ZdM3fx9q/q5rJUf1MzVG+eezWAg5yUpSMrUA1jojgg4NR+jj8lN2XfMIR
	cnhS69uZSijLhroZtpsrvAdKKo+brmsgTuGOlxw6rR78WsMUNvJ6Ygf+YeAxPln1uoTmaRIXA6F
	6n+hiqv0x8PCN0JJPqtJiIOzot4i+W7/WxD03Pi7cbGBx6qY9fml3qDmF4yLrwjHlggkTiEz3U0
	ii4P4+kyfTrNaMHoJ2OfmhK5LR1ey+g4rpEoRchLWNrRWV8fMf708utHhpAbqsSeHUoUoFIBwh1
	kULcOPO2tTqfysvPmEUDnOdIvs=
X-Received: by 2002:a05:622a:1b15:b0:517:8f31:df0a with SMTP id d75a77b69052e-51795a08705mr257391641cf.8.1780964280672;
        Mon, 08 Jun 2026 17:18:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c4d7absm165652141cf.11.2026.06.08.17.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 17:17:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWkAI-00000000rFN-46mU;
	Mon, 08 Jun 2026 21:17:58 -0300
Date: Mon, 8 Jun 2026 21:17:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: take dma_resv lock before dma_buf_unpin() in
 release path
Message-ID: <20260609001758.GG2764304@ziepe.ca>
References: <20260526111034.4079-1-Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526111034.4079-1-Ankit.Soni@amd.com>

On Tue, May 26, 2026 at 11:10:34AM +0000, Ankit Soni wrote:

> Take the dma_resv lock around dma_buf_unpin() in iopt_release_pages(),
> matching the iopt_map_dmabuf() convention. dma_buf_detach() acquires the
> reservation lock internally, so it must remain outside the locked region.
> 
> Fixes: 8c5f9645c389 ("iommufd: Add dma_buf_pin()")
> Reported-by: Ankit Soni <Ankit.Soni@amd.com>
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/iommufd/pages.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next

Thanks,
Jason
