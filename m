From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v4 0/2] Enable smmu support on sdm845
Date: Thu, 11 Oct 2018 15:19:28 +0530
Message-ID: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series enables apps-smmu, the "arm,mmu-500" instance
on sdm845.
Series tested on SDM845 MTP device with related smmu patch series [1],
and necessary config change, besides one hack to keep LDO14 in LPM mode
to boot things up (see the commit in the test branch).
The tested branch is available at [2].

Changes since v3:
 - Refined the dt binding documentation more to align with
   Rob's comments for qcom,smmu-v2 binding documentation [3]
   on SoC specific compatibles and state things similar
   to qcom,smmu-v2 [4].

Changes since v2:
 - Dropped patch for gpu-smmu [5] as the same has been pushed by
   Jordan [6] after incorporating the dt binding update.
 - Updated binding doc to include valid value for '<soc>'
   in "qcom,<soc>-smmu-500" compatible string.

Changes since v1:
 - Addressed Rob's review comments by adding a SoC specific compatible.
   Have added a new dt-bindings patch for this.
 - Updated node name to 'iommu'.
 - Addressed Doug's review comment about removing status property from
   smmu's nodes, as smmu is either present on the soc or not. Enabling
   it is not a board-level decision.

[1] https://patchwork.kernel.org/cover/10581891/
[2] https://github.com/vivekgautam1/linux/commits/v4.19-rc7/sdm845-smmu-dt
[3] https://patchwork.kernel.org/patch/10576937/
[4] https://patchwork.kernel.org/patch/10581911/
[5] https://patchwork.kernel.org/patch/10565295/
[6] https://patchwork.kernel.org/patch/10577297/

Vivek Gautam (2):
  dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
  dts: arm64/sdm845: Add node for arm,mmu-500

 .../devicetree/bindings/iommu/arm,smmu.txt         |  4 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 72 ++++++++++++++++++++++
 2 files changed, 76 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
