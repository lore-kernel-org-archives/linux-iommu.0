Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38692F2738
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949350; cv=none; b=mlsw7awwl+LtGQy8s6ccuH+p/IM9pEGLBUXdJJZY9lMCe70iRUhxu+Sc78k7MPP7u5JpW6MmtJhSegcWwkJpj1Q9e+STN0/i0tZYm84L04pojTxLtB1HLK8oamPLrUm7m3KO6K0IUVKK+j6TjSPbmvhB8Ps11ektXTLqOykSi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949350; c=relaxed/simple;
	bh=P57Mm725L5SPEV08pQH67xytCGylGZyn9IkhBqAcSlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WPEL1xHPZQEh3vR3KVnn1pnZGAD3oJzvqXsp4wOxM5XrCIs75dNkl/TcVIB9e6a9smjkwEpT8GZJHtXSmDFSEHxIS1FlGFMckdpJVUxcgA+BDdWVa2/pNVvd/RJPgtsmttnXyVr3D3yGf9Ru9M4plbS372ov05gt/XB4oDfpKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAjvDf8x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=To1NwsfA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAjvDf8x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="To1NwsfA"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9D/Ii3iU3sfaHnChN1LJ+jxjfUEG57+0qTukBk27a8=;
	b=SAjvDf8xY2wJ033CU3jln2Xn6FlyT6P1v2ANUKdNizuHhkqKya/0w8cH+IP2dFRsqT3Fyh
	9sjTbSWu8GglRbFcZ4Z43F/W6A1fyg7Rzs3Qrx2muFpbjebyi6rIFHbNl8/YDjurTLhSeC
	mXUmAa08gXGoswtIUawwT4GYSVSWWKaU6+Vw7FCHj6qyO7OxfC9RIm08TVRBUp9YneUREx
	98IDXAToJesUZsHlzeUbkdc4jqoT6YZyS3XhmZSaCkxhX+KSbuBroQOwHTO5XYVFVa0cKS
	Deeu7W0rCrDvxCJBSz1rvf/tLjF99dkCEY80eYqdM4qRcX63Ux8ZMLQ+/E1LPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9D/Ii3iU3sfaHnChN1LJ+jxjfUEG57+0qTukBk27a8=;
	b=To1NwsfAmWGmULnKy4f4JhSY207XjCC+OoRcTLyGHhVnKwZYNhwuisDETVdNMzJCoE7UHu
	zZkRvLz04WwwuBDQ==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] iommu: MSI parent domain conversion
Date: Thu, 26 Jun 2025 16:48:53 +0200
Message-Id: <cover.1750858125.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The initial implementation of PCI/MSI interrupt domains in the hierarchical
interrupt domain model used a shortcut by providing a global PCI/MSI
domain.

This works because the PCI/MSI[X] hardware is standardized and uniform, but
it violates the basic design principle of hierarchical interrupt domains:
Each hardware block involved in the interrupt delivery chain should have a
separate interrupt domain.

For PCI/MSI[X], the interrupt controller is per PCI device and not a global
made-up entity.

Unsurprisingly, the shortcut turned out to have downsides as it does not
allow dynamic allocation of interrupt vectors after initialization and it
prevents supporting IMS on PCI. For further details, see:

https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/

The solution is implementing per device MSI domains, this means the
entities which provide global PCI/MSI domain so far have to implement MSI
parent domain functionality instead.

This series convert the IOMMU drivers to implement MSI parent domain.

 drivers/iommu/Kconfig               |  1 +
 drivers/iommu/amd/Kconfig           |  1 +
 drivers/iommu/amd/iommu.c           | 26 ++++++++++++++------------
 drivers/iommu/intel/irq_remapping.c | 28 ++++++++++++++--------------
 4 files changed, 30 insertions(+), 26 deletions(-)

--=20
2.39.5

