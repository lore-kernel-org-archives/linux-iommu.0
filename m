Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FA5B1E0;
	Tue,  7 May 2024 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074523; cv=none; b=FIz6DUxsK19aWldW7a+5gtq2IQBaGtcFhauvYYHWK2E6d9TIguZ5ORzuv7RQ72xlQGjli4rK5nWqb9nbUyBJlFRXAfsiYLmSwXvp08p85EHhf6L1jKBF/r5j/0eVnIlYrl+iMgL3E9bsNN/tBXY6jaxumQl8bMZ5YB3lx0FnyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074523; c=relaxed/simple;
	bh=bIH6BSYqaydiAyF2D3DjIJkcTCqZTJxrCYi7Z04Qct4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBZIHSVfYhP9x6Wq94XLpHXoG/vJ7ulhAAi9Z8GHJ/S9hVKwDxyJHV963arx1dfhowJW7JAsuXaguOj5pqwCVan/V3KhX7EG2gbcuYznOMbQk3l2ein0evUScua+Pj3ZCRYvTK8ClVLNF1iAlSwKqAvkujqgGC9kXNTWoLlqeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Afrcw81Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afrcw81Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246F4C2BBFC;
	Tue,  7 May 2024 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715074522;
	bh=bIH6BSYqaydiAyF2D3DjIJkcTCqZTJxrCYi7Z04Qct4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Afrcw81YpBkwYWw7cDMm1PGEdNaZfAUo8URijH796dtq/rXwVrfhRg/LfjPb5MtiE
	 rfst5//YGc3HUxoEfRaz0+DerBUEz2pwmSJTM92zof/mzGlOyKhncEQNL1eYb76m7d
	 J6BRx27vOOKBTIaUbvhndLCCZldYc+s9LCTeAbY/3lf9XoGIpWuuzuPIns2t3yV7iI
	 5i2s8wDxi2xLrIETo3TDmY3Mpd8nx9Da1+PBepwYrwZtK3a/FazOML1Pctb5pU7gTS
	 xHV04bFHU3jwxEPHNrMAQNSbOnBfyo/SrILZ9m6LGv3/hF7rnWugxM7fyBICYvo339
	 SnRSmxhtqJuLg==
Date: Tue, 7 May 2024 10:35:17 +0100
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.10
Message-ID: <20240507093517.GA22060@willie-the-truck>
References: <20240503111037.GA17940@willie-the-truck>
 <ZjTk0YG4aJZiF0d2@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjTk0YG4aJZiF0d2@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, May 03, 2024 at 03:21:21PM +0200, Joerg Roedel wrote:
> On Fri, May 03, 2024 at 12:10:37PM +0100, Will Deacon wrote:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> 
> Pulled, thanks Will.
> 
> Pushing might take some time, as I temprarily lost access to my
> compile-test machine.

I can see 'em in linux-next now, so looks like it worked out.

Thanks!

Will
