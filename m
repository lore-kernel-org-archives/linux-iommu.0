Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550012D777
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667310; cv=none; b=bwpxayQrxTKmwosLUoc+KFjGv7NXkRsfkC44d6PrgJLXmSf5UEc2Gphb2MeXHD5YvljaOIdSTmWZoZCLyzmxqBvTQTsU5Tiws4lJp0MLVyD92X7F6EVvox6HydiCnLA7xfl41kV4OBxBg0rlneVUM+l8R6T8OJ0DqJxTYhgKu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667310; c=relaxed/simple;
	bh=1GMf6gi2TilKqPUOlziTNFGEK7FxrHiyZIVKlRxnKuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p20D4WpSWSzNWxrAfbthibp3NJxJsVi5siOxDPHKldnOnrkkdJ83g/wcPhuqNPk/AC/YKn+EEiNADiIalX9nCx0raifXJgqU+M5BSx4ZjJfwgbbehsFwtne1vqOc/GSULJeQ8VcF827EqomsVDU8qkn7qWBzUGAgWOZgLe1TDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfdj7q3F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfdj7q3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ACFC43399;
	Tue,  9 Apr 2024 12:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712667309;
	bh=1GMf6gi2TilKqPUOlziTNFGEK7FxrHiyZIVKlRxnKuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mfdj7q3FuSi5lkqIxIgRdWOt2OeCjFa5VypgwRWRbBL+uK5GUYncO5DlHC0uqjGsT
	 BhwyVYQx1yScdqJW5i3II8ATunOCmF6yCWk7k2ncYlWFWg8CG0uQu91iyNcPU8nsRw
	 KQimUPyWaVguG5yiz+u31YcFC+8Gk/V3XYF2Mr9Qk0116JbSmbAMo+C9f5L/1ZcvaK
	 BNmY64AyghC2DE3oGCe6zyhEwQaoN1QIEfdCFquQGD2Fom2CG2tzFQ5ry1WvD+FyEo
	 AyjMMxiVz0LIuiD9h3pmfaTEZTT0nN+b37yJ9wijli55IP3ywymGmcDpyXp64wSaTZ
	 I5sS3lOlB1Llw==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Retire disable_bypass parameter
Date: Tue,  9 Apr 2024 13:55:00 +0100
Message-Id: <171265821067.1454498.16197081447570903681.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ea3ac4cd595a81b5511729601b2f7d4668178438.1712335927.git.robin.murphy@arm.com>
References: <ea3ac4cd595a81b5511729601b2f7d4668178438.1712335927.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 05 Apr 2024 17:52:07 +0100, Robin Murphy wrote:
> The disable_bypass parameter has been mostly meaningless for a long time
> since the introduction of default domains. Its original intent is now
> fulfilled by the controls users have over the default domain type, and
> its remaining effect in the brief window between Stream Table
> initialisation and default domain creation hardly seems worth the
> complication. Furthermore, thanks to 2-level Stream Tables, disabling
> disable_bypass (there's another reason not to like it right there) has
> never guaranteed that any particular StreamID *will* bypass anyway - any
> device which might actually care about that wants RMRs - so there's not
> really much lost by taking away that option (which has already been
> non-default for nearing 6 years now).
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Retire disable_bypass parameter
      https://git.kernel.org/will/c/734554fdfce6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
