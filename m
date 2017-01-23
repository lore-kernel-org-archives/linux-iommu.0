From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/3] iommu/ipmmu-vmsa: r8a7796 support V2
Date: Mon, 23 Jan 2017 20:39:49 +0900
Message-ID: <148517158986.13306.314435910710426381.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: r8a7796 support V2

[PATCH v2 1/3] iommu/ipmmu-vmsa: Add r8a7796 DT binding
[PATCH v2 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
[PATCH v2 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code

This series adds r8a7796 support to the IPMMU driver. The DT binding
gets updated, maximum number of micro-TLBs are increased and the
driver is adjusted to match on the new DT binding.

Changes since last version include:
- Patch #1 (DT binding patch) updated with more Acked-by tags
- Patch #2 (micro-TLB patch) updated with high I/O register range support

If possible I would like to fast-track merge of patch #1 to fix DT interface.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Developed on top of renesas-drivers-2017-01-10-v4.10-rc3 with locally reverted
 "[PATCH 0/3] iommu/ipmmu-vmsa: Initial r8a7796 support"

 More detailed patch stack dependency is v4.10-rc3 + iommu/next and:
 [PATCH v6 00/07] iommu/ipmmu-vmsa: IPMMU multi-arch update V6
 [PATCH v2 00/11] iommu/ipmmu-vmsa: r8a7795 support V2

Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |    1 
 drivers/iommu/ipmmu-vmsa.c                                     |   19 +++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)
