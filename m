From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH  0/3] Add IPMMU support for r8a774[35]
Date: Wed, 24 Jan 2018 15:41:59 +0000
Message-ID: <1516808522-17348-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>
List-Id: iommu@lists.linux-foundation.org

This patch series aims to add IPMMU support for r8a774[35] SoC.

It is tested with modetest utility and the patches present
in the below git for enabling ipmmu support in the vsp1 and DU.

git://linuxtv.org/pinchartl/media.git iommu/devel/dt

It is tested against renesas-devel-20180122-v4.15-rc9


Biju Das (3):
  dt-bindings: iommu: ipmmu-vmsa: Add device tree support for r8a774[35]
  ARM: dts: r8a7743: Add IPMMU DT nodes
  ARM: dts: r8a7745: Add IPMMU DT nodes

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  5 +-
 arch/arm/boot/dts/r8a7743.dtsi                     | 58 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7745.dtsi                     | 58 ++++++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)

-- 
2.7.4
