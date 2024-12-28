Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0027405A
	for <iommu@lists.linux.dev>; Sat, 28 Dec 2024 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735388556; cv=none; b=DL1meFfBs6jCkfHdfXj5ZDV4yDOUKHIR9QXmyIpx8LXSz/wzhfUhLvsjjKupmtZB9WH9vsEAZbY/+fSfUFN29oFfOWRWjxbEQVcfLIKcVXOHYYLVxMRVscDFX7u5iYbId1TffKQRGqw5AguPyGCnsuCZOxnrWMtfh3+zo1X7STs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735388556; c=relaxed/simple;
	bh=RSI1XS/H73ScKp7yQYVKOICWKOs1g6qxFC4vPcx7Zcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQpTx9item5L2/sEeJWAl8raa5tOWC1AS7sAajU39EteywrbHTmra8x0ABnq5+K2TJmUuGntfM0QUHZbvY1nBJsdP5wrcn3eGg/2aAStKhS4ITqixTKFBdWWBfc5rRuOJdKyW33j58nxBIyYk8FfYJzrr5bSpGhDjUh9HhRZPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ovurLZSW; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ovurLZSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=SV0/w
	h8oJIpggaKXs0KqU/L+Acgqq8H2YHjCCFLUvTw=; b=ovurLZSW8cE/5rHXCAk7X
	cJb4+9/ES1it5JShxRGZCP1xeb/6kSQrKbCuctg68yMHkvhwr3kFp2/qAqkM3Oea
	Cw8lsem9ijCBrJ+39akCoIO4TrIM0UrFrkQ2kaolcjvDL50wb7MisX6UTbnDH8iW
	EnX5n4S7IyAUA3/4oZkCN0=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3t0tl7W9nUxdCCQ--.1009S2;
	Sat, 28 Dec 2024 20:22:01 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de,
	krzk+dt@kernel.org,
	joro@8bytes.org
Cc: cl@rock-chips.com,
	robh@kernel.org,
	hjc@rock-chips.com,
	vkoul@kernel.org,
	devicetree@vger.kernel.org,
	detlev.casanova@collabora.com,
	cristian.ciocaltea@collabora.com,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 0/8] Add display subsystem dt node on rk3576
Date: Sat, 28 Dec 2024 20:21:43 +0800
Message-ID: <20241228122155.646957-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t0tl7W9nUxdCCQ--.1009S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur17tw1DAr48CF1DWF18uFg_yoW8AFWkpa
	nxCF98Jr18GFnrXFsxtwn5CrZYqrnYyF45Wrs3J3W7tw45Kr47GryfWr1DZrnrGr4Iyay7
	CF18Cay3Ka92vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBa09UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqA-DXmdv62k+ZgAAso

From: Andy Yan <andy.yan@rock-chips.com>


As the VOP[0] and HDMI[1] driver have already been submitted for review.
This series send all display related device tree part together.
[0] https://lore.kernel.org/linux-rockchip/20241219073931.3997788-1-andyshrk@163.com/T/#t
[1] https://lore.kernel.org/linux-rockchip/20241225103741.364597-1-andyshrk@163.com/T/#t

Changes in v2:
- Wrap commit message according to Linux coding style
- Make "rockchip,rk3588-hdptx-phy" const for "rockchip,rk3576-hdptx-phy"
- Make declare phy/ropll/lcpll reset line are not exit on rk3576
- describe constraint SOC by SOC for vop2 binding, as interrupts of rk3576
  is very different from others
- Drop Krzysztof's Reviewed-by for vopp2 bindings, as this version changed a lot.

Changes in v1:
- ordered by soc name
- Add description for newly added interrupt

Andy Yan (8):
  dt-bindings: soc: rockchip: add rk3576 hdptxphy grf syscon
  dt-bindings: phy: Add rk3576 hdptx phy
  dt-bindings: display: rockchip: Add rk3576 hdmi controller
  dt-bindings: iommu: rockchip: Add Rockchip RK3576
  dt-bindings: display: vop2: Add rk3576 support
  arm64: dts: rockchip: Add vop for rk3576
  arm64: dts: rockchip: Add hdmi for rk3576
  arm64: dts: rockchip: Enable hdmi display on sige5

 .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml  |   1 +
 .../display/rockchip/rockchip-vop2.yaml       |  70 ++++++++--
 .../bindings/iommu/rockchip,iommu.yaml        |   1 +
 .../phy/rockchip,rk3588-hdptx-phy.yaml        |  62 ++++++---
 .../devicetree/bindings/soc/rockchip/grf.yaml |   1 +
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts |  47 +++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 126 ++++++++++++++++++
 7 files changed, 276 insertions(+), 32 deletions(-)

-- 
2.34.1

