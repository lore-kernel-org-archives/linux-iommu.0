From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 0/3] How to pass IOMMU map attr via DMA API?
Date: Thu, 20 Jun 2013 08:49:41 +0300
Message-ID: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In Tegra SoC, IOMMU can set some mapping attribute for each page, for
exmaple, READable, and WRITEable. We'd like to use this feature
*newly* for robustness, where read-only pages can be protected from
being overwritten by wrong operation. We have been using IOMMU via DMA
mapping API(ARM). DMA mapping API currently doesn't use "prot"
parameter when calling IOMMU API. So this series tries to pass "struct
dma_attrs *attrs" via "int prot" in IOMMU API. I'm not so sure if this
implementation is right or not because:

- Casting (struct dma_attrs *) to (int) in DMA API doesn't look nice.
- IOMMU layer needs to cast (int) back to (struct dma_attrs *) again,
  which can be considered as violation of layers.

If you have any implementations/suggestions, it would be really helpful.

This series isn't applied cleanly but this is posted to request for
comments.

Hiroshi Doyu (3):
  common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
  ARM: dma-mapping: Pass DMA attrs as IOMMU prot
  iommu/tegra: smmu: Support read-only mapping

 arch/arm/mm/dma-mapping.c  | 34 +++++++++++++++++++++-------------
 drivers/iommu/tegra-smmu.c | 41 +++++++++++++++++++++++++++++------------
 include/linux/dma-attrs.h  |  1 +
 3 files changed, 51 insertions(+), 25 deletions(-)

-- 
1.8.1.5
