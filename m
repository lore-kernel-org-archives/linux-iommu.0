From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 00/09] iommu/ipmmu-vmsa: r8a7795 support V3
Date: Wed, 08 Mar 2017 20:01:23 +0900
Message-ID: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: r8a7795 support V3

[PATCH v3 01/09] iommu/ipmmu-vmsa: Introduce features, break out alias
[PATCH v3 02/09] iommu/ipmmu-vmsa: Add optional root device feature
[PATCH v3 03/09] iommu/ipmmu-vmsa: Enable multi context support
[PATCH v3 04/09] iommu/ipmmu-vmsa: Make use of IOMMU_OF_DECLARE()
[PATCH v3 05/09] iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master
[PATCH v3 06/09] iommu/ipmmu-vmsa: Write IMCTR twice
[PATCH v3 07/09] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
[PATCH v3 08/09] iommu/ipmmu-vmsa: Allow two bit SL0
[PATCH v3 09/09] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code

This series contains a much needed r8a7795 support update for the
IPMMU driver. Last series was earlier posted as:

[PATCH v2 00/11] iommu/ipmmu-vmsa: r8a7795 support V2

The DT binding for r8a7795 has been accepted for upstream merge
and this series implements support following such format:

d4e42e7 iommu/ipmmu-vmsa: Add r8a7795 DT binding

The r8a7795 IPMMU is almost register compatible with earlier devices
like r8a7790-r8a7794, however some bitfields have been shifted
slightly. On a grander scale topology has been added and interrupts
have been reworked. So now there are several "cache" IPMMU units
without interrupt that somehow communicate with IPMMU-MM that
is the only instance that supports interrupts. The code refers to
IPMMU-MM as a "root" device and the other ones as "leaf" nodes.

To make this more interesting the IPMMU driver needs to be shared
between 32-bit ARM for r8a7790-r8a7794 and 64-bit ARM for r8a7795.
In practice this means that two separate implementations are needed
inside the driver to attach to the rather different architecture
specific code.

CONFIG_IOMMU_DMA=y is needed on 64-bit ARM while on 32-bit ARM
the arch specific dma-mapping code is hooked up rather directly.
During init 64-bit ARM IPMMU support is relying on IOMMU_OF_DECLARE().

This version of the code is known to build on 32-bit and 64-bit ARM.

Some patches that existed in V1 have been folded into:
 [PATCH v7 00/07] iommu/ipmmu-vmsa: IPMMU multi-arch update V7

Changes since V2:
 - Patch 2/9 has been updated with a bug fix and to supply __ipmmu_find_root()
 - Patch 4/9 now makes use of iommu_device_* functions
 - Patch 5/9 sets the mask to 40 bits instead of 64 bits
 - Patch 9/9 implements white list handling via ->xlate() and fixes a bug

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Developed on top of v4.11-rc1 and:
 [PATCH v7 00/07] iommu/ipmmu-vmsa: IPMMU multi-arch update V7

 drivers/iommu/ipmmu-vmsa.c |  291 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 251 insertions(+), 40 deletions(-)
