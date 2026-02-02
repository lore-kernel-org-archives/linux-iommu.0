Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5738E5D9
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075818; cv=none; b=cadA7+T0dhqtBTySkaq5iVrss0gn3due2IOxitF7Ds+5y23nZWJTvYQbvyK8JOBW9zEGSHfqfFDJt9PVsGDPWrPu14RL+xYdkZIXDXNii+Gtg4GUG0OugTN1UyGI9VmzOFRsIzEM46BwpGAge9H8yv+y10RscZn22UoovGVakPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075818; c=relaxed/simple;
	bh=KxCZb7m68SELksBw6wq/ZEyhCC8tdMFOFPozDlx1NLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys6Fh914JsblQUwR9Be4QrR4RNZLuwnhWrfQHt20fg+XTt9anf1OO3gUSJCYV/9nzuCSod2a11LY7laZ/y8+l42gY48P1P7P4I+MDYhi0XtWwcYNOXcplDlxRv83O3d1YE72/l0QLygh7HmaIwnC+vie9g46iA08JLOiv8lsKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B87XINus; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B87XINus"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-505aaab61d9so36867691cf.0
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 15:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770075816; x=1770680616; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lbr9I1sJrI4qHhUfKsSd+7bRl/Tu2BGmuFfiKL8Kjfk=;
        b=B87XINusd+3XsdTs+Fv+S8jI05P0ZhCbbUYiMcQ1wVzOUmRL/1ggk2Xo8xUjOP6hRt
         ioPWsROrvMIT9tu169dPmCH4E3wd0lrdPofoVGha40SfS1KYY4cebiZ70I+QCw9Z+tPP
         H1jdCI/oX+YUjIOV/7K9Lss/KiHYgEvnMeOhhuJz3jW2J8lib8YSYURfKprWDk7JMrG/
         +aN3oMotiFeMnL2MSMV/CXlEoHulrIH5ttZzfN8/wDXuyqdzeHhwL9fykf1LmTMzUrHM
         3a9PHCnLJeRwXvMgGCzDfEc9wQt5TcMcdGLpDIIwznDWhVQo9H/Cz+UmHaDt08l5d6a+
         4cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770075816; x=1770680616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbr9I1sJrI4qHhUfKsSd+7bRl/Tu2BGmuFfiKL8Kjfk=;
        b=VIkryWERXs8rW2tY/oserTCTf+Qb1J1OWHCYuFU90+q/9Th9pHDvLy6bNA1hO+7Q2G
         xFV7JTsBW6pDmcSRHCDSWXysNwbETi+GCNgmuUoh8BFuLdRb0MCzjisjczC2SUwP32uo
         So+NHhDeLMNP+NiAjVkqn7P9iScZn5HC5hFpR/e/ugAbvfN5eFjC7Mzfz+MoSL1dksPR
         r2tHW6TibpOIGLeRtDazzfEQIY+evGeSHjqWS65LhqJyuWuf0nro9ShiiSoce2zbB5f/
         em6sHLThNQNQBBjtFQP1ddEwzpwEbBAw5S4iUbmDbOCif8jE9ikPgvoFY8QiI3HWDq+y
         raMA==
X-Forwarded-Encrypted: i=1; AJvYcCV+wZMKT//Ur/9XL5h4MKlgiR+3DKdkQyM2e5g1A8nm+53mWIvV9VNUZzhdfdvfBJ9GjNjgmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvlzOwe2QKHsdbIdF2dMhqv92eTO1tX/hUAJXdqxrISS3g8T4r
	13QrtcJIC39a6qjAPNxB17oDQ2vA9g695yypE/98kXp6LEP9mD4iHMSifBcOHzH9r1U=
X-Gm-Gg: AZuq6aJTkFa9zokQ3UZNsY9/LjwWMF5xtOWK8s4UdfcSSHQYCzHcOnH7EN2cde6OUcu
	S+etSeSbBO7DC02UZWGdoIcMyfznplM6PQTrRR+AjrRW3IvhXSNr+67L9pCcFu9rNz+f88wnozU
	p75/kgg6UFqzGn7fp1IsGOMsDDtoO1vcdTQ7OLq6VMLA4vDLyQYNV3MDKviblBb3t1GMtczXrjO
	xT8URiyzjvfwMUatnJX90pkffZ8OAZOjZv6Wgc07gwdR6wcrftQ2fpHtqY99B5gAS71gnwDAQj0
	H7rZCc9KmGjk8tkPx0uOOt8joCN7pFu30DG84rgmoCuL2/7aqfF0ujHlcEQ0mH1rwtWsoupQv7l
	ZNHi5X1Cnol8XduauRmEl5APmO88kEKn4Ij2DVzt3mAqv0ZybkXEuqCL7VDz77+ZgJhhmt/dNXk
	jlfZ8a6cEcLeBhyFAvZDwseQ2EoayC9QxZrww7IEMfrNGsNLKDbPx4+3XjH+JzN5OfDis=
X-Received: by 2002:ac8:7f0e:0:b0:505:d171:7e44 with SMTP id d75a77b69052e-505d22dd9efmr158787551cf.81.1770075816093;
        Mon, 02 Feb 2026 15:43:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337ba4126sm120033811cf.21.2026.02.02.15.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 15:43:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vn3Zu-0000000GNqC-2QL9;
	Mon, 02 Feb 2026 19:43:34 -0400
Date: Mon, 2 Feb 2026 19:43:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Viktor Kleen <viktor@kleen.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Treat PAGE_SNOOP and PWSNP separately
Message-ID: <20260202234334.GM2328995@ziepe.ca>
References: <20260202192109.1665799-1-viktor@kleen.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202192109.1665799-1-viktor@kleen.org>

On Mon, Feb 02, 2026 at 07:21:05PM +0000, Viktor Kleen wrote:
> The PASID_FLAG_PAGE_SNOOP and PASID_FLAG_PWSNP constants are identical.
> This will cause the pasid code to always set both or neither of the
> PGSNP and PWSNP bits in PASID table entries. However, PWSNP is a
> reserved bit if SMPWC is not set in the IOMMU's extended capability
> register, even if SC is supported.
> 
> This has resulted in DMAR errors when testing the iommufd code on an
> Arrow Lake platform. With this patch, those errors disappear and the
> PASID table entries look correct.
> 
> Fixes: 101a2854110fa ("iommu/vt-d: Follow PT_FEAT_DMA_INCOHERENT into the PASID entry")
> Signed-off-by: Viktor Kleen <viktor@kleen.org>
> ---
>  drivers/iommu/intel/pasid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It looks like a typo to me too

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

It should also be:

Cc: stable@vger.kernel.org

Jason
