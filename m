Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920B258EF9;
	Sun, 26 Jul 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078081; cv=none; b=XtvjbY2gMXE2eEKdDwPVaresCbfp3QvXHBx7y/psSllTl6VHE56coXZ6/6JvDOwWBFC/UHA2y/O9GBx3be7UxiMNJZG4s2VzHeruwoD5Or5uceD34ogphFbw4R7ke47hL17P5oGBm1LW9Wbyy/GB7G1FQ4LZCzqnGa24RQpynTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078081; c=relaxed/simple;
	bh=MnBhYTViu8kxdfK0cwwHJQCbn/Sg9K2EF91ir/yFaFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEQgOu4lJDOBEaqkVp4S8Bqy+J0spHS4yOyhjkvspT9gwZtiRCePTd5dS3Urb8eHO+yN8/fZnbi9EZWQonR79TE/ehztj0D6OM+5M7FC/e40Tgk/ZOPBtSGpTZ/c6zLkVrNJu7a0pXtq9i4RCIHsJw8Ujvi5Q8MFRBDjN1fJUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKN/3Nra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKN/3Nra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BF11F000E9;
	Sun, 26 Jul 2026 15:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785078080;
	bh=DPkoltX9TEEEGuCWddp6fep3WTxy0zq+YUKjB2+nxBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SKN/3NraiKo1BeqbR80B42/Kfu8bBunap31U7N8WIucCKiFzNUxJl29OVZKEqrstI
	 UftN8JQ6Ouf6F3Tgy8hZMju87HClqaEnH1dZLUTXgindLnC4iuvXdOy+O95JV1MBn3
	 2EVKfvA/5T+0UpxUx/b9L/Aw5x+88hRWD5fWfQisxacw2EZGkDBHgIFDIO+qyC1xNl
	 u4U/k7k8kRnyo0Z0UOLx50rB9LVyRZOcxbiSs83iHyLwNJA6KsjJ9lkBjbjJ9z+GF4
	 KK/Bj+5CgYAuh9sPufNeou4BsJibUcUj4B8D8JupbQ9tVwhZlXIq6Q/aFXNpeplu5y
	 sWBHVLMIbhVSg==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Simon Xue <xxm@rock-chips.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/rockchip: Drop global rk_ops in favor of per-device ops
Date: Sun, 26 Jul 2026 16:00:55 +0100
Message-ID: <178506896133.2040068.17210762744367310935.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722073511.403252-1-xxm@rock-chips.com>
References: <20260722073511.403252-1-xxm@rock-chips.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 22 Jul 2026 15:35:10 +0800, Simon Xue wrote:
> The driver currently uses a global rk_ops pointer, forcing all IOMMU
> instances to share the same operations. This restricts the driver from
> supporting SoCs that might integrate different versions of IOMMU hardware.
> 
> Since the IOMMU framework passes the master device information to
> iommu_paging_domain_alloc(), the global variable is no longer needed.
> 
> [...]

Applied to iommu (rockchip), thanks!

[1/1] iommu/rockchip: Drop global rk_ops in favor of per-device ops
      https://git.kernel.org/iommu/c/414cb6f3ac62

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
