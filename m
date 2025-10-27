Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC81DFCB;
	Mon, 27 Oct 2025 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572436; cv=none; b=FmfjLomxfk/fSB0JamgYZaYpLLLw7mUdIH3fCXodoSxnbR5L6HHk+D6MzeyHtvSoE90DnSJ0CTPv7xIqbymWGw2IX3nl7nK8WTwl9CRkvBkIWz9LJ5Pb2Wx35nUb3fSTBkiVvursOq79EgGYDdAMcFJrMfuAvAnCsWI+NLU2YPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572436; c=relaxed/simple;
	bh=zLbYrEbU51yqnKphNPrGpgZRCpZtR0wytakOHpYttT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hubYJVK+wA8Jy7UKHA5GWFBM80+qT1bWkCQJbugRIw2aDbOkGxoGF7c/Xdooy0B2t+IKyJP33nyi+wt7++tB78XC5W5gdsiIT7OteVthPlK5IP7yAfnhuynSjHb8vw4NRaia/Na4buiw0IBZalojkUOmUAmTPGH9VQhxnViLVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKPtcFhW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKPtcFhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873B0C4CEF1;
	Mon, 27 Oct 2025 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572434;
	bh=zLbYrEbU51yqnKphNPrGpgZRCpZtR0wytakOHpYttT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKPtcFhWfJUozcQVRtD9lF0QV7GrOlxpGfnqVkV1AAeMkTjKnowfKwmTFZaAr9BPp
	 XxqcPrzKpMGKpx4C7OhiKsG+yZBZl9Sv4h0w7xoedN5kgMBTtZU8kNlaXoetRX4am9
	 i7JooKct3X+cMwKWhJjEUWIx/8qpYh9XVfUXJqNG/kvX2trEvx9Jxo5XBHGRzvEznI
	 eZgmSpFUMvz1FFVhzi06pQJ2opoiwZ32Z8iO6TAqYydspYEJy3ldWVdK7gXXoEmOnb
	 Mx6yz4EpF5PTvyx5UL5N328WdC9Zgc4/wNO0cgcChsSheyLBrRCfD8KeSLidu7LrcM
	 FS1K2fF9vpRzw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDNSg-000000000MM-1HHB;
	Mon, 27 Oct 2025 14:40:38 +0100
Date: Mon, 27 Oct 2025 14:40:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] amba/iommu: tegra: enable compile testing
Message-ID: <aP92Vs7UfkU-Xvj9@hovoldconsulting.com>
References: <20250925153120.7129-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925153120.7129-1-johan@kernel.org>

On Thu, Sep 25, 2025 at 05:31:18PM +0200, Johan Hovold wrote:
> There seems to be nothing preventing us from enabling compile testing of
> the Tegra AHB and IOMMU drivers so enable that to increase build
> coverage.
> 
> Note that these could go in through separate trees, but compile testing
> of the IOMMU driver does depend on the AHB driver being enabled.

> Johan Hovold (2):
>   amba: tegra-ahb: enable compile testing

Joerg, could you consider taking also the amba patch through the iommu
tree as a dependency with the nVidia guys' acks?

>   iommu: tegra: enable compile testing

Johan
