Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402202E1EE0;
	Thu, 25 Sep 2025 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814302; cv=none; b=svWnKe6bMYmfJnVK6awjdp2I4/VrBGFwz5fIeh7zQvO0/OdqHrfi+eO+95zVve6syTCEBd1XT7OTODEBYD4lne1xo++IyjnsNz4DZtV6muoQZqK6LgAbOwgzTGWHudxErwq67bb1sREh3V9EBx/fPpWFD2cpcFmynYKxU5CSsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814302; c=relaxed/simple;
	bh=5TzYyfN30Gd8ZdkbRC2NSvcwxJWEaGl7JZniBQ2+WYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbYiTJYZgO73Ien828e2QIA+78JeF5OVC/qHZc5lP7P+9wDjvPonbxUkjutvlngRS/qyfFwr5ipT2vWH+NpzTWVjD3eFPtcBbld/6Uwb6Q1rVWio2kPqkQY3GYBuUSf2u4YQK7XC0gSmlxHln99x6BkmgTsYVrbMKsm/3gN/ZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0Mw1gi5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0Mw1gi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA49AC4CEF7;
	Thu, 25 Sep 2025 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758814301;
	bh=5TzYyfN30Gd8ZdkbRC2NSvcwxJWEaGl7JZniBQ2+WYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0Mw1gi58QxPkfQ1JKhpC2IEVo3Wl5kG3DaY+GvGJniPSzE2zJPPC51UDxrY36qDY
	 Om8Z8FvGTymihFeVENLhjM6PwnTcyAe2m6x0A1C0f37W3YZ+iObL9gy7pb58KrjV4Z
	 fMIS1Ovrk5dZzSjoOnHvU/H9uFrgxmfiMsPeVnuN4OBvGmNoE1/b3m7L/f2mA6yKfn
	 ml9mnxa34//4P+rcDNIHSz1QHaLxSkgBPubm343RPCTNuuiUKmI05wcLN/4jtIzTRK
	 vmKPNZzyQba/UvjfOi7oKJS2jiUT/YAo/hZ8b3yhrdG+LhAZ2kfLIFUuXthfC5zDy0
	 jhagSp9pIUCLw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1nwV-000000001rZ-0529;
	Thu, 25 Sep 2025 17:31:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] amba: tegra-ahb: enable compile testing
Date: Thu, 25 Sep 2025 17:31:19 +0200
Message-ID: <20250925153120.7129-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250925153120.7129-1-johan@kernel.org>
References: <20250925153120.7129-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be nothing preventing this driver from being compile
tested so enable that to increase build coverage.

This also allows for compile testing of further Tegra drivers (e.g.
IOMMU driver).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/amba/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
index fb6c7e0b4cce..14bb61ff801e 100644
--- a/drivers/amba/Kconfig
+++ b/drivers/amba/Kconfig
@@ -5,7 +5,7 @@ config ARM_AMBA
 if ARM_AMBA
 
 config TEGRA_AHB
-	bool
+	bool "Enable AHB driver for NVIDIA Tegra SoCs" if COMPILE_TEST
 	default y if ARCH_TEGRA
 	help
 	  Adds AHB configuration functionality for NVIDIA Tegra SoCs,
-- 
2.49.1

