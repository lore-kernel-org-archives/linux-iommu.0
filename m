Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FCE23E325;
	Wed, 10 Dec 2025 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765336313; cv=none; b=JTGxEOUj7grileHi3bNtAiDnWXOBGGq0979QgJz2EtZEw3C2a9lfz/zCLLL1V8Y4vFNxHqJ3QbFi11DSpGJsnUEwAceQCutYmGHDVJr2wQl/J1Aknsw+Je05PFGatx8O0Q8GgLssWMkPehSHVT5YLGNIu6EwDjXrP+6oZJ07zzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765336313; c=relaxed/simple;
	bh=0124KkN7sv+bNIS1dS4ra69nUVh8Gemr0w5EgGpTRHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMDlj+3m/H9xgskt/b+WbhN78bfCbz9gj0ShDIZbWGeIOcNlxLF00X/WQd8eL7yhHnXWv83wE6QdrWsM6Y3py8ihwSE2HZwblFXYddVOCGjmmmFNdVcdooST0WFULQImzhWA09aA85QFBn1hqbCtX7q7Rx2D0Tbl6CdIBI0NOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAYmhjnt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAYmhjnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B10C4CEF5;
	Wed, 10 Dec 2025 03:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765336312;
	bh=0124KkN7sv+bNIS1dS4ra69nUVh8Gemr0w5EgGpTRHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAYmhjnt1r3wBsACMAP3VD2b5vEpLZxdkiuk3uvNzRSrDzh+ZhSuDBAVp3VX+Ofyb
	 VNhqmTtkUxwtWYTXQLXbB0U6XhpWx8ucHmXA7KBHQ1Au4YGpz8nR0xrbZ10rZFGDvU
	 qme07I44vYb7WvaO0KMoBn00l4z/077uZQ6sEnrMAnn/aoDKU2BY6Ttb7MploajeA2
	 aOLx41DkUIGUND8qMz4XEzluP2U9Im1E2E5WDJ6TU7MMIjM4nC5BEVY4XuttqzWjue
	 IgAd7fdHKrBY/h/pdTsYD6GUPsVZ6AX1gy81CtfHuCSVai0uO2YYq9qPB22eQ3g0l+
	 /jruG7m9bVzdg==
Date: Wed, 10 Dec 2025 12:11:47 +0900
From: Will Deacon <will@kernel.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and
 efficiency
Message-ID: <aTjk89lJFc3sNTN_@google.com>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
 <20251114171718.42215-3-jacob.pan@linux.microsoft.com>
 <aSXlAT00HVCGBaNY@willie-the-truck>
 <20251130145236.0000009d@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130145236.0000009d@linux.microsoft.com>

On Sun, Nov 30, 2025 at 02:52:36PM -0800, Jacob Pan wrote:
> On Tue, 25 Nov 2025 17:18:57 +0000
> Will Deacon <will@kernel.org> wrote:
> > That aside, doesn't this introduce a new fairness issue in that a
> > steady stream of shared lockers will starve somebody trying to take
> > the lock in exclusive state?
> > 
> I don't think this change will starve exclusive lockers in the
> current code flow since new shared locker must acquire exclusive locker
> first while polling for available queue spaces.

Looking at this again, we already have the same starvation problem in
that the lockword has to hit zero for the exclusive locker to succeed.

So my initial worry was unfounded.

Will
