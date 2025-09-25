Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029A2E1F0E;
	Thu, 25 Sep 2025 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814302; cv=none; b=EKxZp3X+ZYKwdf+zn2dL8nrZUu68tbZirg9EH8M/INBhkegq27uj0yFIq2zsItyUGZjVFq/RQKwaKkM0kVMHsa52VEjACoDjxxxsgl53mvti+KIczksJ2g1FG4LR5d8CIxkxi5j18RQdc0iVyjvpxiTbDITPV8AA8pLJ6jjM4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814302; c=relaxed/simple;
	bh=hs3/b4g1dQM9Z+tsOuy86drRfsNzi6pXe5+7OCNLjYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEEiWcsQrogoi0OSlPen9mSWTEUsAdbES1meXu5x+HvsTAIvfbyahdUzFXPmdhzOvrH4gGIxDHbk0dDm/3lJbt7RnOFywukpGSk0DvFAiJPW86xpVCWQ+xmOlCT4wG8jf1m/pgIAlb8QfK8uhQTCvuCot4Ao1DF+jQKaBEKHVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcCxa/jo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcCxa/jo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D735FC4CEF0;
	Thu, 25 Sep 2025 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758814301;
	bh=hs3/b4g1dQM9Z+tsOuy86drRfsNzi6pXe5+7OCNLjYY=;
	h=From:To:Cc:Subject:Date:From;
	b=JcCxa/jov8Z4Y94cDk0nG70doBl0K8dLrObTsk7AOX7wilQmuDI29gG+NLhpQQdvv
	 iDHe2h2dPKCJIKOsIs4qX12gHGSBg9llxT4DxfARKYJphAF72ZUCTftP+9jCjjgqHS
	 MoyMrnw1GWsLzT3lEps+Cyi1DFv7+fOVDBoI+tTZAWXBAsh75Dxt7Wz5kpa4hB4S4q
	 XQgIDmAGIWRO0clmgYRnT7H9CCxBuSOYV83EZzetSady53OXaLqIcYgpmKAk8EMQs6
	 wSFse59qfy6/lYnlKjMhDt0HYtSNuBhX4JWrFu2LwCbZLYpdemstdpV6dGco3x4kIb
	 p6yfaK9bkaiPg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1nwU-000000001rX-3qIS;
	Thu, 25 Sep 2025 17:31:34 +0200
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] amba/iommu: tegra: enable compile testing
Date: Thu, 25 Sep 2025 17:31:18 +0200
Message-ID: <20250925153120.7129-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be nothing preventing us from enabling compile testing of
the Tegra AHB and IOMMU drivers so enable that to increase build
coverage.

Note that these could go in through separate trees, but compile testing
of the IOMMU driver does depend on the AHB driver being enabled.

Johan


Johan Hovold (2):
  amba: tegra-ahb: enable compile testing
  iommu: tegra: enable compile testing

 drivers/amba/Kconfig  | 2 +-
 drivers/iommu/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.49.1

