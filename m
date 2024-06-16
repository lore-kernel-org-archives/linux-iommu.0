Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD79457;
	Sun, 16 Jun 2024 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718577754; cv=none; b=FWLBCf3Qb8RSmV8i8dzSElFTAa6uD26phGKbw5SPmbIKPYiapiOWhCG3V1SsMJ3D4fUThmR7+8DlsobPsi7021vs2AlBTBzkokac1n6MA/TW7sxhdvj3ty1o+ycFTjhwMOUYsp8oMiXTAcBkmULaylfo9fFgNZ7oH0z51/mjYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718577754; c=relaxed/simple;
	bh=5CDWZaMP44AkRBZmWKu0xjffFBosSFrJxoi6TrM1SoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IShz4kP8QL2pOYopaCUsjUjfy3OIsHNss7nwyryPbdc+qwJoWaRtg61jfzovKuGJ3pw6FKXBTZl1RzhY/t7QxE5F0SOXZsAGx46kmh7al+yL6+79gLQi6A+x6UQUY9qmeHw2AxEXLvbnBCpaWSsg94WvoX12WXB4pJVCxgUTYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90B99DA7;
	Sun, 16 Jun 2024 15:42:54 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C60A13F73B;
	Sun, 16 Jun 2024 15:42:27 -0700 (PDT)
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
	Philippe Simons <simons.philippe@gmail.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/5] iommu: sun50i: Add Allwinner H616 support
Date: Sun, 16 Jun 2024 23:40:51 +0100
Message-Id: <20240616224056.29159-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Version two of this series adds a check that no physical address larger
than 4GB makes it into the PTEs: the map_pages() function returns an
error and prints a warning into dmesg to give users a clue why this
failed. I haven't tested whether this really happens, or whether the
32-bit DMA mask of the master devices already prevents this. In the
worst case this might fail on devices with 4GB of DRAM, but would always
work on smaller devices, which are arguably under bigger pressure to
find contiguous PA ranges. Changelog below.
===========================================

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
from below 4 GB. Others have verified that the driver works with the
(not yet upstream) video decoder engine, but more tests are surely
welcome.

Cheers,
Andre.

Changelog v1 .. v2:
- return error for too large PA in map_pages()
- add Krzysztof's ACK to the binding patch

Andre Przywara (4):
  iommu: sun50i: allocate page tables from below 4 GiB
  dt-bindings: iommu: add new compatible strings
  iommu: sun50i: Add H616 compatible string
  arm64: dts: allwinner: h616: add IOMMU node

Jernej Skrabec (1):
  iommu: sun50i: clear bypass register

 .../bindings/iommu/allwinner,sun50i-h6-iommu.yaml |  7 ++++++-
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi    |  9 +++++++++
 drivers/iommu/sun50i-iommu.c                      | 15 +++++++++++++--
 3 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.39.4

