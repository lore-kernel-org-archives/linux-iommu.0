From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 0/9] Tegra GART driver clean up and optimization
Date: Tue,  8 May 2018 21:16:51 +0300
Message-ID: <20180508181700.5169-1-digetx@gmail.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

This series addresses multiple shortcomings of the GART driver:

1. Thierry noticed that Memory Controller driver uses registers that belong
   to GART in [0] and for now MC driver only reports the fact of GART's page
   fault. The first two patches of the series are addressing this shortcoming.

   [0] https://www.spinics.net/lists/linux-tegra/msg33072.html

2. Currently GART is kept disabled by the commit c7e3ca515e784 ("iommu/tegra:
   gart: Do not register with bus"). If GART is re-enabled than all devices
   in the system are getting assigned to the GART as it is a global systems
   IOMMU provider. This is wrong simply because GART doesn't handle all those
   devices. This series makes GART to accept only devices that are explicitly
   assigned to GART in device tree using 'iommu' phandle.

3. This series makes a generic clean up of the driver by removing dead code,
   allowing to have one IOMMU domain at max, etc.

4. This series introduces and utilizes iotlb_sync_map() callback that was
   previously suggested by Joerg Roedel in [1].

   [1] https://www.spinics.net/lists/linux-tegra/msg32914.html

Dmitry Osipenko (9):
  memory: tegra: Provide facility for integration with the GART driver
  iommu/tegra: gart: Provide access to Memory Controller driver
  iommu/tegra: gart: Remove code related to module unloading
  iommu/tegra: gart: Remove pr_fmt and clean up includes
  iommu/tegra: gart: Clean up driver probe failure unwinding
  iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
  iommu/tegra: gart: Provide single domain and group for all devices
  iommu: Introduce iotlb_sync_map callback
  iommu/tegra: gart: Optimize mapping / unmapping performance

 drivers/iommu/iommu.c      |   8 +-
 drivers/iommu/tegra-gart.c | 216 +++++++++++++++++--------------------
 drivers/memory/tegra/mc.c  |  26 ++++-
 include/linux/iommu.h      |   1 +
 include/soc/tegra/mc.h     |  13 +++
 5 files changed, 143 insertions(+), 121 deletions(-)

-- 
2.17.0
