From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 0/5] iommu/msm: Add DT adaptation and generic bindings support
Date: Wed, 12 Aug 2015 20:17:44 +0530
Message-ID: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The msm_iommu.c driver currently works based on platform data. A single master
device can be connected to more than one iommu and multiple contexts in each
of the iommu. This association between master and iommus was represented
from platform data using parent/child devices. The master drivers were
responsible for attaching all of the iommus/context to a domain. Now the
platform data support is removed and DT support is added. The master/iommus
are added through generic iommu bindings.

This is essentially rework of the patch posted earlier by
Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>. This series folds the changes
in to the existing driver with the addition of generic bindings.

        http://www.spinics.net/lists/linux-arm-msm/msg10077.html

This series is based on the IOMMU probe deferral series from
Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

        https://lkml.org/lkml/2015/5/14/786

Tested this series on ifc6410 board.

Sricharan R (5):
  iommu/msm: Add DT adaptation
  iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
  iommu/msm: Add support for generic master bindings
  iommu/msm: Set cacheability attributes without tex remap
  iommu/msm: Remove driver BROKEN

 .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  59 +++
 drivers/iommu/Kconfig                              |   1 -
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/msm_iommu.c                          | 508 ++++++++++++++-------
 drivers/iommu/msm_iommu.h                          |  73 ++-
 drivers/iommu/msm_iommu_dev.c                      | 392 ----------------
 drivers/iommu/msm_iommu_hw-8xxx.h                  |  10 +-
 7 files changed, 432 insertions(+), 613 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 delete mode 100644 drivers/iommu/msm_iommu_dev.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
