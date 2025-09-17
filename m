Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2B227EB9
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137980; cv=none; b=sbaUxWBOcZopajmxH6yijiiWAJa8znmjV38JKiDHemcapLmTOK/qbXNwzzmAYuer/947FLqWGIIHoNL9r0lfc5FCbOvMbemKiJQm4vlxWhpU9JsZkTkbneHMacn2CCY8B2wWLc4USYRCnSRIqM9hUO64Q8lBmoyKWvVHIBGCPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137980; c=relaxed/simple;
	bh=+QnggltKchDLGLemYARPWxsrB/q6KzZjJCOBzPmSvqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1y1UE6ARyqQh3gJzLyI55e3x2Ai1fDmQ0FrRqKKz8B/MOTuTN4lLpTX8RgtvFtgH2NMiN/y0fsLvFkLEP6vTb90bzIH6xnJzqz4J5vxxXMulM7n22YVBzGSt+CUhStjrNqLObVakWGkVcuOQ3RORnEkUg6gXrTAQMb8JrRN1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IB/T8fVc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IB/T8fVc"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5f7fe502dso1106151cf.0
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758137978; x=1758742778; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loCR1eKtWPQr2AOCV7oFDbaaSxP/4srZDyqT1RiPxjU=;
        b=IB/T8fVcLi0na9LYCryU7qEdUQVC76D2V/F9AZhwtuakh4J1brDjmgeDVSnsDPVLxb
         wMq/9j2OBmGsT9svd3DAyXTd+waT+REYYwqwVDF8Cx31JjrqhRVk5FLQvJBlKorTgY9C
         sSi+kNeuwTDw5rGWiA9j0/ZLZHs2PrWEaRW0k0g4ovi/C+Ean1uEfab+r2DtkXdseNTj
         gfBPrgqTS1gSj+XjPSIWT41JKsLKLrfmRwg/dJ0Ize0RMqAomL6KENlKj/VGBSNtLpzb
         THneRSP8wFDf9LrEfAZlq49BN2QNSOAX1+z6LaERm7xcPqH3YTE2giT9qr5fFt5NzkJ6
         DoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137978; x=1758742778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loCR1eKtWPQr2AOCV7oFDbaaSxP/4srZDyqT1RiPxjU=;
        b=PkoLnL7TP+0AzXGRceHcCP8pSqZEqUX4pTBb/1gpnEBpUM9dPgmwyHLOXaNtMq4yCZ
         hTjdqOZFOSKbp9Oo9JrhBXi4f8GcFm72KCw0oPQZK9CpLNK08fCKi1foLQXMm8nohzHA
         U51+9+3PMgofw2pMxp3xVKJwF5kNRk58c0IAruFDjqeoRHIN5q9Ybw1rZCde7gTdtRmt
         6Qa+/sybXf1bClFc1FFh/UNqdGdnBxmnREzWKVX3MyqHlZBUaauudpnEk3RLgJLY8zVA
         Oor8Uj+lbIcV6GjtxwkO7GZs1/Qu+SDoLj84/lxgh+9tBqGijETrPy9cmbUSSuY+mHOa
         tMTg==
X-Gm-Message-State: AOJu0YwswBpSDngJl5fUMkeOlhQKJEdNS50ksPFBUSVrs4c8Ta1ssS+a
	y5tpdcpKicUSHZq+rjHUykU8Oqngz/dFSTQVRr6aBs12GgR5exZnFoyfw2syhUUp4m8=
X-Gm-Gg: ASbGncuaMVmEXO5WZi0bds0M1wUVATsX8ESdidYnlbnj6H7grabivKV3OamFcgM2dgW
	E1U0Ot7YlDzrDnfT6y7eJ9hQrxeS2EB2MJrmE9S9KOUX1t+y0sIXyD90m5GQDBFPLm1R6bMm82N
	gd1uvaoxMPfUu6l4t/TGktZm5aAWKhXjfrzuQWoDpeYMVvvENiak5pydDOnlr91uSBBXjHN7kK3
	NKrz9Bji6U33G6jPrli/RKdE7EOHiepV05uZlhmDHblhbyAYRJxIfCtjuqR7bPKRWiIdo8Ko9f5
	3BzNRrCW5uI5/gz3YM7Bc7ULw/AyFZ/tk+jb7JGIO/KAeZBoat1VGCTxDfDvxvaQfZttL70Xl6e
	8H7K66qsFF+so2079YHlCaWOo/QgiX8mOb0jCHzrfxx6TTmCoBZ94Vi/CiDrW3p1zqRa6QgfnNp
	lXnq0ThpJ7LJE=
X-Google-Smtp-Source: AGHT+IH8rddOOuj2183qpUVyyVFif6dJ3P2j8BhXdLVsUERS6zel3c3yU22dws8RNYbBXoaWy5oC5A==
X-Received: by 2002:a05:622a:5e85:b0:4b4:eace:d0b4 with SMTP id d75a77b69052e-4ba655fa244mr47322681cf.16.1758137977567;
        Wed, 17 Sep 2025 12:39:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b3cf7sm2702201cf.29.2025.09.17.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:39:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyy08-00000008n9B-2ccZ;
	Wed, 17 Sep 2025 16:39:36 -0300
Date: Wed, 17 Sep 2025 16:39:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 2/3] iommu/io-pgtable-arm-selftests: Modularize the
 test
Message-ID: <20250917193936.GL1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917191143.3847487-3-smostafa@google.com>

On Wed, Sep 17, 2025 at 07:11:39PM +0000, Mostafa Saleh wrote:
> Remove the __init constraint, as the test will be converted to KUnit,
> it can run on-demand after later.
> 
> Also, as KUnit can be a module, make this test modular.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Kconfig                    |  2 +-
>  drivers/iommu/io-pgtable-arm-selftests.c | 36 +++++++++++++++---------
>  2 files changed, 23 insertions(+), 15 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
