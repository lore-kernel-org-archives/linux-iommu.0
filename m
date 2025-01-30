Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4963D383
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246610; cv=none; b=ig53eOVBaiBwwRr8p4co+buLR1ExkO0bKWJrmUMnjyvoWodksTDnLwiAy3H/0W2Q5325mgMeFCiJM+ICqXnuBNlkUHd5fCGT7t9RbKvtoeeAK6xGUPaMbx8TBYw+vVeeuM+3X588g/MblS4dgnqnPgmE0FzCGN11ujPr88n46/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246610; c=relaxed/simple;
	bh=eKFtaSi1HdST9VVRKgENgSCnuaaTdZ8+rnXRb1CzOrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRcoOG2u+JF1bnrq7omRN1s5AiCQ+FVaFtJT2HnxFImLqQWyqWc032CFNGuLEnOuAk6+b7JEbIYFV6ZcKp8ZrLrA9+oAYyK+f5dFVswMDRKHsvtVHvuQchiI6ZRKqhuwgoANugGdcAsAoO+/yGPezMY6bdfGaszF5I2OJ0tObtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F8nYnFGL; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F8nYnFGL"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so8109476d6.0
        for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 06:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738246608; x=1738851408; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dANM8Zs9s576kPdyfPzTz1kKsCDxnvejE2CxJSYcFDo=;
        b=F8nYnFGLXE7OZeK8dwASEvchKebctLAPHhrtZ+GCWAApTpZuQ0sOQ6AIbfrTIJCvJw
         U0mZUkOrznXdZ20cBbOp6sGNvOFL7MoinMSgypMhPCyy76zL6SdfDhdzkHJTQDex3qpO
         9VLGGA+KIf159taludtd3Za76yGuGfi7ilFoqUs1dB1lWFl9hOZRu5rlZ8F27ddzWqut
         N8ZyT+D9k/Og1fKl8JhMYXcwxFPDvR2jw5w3rf7CV8VWcCo2X5OkwEeEXTG0NxOkCba4
         n0l1yOWW3Igq5GLZ2sj1uUyVbwnqjRHs4mQpUV6yf8AqOjMkglhzlvEocLqCuKPEX3EB
         LSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246608; x=1738851408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dANM8Zs9s576kPdyfPzTz1kKsCDxnvejE2CxJSYcFDo=;
        b=ZGsIGKbKlTH8N4hRyHKi1hwKJwtFlEkq84Hoz3964i4O32u0mfOZStHAzqR8Pk/cuH
         d9Igw/4kf529vET4RCD02fzgkg+LbHFsx53UEMK6K2wbL3I3uE6Z7hl4tkk9mzqVeWVP
         Q0CN639gYCzt00WNKjtvO1aVDS/TX18ePe3sQ5M/URIz1c7wgTHTYR5dxANyB0CqNnBP
         VUyerSBu+70EVPq0jDHzfNA8ZZ1zXGPYM6UmSrZrTkdnxugjnHPXMESnAP+iWQuGvCK7
         iMR/MSKFfMJmSM8ADyTBfudT6/7qjr85IenUVisfRaUUdUTGNo7+6C9qt8TXmrlzcA7K
         5EKw==
X-Forwarded-Encrypted: i=1; AJvYcCUhd5xGmvdgofklf9siiT6dg5JMoLS6vISPXebhYRujEfw+v8rR2mcrjHNLvpcH41VYlVxnuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyV13fVwmDf9S47hEuhNmq9kx4942PPhQEfn0eyYoLu646rdQfT
	sdQVeNZeeRB/Q02usaaCjqXNu3d3kYw30Lj7tzAMdkLbIDYytjwHkPwYgoaGrN0=
X-Gm-Gg: ASbGncs4frDjOoFP/gDL1XgOqRNnhkfaIX2/ylh7sPO7EItYBbrjfcoH0x86mkjEZjp
	IrNuSPQ1HnQPHdKlATra4xl0mxd9ojLlO/duuqada0iTGVxEB4GbZ0UXHoNvL0pixZN2CQoEXxM
	gwSGaW0se9+Ljuodm+ASSC2Cux8D77D0fIUfZA7D4cSZqX+n40Zw/5Dc1cvwFtOKJ9WKRP1VIsH
	D6AONocu3vNKP9SbJ4BXPHCRqYMCVcR4kbKNfe4FPvjOUpz7jgOTu95e/ryc2Y3FGHcj6hJRNaI
	Q9WN2zOvd7gIoyr/UAK9g6e4y9dv9KlVYtUavHbRO0yPpuyev2n+F/ZdUlpNOWd8
X-Google-Smtp-Source: AGHT+IHHBHiH5Qa9dCXahKb1sFmoeQt6qg2bkg8fltQLMSNrrtwlCR66jinyVsJRAPaY2qDwMvtwEQ==
X-Received: by 2002:a05:6214:248e:b0:6d8:a9dc:5a65 with SMTP id 6a1803df08f44-6e243c98d55mr111873236d6.45.1738246608197;
        Thu, 30 Jan 2025 06:16:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254814405sm6609706d6.40.2025.01.30.06.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:16:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tdVLa-00000009dOr-1GlW;
	Thu, 30 Jan 2025 10:16:46 -0400
Date: Thu, 30 Jan 2025 10:16:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu: Fix a spelling error
Message-ID: <20250130141646.GI2120662@ziepe.ca>
References: <20250128190522.70800-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128190522.70800-1-eahariha@linux.microsoft.com>

On Tue, Jan 28, 2025 at 07:05:21PM +0000, Easwar Hariharan wrote:
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
