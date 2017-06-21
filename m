From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RESEND PATCH 0/4] iommu: add qcom_iommu for early "B" family devices
Date: Wed, 21 Jun 2017 08:04:02 -0400
Message-ID: <20170621120406.2053-1-robdclark@gmail.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

An iommu driver for Qualcomm "B" family devices which do not implement
the ARM SMMU spec in a way that is compatible with the arm-smmu driver.

No change since last time, other than Riku's tested-by.

Rob Clark (3):
  Docs: dt: document qcom iommu bindings
  iommu: arm-smmu: split out register defines
  iommu: add qcom_iommu

Stanimir Varbanov (1):
  iommu: qcom: initialize secure page table

 .../devicetree/bindings/iommu/qcom,iommu.txt       | 121 +++
 drivers/iommu/Kconfig                              |  10 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/arm-smmu-regs.h                      | 227 +++++
 drivers/iommu/arm-smmu.c                           | 203 +----
 drivers/iommu/qcom_iommu.c                         | 932 +++++++++++++++++++++
 6 files changed, 1292 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
 create mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/qcom_iommu.c

-- 
2.9.4
