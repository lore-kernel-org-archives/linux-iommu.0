From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/3] Driver message cleanups
Date: Wed, 28 Nov 2018 09:43:39 +0100
Message-ID: <20181128084342.16363-1-joro@8bytes.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here are a couple of patches to clean up the message
printing in the AMD IOMMU driver a bit. The patches switch
the driver to use pr_fmt() instead of inconsistently open
coding the 'AMD-Vi' prefix in error messages. Furhter the
Event log messages are fixed and contain no newline anymore.
The addresses in the event log messages got rid of the
leading 0s to make the messages shorter.

Regards,

	Joerg

Joerg Roedel (3):
  iommu/amd: Use pr_fmt()
  iommu/amd: Fix line-break in error log reporting
  iommu/amd: Remove leading 0s in error log messages

 drivers/iommu/amd_iommu.c      | 62 ++++++++++++++++----------------
 drivers/iommu/amd_iommu_init.c | 64 ++++++++++++++++++----------------
 drivers/iommu/amd_iommu_v2.c   |  2 ++
 3 files changed, 66 insertions(+), 62 deletions(-)

-- 
2.17.1
