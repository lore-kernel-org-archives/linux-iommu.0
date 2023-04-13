Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F3133CC
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 10:01:43 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4528F242D84;
	Thu, 13 Apr 2023 12:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1681380103;
	bh=YIak5Ldwe/BQilh0WkfdYryog/OSRH+LRu60YHJ+tEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=8u7cNWzkEM9x44hyALL5DgvudKz18EWanw3czcYdVmfsHb+39iLlXSpcheFsYkYSA
	 Hpiu5a/IL18EJw8xbx3gHzzg/7uxkMVRbr8x53DTq5DCHgTFuKAWjiMteM0Y4s+ud1
	 69M5VGnuN+VSs1sY+Knk2NuAFPk6RfDlzIWzgnD6qaz/tnlAyFwKErx6DFgz5Dg59l
	 Oq7OOJpRt1jV3nif07c7wA0M4j7+mLUvMM2h4kbTspNKvUhmiwsyB62EANd9+Ht65G
	 6eWomZpBMsKXakjzwh/COCE5xEum3ALZVaxSId2hkgvIdO7y+Vl3shFpUBM8DKh0hL
	 hwi6JVX79W0pQ==
Date: Thu, 13 Apr 2023 12:01:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.4
Message-ID: <ZDfTBOoBrxxnMWAS@8bytes.org>
References: <20230411142600.GA22971@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411142600.GA22971@willie-the-truck>

On Tue, Apr 11, 2023 at 03:26:01PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
