From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/9] iommu: clean up/remove modular stuff from non-modules.
Date: Mon, 26 Nov 2018 17:31:29 -0500
Message-ID: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alexandre Courbot <gnurou@gmail.com>, Simon Xue <xxm@rock-chips.com>, Rob Clark <robdclark@gmail.com>, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-mediatek@lists.infradead.org, Stepan Moskovchenko <stepanm@codeaurora.org>, Honghui Zhang <honghui.zhang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>, Hi
List-Id: iommu@lists.linux-foundation.org

The work here represents a scan over the iommu dir, looking for files/drivers
that have nothing to do with a modular use case, but are using modular
infrastructure regardless.

We are trying to make driver code consistent with the Makefiles/Kconfigs that
control them.  This means not using modular functions/macros for drivers that
can never be built as a module.  I've done this in other subsystem dirs
already, and some of this has already happened in drivers/iommu by others;
such as 98b72b94def9 ("iommu/rockchip: Prohibit unbind and remove").

Using modular infrastructure in non-modules might seem harmless, but some
of the downfalls this leads to are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other drivers and spreads quickly.

The last two commits (arm-smmu related ones) deserve an extra mention,
and I put them at the end in case they want to be deferred for later or
altered.  Normally a "module-ectomy" allows us to delete the ".remove"
function, as per the rockchip commit above, but ...

A kexec commit (7aa8619a66ae) tried to improve reliability by trying to
shutdown the iommu in the compromised/crashing kernel, but of course the
better solution is to have the recovery kernel be able to handle all of
the possible initial conditions.  It appears this was done later in the
commit b63b3439b856 - but I don't know if that means relying on an
orderly shutdown is no longer required - I don't have the platform and
am only going on what is in git history.

So, as the kexec commit recycled the ".remove" handle to also be the
".shutdown" handle, in this series the remove function was renamed to
shutdown, and the ".remove" handle was deleted.  This was IMHO the most
back compatible way to make this update.  If the reliance on the
compromised kernel to run ".shutdown" is no longer necessary, then it
can be removed in a future change.

Patches were build tested on top of next-20181122 for ARM, ARM64, x86-64
on an allyesconfig.

Paul.

---

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Honghui Zhang <honghui.zhang@mediatek.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Nate Watterson <nwatters@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Simon Xue <xxm@rock-chips.com>
Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-tegra@vger.kernel.org

Paul Gortmaker (9):
  iommu: audit and remove any unnecessary uses of module.h
  iommu: rockchip: make it explicitly non-modular
  iommu: msm_iommu: make it explicitly non-modular
  iommu: mtk_iommu: make it explicitly non-modular
  iommu: ipmmu-vmsa: make it explicitly non-modular
  iommu: qcom_iommu: make it explicitly non-modular
  iommu: tegra-gart: make it explicitly non-modular
  iommu: arm-smmu: make it explicitly non-modular
  iommu: arm-smmu-v3: make it explicitly non-modular

 drivers/iommu/arm-smmu-v3.c    | 25 +++++++++----------------
 drivers/iommu/arm-smmu.c       | 32 +++++++++++++-------------------
 drivers/iommu/iommu-sysfs.c    |  2 +-
 drivers/iommu/iommu.c          |  3 ++-
 drivers/iommu/ipmmu-vmsa.c     | 16 +++-------------
 drivers/iommu/msm_iommu.c      | 13 +++----------
 drivers/iommu/mtk_iommu_v1.c   | 15 +++------------
 drivers/iommu/qcom_iommu.c     | 16 ++--------------
 drivers/iommu/rockchip-iommu.c | 13 ++++++-------
 drivers/iommu/tegra-gart.c     | 37 +++++++------------------------------
 10 files changed, 49 insertions(+), 123 deletions(-)

-- 
2.7.4
