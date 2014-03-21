From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 00/33] iommu/vt-d: Add support for DMA mapping of
	ACPI-enumerated devices
Date: Fri, 21 Mar 2014 17:18:41 +0000
Message-ID: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
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
List-Id: iommu@lists.linux-foundation.org

Version 2.2 of the VT-d specification adds support for DMA mapping of ACPI
devices, by adding fields to the DMAR table which indicate the ACPI path
of each	DMA-capable device and the PCI bus/dev/fn from which its DMA will
*appear* to come.

The bulk of this patch series is going through the code and changing all
the hardcoded assumptions about	'struct	pci_dev' to use	'struct	device'
instead. The rest is fairly boring; just storing the bus/devfn in the
scope arrays and using them accordingly.

I've pushed this out to git://git.infradead.org/iommu-2.6.git along with
the previous 4-patch series to clean up and fix the page table unmapping.
