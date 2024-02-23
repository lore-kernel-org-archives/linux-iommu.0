Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0364682D7B
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703085; cv=none; b=TB4q2FVMvWC2Gc9qn5c6cKQpaPmg0wD56f8JMV/2H0lM374cGhVufTnykDX9hV+qYZIiBfx/j5kOVPStRhhW2NGYwuUMt96ATlbBTgdB6vJqHjui/Xtmm7/1y0UW+FkxOwYtxikn1zLmJV/qU8KgN4jMNgjdiv3iuFUxUEnNKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703085; c=relaxed/simple;
	bh=WUiTuKfqiqfQmxmzthiloCu0Nc0w+6TSox5GyIwSMlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOUJajuc3PymvUJn3U+EgutE16ZHz5ljEOQ3AphNTadEvHzmwpMGPHtLFGjF4CrPsGIU+0F2tjOr6E31snE4sa4TUHxCnK2/aTpjuThzShVN4843yFWYFG2P0wz2RBjW/vxJjM6EvGSoBtmuTbKSMM7W9slIVuVvJHFMNq8SUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=WaU261KS; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="WaU261KS"
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DDB241C1163;
	Fri, 23 Feb 2024 16:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1708703075;
	bh=WUiTuKfqiqfQmxmzthiloCu0Nc0w+6TSox5GyIwSMlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaU261KSzf7o9zJybj2DU+Ix/YL7QlSQ650KSZqn3RkXGRY5ZTbXccNQbaECfEx9G
	 HkSNdLM5XlPTi8SG5kPkCmrsMwm3Mk82vVsB6y4DvQ6MONfw37b0x2ZUtoCmVWc85d
	 MHR9I/1S6YAtmcgVzpeb5JcDFK2NN+/MP57ZMRv9UoMWqWmUvEKhisCnv/UOBo1CGc
	 f2SxpX9z1Gr7cOXti1MnJZUpqajgFAljsmOk8ofF9m2ZGUx1wbWOCx0clxzVDbGsxK
	 6py57/lUS/D6+rr7sZC9fvbqr4uYnLue9UrXSYVW9mwLiPKvb+NxYyS3KmJhX5sURi
	 1lczYDlxfQ87A==
Date: Fri, 23 Feb 2024 16:44:33 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 6.8-rc
Message-ID: <Zdi9YcGDlXskO_hO@8bytes.org>
References: <20240223115043.GA10608@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223115043.GA10608@willie-the-truck>

On Fri, Feb 23, 2024 at 11:50:43AM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

Pulled, thanks Will.
