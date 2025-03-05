Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE7250C02
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197362; cv=none; b=mIj4mLP1+CjOcxbIWSKUfqh0C8A2nkwLGRbJqOODkxlkLFt5q+OZrG2UT1yNZb+PG22FSTVoOlhoJLgiev40TLfs1Cv3szIzsfKSGYmrEoUOCabM1d9iHbuSUJTdsYnET8Ue/CArGMkEzqhQVQmwklI6WA4ZYbVqlUTasN6ofTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197362; c=relaxed/simple;
	bh=TUPQEmrW/zlDUggHE/0eBZQD2cfbqcK2BAfpEugKfy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jncqpNYrL/yIlGLGO7Vnt3+2GvmBidDdfKhcF88pj9A8g7CPqgcs9eGBUM314AgXLWDRaTfuDaCKASbHf+mdMJgYORDwMJrWdHhZh8R068mvA/i8EDe+wuJJj1jZbaxDWUl0xRxL2m6tmO+EwSpGN7Xe8MHusNiw9mVv+P6tESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DumL5qf2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DumL5qf2"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c07b65efeeso619698385a.2
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741197359; x=1741802159; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ep2jN4skgI+D4W4EsgQGzXEpA82GjT/riHpbC+3iOM=;
        b=DumL5qf2mgDgek+65+u6HZiwqz4PLETecwkrTsKH7lurFebkhVtR2qc9TkLJ+8C4bG
         BqLpoEvAcP7O8zeyb4iaaMM0iDTmjx4r6sKeiWkDUdOtBf+WY8dAKMX7A8do2p9xwKw7
         zEJse3kE3V67fT89dUDI/IyRhWtVSRHVSpPSGblfQqhBQWEuxVguZjmJT+OsvzDzRHGp
         DgwM7Vo/i1bQ+xt7sXYlxhrw6DMlXNe1xIiIzT/QRhi1+i0q4Gx4+ejUsr8Mfdn8o/FU
         g9DXNdKBrnYku8/Efob6qyra0aaEn7Z52iqh36smaoF6Rdux8KW1JfUlZ5vwYnxJ+JPR
         bd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741197359; x=1741802159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ep2jN4skgI+D4W4EsgQGzXEpA82GjT/riHpbC+3iOM=;
        b=A8lD5xD9s80nMC6jo/8NmZ9B7aGILqlkQ8cZC18X8A9oxJXtoZc2PveP/z4U50LHlh
         KwJgmo8ZrDt7FzOxcHqOFitqNErrSiylAPnUSgD5Ga5Wtqkbgs4WNVhUEV15QLU6xpfO
         q7leN8c+xESqirdeDwUUkcp90y1X0fD2wkxniG9YOvp/jfTZs6LG6qez28CrNGBSZ9gl
         aVytvN4Qbj26shgd9sIgdTN3MwoBWGSayhPDqAzhN4HKGHiezs28cMzNKzRsFXUO3Vhc
         URcOp7tKc87lnAWwpLSYqC3k+74ZDXCYgZtTVKEGol5Z8d3X8Kvu4W5FLNWv4dFj38fs
         MYWw==
X-Forwarded-Encrypted: i=1; AJvYcCUa27xBxgVwPjcSm9MqEVDOlaAZfPSLqVUveqNiWj6u6W6Dj1mAQ8ec3GHgCioPjZsZQC7HbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq7H/GIHhTr/v4e/vN32YZdht8Rc5McTPyp+kmlip0ft5u2V1H
	8S9Dn1MuyuRKstMSe77bZXnHsqd6DBCwD5OuReLSVYYO/emsaRhJ8jgAmMoq1ME=
X-Gm-Gg: ASbGnctDCFSwjooMxyeuCKFXp/T4oYC6HZGPNLJ1nr5bDQyKusnquZ5q1woJvmvFMzY
	P5itxwY2rDIMFYrmQKldwjJXfc40XlveFFPmnTQx8cGXpAWdf3xtnFxUhxa4RtCqymrOeLjjPR7
	GJCHP0AcTRYEVTTHmFNR+OPBZSlN9nNsFPXVD3RRtKzf63E9M47QPvlqm7MJsRRp6CYdLQprrmA
	EZrBpK/lY1Z/SrJ8MhgoZpDG4sMPk2Def+z6GNzv7A0aEHB+NPHfaD3v7t1suQ4aLcx8wFp0naZ
	TknWqTqN0yl0B3MEIyU=
X-Google-Smtp-Source: AGHT+IE075gQ9paRBr5FJqePHxLiGeTWllaX8jx4kAg32gkUcqpKhkxzc9FKZ5jSjzoHlrJkCTJ+cQ==
X-Received: by 2002:a05:620a:8908:b0:7c3:cbad:5729 with SMTP id af79cd13be357-7c3d8e7ae8cmr768466685a.25.1741197359262;
        Wed, 05 Mar 2025 09:55:59 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b4c9e120sm486128485a.11.2025.03.05.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:55:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpsyL-00000001TVM-2YSq;
	Wed, 05 Mar 2025 13:55:57 -0400
Date: Wed, 5 Mar 2025 13:55:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 2/4] iommu: Resolve ops in iommu_init_device()
Message-ID: <20250305175557.GI5011@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <fa4b6cfc67a352488b7f4e0b736008307ce9ac2e.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4b6cfc67a352488b7f4e0b736008307ce9ac2e.1740753261.git.robin.murphy@arm.com>

On Fri, Feb 28, 2025 at 03:46:31PM +0000, Robin Murphy wrote:
> Since iommu_init_device() was factored out, it is in fact the only
> consumer of the ops which __iommu_probe_device() is resolving, so let it
> do that itself rather than passing them in. This also puts the ops
> lookup at a more logical point relative to the rest of the flow through
> __iommu_probe_device().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: New
> 
>  drivers/iommu/iommu.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
