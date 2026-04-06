Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E303603E9
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482108; cv=none; b=nW+7Y2ubU0I8H+usFHul19ValYftD1r/EM8FNq6r4FmDa8YVlCZB2f6x98PdoMHwh8/mwrptdSKtLVQnSkIT5VJIEXMQwCgRuHjLF+qJh4cQ7JR5FfNlgJ+M1cFN13uMkZ/3yw4EMIV4K0wJ41kJimFB6pcbQeD03ipFnYBunVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482108; c=relaxed/simple;
	bh=RC4cWDaGAYcewo/NqMa6uWSAbqyf0AL89RTChBmRwxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXwtzzFJwYgap4UKW0fMqR+CmcWTZg4ozbzJt6/S9aWAcaa7JVGblCAC8O+XfX4oG1N0ZJvnpVgqPAeuzN+clxefjP3kEwGEuAaNcG+e/1P8/b52v3pdrm4WiO4aiE9rpuDeLt150oja2uo2tHNY/Bit7L9d3Cf27qE9pbIwDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ekwlolIb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ekwlolIb"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d8e11b948so10062791cf.3
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775482106; x=1776086906; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BmMy8/QJeirnzr9THEiEhYq+HjfA7YhjwHNqVDBObHw=;
        b=ekwlolIbEIw+ibbxLpMsgJvxGknJkIML1ucjKqHfBviOJXzSeqsuooNbjKhU55KOxS
         M+ZUy5mDdJTu9Ju5mJK/zp3aywD9uQElz2xqlb6rm1SazLwwO/eQsi3WoCdVyKFY+fqi
         WTZubObncTvvJbFtzckLIvmltKD8H2oVuVcK0uflsFaK7UyYFokpaeiuMAWHk6rIBmsI
         RsJv4deINR53fGCVd3Vp5z3PWktYO5qslUKtRiXzCCOVHLfDMUn3BCDKLltcTlax3utS
         /G2RUqUBGIrqI0MnPBxZaYTJ9XpaZsirwPlWvnoL+ogdskUzMduwbTTGrBw9rpPC91JA
         6zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482106; x=1776086906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmMy8/QJeirnzr9THEiEhYq+HjfA7YhjwHNqVDBObHw=;
        b=BRLuVE3ABqyBsc0+RAgrCiYdzdmxswS+/RB1qPCCxvoKqSYIm833GmEPM2rOch2RX4
         x7pHGrU+Iu7br2tEPY+j9C5DEhZmc3qU/Q3I3dnq3LOdgHfIE/fIpwnpa0odZxGbsC4r
         ro4srJvS2GxyfLHkA80nCgR3l1x5ljgap63z8U/GQwhvQnvRb2650d0NRGDwNOutwc85
         5x69YIuxUmY7os/fddS8umY9epSi45vuBHgXIJNwDeUkuZZ+XARIAjx4Fdz0g9HR81EA
         S3SWQOW232GoQ04tcnhLZCS5jYshIFuo/Dn3tzEJk7PRo4xJ0QHRUUpYIM8L6VwMIYLZ
         MBAA==
X-Gm-Message-State: AOJu0Yz675Y77j/38oWBPfaV9jpEdkNPJ0Yn0sjuDOMfmw6FEDksqCSd
	tbFiOfCk8mnrwEbZfJmi2KKi6kiamHhsGf/Py/jYJJYUKAFcPYT6xPYvXhZIa5RGcuU=
X-Gm-Gg: AeBDies9/cZp8Ovv+SQLwR8tffCtJn7S2Ce783pphMoHYdc99fn6qlPqAKM5UIEaYOE
	bJQJacKR6rZu03raxW+xe1DcWbGuu009RuJgXzoirtF6ZOyyAbiif+C9jogyvZEB+hhsQMtMqjy
	agueoEkwrrCAvtsWsnNlsrzfVlETFrysu1v0P1bRkyfiyoOMoAgTtt7FCD+8Hj2rqWrbVINuCed
	uz1ZGp+Z4uvuZdAIc1r8vq2DORQaF5cciYivWyg2SjPFHsidV2yOjgFBBOj1sb+ItCag+ws4U/V
	v0hTEAg71eewhWTaF3waHsUI+NTz+Eb/9Mfg4+kYUpmqvsM7YZZbLUzQRGqSfI9lY24I/GjM92Q
	zBBg/49sNHL5dMOpYX2tW4ccMR2rGEUGkdKJZlcd6gGmcjisGL43ZMo9L5T+Io7Q1uItSOPsuns
	0CsaSUCjpBmi8uxE7/88cpBbYW1Ys+GWlok/x2fv9IrQl9CNdLU1zVv5DgOLHD0Rc49ZLrCQ==
X-Received: by 2002:a05:622a:1e0c:b0:509:2053:ab60 with SMTP id d75a77b69052e-50d62aebe87mr197107481cf.47.1775482105678;
        Mon, 06 Apr 2026 06:28:25 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d63962c30sm85769161cf.10.2026.04.06.06.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 06:28:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9k08-0000000DTs2-2Cjx;
	Mon, 06 Apr 2026 10:28:24 -0300
Date: Mon, 6 Apr 2026 10:28:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iommu_pt: add kunit config for 32-bit VA
 (amdv1_cfg_1)
Message-ID: <20260406132824.GF2551565@ziepe.ca>
References: <cover.1775045213.git.Ankit.Soni@amd.com>
 <993efc6aec604ca6c7e706e5faf7ee216e70ce2c.1775045213.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <993efc6aec604ca6c7e706e5faf7ee216e70ce2c.1775045213.git.Ankit.Soni@amd.com>

On Wed, Apr 01, 2026 at 02:43:56PM +0000, Ankit Soni wrote:
> Add test coverage for small VAs (32‑bit) starting at level 2 by enabling
> the AMDv1 KUnit configuration. This limits level expansion because the
> starting level can accommodate only the maximum virtual address requested.
> 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/generic_pt/fmt/amdv1.h      | 1 +
>  drivers/iommu/generic_pt/kunit_iommu_pt.h | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
