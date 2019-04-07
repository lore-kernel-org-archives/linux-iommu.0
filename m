From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 0/6] normalize IOMMU dma mode boot options
Date: Sun, 7 Apr 2019 20:41:41 +0800
Message-ID: <20190407124147.13576-1-thunder.leizhen__45694.463390258$1554643592$gmane$org@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@>
Cc: Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

As Robin Murphy's suggestion:
"It's also not necessarily obvious to the user how this interacts with
IOMMU_DEFAULT_PASSTHROUGH, so if we really do go down this route, maybe it
would be better to refactor the whole lot into a single selection of something
like IOMMU_DEFAULT_MODE anyway."

In this version, I tried to normalize the IOMMU dma mode boot options for all
ARCHs. When IOMMU is enabled, there are 3 dma modes: paasthrough(bypass),
lazy(mapping but defer the IOTLB invalidation), strict. But currently each
ARCHs defined their private boot options, different with each other. For
example, to enable/disable "passthrough", ARM64 use iommu.passthrough=1/0,
X86 use iommu=pt/nopt, PPC/POWERNV use iommu=nobypass.


Zhen Lei (6):
  iommu: use iommu.dma_mode to replace iommu.passthrough and
    iommu.strict
  iommu: keep dma mode build options consistent with cmdline options
  iommu: add iommu_default_dma_mode_get() helper
  s390/pci: use common boot option iommu.dma_mode
  powernv/iommu: use common boot option iommu.dma_mode
  x86/iommu: use common boot option iommu.dma_mode

 Documentation/admin-guide/kernel-parameters.txt | 42 +++++++-------------
 arch/ia64/include/asm/iommu.h                   |  2 -
 arch/ia64/kernel/pci-dma.c                      |  2 -
 arch/powerpc/platforms/powernv/pci-ioda.c       | 23 +----------
 arch/s390/pci/pci_dma.c                         | 20 +++-------
 arch/x86/include/asm/iommu.h                    |  1 -
 arch/x86/kernel/pci-dma.c                       | 20 ----------
 drivers/iommu/Kconfig                           | 36 ++++++++++++++---
 drivers/iommu/amd_iommu.c                       | 12 +++---
 drivers/iommu/amd_iommu_init.c                  |  4 --
 drivers/iommu/amd_iommu_types.h                 |  6 ---
 drivers/iommu/intel-iommu.c                     |  7 +---
 drivers/iommu/iommu.c                           | 52 ++++++++++++++++---------
 include/linux/iommu.h                           | 16 ++++++++
 14 files changed, 108 insertions(+), 135 deletions(-)

-- 
1.8.3
