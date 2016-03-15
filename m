From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 00/04] iommu/ipmmu-vmsa: IPMMU multi-arch update V2
Date: Tue, 15 Mar 2016 13:21:36 +0900
Message-ID: <20160315042136.22103.26570.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: IPMMU multi-arch update V2

[PATCH v2 01/04] iommu/ipmmu-vmsa: Remove platform data handling
[PATCH v2 02/04] iommu/ipmmu-vmsa: Rework interrupt code and use bitmap for context
[PATCH v2 03/04] iommu/ipmmu-vmsa: Break out 32-bit ARM mapping code
[PATCH v2 04/04] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency

These patches update the IPMMU driver with a few minor changes
to support build on multiple architectures.

With these patches applied the driver is known to compile without issues
on 32-bit ARM, 64-bit ARM and x86_64.

Changes since V1:
 - Got rid of patch 2 and 3 from initial series
 - Updated bitmap code locking and also used lighter bitop functions
 - Updated the Kconfig bits to apply on top of ARCH_RENESAS

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Built on top of next-20160314

 drivers/iommu/Kconfig      |    1 
 drivers/iommu/ipmmu-vmsa.c |  146 +++++++++++++++++++++++++++++---------------
 2 files changed, 97 insertions(+), 50 deletions(-)
