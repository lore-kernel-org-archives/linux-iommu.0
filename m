Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DA4FC8E5;
	Fri,  2 Oct 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959633; cv=none; b=jkp7OkIb6b1Y5vXTV17z9IgEoxmDLRafG/iW0TGKJ+JrNI22HiUnzCuDyskya5kI8651bKfGbqAEn+LnTnbGge2hdb5DQcnzP3oFInQqK9ou8awHJKH5tTZ0eL1l/xCUu5W4iZLns8F/CntVDWvsikNyd4ZlM1ceVceJyoqRncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959633; c=relaxed/simple;
	bh=Xaegkhc9onMmmjdDvzlfdnt71/kpLt4YZ7qBsP6R+YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTa85vjGQrpDh6RTWQ/1AgO9YkVY6E87qwRbvAa9pM2r5mI1gmkYWnIU8ykPov/wK8mdlgaVTTtReOaEns7Bh3q0zM1Bz7mTqfPKWfkmqTyw0FKpXXLlsW924oFOZDtnSLeOHz21oiOO0a1mjEKAiYeJbaJGLjcueaG+z7OaKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+o/QENJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+o/QENJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23081F0089A;
	Fri,  2 Oct 2026 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959631;
	bh=lfEw+vmZQa7y2I57+xbALyP2uxbf7nEAnGZOJevuxd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J+o/QENJmct9gAt9stt6eV9AJtscL/saju25nYWe+J6/8xNQFyOU4F4v22WSfwxwU
	 uELUeJm2xPwbXyteSnbprTpYMJmhZ6CFmewpIErhB2cct08CLg5CdMYrF7b5NfigtI
	 gxYgFq2iL7W9WPi5w5pgaXpGzO4S2uF5wHe48gYkyq3f+mJpvxbeb0boacmKrUnrMr
	 rHLLvfj0IR73iZkgbswR6XPyzISDgnlJl3S6oNW3CQYUQHGqdUzXEUza2CXSi8iOsv
	 OE1CZa8vG8aG+W9eFx3N9xPqINrgs9/ioSah1diNhiUEgN8ZxktqBUKPzxQaauFPs2
	 FR1yfGeiS1nwQ==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Mostafa Saleh <smostafa@google.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	praan@google.com
Subject: Re: [PATCH v2 0/5] iommu/arm-smmu-v3: Fixes reported by Sashiko
Date: Fri,  2 Oct 2026 17:46:41 +0100
Message-ID: <179095609026.2120495.10251338517190758348.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924085616.300650-1-smostafa@google.com>
References: <20260924085616.300650-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 08:56:11 +0000, Mostafa Saleh wrote:
> While running sashiko locally on the pKVM SMMUv3 driver patches, it
> reported some pre-existing issues in the SMMUv3 driver (the RB tree
> corruption and a missing NULL check) and given that this is not the
> first time a pre-existing issue appears in the driver from sashiko,
> I went ahead and passed the whole driver to Sashiko which reported a
> dozen of other issues(except the last one in this series), I included
> fixes for bugs I believe are true or worth fixing (others were mostly
> missing NULL checks or bizarre HW/FW configs I don't think are needed).
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/5] iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
      https://git.kernel.org/iommu/c/84366fb547ed
[2/5] iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
      https://git.kernel.org/iommu/c/ce58940ccc3d
[3/5] iommu/arm-smmu-v3-test: Add missing error checks for inv array
      https://git.kernel.org/iommu/c/388986bfc540
[4/5] iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
      https://git.kernel.org/iommu/c/8105675f3374
[5/5] iommu/arm-smmu-v3-test: Fix UBSAN error
      https://git.kernel.org/iommu/c/b370a5e979f8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
