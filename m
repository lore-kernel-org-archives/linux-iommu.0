Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22CD149C45
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934921; cv=none; b=iJ1wh+bVE9D3kkscmKvyGX+aG6uelbk2iLPOaTdCkjwzLq7DBNB2flnn7WrvrtK19hss+1LrxxWP3q7AohagQs1sNrVt0vHVLFemMFiYFaTWmeMH+u+WYb3hj3vGPY3Rkosbagd9fKEtnTrIgimQNMDfeW/s+/RagFN3y7cTW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934921; c=relaxed/simple;
	bh=D3+ff2nIVEmIX8x1WaPKMezVEZTZ8Wnx3xAMNbQKNRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RULGEfj6jvTE1SORCJRfE+FZJs+s32DiYaRWc0EIhZq3J5e8fqm0NWlh+yEXk+x3Ob0w/8qmV/HxVjCMJMgCIPFSGzc1XcpJzgQg6eNZPoTYskeKjP0eOd1UOWRPywEQTXinCaxskzg2tLVCK20fJBu9asfz3kq6xU3M73ikaUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 7066A10A2673; Fri, 12 Apr 2024 17:15:17 +0200 (CEST)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: linux-kernel@vger.kernel.org
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 0/2] Enable JPEG encoding on rk3588
Date: Fri, 12 Apr 2024 17:15:09 +0200
Message-ID: <20240412151515.837824-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Only the JPEG encoder is available for now, although there are patches
for the undocumented VP8 encoder floating around[0].

This has been tested on a rock-5b, resulting in four /dev/video*
encoders.  The userspace program I’ve been using to test them is
Onix[1], using the jpeg-encoder example, it will pick one of these four
at random (but displays the one it picked):
% ffmpeg -i <input image> -pix_fmt yuvj420p temp.yuv
% jpeg-encoder temp.yuv <width> <height> NV12 <quality> output.jpeg

[0] https://patchwork.kernel.org/project/linux-rockchip/list/?series=789885
[1] https://crates.io/crates/onix

Changes since v2:
- Only expose a single VEPU121, since the driver doesn’t yet support
  exposing them all as a single video node to userspace.

Changes since v1:
- Dropped patches 1 and 4.
- Use the proper compatible form, since this device should be fully
  compatible with the VEPU of rk356x.
- Describe where the VEPU121 name comes from, and list other encoders
  and decoders present in this SoC.
- Properly test the device tree changes, I previously couldn’t since I
  was using a too recent version of python-jsonschema…

Emmanuel Gil Peyrot (2):
  media: dt-binding: media: Document rk3588’s VEPU121
  arm64: dts: rockchip: Add one VEPU121 to rk3588

 .../bindings/media/rockchip,rk3568-vepu.yaml  |  8 +++--
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 29 +++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.44.0

