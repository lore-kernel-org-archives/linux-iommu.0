From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 0/5] amd_iommu: Refactor IOMMU group and support virtual
	aliases
Date: Mon, 08 Oct 2012 22:49:28 -0600
Message-ID: <20121009044057.16302.44577.stgit@bling.home>
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
To: Joerg.Roedel-5C7GfCeVMHo@public.gmane.org, florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series is meant to refactor IOMMU group support in amd_iommu
to properly support virtual aliases.  If multiple devices alias to
the same virtual alias, they should be grouped together.  This code
also verifies whether the alias should be the root of the group vs
devices above the alias.

This seems to do the right thing on my system, but that's not saying
a lot since it doesn't do anything interesting with aliases.  I'd
appreciate if Joerg and Florian could test this on their systems.
Thanks,

Alex

---

Alex Williamson (5):
      amd_iommu: Properly account for virtual aliases in IOMMU groups
      amd_iommu: Split IOMMU group allocation and attach
      amd_iommu: Split upstream bus device lookup
      amd_iommu: Split IOMMU Group topology walk
      amd_iommu: Split IOMMU group initialization


 drivers/iommu/amd_iommu.c       |  184 ++++++++++++++++++++++++++++++---------
 drivers/iommu/amd_iommu_types.h |    1 
 2 files changed, 142 insertions(+), 43 deletions(-)
