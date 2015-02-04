From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] iommu: A couple of urgent fixes
Date: Wed,  4 Feb 2015 08:58:06 +0100
Message-ID: <1423036690-3862-1-git-send-email-thierry.reding@gmail.com>
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
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Hi Joerg,

Here are a couple of urgent fixes for a regression on old Tegra devices
related to IOMMU support. The issue is that many drivers think it's a
good idea to register IOMMU support unconditionally, which is not the
smart thing to do at all on multi-platform kernels. This probably went
unnoticed for a while because the offending drivers aren't enabled in
any of the multi-platform default configurations. Fedora ARM has their
own config where the offending drivers did get enabled, hence caused a
regression on Tegra20. I would expect the same regression to exist on a
number of other SoCs, possibly all that support IOMMU.

I've tried to keep the patches minimal in the hopes of still getting
this into v3.19-rc8 or the final release to avoid the regression.

Thierry

Thierry Reding (4):
  iommu/exynos: Play nice in multi-platform builds
  iommu/omap: Play nice in multi-platform builds
  iommu/rockchip: Play nice in multi-platform builds
  iommu/msm: Mark driver BROKEN

 drivers/iommu/Kconfig          | 1 +
 drivers/iommu/exynos-iommu.c   | 3 +++
 drivers/iommu/omap-iommu.c     | 6 ++++++
 drivers/iommu/rockchip-iommu.c | 6 ++++++
 4 files changed, 16 insertions(+)

-- 
2.1.3
