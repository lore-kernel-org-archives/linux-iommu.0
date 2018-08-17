From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/2] Add IPMMU compatibility for r8a774a1
Date: Fri, 17 Aug 2018 15:31:03 +0100
Message-ID: <1534516265-10059-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Dear All,

this series adds IPMMU compatibility for the RZ/G2M (a.k.a. R8A774A1).

Cheers,
Fab

Fabrizio Castro (2):
  iommu/ipmmu-vmsa: Hook up R8A774A1 DT maching code
  dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support

 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
 drivers/iommu/ipmmu-vmsa.c                                     | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.7.4
