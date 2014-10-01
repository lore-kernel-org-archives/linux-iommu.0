From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/3] Rockchip IOMMU driver and devicetree bindings
Date: Wed,  1 Oct 2014 18:20:40 +0800
Message-ID: <1412158843-8115-1-git-send-email-djkurtz@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add a driver and devicetree bindings for the IOMMU found in Rockchip RK3288
SoCs.

Daniel Kurtz (3):
  iommu/rockchip: rk3288 iommu driver
  dt-bindings: iommu: Add documentation for rockchip iommu
  ARM: dts: rk3288: add VOP iommu nodes

 .../devicetree/bindings/iommu/rockchip,iommu.txt   |  26 +
 arch/arm/boot/dts/rk3288.dtsi                      |  18 +
 drivers/iommu/Kconfig                              |  11 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/rockchip-iommu.c                     | 924 +++++++++++++++++++++
 5 files changed, 980 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
 create mode 100644 drivers/iommu/rockchip-iommu.c

-- 
2.1.0.rc2.206.gedb03e5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
