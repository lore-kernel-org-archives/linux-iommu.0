Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD44212D2B
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411861; cv=none; b=kmuWkc08PMKZnBuFbjQitqnu6GGYkjI5ZbS1RCkcCjv9sgLukD2dizwcM2dTBwZTz3w8WIDexajynX+6DpRmQ1pR9SmImf8erRSbH34cXBNZIUdQ2dAPUDhzFSif+vZG8oy9Ewiud+jmIiYKOjQec1nv4VWA1dsAuj4jM8RIPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411861; c=relaxed/simple;
	bh=n4S+1fx0NlNrk04YQn4c8yzmilu8UbXYGmQH8vnZb7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvqlkBRDVTJ25vsmODi++sa8SxHfAbKl1jHLQsont7C7HUWH82PrvFus8vT5I43yB+SEBDG+mfGPjXYMRi83/qNKAVq8LdoKEy5y1hfE0tjU70jExtcPm6iwu8F6T3GbzdnWzBoHpsqOTP+gFRVPdwLIEcs/18aOElk7KI3qLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/WuOhQV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/WuOhQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B8C4CEC7;
	Tue,  8 Oct 2024 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728411860;
	bh=n4S+1fx0NlNrk04YQn4c8yzmilu8UbXYGmQH8vnZb7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/WuOhQVQsq3ULmYf/RJFrgjuVpViPvEycCwNp9GmqfwT9T1NQvP2JjrwwEI8dO2/
	 RKlkCUFIKAB2XN8sTkTemXfClQImHqd41s5Ie6ySeXw5d7KUEKC3Bu8P9DT1bmcbNE
	 TuNinnMrdpdfdzJgO1VXCLgO713NqBDUHUmWS2tvEnFCn66TrF83mLo+0FQVXqjr+K
	 2zLYWyK+ub6pOCZpNlsz3ZWpYTPwQ8BgsRCDLHk58H5vPxm9SfrojV/R2vzQO9ULZd
	 I+AbmzQ/aEwGK+zG1wMjBLOe7Q4toEKSXO7gVJ96R3Jduj3gaoUCnRO/ZH+jpZceOF
	 q5KmHgdcR0PoA==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] iommu/arm-smmu: Clarify MMU-500 CPRE workaround
Date: Tue,  8 Oct 2024 19:24:10 +0100
Message-Id: <172840894159.3010969.17557611673793266245.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <dfa82171b5248ad7cf1f25592101a6eec36b8c9a.1728400877.git.robin.murphy@arm.com>
References: <dfa82171b5248ad7cf1f25592101a6eec36b8c9a.1728400877.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Oct 2024 16:21:17 +0100, Robin Murphy wrote:
> CPRE workarounds are implicated in at least 5 MMU-500 errata, some of
> which remain unfixed. The comment and warning message have proven to be
> unhelpfully misleading about this scope, so reword them to get the point
> across with less risk of going out of date or confusing users.
> 
> 

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/arm-smmu: Clarify MMU-500 CPRE workaround
      https://git.kernel.org/will/c/0dfe314cdd0d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
