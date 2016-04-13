From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/7] arm-smmu: Implementation and context format
	differentiation
Date: Wed, 13 Apr 2016 18:12:56 +0100
Message-ID: <cover.1460391217.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

This is almost 3 separate sub-series, but there's enough interdependency
and horrid merge conflicts that I've been keeping it all together.

- Patches 1-3 rationalise implementation-specific details and errata,
  in order to start shovelling in yet more wonderful workarounds.
- Patches 3-6 do a broadly similar thing for context formats, breaking
  the effective hard-coding to allow it to become a runtime choice.
  (With the bonus of unblocking short-descriptor support, once I find
  and revive the hac^Wpatches I was using for that.)
- Patch 7 then takes advantage of the previous changes to support the
  hilarious raison d'etre of MMU-401, in all its glory.

This is all based on top of the ThunderX patches in Will's iommu/devel
branch. It also conflicts somewhat with my per-domain page size series;
since this is probably less contentious, I expect I'll optimistically
rebase that on top of this one before I post it again.

Robin.
---

Robin Murphy (7):
  iommu/arm-smmu: Differentiate specific implementations
  iommu/arm-smmu: Convert ThunderX workaround to new method
  iommu/arm-smmu: Work around MMU-500 prefetch errata
  io-64-nonatomic: Add relaxed accessor variants
  iommu/arm-smmu: Tidy up 64-bit/atomic I/O accesses
  iommu/arm-smmu: Decouple context format from kernel config
  iommu/arm-smmu: Support SMMUv1 64KB supplement

 Documentation/arm64/silicon-errata.txt |   1 +
 drivers/iommu/arm-smmu.c               | 238 +++++++++++++++++++++++----------
 include/linux/io-64-nonatomic-hi-lo.h  |  25 ++++
 include/linux/io-64-nonatomic-lo-hi.h  |  25 ++++
 4 files changed, 216 insertions(+), 73 deletions(-)

-- 
2.7.3.dirty
