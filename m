Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7054508EB;
	Wed, 22 Jul 2026 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756426; cv=none; b=KhNQo2gfrtWdpE62rbdXS0SWa8K0YE/DttV9qRp01SioHATFDeSk3BTgxGFppIDlhBHLfwjX15sZWQbUzbV74wPx3Dg0a2JGrS0o3ZEFihqGsBD5n5fddqSGLU8yJjeqNhMOXBFQiLoEQKTxfjdMxha7dt9m0tOWzpRVrFNNebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756426; c=relaxed/simple;
	bh=PHuAoCXRvyl7dMAdg9i7qf1XfOiXio+75EMBuh5Duxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqEHtzow6ndVJB6RFhspFuW5QTkhbl8MPCANyEHXpi6j92p6Zgrvy69ZIpinTyTv6OfcIo3HKcuucIM2ozUYybUNCQqSMPNJEbNXU/+ZffCpdH5FThJ02ZOHq9E/JB7u/xmyV85zcE1LXjL16FErnxAy42Th6yI9uHcK+r2Uogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ5CUgjY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ5CUgjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C73F1F00A3D;
	Wed, 22 Jul 2026 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756425;
	bh=oakyfwRPUlUhIuYXETLwbO8Sp1BJjGX0KU4hVjSlLFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJ5CUgjYAwDgRiGGS3h7AtnZtmjG3+vrAiye1YPjWil6HDwtkq825XgIjTEqphk2E
	 Npqq9t/eNT1XXJpiooKqUla6glq0mGSSgjWJWckpQ4PZfKQZ1uBzjWGPBZM6FE8JD4
	 5aAfrknKKwFdBffjtwy8mLzfKcizqX4crEWeZIIxaxGA04q08nez7HNfb53DLA2rCu
	 VZW1BmrV87VZmYDHmr9KtkuMztFfCBa7MceKfLFSU7Hr7ewQez65Mug6c+uSwhBCMW
	 r7/DdMT0yQJqaLmPSjHK8uXsbVk/DhiEFKhBLwrmBFfDq/T6XhlE7SlH6MXDiTP1AQ
	 P0PMk341I2ADQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu: arm: Remove redundant dev_err()/dev_err_probe()
Date: Wed, 22 Jul 2026 22:39:29 +0100
Message-ID: <178472595619.2878707.2602583908071504457.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714133246.575556-1-panchuang@vivo.com>
References: <20260714133246.575556-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 21:32:43 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
> automatically log detailed error messages on failure. Remove
> the now-redundant driver-specific dev_err() and dev_err_probe() calls.
> 
> 

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu: arm: Remove redundant dev_err()/dev_err_probe()
      https://git.kernel.org/iommu/c/13a86292681d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
