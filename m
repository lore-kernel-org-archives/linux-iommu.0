Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3141B8E91;
	Fri, 30 Aug 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034362; cv=none; b=J5MDnVqHNBJkrg5FeEPHfFUA0aUM1EIhWqmxtYO2QqduqpfOO7S5js90hEw2xEuZdDDPjVboALzgQGi7h9whjrbFfCs1dT87Hqn0QfL5QRQWMqidTZaXEKjU9fym9wIRSei1fC7wH/LzgMs9g2sX6wh2uqirN7J7E5MZZjUXK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034362; c=relaxed/simple;
	bh=4vUSzrtzbqxF4YHTsqrl1m40oJesI+VvMoFuE5sdrvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvqNf8Y1KkZ3ydx9CF5lkIfGI9rr2+JQG2Ni/ZbjUwoCL2u509I3JFAqHuDL/qMpcbulsFNWosn6DD94422z2t6z4Z0142fmLibyr4EJwuuk0gTaB6DRtzZDl+zWpgPBICg79etd/w6OSVSS/nNezj5CDagjBqwzgZVjD2fvP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7Nb0SDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7Nb0SDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48698C4CEC2;
	Fri, 30 Aug 2024 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725034361;
	bh=4vUSzrtzbqxF4YHTsqrl1m40oJesI+VvMoFuE5sdrvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7Nb0SDWG2mx1Wusjg0AiHgDIGEbKYmmcaS+2HKO3Km94KVHn9xxcaOLTv3YsK3hN
	 owgtQbn3jpJIbOpqNywqUkOrKa/nJ5L/kZHx/PPbQqnHuN3ZEK+r3GfLm92utYu2vR
	 R5DZFs2zKf4ja0MOeKdQ6cJz/IAPr52fQewuaDNA6DcdXPf9z/QmdVXVlv8v9xCcq2
	 d0V0Xhf1S1Cx2zUWy/xoAvo9psRcRljcIPOMNmZJjSczA7qPU9PsI7KLP4OoabzCtN
	 JjqbGiLbEBfa7q+q2pLJGJbhb69wZDdMHJmcaGFs/5bceFrhG58/TTZnGt0pSvCmgu
	 y9nFHAje7j16w==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	Mostafa Saleh <smostafa@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jean-philippe@linaro.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH v4 0/2] Fix handling of S2 stalls
Date: Fri, 30 Aug 2024 17:12:14 +0100
Message-Id: <172503018121.1633151.4148376979460234025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240830110349.797399-1-smostafa@google.com>
References: <20240830110349.797399-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 30 Aug 2024 11:03:46 +0000, Mostafa Saleh wrote:
> While debugging something else, I spent hours looking at hexdumps of
> STEs, CDs and commands while comparing them against the arch specs,
> where I noticed a minor violation in the driver regarding handling of
> S2S bit in the STE.
> 
> This has been there for ages, so it’s highly unlikely that any HW (if
> it exists with such features) running Linux is affected.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
      https://git.kernel.org/will/c/ce7cb08e22e0
[2/2] iommu/arm-smmu-v3-test: Test masters with stall enabled
      https://git.kernel.org/will/c/070e326f327a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
