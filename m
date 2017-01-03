From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 0/3] iommu/arm-smmu: patches for adreno
Date: Tue,  3 Jan 2017 16:30:53 -0500
Message-ID: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Will,

I meant to scrape something together a bit sooner.  I wanted to check if
this was in line with what you were thinking for upstream alternative to
reverting "iommu/arm-smmu: Disable stalling faults for all endpoints".

(Third patch is semi-unrelated, but I'd prefer to only have my rate-
limited prints from drm/msm, since they contain additional information
about gpu state for debugging the fault.)

Rob Clark (3):
  iommu/arm-smmu: Add support to opt-in to stalling
  iommu/arm-smmu: Add qcom implementation
  iommu/arm-smmu: Let fault handler return -EFAULT

 .../devicetree/bindings/iommu/arm,smmu.txt         |  3 ++
 drivers/iommu/arm-smmu.c                           | 54 ++++++++++++++++++++--
 2 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.7.4
