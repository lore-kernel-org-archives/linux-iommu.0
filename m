Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE1258E;
	Fri, 13 Jan 2023 10:51:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 1EAFD42462;
	Fri, 13 Jan 2023 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1673607087; bh=tFvGULUm14+dr5KO0r2GXMUhnj28fQz3V85nCFyfxVI=;
	h=From:To:Cc:Subject:Date;
	b=pi/O7iWY9cFHNORSpJiiy9M8zhkG/X5AazwtO9IUn/A2ItgNETQzeMzCmRn84LvZn
	 Z6nkOcTjBgYFpR8oawFJCANiQLg/HL6Tsaof8hgr3yzjEjVuHaRDpV1u7I/TqGrRbr
	 y5PVQU1C9egFIIp+GVlDjGUs4kwqw+4zNEJbSeUvkpKYA2qBZqc8AzacSj0cgmyGWn
	 DEyj3f/qZ3Ijv96IbpSotKdzgrEDCf6Tqyya5SrSkBdDEf84Qd16G4kv0M7j+CJPyo
	 KDic7lt17YwKkHWOF+C/HC0KXbvpnjcmjG70bjeJ4nmRe48MimOrd15xuhGw6rDnUF
	 vOvHuNQAsW3bQ==
From: Hector Martin <marcan@marcan.st>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: [PATCH 0/7] iommu: dart: Apple t8110 DART support
Date: Fri, 13 Jan 2023 19:50:23 +0900
Message-Id: <20230113105029.26654-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series adds support for the T8110 DARTs used for the Thunderbolt
controllers on T600x SoCs and everywhere on T8112 SoCs.

This new DART revision shuffles the registers around and removes
support for multiple TTBR registers per SID (which never made sense on
16K configurations), but otherwise works much like the existing DART
hardware. The pagetable format is the same as t600x, so no changes are
needed there.

Once reviewed, I'd like to merge patch #1 through the Asahi-SoC tree so
we can start using it in device trees right away, instead of waiting for
one release cycle. Patches #2 onwards should go through the IOMMU tree.

v2: Addressed minor review comments (style nits and minor fixes).

Hector Martin (7):
  dt-bindings: iommu: dart: add t8110 compatible
  iommu: dart: Add suspend/resume support
  iommu: dart: Support >64 stream IDs
  iommu: dart: Support a variable number of TTBRs per stream
  iommu: dart: Fix DART_PARAMS1/2 bit define names
  iommu: dart: Support different variants with different registers
  iommu: dart: Add t8110 DART support

 .../devicetree/bindings/iommu/apple,dart.yaml |   1 +
 drivers/iommu/apple-dart.c                    | 557 ++++++++++++++----
 2 files changed, 448 insertions(+), 110 deletions(-)

--
2.35.1

