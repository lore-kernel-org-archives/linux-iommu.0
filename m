Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424248;
	b=cpFvBeGCTOxMZWqvnE7pDJVV5pvTT6T3rRwb8cCB6IMahpt5tbcZW3XH4KKOEiiXVnhG
	 tNPFx6JwA10VCIa22vYQ2cos803fIkqJe3w/yNUcIawRUe9KRvsbAb8J0Ypb+4bvf4XXk
	 aIq1wU+AEZw6y3DVwpmZ8VF+gPdMevCsBU8icGIIJf1B8FZ8kg5WtEDjdlFeLWfUGCy8h
	 aTPCoFrlHbnpv3s1TOfvRP67aHPoqgFkWNAI9esqXpLteoOOwFg3Oyj4lPWshn+KO4bys
	 ZmxzBOcuJt20ry++YKFL1rAQQz/7iJImVXqIAT12EO7fsu8eKROfdS7w86n9+2qHkAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424248;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EN2Bg5eVxZXsvBNAnQoxpyUS4DRjW1tvWkJO+HXo9CY=;
	b=yeuU3NUXi3VxxQ5ltOifkxtj7a4IEodYdW0zzYQMKO7pd5RdDVCiruN4i75sXew8Nm10
	 ZAaLsBqagm571xOj3v18eSMWXFCxuC8SADvHFCERI9xUtIq3zJFCAUH4BacYeuasJsJY8
	 uHQ2HuOFqBpBcOgJwEhKzSU0ct3eaVLi0UFtSeEGHCVfzX32Pqg7VUke591imP/H4nMrG
	 VVCqRk0l/IVsh8DAEiCECkY8i8S0xly9w7NDAxgHSDhTpo2JH54UKjYz6jIMkQuhwCpZ1
	 XwouobsnG7iAofxPwVygeTGtFfH4Gdrhhh51SkfS6g1CtVovBnYE5tykzMrvZSPuPNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E900E606A331
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 08:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E900E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id ECAAE2436B3;
	Mon, 23 Nov 2026 09:57:26 +0100 (CET)
Date: Mon, 23 Nov 2026 09:57:25 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Cc: Tomasz Jeznach <tomasz.jeznach@linux.dev>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/riscv: Use named initializers for acpi_device_id
Message-ID: <awP_4yyEoGoMggNL@8bytes.org>
References: <20261014-acpi-iommu-v1-1-1744523fa658@thegoodpenguin.co.uk>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-acpi-iommu-v1-1-1744523fa658@thegoodpenguin.co.uk>

On Wed, Oct 14, 2026 at 11:26:33AM +0100, Pawel Zalewski wrote:
>  drivers/iommu/riscv/iommu-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
