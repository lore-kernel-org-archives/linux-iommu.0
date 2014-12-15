From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 0/3] Add support for APM X-Gene SoC AHBC IOMMU driver.
Date: Mon, 15 Dec 2014 22:25:20 +0530
Message-ID: <1418662523-8458-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds the support for the APM X-Gene SoC AHBC IOMMU driver.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---

Suman Tripathi (3):
  xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU driver.
  arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
  Documentation: dt-bindings: Add the binding info for APM X-Gene AHBC
    IOMMU driver.

 .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt |  17 ++
 arch/arm64/boot/dts/apm-storm.dtsi                 |   5 +
 drivers/iommu/Kconfig                              |  10 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/xgene-ahbc-iommu.c                   | 336 +++++++++++++++++++++
 5 files changed, 369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt
 create mode 100644 drivers/iommu/xgene-ahbc-iommu.c

--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
