Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299033ED
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 12:25:29 +0000 (UTC)
Received: from 8bytes.org (p200300c277327f0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7732:7f00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6B7A02622F4;
	Fri, 13 Jan 2023 13:19:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673612387;
	bh=FbFHaw7CG8FPCkGPoG6HKlHdu8f63492k185xUdeniY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4+S4Mg2bqJs6GklAHzrjRrdDc2WLi9Xz7n4g4/yad+HnQQ5+sl51gg4hVig2T3Ot
	 j7M+eGDa7FpT33hyTPV0J8Nnw+ZFKrjFDJTclRaiAvSyOgC7Qc0A1QimfHV8o3/xlA
	 WUqGmPtHfibu4Y9gdzqmngZTsbUEGKzaL/x63bNMUw2rWON36cYWrcA8L/BWQEiwIS
	 EruBlnZC5WluLGPG4cCdYDkOGl9Uflr5DkculBia8YzrZlrLAJAk5a5DrOmRNlzv3k
	 WrDAN5hA5ZuFcOXestwo5z3ubRcmzr8j1TO8rX7BwyrqZ8Dgtb4Kyl8UjQCFL6SBte
	 G50nGvUPs2Leg==
Date: Fri, 13 Jan 2023 13:19:46 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 6.2
Message-ID: <Y8FMYugtpgost7jT@8bytes.org>
References: <20230113110318.GA12771@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113110318.GA12771@willie-the-truck>

Hi Will,

On Fri, Jan 13, 2023 at 11:03:18AM +0000, Will Deacon wrote:
> Please can you pull these Arm SMMU fixes for 6.2? The summary is in the
> tag, but the main thing is fixing a VFIO regression due to the way in
> which IOMMU_CAP_CACHE_COHERENCY is reported for SMMUv2 devices.

Pulled now, thanks.
