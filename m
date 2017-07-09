From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 0/2] arm-smmu-v3 tlbi-on-map option
Date: Sun,  9 Jul 2017 17:15:01 +0200
Message-ID: <1499613303-30173-1-git-send-email-eric.auger@redhat.com>
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
To: eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org
Cc: Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series adds a new tlbi-on-map option to the smmuv3 driver.
When set, the IO_PGTABLE_QUIRK_TLBI_ON_MAP quirk is applied for 
LPAE tables and the smmuv3 driver sends TLB invalidations on map.

This mode is useful when running the driver on a guest as it allows
the virtualizer to trap any change to the translation structures.
This is similar to the Intel vtd caching mode (CM).

This is especially needed for VFIO integration integration where
guest mappings must be applied to the physical IOMMU.

At the moment the option only is available for DT probing.

Best Regards

Eric

Eric Auger (2):
  iommu/io-pgtable-arm: flush TLBs when IO_PGTABLE_QUIRK_TLBI_ON_MAP
  arm-smmu-v3: Add tlbi_on_map option

 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt |  4 ++++
 drivers/iommu/arm-smmu-v3.c                             |  5 +++++
 drivers/iommu/io-pgtable-arm.c                          | 13 +++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.5.5
