From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2 0/5] Renesas VMSA-compatible IPMMU DT support
Date: Thu, 17 Apr 2014 12:33:22 +0200
Message-ID: <1397730807-5993-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch set adds DT support to the Renesas VMSA-compatible IPMMU driver.
The first patch refactors the driver to remove dependencies on platform data,
the second patch adds the DT bindings documentation and the third patch
implement them in the driver.

The next two patches show real-life examples for IPMMU DT bindings usage.
Patch 4/5 adds IPMMU DT nodes to the r8a7791 SoC dtsi file, and patch 5/5
enables IOMMU support for the VSP1 on the same platform.

The patches are based on top of the IPMMU driver previously submitted to the
iommu mailing list. The last patch additionally requires to VSP1 DT support
patch series previously submitted to the linux-media mailing list and is thus
a test patch only at the moment, not meant to be merged yet.

The DT bindings are pretty simple, with only three standard properties in the
IPMMU DT node. The driver doesn't need to know the number of micro-TLBs (a
micro-TLB being a port to which a bus master device is attached, identified by
a number similar in purpose to a stream ID), so I've decided not to specify it
in DT. The micro-TLBs are configured when a bus master device is attached or
detached, and at that point the device provides its micro-TLB number.

The only reason I can foresee why the number of micro-TLBs would be useful is 
to iterate over micro-TLBs when the driver probes the device to disable them 
all. A mask would probably be better than a number in that case, and I think 
we can always add that later if we find a need for it.

The device to IOMMU association is represented in the bus master device nodes
using an iommus property, similarly to interrupts or clocks. This model departs
from the ARM SMMU DT bindings that represent the same information inside the
IOMMU DT node. Will, please feel free to tell me if you believe this model
isn't good.

Every IPMMU instance serves multiple bus master devices and implements four
independent page tables and TLBs. Each bus master can be freely assigned to one
of the page tables, lowering the risk of TLB miss when multiple bus masters
require address translation at the same time. I've decided not to express the
bus master to page table association in DT as this seems to me to be a software
configuration decision, not a hardware property. Feel free to disagree.

As a side note, there's no API at the moment to configure that association. My
plan is to assign bus masters to page tables automatically in the driver in a
round-robin way. A more configurable solution might be needed later, but I
believe that's out of scope of DT.

Changes since v1:

- Fixed typos
- Add a missing of_node_put()

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Laurent Pinchart (5):
  iommu/ipmmu-vmsa: Refactor micro-TLB lookup
  iommu/ipmmu-vmsa: Add device tree bindings documentation
  iommu/ipmmu-vmsa: Add device tree support
  ARM: shmobile: r8a7791: Add IPMMU DT nodes
  ARM: shmobile: r8a7791: Enable IOMMU support for the VSP1

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  35 ++++++
 arch/arm/boot/dts/r8a7791.dtsi                     |  54 ++++++++++
 drivers/iommu/ipmmu-vmsa.c                         | 117 +++++++++++++--------
 3 files changed, 165 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt

-- 
Regards,

Laurent Pinchart
