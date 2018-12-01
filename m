From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH v2 0/9] iommu: clean up/remove modular stuff from non-modules.
Date: Sat, 1 Dec 2018 14:19:08 -0500
Message-ID: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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

Patches were build tested on top of next-20181128 for ARM, ARM64, x86-64
on an allyesconfig.

Paul.

---

[ v2: use recommended iommu subject format, add Acks, trivial tweaks. ]

Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Paul Gortmaker (9):
  iommu: audit and remove any unnecessary uses of module.h
  iommu/rockchip: Make it explicitly non-modular
  iommu/msm: Make it explicitly non-modular
  iommu/mediatek: Make it explicitly non-modular
  iommu/ipmmu-vmsa: Make it explicitly non-modular
  iommu/qcom: Make it explicitly non-modular
  iommu/tegra: Make it explicitly non-modular
  iommu/arm-smmu: Make arm-smmu explicitly non-modular
  iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular

 drivers/iommu/arm-smmu-v3.c    | 25 +++++++++----------------
 drivers/iommu/arm-smmu.c       | 32 +++++++++++++-------------------
 drivers/iommu/iommu-sysfs.c    |  2 +-
 drivers/iommu/iommu.c          |  3 ++-
 drivers/iommu/ipmmu-vmsa.c     | 18 +++---------------
 drivers/iommu/msm_iommu.c      | 13 +++----------
 drivers/iommu/mtk_iommu_v1.c   | 15 +++------------
 drivers/iommu/qcom_iommu.c     | 16 ++--------------
 drivers/iommu/rockchip-iommu.c | 13 ++++++-------
 drivers/iommu/tegra-gart.c     | 37 +++++++------------------------------
 10 files changed, 49 insertions(+), 125 deletions(-)

-- 
2.7.4
