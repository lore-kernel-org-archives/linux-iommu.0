Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13492FB0BF
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654322; cv=none; b=flH/zldnaIymlnIXPJd+8waFLDxd1NgSsqiyCIeS8JI9fhWLfnF7gzsMqysf7IZBNa6aw0HIk73OPiMpTb3qG6FOz6E/bUQa96+7NjkPnhTgrPjMhhTo/xqodEey7B+y65g0/2aOVcThy3vHA/HtSj+5iDRSq8J13Nc97QsZ8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654322; c=relaxed/simple;
	bh=6iqS6pI/nww2nERtNHBGKjrRyseW6VXKyAN/ovur7J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqB79l2Zr+UzewV4A5QibCaqtjcd/gETqEsrn1h9zkFEtWvD7xYcWtyQ28mz6QVEMdOgYUxHxTSgpSwy2Me6DHcvdrkO2qV4NSgYCLEBvizAYGesBY+pKjUfMjLkxGMB/VHDIWhyOZebEQB3JCR8rlCevBAb2Fd27JKPnD0bW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kuJ2gyiC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuJ2gyiC"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2731ff54949so34705ad.1
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758654320; x=1759259120; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shQ9F/S9E+ezjDmWjFc88/0zLU6nZIORFrqFjPoe6W4=;
        b=kuJ2gyiCDxjjR29whIjn3vW+kz0wyzUBIAlAzHd4DIP/hWNsjnoa9jP7cxGIGtec6V
         9PrSps/o4obCh+/rlpWCVHpjqyTGXE73wz6VD+stDmzZ1pTrIMcx8l4vUs//idPtCZhR
         ViNlC3FrELlvQ5Y0Fx/w9F3dNHLVi8QWMmJwFN8GTyZgdbEfcLiCAeNWOamQDRMClp9C
         Z6Usghzmf8F/qthCVFimYuFVBC8RHRvZFJVHKjCghncaywwqIh/9+Zq0MQmIhW/28SIr
         rj04EoGMxRt/mMbSiY61BVsu2TL8kpTH/qO0/NECZmJeHHNmL2B+8I0mMqXci0EJjL1w
         Vh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654320; x=1759259120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shQ9F/S9E+ezjDmWjFc88/0zLU6nZIORFrqFjPoe6W4=;
        b=tv4T6H8B+K2BE1MBwhmyJ0mrQ0CkpaZDfwyAVld0E+DDS4ex3FLyq6Aaj/1xPAfgR3
         BSNbWsq/r01m4mc48itgiCKIFBIru/Cu1iEY6W7gA1S6N8ccHBTZWy7nJJTtQWsByaDh
         +b2vjMIzi83vQ3f36rUTgLE8WwbyL65Js7G/h7th7SMuX0WiBCQICDPhOrl4f3RqpdpU
         xO7V6yGmXYa5G8V7Ijbt4QcsftV6ua618hBw5oKmDA+x1Jl/DhBEaWQmK5I5FklcrVId
         jQ4DPzDxZ19xnIJediK2IIaj8e/WvG10dSaBDJ5SFzzZXdplWWREli+CpllwcRoWLPPg
         pwuQ==
X-Gm-Message-State: AOJu0YxdzeuFRdkDN7ME9pKa3yEkX5UPzwx7uvDXxH6bkV2va6ARuchl
	d3bZHJBBN4CUrSdRJ1Nx6kDUJvD2mcPVG01DGVuhHMw6Ce/kPqWwgraVB5W6qozJng==
X-Gm-Gg: ASbGncsDImlm5cW1zkP0Th/ePopMsNw1+gh2eC6vFSK7Dalu2wvpR0r2wEyyTMbgx4V
	LZDSXQp5MTvCYmk0iYaPM1jgIyYCzE9hdCsQnjwpU15uIe7fP2o7AzNGU1mTkwKxGF5ywvcPDe+
	mMeh1QGP7WHW4oNMBLgkbPjYJD3s+qVoM4HXsNO7WoEshb+N3u3aUciLqPi5BNoRLCdB5aoIWLK
	KjXOCXVruJCD0C9cba+FkZJAtyHKVgHFXqfWZXAmqM80jS7nXNvzC2MU88CB+13+cYfyVrM83/O
	ZybK0ldy+eCxlhR5hxv7RIB0T+Nn6TG9bLZY/EC/7K0TtizNZiML2+tPP5872CHLrMTaveB9Huw
	TGKscUNaWb2jRo3MTJkdzGsuMaHiBPOnLKnl3HNqMi8JR3Fcwn62XYydUoTpyBpY=
X-Google-Smtp-Source: AGHT+IHVaOaeuEz2XAlC49A/lUlZuiYJ4YEiwzji5f5sfrXloiYMH7AkD2MYjlrCozMP/2Heq38dGw==
X-Received: by 2002:a17:903:11c7:b0:267:912b:2b4d with SMTP id d9443c01a7336-27ebf1b61a4mr578145ad.7.1758654319543;
        Tue, 23 Sep 2025 12:05:19 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b553d5b35b4sm8345090a12.2.2025.09.23.12.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:05:18 -0700 (PDT)
Date: Tue, 23 Sep 2025 19:05:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 3/4] iommu/io-pgtable-arm-selftests: Modularize the
 test
Message-ID: <aNLvaVHgOh-uS2JS@google.com>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-4-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:27AM +0000, Mostafa Saleh wrote:
> Remove the __init constraint, as the test will be converted to KUnit,
> it can run on-demand after later.
> 
> Also, as KUnit can be a module, make this test modular.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Kconfig                    |  2 +-
>  drivers/iommu/io-pgtable-arm-selftests.c | 36 +++++++++++++++---------
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>
