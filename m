Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC03AE1AD;
	Mon, 25 May 2026 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692766; cv=none; b=ONQGbGV9uc3rvRa/8Sz2ZTMPImFdEJF3vXolDGo0WdbW04FMYg+HQ/h1GMJsqGAW77p8yGXvsM+oz3eDosbp21z2riURLcj6I8D7LTcwAjGltpnWx4BAE0nQdx0iDrbMYRvqdXsdhBnZdwAJk4+qcVpTu6/JW7m1L0k+WCRwqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692766; c=relaxed/simple;
	bh=Fh1mGEambcfDEu+L69C1Wygb564/eDAJjycCBSCQFOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlRUjzlGDSmqAoeTrCSRShqjn0jmeW6isIOUW/GS6QEJABUMDtdPH8cvHMkZE9xC4KQpZ3Jli7wQLpTPAVpOtUjKMgJrp2eXrlUh9737ZOmlAHpw59IgpArGW1d0Ql1MeewtETbT1QhVCEz3FGI5277hy6OgyAkJWj+yVHM3Kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRNLva+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRNLva+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE72C1F000E9;
	Mon, 25 May 2026 07:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779692764;
	bh=tKq39zSlshz2JLk+A5C/A0JVi3d04SAkhIgiWqzfHEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cRNLva+AUPtjAKJT9R2UpnuDsbcjzO88XyV3jCC41OegEeHO7KnSMOIK4Y9FF+s3w
	 SdBGNMEet92u2p4bMzvh2ccpOGcxDUIK2JVuelossrYGQ3VbwcYtNh6b39PBhj6uLX
	 LwDWsj3PVe/IoG3T9SB4iqX/xPKOLaaLHNAAxE25vfY5U1jK38inIFMOtWsNmlA0uO
	 OPMenGAyGK7AgiBxApliPhXU6/LkWkEJwhjmwI1fZMbb/pzzIJj14UfNI9veVeE210
	 QpSIoOI2H8t8YbeU4DB1r/AUx7koJk1PSfCU/OmXO4YXA/j4V+iHAyninVjnKhUBkL
	 7QYfaYBIFNYvg==
Date: Mon, 25 May 2026 00:06:02 -0700
From: Drew Fustini <fustini@kernel.org>
To: Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>, Joerg Roedel <joerg.roedel@amd.com>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4] dt-bindings: iommu: riscv: Add bindings for
 Tenstorrent RISC-V IOMMU
Message-ID: <ahP02vU6WTN_etDb@gen8>
References: <20260521170652.1880662-2-fustini@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521170652.1880662-2-fustini@kernel.org>

On Thu, May 21, 2026 at 10:06:33AM -0700, Drew Fustini wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Extend the binding to cover details specific to the Tenstorrent RISC-V
> IOMMU. In particular, a second register range is added which contains
> M-privileged registers, e.g., PMAs and PMPs.
> 
> The RISC-V spec S-privileged registers remain in the first register
> range and are compatible with "riscv,iommu" so the Linux driver does not
> notice any difference, but the binding will be used by OpenSBI and
> potentially other M-mode software.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Joerg Roedel <joerg.roedel@amd.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [fustini: fix dt_binding_check errors]
> Signed-off-by: Drew Fustini <fustini@kernel.org>

This has been applied to tenstorrent-dt-for-next.

https://git.kernel.org/pub/scm/linux/kernel/git/tenstorrent/linux.git/commit/?id=33583baeb1ba7d328e6a9775d889036900b74cdb

Drew
