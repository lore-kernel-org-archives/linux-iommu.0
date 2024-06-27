Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7D1E877;
	Thu, 27 Jun 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496959; cv=none; b=ciVaMIh35Vh/Yqed2Wn8C2KJ/X4IBa+QBjpyB5bpbzejhtjdVebmKcmUC92yZH4qU1RiMOVdF7QGGur69yIVmPfm+FlFaA0moIRl6tww8jZSguYeSWP1onhdW1tfoGm4QrCVlJBgzdgSKjk8M4lNTrX67hEMZw8Cznl35LXVpMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496959; c=relaxed/simple;
	bh=NlfmYxXweTu4GycRr5v1NpDz0wE5/WmiEEwdYxjqKyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TusmO8m0MwBsgeIEYXYe60tCKIeHUdw8i1FDc8JkyfiolSIqBeA2mPk1JAPTZ+UbwsL8rSPbVBXg1XtNa4QLzk4YigDfh0Ju+E9TC6XuiIGQw6bkLZrb1JrkOiZcBDdBQATwMWzLKCLPX6ks1rnZTSUHoArcchi6jOiXNJfSXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgA9pFmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgA9pFmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16A0C2BBFC;
	Thu, 27 Jun 2024 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719496958;
	bh=NlfmYxXweTu4GycRr5v1NpDz0wE5/WmiEEwdYxjqKyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgA9pFmCzNcPyiCzHwyhgl7NadroOg386k75KRZcJPEBs3PRMBYa6Y/q7oJdFlnbP
	 3jWJTseVKfvI0odYX/IqqaqrWGaGs7O9ztzA2735AZKSw5XoTaJzXOnP6o0cHZ+3lN
	 O9eMp02B7xqd742eSNQd1bBqPavaGbHs+YEW7FqRT+DZERPv3ELlmMCMPV7Mxflxsl
	 spzAXxT2WG7KeoxK/zo/NwYLFDScSuijtkrCCJY+ZDmlZOBMIyvrHKHY8Uz6OBrOMJ
	 6aVQD7Zrh/81IJsYxvfaobmv0s6K23mf2FXWpKBZ7M2XuY/Zp0Xmm3cX5OC2Tk5Q2k
	 F/uwRN7UlPx+w==
Received: by wens.tw (Postfix, from userid 1000)
	id D27F05FB64; Thu, 27 Jun 2024 22:02:36 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/5] iommu: sun50i: Add Allwinner H616 support
Date: Thu, 27 Jun 2024 22:02:32 +0800
Message-Id: <171949688960.1165598.14192419848748890768.b4-ty@csie.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240616224056.29159-1-andre.przywara@arm.com>
References: <20240616224056.29159-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

On Sun, 16 Jun 2024 23:40:51 +0100, Andre Przywara wrote:
> Version two of this series adds a check that no physical address larger
> than 4GB makes it into the PTEs: the map_pages() function returns an
> error and prints a warning into dmesg to give users a clue why this
> failed. I haven't tested whether this really happens, or whether the
> 32-bit DMA mask of the master devices already prevents this. In the
> worst case this might fail on devices with 4GB of DRAM, but would always
> work on smaller devices, which are arguably under bigger pressure to
> find contiguous PA ranges. Changelog below.
> ===========================================
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[5/5] arm64: dts: allwinner: h616: add IOMMU node
      https://git.kernel.org/sunxi/linux/c/0c85e2e377c3

FTR, I moved the IOMMU device node after the GIC node so the nodes are
properly ordered.


Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>
