Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60907AD24
	for <iommu@lists.linux.dev>; Sat, 18 Jul 2026 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784416568; cv=none; b=eNbvZAy3d+400dis1vPC0HI42Qe8jV+eo03TgPUEyp/SejRenjjMsPRZHEA/f1GIsyl5P1FvAeGmOEn44hwZ1bt9WOweZWSEP6gCzKhI+GwiSBO23+0DGytV5/nevEjoavDRWiPNccKTRf6waXD/4btA7wrSNkiSN+H+6hRKL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784416568; c=relaxed/simple;
	bh=YziOsZAuz5FyhRvti4+0bqRF5BJSUN2tM+fuVXppn10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1zILrxC6U1p4LLgxlWQEjOE9uj9Fr+qX27v0bGYdha5ixwSXQJhIFFXlJPwlMKuDn+Q2fqPgY70SYQ3soCcGd8ZRpvxeyOk585+/UHhNQ6ko9K2iQ+1MpV0NIW6gRcMvt2Yaerx0k/oQDio4fEJoKNcrw5YdSqo/eziOzwgI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NvpiRqGh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NvpiRqGh"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90004d2f7b7so118829166d6.1
        for <iommu@lists.linux.dev>; Sat, 18 Jul 2026 16:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784416565; x=1785021365; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YziOsZAuz5FyhRvti4+0bqRF5BJSUN2tM+fuVXppn10=;
        b=NvpiRqGhRXFBaOAZFChwKIbfvAi0AHSby0IR5v8UBLvUY9l8ssJMaP6pECGapyrPT7
         khpELN3HRSwcEnXMt/23FgVTjYjrANdT80EIy/RtKKGST1A1/jqR7M2VWN1ZE29xTFEx
         QqqlAa5vF8cd9EHyZ9JOY7uV9kvd+58pTATKHh/ZERAM46tzIZmqifTwUkQpCo6NebT2
         c9oW4/uXbCi94XGylZnl1B/tVL0sH0VphVPCnYLSFT2Dyv+q10CvsF4PwejXwXcPlg5N
         ymgltAYtspqHw1ubZpiJqwEaoGfNJoocv44kbScOBVI1u0sGTp5T3H+2zveWtyG/DBZC
         XO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784416565; x=1785021365;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YziOsZAuz5FyhRvti4+0bqRF5BJSUN2tM+fuVXppn10=;
        b=RW7rzeU1CEtnM/4Rkh2J/WBRlio//Ch5A2JS3K9ZbzyaKMM7REwfJlYiYHGADiDzVJ
         umg4EhOUetDRdu1DzYjEx68uiHxeTzI8h7QZcf3WTl9hXbWILaMsPKTJzbxB6ZtIeQ3C
         J8qWnV42TaTSciYh3+7VNVhNoqugK1U+5HNPEx2b9VwNujM7x21tHy6SuAgKPxqmQw3D
         mGa+hKAUKQUPVzumW34oY68k2r1EKjYnOPiw7c2ItK9QXi+KzGJjqvPYC5qFQengL22G
         VAIzawpBFe8w6qe6KnKZ3+dmt00m6dIpYTXkgE320AeGGsAV5a/5LZLgU0avS9Ti/nfM
         DhOw==
X-Forwarded-Encrypted: i=1; AHgh+RqM4XhLwPCqNok7zgJ8JGgPF6zvTYJiZL2lnya25v/fRvDgr+UUR3nZbohNfqirS49iGwb+QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPMToclX3GQAAZ/o73v61voQATD5E2zB0fFHre5B8S7U3fnzLT
	yg4eVGfsx7VzjRkC0HYlyLhQFtyBsPHnZoOJYs/+k/2CHUNvy9TAcvgRyDjxDgwZiRQ=
X-Gm-Gg: AfdE7cke2en+1jsBn0MdBcx4Rf7vOOJTJ6H+CoGplz9BMr5RFh6S/okPlClb32d4A0F
	8iKBEm0m9vcuapF5kGW0tcB9wD2CwlYFKbs4ysSDquoWcX0VPpDR1bZgCZll3PRcS1CIH52upAJ
	ekEiWZLcS+x3WtRfC59sMY2PsTuulXg0+58Jjp10/tGXLXgpbJHd/qCvwNJlvMQjMQRYGRJUuVS
	gBhsRD3Aw0x6bZZHjM0mhSBZ0pyVyDEeR2YfE/aWZoRiXVtyI+upJB/o6TwrJF9FIOTKkywW+Ge
	OEwfvnJVj1BqHqMcYkNYIToFOIgFBGWSuqkWGW6VflNa4fmz5WIQwi6AtYELe+aQG5I26kqtnMf
	4b0Vn0powEbTnXH5kVaJ4uXEkrUvwBZWNaYVjZ6NwhXLknrnEOTdyM/cquFqo
X-Received: by 2002:ac8:59c6:0:b0:51c:18e4:38ab with SMTP id d75a77b69052e-5213ee7eda4mr74584161cf.66.1784416565170;
        Sat, 18 Jul 2026 16:16:05 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214fae3268sm40901021cf.24.2026.07.18.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:16:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wl8Ae-00000006ef0-0ssw;
	Sat, 18 Jul 2026 13:45:48 -0300
Date: Sat, 18 Jul 2026 13:45:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Ashish Mhetre <amhetre@nvidia.com>, catalin.marinas@arm.com,
	will@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat
 workaround infrastructure
Message-ID: <20260718164548.GI701389@ziepe.ca>
References: <20260714104202.1664187-1-amhetre@nvidia.com>
 <20260714104202.1664187-3-amhetre@nvidia.com>
 <20260717201841.GC701389@ziepe.ca>
 <alqbxaKVYFX1BZR5@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alqbxaKVYFX1BZR5@nvidia.com>

On Fri, Jul 17, 2026 at 02:16:53PM -0700, Nicolin Chen wrote:
> Given the use cases on Tegra264, instead of patching the iommufd
> path as this patch does, perhaps we should simply spit a WARN in
> arm_vsmmu_init():

Nope, in this case you need to make the errata discoverable through
the viommu info so the VMM can validate the right DT is used, or apply
the WAR itself before submitting commands to the kernel.

Some kind of new flag in the viommu struct I guess

Jason
