Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222162574C
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aXqpuAAr"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6A0421A11BC;
	Thu, 14 Dec 2023 15:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702564522;
	bh=HrmgNZoTbTl3lSWG3muA8VTTeVGecUWY+AkVUaur7KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXqpuAArM2r6WSqvflso7cko9ggggynksNAll3fHte1UhiEUW1Va11Guh7GX5bCXM
	 71ZGWmweXyh11WG3O2ffgwtoro4rSUOhsdP/2H/qtascBty8Vdu6D7BZxU7rbY0EAp
	 7AKIt47XNRDL+1Dl0/e272ZDIcL7vMwHqaVAgcFdpKYjxP0QZbjYWye7QX1uqG5I/j
	 x5cJiFWvYNb70NwIZwWcbbdMGT/5aQgiupc0xjbA81BwlY4mCNmjdcKkocfmnN9nYr
	 F8FeJp3il/3qqS26JtymiQSZxtSsJfjsl70aikQwc49BjHWTRPvjUXTVLW8O8NFYNq
	 CbXVsyBqt1ciQ==
Date: Thu, 14 Dec 2023 15:35:21 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.8
Message-ID: <ZXsSqZGxulavBmuw@8bytes.org>
References: <20231214104327.GA924@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214104327.GA924@willie-the-truck>

On Thu, Dec 14, 2023 at 10:43:28AM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
