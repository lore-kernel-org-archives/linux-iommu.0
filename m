From: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 0/7] Add Support for Hi6220 PMIC Hi6553 MFD Core
Date: Thu, 5 Nov 2015 21:34:41 +0800
Message-ID: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, xuyiping-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, yudongbin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, weidong2-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, saberlily.xia-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, haojian.zhuang-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, peter.panshilin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, qijiwen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

  The patch sets add support for Hi6220 PMIC Hi655x MFD core and its
regulator driver.
  Current testing and support board is Hikey which is one of 96boards.
It is an arm64 open source board. For more information about this board,
please access https://www.96boards.org.

This is hardware layout for access PMIC Hi655x from AP SoC Hi6220.
Between PMIC Hi655x and Hi6220, the physical signal channel is SSI.
We can use memory-mapped I/O to communicate.

+----------------+             +-------------+
|                |             |             |
|    Hi6220      |   SSI bus   |   Hi655x    |
|                |-------------|             |
|                |(REGMAP_MMIO)|             |
+----------------+             +-------------+

The patch sets are based on 4.3-rc7.

Chen Feng (7):
  doc:bindings:Add document for mfd hi665x PMIC
  doc:bindings:Document for mtcmos regulator on hi6220 SoC
  doc:bindings:Document for hi655x pmic driver
  mfd: hi655x: Add hi665x pmic driver
  regulator: add driver for mtcmos voltage regulator on hi6220 SoC
  regulator: hisilicon: Add hi655x pmic voltage regulator driver
  arm64: dts: Add mtcmos and pmic node for hi6220 HiKey board

 .../devicetree/bindings/mfd/hisilicon,hi655x.txt   |  18 ++
 .../bindings/regulator/hisilicon,hi6220-mtcmos.txt |  32 +++
 .../regulator/hisilicon,hi655x-regulator.txt       |  50 ++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 210 ++++++++++++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/hi655x-pmic.c                          | 315 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |  13 +
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/hi6220-mtcmos.c                  | 245 ++++++++++++++++
 drivers/regulator/hi655x-regulator.c               | 246 ++++++++++++++++
 include/linux/mfd/hi655x-pmic.h                    |  50 ++++
 include/linux/regulator/hi655x-regulator.h         |  63 +++++
 13 files changed, 1254 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/hisilicon,hi6220-mtcmos.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/hisilicon,hi655x-regulator.txt
 create mode 100644 drivers/mfd/hi655x-pmic.c
 create mode 100644 drivers/regulator/hi6220-mtcmos.c
 create mode 100644 drivers/regulator/hi655x-regulator.c
 create mode 100644 include/linux/mfd/hi655x-pmic.h
 create mode 100644 include/linux/regulator/hi655x-regulator.h

-- 
1.9.1
