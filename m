Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38D2D592D
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314081; cv=none; b=uJNGWWWVPvp2k0VgUBaYd27PJXKNDkPt6OUxlx8dnCybx5zmqCMp12puldZAikn+5g8Pb3sWsYhNVEzqOn/pQ37Zxua+bq5LPCeGIKRl8HFXBUFf7ows9tOAr6FhRIxP+qDGxLoK0aOtaLfpTbXx/JE1uXtqRj8JCGsaAL1omwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314081; c=relaxed/simple;
	bh=ZE8RrK7vXOIiyiPm5GvZG8/2gl/OXY1eSjMwMyYpiaI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=L/DR9Sza7fGafeGav8pDWqVhODn6HV+BM+5WlpeFylhvHC8Xy2O8SdoKnBgfQ0hCLsA4VM8RymD+uoIbu5iE/eWkSWzKiEMSEnUd9VywEMPSRNYpAZtjlYJF7kb0KblemrLF5Jy16/PTOblGbGBTdq5X2zcPl/rHLgMmNoXMo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=ejdETGwJ; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="ejdETGwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1764314014;
	bh=8r9aJGmUsw4md2Y+21WpPtb3FONAryJYnibLGFu+eE0=;
	h=From:To:Subject:Date:Message-Id;
	b=ejdETGwJoOwYNSgwzTsI1MWHjPNvHbdqN+MxYRxC70kUoWoYPgvdkcFrW4T7T5sed
	 VLDGdKjnHxenYjq7Nfta/+JE6ybRyz7mVm/HnBm+fQ1mQ9AO4VAha/FnY0BDTW5qij
	 AW1t4aB3CPMMhsqR/8u80vAELNiVqJNjJPjoT5oM=
X-QQ-mid: zesmtpsz7t1764314006t744032d7
X-QQ-Originating-IP: Mdi+Vc0qxw+qp6bUZ2zG3LK3yAZHFIYKYMa1h3TPCNE=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Nov 2025 15:13:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2142567719846038083
From: Chaoyi Chen <kernel@airkyi.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH v2 0/2] iommu/rockchip: Add support for multiple interface clocks
Date: Fri, 28 Nov 2025 15:13:20 +0800
Message-Id: <20251128071322.92-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NE8iuDeseKq86VOizA7BECqteYtkaA46C2SLeSZe0814HzExZqV3m2dB
	UCRs5tvDjaZZdmJ8HKCz+6p3cQ80pZuSw4WzGJ+X8LDaFH5Ku5Wr/CIcGulj6R6of6H1mWp
	+Ttzc5ObrCrt5SZVsQOtKfz6WYDrX1Tea77q/H1s01O7kFkASf/0WxYL7LSnzEUZJGuEKaj
	qUMEUpLPNKJ+TdiiAGuufEA+QKsOGhRwjXsb1JlVIdva8H4lr5R5Fc5M/lBFi5PU9OtlAs+
	Q+nPOQZbegjeBHnUsCJ6sSxY0fGpPe5u06KwZ4PlcuHaRSw8GkEp0Fgq+TefMcUoqzpdjjq
	yMb2puRJJILLeAA3CT3b8tYpvesaDet/GsXRqekrEgGEox8swO8OPAf3Kp5swqM3rYUL/hf
	GR1TKWY3UPAnRUiFzOGskuzs91ocpmwwyseU80z0N6syBDj1naR2mR8FOQc7LOlt/mEO+JF
	EV7V02jNbLiBqedppxB+NhX3e/TJuEAbmoTTT6nYY6uF/dCfDvw/b3oczRs1cUe+4rD6PUn
	kX13LupwMWRCt0LaLtJInVLHH2IvRT76Z0cXcA8grdUk3JS2um6yyzbt9KiBaMDJZSU990S
	0gAWhXskDz3firHS0w0ghK1UNTCjYRctLThq33j6bw/wY5dcM2v2hR+5kmBDzYzW3rR960e
	0sy2LDvFzrnt88xmTjLZtc/PLM+X4gVQNIkPt0/nlcvyn3PurtsRLuy0QlcGCN8kaTNQp0X
	Ckhb29G/lKBKLvhwv8c9Ea9VTkiBJgH5TnmVYXqn+4ukx0Fzp1B18kJxK9XJccDvgdlnLh1
	QKgO77H/SuNRR3xeszh8LijG0k6bQo8CqG0hdO1ps5HsXX/c/r83ff/rv77cwwketECWZvj
	XlnTzzxK+w+oUhZSUBUbGCMt/Af4tzKxzkFyLMPvRqV7Jjoex9F6F/LwY2C7ZBrPWvJ2Xk4
	zk9wMV2+CMWemAgkOl+vs24nKpxDE5L3T2MCN6b0CSdkY+0dbQPFZZ4R0dmPxxCKYwRFWGW
	4Rru6sIw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Hi,

Some rockchip iommus require extra clocks besides aclk and interface
clock, such as the iommus for NPU and RKVENC in RK3576.

Changes in v2:
- Link to v1: https://lore.kernel.org/all/20251126083345.88-1-kernel@airkyi.com/
- Rewrite dt binding.

Chaoyi Chen (2):
  dt-bindings: iommu: rockchip: Add support for multiple interface
    clocks
  iommu/rockchip: Use devm_clk_bulk_get_all() to get multiple iface
    clock

 .../bindings/iommu/rockchip,iommu.yaml        | 52 ++++++++++++++++---
 drivers/iommu/rockchip-iommu.c                | 20 ++-----
 2 files changed, 50 insertions(+), 22 deletions(-)

-- 
2.51.1

