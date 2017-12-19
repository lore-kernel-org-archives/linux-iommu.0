From: Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH V1 0/1] Fix kernel panic caused by device ID duplication
	presented to the IOMMU
Date: Tue, 19 Dec 2017 16:13:55 +0100
Message-ID: <1513696436-31834-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: Jayachandran.Nair-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ganapatrao.Kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Here is my lspci output of ThunderX2 for which I am observing kernel panic coming from
SMMUv3 driver -> arm_smmu_write_strtab_ent() -> BUG_ON(ste_live):

# lspci -vt
-[0000:00]-+-00.0-[01-1f]--+ [...]
                           + [...]
                           \-00.0-[1e-1f]----00.0-[1f]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family

ASP device -> 1f:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family
PCI-Express to PCI/PCI-X Bridge -> 1e:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
                           
While setting up ASP device SID in IORT dirver:
iort_iommu_configure() -> pci_for_each_dma_alias()
we need to walk up and iterate over each device which alias transaction from
downstream devices.

AST device (1f:00.0) gets BDF=0x1f00 and corresponding SID=0x1f00 from IORT.
Bridge (1e:00.0) is the first alias. Following PCI Express to PCI/PCI-X Bridge
spec: PCIe-to-PCI/X bridges alias transactions from downstream devices using
the subordinate bus number. For bridge (1e:00.0), the subordinate is equal
to 0x1f. This gives BDF=0x1f00 and SID=1f00 which is the same as downstream
device. So it is possible to have two identical SIDs. The question is what we
should do about such case. Presented patch prevents from registering the same
ID so that SMMUv3 is not complaining later on.

Tomasz Nowicki (1):
  iommu: Make sure device's ID array elements are unique

 drivers/iommu/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.7.4
