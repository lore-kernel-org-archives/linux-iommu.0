From: <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/3] iommu/amd: Improve IOMMU Event Log Interrupt Handling
Date: Wed, 27 Mar 2013 18:50:15 -0500
Message-ID: <1364428215-2513-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

Typically, IOMMU events are logged into the event log.  Current driver processes each event
in the log when the hardware generate an MSI interrupt. It reports event type, device ID, 
raw status flag, and etc. in the kernel log (dmesg)

1. The first patch improve event reporting by using the type of event and status flag to 
decode event information and provide more detail in the report. This should also be useful 
when debugging IOMMU issues.

2. The second patch provide interface for testing the event decoding logic using the debugfs.

3. Fix IOMMU event log interrupt handling which currently does not re-enable the event interrupt.

 drivers/iommu/Kconfig            |    9 ++
 drivers/iommu/Makefile           |    1 +
 drivers/iommu/amd_iommu.c        |  167 ++++++++++++++++++++++++++++++++------
 drivers/iommu/amd_iommu_inject.c |   99 ++++++++++++++++++++++
 drivers/iommu/amd_iommu_proto.h  |    9 ++
 drivers/iommu/amd_iommu_types.h  |    1 +
 6 files changed, 259 insertions(+), 27 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_inject.c

-- 
1.7.10.4
