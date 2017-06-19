From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v4 00/09] iommu/ipmmu-vmsa: r8a7795 support V4
Date: Mon, 19 Jun 2017 18:13:45 +0900
Message-ID: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: r8a7795 support V4

[PATCH v4 01/09] iommu/ipmmu-vmsa: Introduce features, break out alias
[PATCH v4 02/09] iommu/ipmmu-vmsa: Add optional root device feature
[PATCH v4 03/09] iommu/ipmmu-vmsa: Enable multi context support
[PATCH v4 04/09] iommu/ipmmu-vmsa: Make use of IOMMU_OF_DECLARE()
[PATCH v4 05/09] iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master
[PATCH v4 06/09] iommu/ipmmu-vmsa: Write IMCTR twice
[PATCH v4 07/09] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
[PATCH v4 08/09] iommu/ipmmu-vmsa: Allow two bit SL0
[PATCH v4 09/09] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code

Here's an updated series for r8a7795 IPMMU support. The patches adjust
the code based on feedback from Geert and Robin together with a rebase
to include changes from the recently posted series:

[PATCH 00/04] iommu/ipmmu-vmsa: 32-bit ARM update

The DT binding for r8a7795 has been accepted for upstream merge
and this series implements support following such format:

d4e42e7 iommu/ipmmu-vmsa: Add r8a7795 DT binding

The r8a7795 IPMMU is almost register compatible with earlier devices
like r8a7790-r8a7794, however some bitfields have been shifted
slightly. On a grander scale topology has been added and interrupts
have been reworked. So now there are several "cache" IPMMU units
without interrupt that somehow communicate with IPMMU-MM that
is the only instance that supports interrupts. The code refers to
IPMMU-MM as a "root" device and the other ones as "leaf" nodes.

Changes since V3:
 - Rebased on top of [PATCH 00/04] iommu/ipmmu-vmsa: 32-bit ARM update
 - Patch 1/9 has been updated to use of_device_get_match_data(), thanks Robin!
 - Patch 2/9 has been reworked to make it easier to follow, thanks Geert!
 - Patch 3/9 now uses unsigned int for context counts - thanks Robin!
 - Patch 6/9 now includes function name changes - thanks Robin! 
 - Patch 9/9 now uses dev_err() instead of dev_info() - thanks Geert!

Changes since V2:
 - Patch 2/9 has been updated with a bug fix and to supply __ipmmu_find_root()
 - Patch 4/9 now makes use of iommu_device_* functions
 - Patch 5/9 sets the mask to 40 bits instead of 64 bits
 - Patch 9/9 implements white list handling via ->xlate() and fixes a bug

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on top of next-20170614 with the following series applied
 [PATCH 00/04] iommu/ipmmu-vmsa: 32-bit ARM update

 drivers/iommu/ipmmu-vmsa.c |  327 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 260 insertions(+), 67 deletions(-)
