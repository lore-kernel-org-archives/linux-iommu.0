Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138311FA4
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 10:00:59 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F20992A00CB;
	Sat, 19 Nov 2022 11:00:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1668852059;
	bh=sG3j6AU8MT7jufEihjOKuYx6KM3TpI7FmwnE0kt4DPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wHI+bN/Y6atuiEw7CN4iZYxkoJGEz5uowLzy1V+chdLZlwgBnDWOPjBb0RLl5IKtj
	 n9jXzKIlquZoFNlGrpfI2gr17/ny4K1sdcfDx0Hl4kgYUBtF53PBL24JW09oakM9qF
	 qVWkvkFSrV8g3hZ1RFj0jlNGwkHrSndUBOPxOhkiEfKa/bOR4lzaotzWTWTPGjlXTn
	 sL2KmF8eDsRiUkN0k+RdUPzeH5Y90vBwOeBgL1YmzZfb8+FzB0wEhzIPlTl4Vm7TRN
	 15e6TLrVaNx6o56bX0lMpbAlg8JBp7dZpq+gFTd/BQK83illa5l/y5h4BVslmQzzAW
	 UwKx9vOyDrMKA==
Date: Sat, 19 Nov 2022 11:00:57 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Denis Arefev <arefev@swemel.ru>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] iommu: amd: Added value check
Message-ID: <Y3ipWTntw24G5XNE@8bytes.org>
References: <20221118104252.122809-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118104252.122809-1-arefev@swemel.ru>

On Fri, Nov 18, 2022 at 01:42:52PM +0300, Denis Arefev wrote:
> Аdded a return value check for the function
> mmu_notifier_register.
> 
> Return value of a function 'mmu_notifier_register'
> called at iommu_v2.c:642 is not checked,
>  but it is usually checked for this function
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/iommu/amd/iommu_v2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.
