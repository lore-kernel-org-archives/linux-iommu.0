From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 00/12] NVIDIA Tegra memory controller and IOMMU support
Date: Fri,  7 Nov 2014 17:00:51 +0100
Message-ID: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
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
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This is the sixth installment in the Tegra IOMMU and memory controller
support series. This version addresses the final outstanding comments from
Olof about using proper Kconfig symbols to track the dependencies. It also
splits up the driver into one part that implements the memory controller
only and a second part that implements the SMMU. This plays nicely with
the new Kconfig options introduced.

Patch 1 is a preparatory patch that exposes the memory controller clock.

Patches 2 and 3 is a pair of precursory patches needed to make this all
work on 64-bit ARM in the future.

The device tree binding for the Tegra memory controller is added in patch
4 and patch 5 is the bulk of the series that move the existing memory
controller and IOMMU drivers into the new unified driver that supports
Tegra30, Tegra114 and Tegra124.

Patches 6, 7 and 8 add the DT nodes for the memory controller/IOMMU on
Tegra30, Tegra114 and Tegra124.

IOMMU support is enabled for the display controllers in patches 9, 10 and
11. This will allow the display controllers to have their memory accesses
translated by the SMMU, which will enable non-contiguous buffers to be
used for scan-out.

Finally patch 12 also adds support for Tegra132. It is kept separate because
none of the other Tegra132 patches have been merged yet, but I've included
it here for completeness.

Because the patches are rather intertwined, I'd like to merge them all via
the Tegra tree. For that I'll need Acked-bys from Mike, Russell and Joerg
on patches 1, 2 and 3, and 5, respectively.

Thierry

Thierry Reding (12):
  clk: tegra: Implement memory-controller clock
  amba: Add Kconfig file
  ARM: tegra: Move AHB Kconfig to drivers/amba
  of: Add NVIDIA Tegra memory controller binding
  memory: Add NVIDIA Tegra memory controller support
  ARM: tegra: Add memory controller support for Tegra30
  ARM: tegra: Add memory controller support for Tegra114
  ARM: tegra: Add memory controller support for Tegra124
  ARM: tegra: Enable IOMMU for display controllers on Tegra30
  ARM: tegra: Enable IOMMU for display controllers on Tegra114
  ARM: tegra: Enable IOMMU for display controllers on Tegra124
  memory: tegra: Add Tegra132 support

 .../memory-controllers/nvidia,tegra-mc.txt         |   36 +
 arch/arm/Kconfig                                   |    3 -
 arch/arm/boot/dts/tegra114.dtsi                    |   23 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   16 +
 arch/arm/boot/dts/tegra30.dtsi                     |   25 +-
 arch/arm/mach-tegra/Kconfig                        |    9 +-
 arch/arm64/Kconfig                                 |    3 -
 drivers/Kconfig                                    |    2 +
 drivers/amba/Kconfig                               |   14 +
 drivers/clk/tegra/clk-divider.c                    |   13 +
 drivers/clk/tegra/clk-tegra114.c                   |    7 +-
 drivers/clk/tegra/clk-tegra124.c                   |    7 +-
 drivers/clk/tegra/clk-tegra20.c                    |    8 +-
 drivers/clk/tegra/clk-tegra30.c                    |    7 +-
 drivers/clk/tegra/clk.h                            |    2 +
 drivers/iommu/Makefile                             |    1 -
 drivers/iommu/tegra-smmu.c                         | 1295 --------------------
 drivers/memory/Kconfig                             |   12 +-
 drivers/memory/Makefile                            |    3 +-
 drivers/memory/tegra/Kconfig                       |   16 +
 drivers/memory/tegra/Makefile                      |    9 +
 drivers/memory/tegra/mc.c                          |  303 +++++
 drivers/memory/tegra/mc.h                          |  129 ++
 drivers/memory/tegra/smmu.c                        |  716 +++++++++++
 drivers/memory/tegra/tegra114.c                    |  948 ++++++++++++++
 drivers/memory/tegra/tegra124.c                    | 1028 ++++++++++++++++
 drivers/memory/tegra/tegra30.c                     |  970 +++++++++++++++
 drivers/memory/tegra30-mc.c                        |  378 ------
 include/dt-bindings/clock/tegra114-car.h           |    2 +-
 include/dt-bindings/clock/tegra124-car.h           |    2 +-
 include/dt-bindings/clock/tegra20-car.h            |    2 +-
 include/dt-bindings/memory/tegra114-mc.h           |   25 +
 include/dt-bindings/memory/tegra124-mc.h           |   31 +
 include/dt-bindings/memory/tegra30-mc.h            |   24 +
 34 files changed, 4340 insertions(+), 1729 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt
 create mode 100644 drivers/amba/Kconfig
 delete mode 100644 drivers/iommu/tegra-smmu.c
 create mode 100644 drivers/memory/tegra/Kconfig
 create mode 100644 drivers/memory/tegra/Makefile
 create mode 100644 drivers/memory/tegra/mc.c
 create mode 100644 drivers/memory/tegra/mc.h
 create mode 100644 drivers/memory/tegra/smmu.c
 create mode 100644 drivers/memory/tegra/tegra114.c
 create mode 100644 drivers/memory/tegra/tegra124.c
 create mode 100644 drivers/memory/tegra/tegra30.c
 delete mode 100644 drivers/memory/tegra30-mc.c
 create mode 100644 include/dt-bindings/memory/tegra114-mc.h
 create mode 100644 include/dt-bindings/memory/tegra124-mc.h
 create mode 100644 include/dt-bindings/memory/tegra30-mc.h

-- 
2.1.3
