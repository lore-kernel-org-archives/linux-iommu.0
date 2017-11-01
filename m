From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 0/2] iommu/ipmmu-vmsa: r8a779(70|95) support
Date: Wed,  1 Nov 2017 11:34:21 +0100
Message-ID: <20171101103423.7334-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Update Update the IPMMU DT binding documentation and driver implementation
to support the r8a77970 (R-Car V3M) and r8a77995 (R-Car D3).

Based on work for r8a7796 by Magnus Damm.

Patches based on:
* iommu/next
* [PATCH v5 00/09] iommu/ipmmu-vmsa: r8a7795 support V5
* [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
  (fuzz when applying 3/3)

Simon Horman (2):
  iommu/ipmmu-vmsa: Add r8a779(70|95) DT bindings
  iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code

 .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt         |  2 ++
 drivers/iommu/ipmmu-vmsa.c                                   | 12 ++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.11.0
