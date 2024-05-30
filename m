Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E1183092;
	Thu, 30 May 2024 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112371; cv=none; b=DiGF01Zp6cvSU3uuIwsg4EHWgSbKgHqpAqqQfOZxfwm2GTrrEK64DJGqmNqCrRDDDvMiQCBOW73pacQN7EEAzHSfQFwRRkmAwWlkbAgjjgiR/URBOQsJqu1b0+K5fmuQBQcSHtF7Z5CY/EwxevzxSBEux98ANQXlgfD2gGHMw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112371; c=relaxed/simple;
	bh=VMsNX1mhPvrPZQpCqnYyif1nx3CoOqsfjQ6TBJjfMk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hlBbV2OtwI0O5jEniMTzDnTRM4eoTKY0LWxrBe+aZp69OhqXS7nvzG12WujshXncdX11FbQ42Jatr7l4/BVBse75fBB7HxwkkB3pG8DuUTzIMYhYVGGmL9dOSIq4B6Qgjxx3on+zGRDVsnw7xFESyTS4Y85u4Dfm/zGGxEYs+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD0011476;
	Thu, 30 May 2024 16:39:51 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AF0E3F792;
	Thu, 30 May 2024 16:39:25 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] iommu: sun50i: Add Allwinner H616 support
Date: Fri, 31 May 2024 00:37:55 +0100
Message-Id: <20240530233800.27705-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 contains an IOMMU almost compatible to the one used
in the H6. The differing default reset value of the bypass register
makes the two technically incompatible, so use a new DT compatible
string to be on the safe side.
The required driver changes can be applied to both variants, so the driver
is ignorant of the differences between the two for now.

Change the driver to cope with the new variant in patch 1/5 and 2/5,
then apply the required devicetree and binding changes in the remaining
patches.

I could just verify that the driver probes and allocates the page table
from below 4 GB, but haven't tested the actual IOMMU operation, with a
device. I would be grateful if someone could test this in full swing.

Cheers,
Andre.

Andre Przywara (4):
  iommu: sun50i: allocate page tables from below 4 GiB
  dt-bindings: iommu: add new compatible strings
  iommu: sun50i: Add H616 compatible string
  arm64: dts: allwinner: h616: add IOMMU node

Jernej Skrabec (1):
  iommu: sun50i: clear bypass register

 .../bindings/iommu/allwinner,sun50i-h6-iommu.yaml        | 7 ++++++-
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi           | 9 +++++++++
 drivers/iommu/sun50i-iommu.c                             | 7 +++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.35.8

