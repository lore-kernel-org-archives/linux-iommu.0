From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] Generic IOMMU page table framework
Date: Thu, 27 Nov 2014 11:51:14 +0000
Message-ID: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Robin.Murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

This series introduces a generic IOMMU page table allocation framework,
implements support for ARM long-descriptors and then ports the arm-smmu
driver over to the new code.

There are a few reasons for doing this:

  - Page table code is hard, and I don't enjoy shopping

  - A number of IOMMUs actually use the same table format, but currently
    duplicate the code

  - It provides a CPU (and architecture) independent allocator, which
    may be useful for some systems where the CPU is using a different
    table format for its own mappings

As illustrated in the final patch, an IOMMU driver interacts with the
allocator by passing in a configuration structure describing the
input and output address ranges, the supported pages sizes and a set of
ops for performing various TLB invalidation and PTE flushing routines.

The LPAE code implements support for 4k/2M/1G, 16k/32M and 64k/512M
mappings, but I decided not to implement the contiguous bit in the
interest of trying to keep the code semi-readable. This could always be
added later, if needed.

I also included some self-tests for the LPAE implementation. Ideally
we'd merge these, but I'm also happy to drop them if there are
objections.

Tested with the self-tests, but also VFIO + MMU-500 at stage-1 and
stage-2. Patches taken against my iommu/devel branch (queued by Joerg
for 3.19).

All feedback welcome.

Will

--->8

Will Deacon (4):
  iommu: introduce generic page table allocation framework
  iommu: add ARM LPAE page table allocator
  iommu: add self-consistency tests to ARM LPAE IO page table allocator
  iommu/arm-smmu: make use of generic LPAE allocator

 MAINTAINERS                    |   1 +
 arch/arm64/Kconfig             |   1 -
 drivers/iommu/Kconfig          |  32 +-
 drivers/iommu/Makefile         |   2 +
 drivers/iommu/arm-smmu.c       | 872 +++++++++++---------------------------
 drivers/iommu/io-pgtable-arm.c | 925 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c     |  78 ++++
 drivers/iommu/io-pgtable.h     |  77 ++++
 8 files changed, 1361 insertions(+), 627 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.c
 create mode 100644 drivers/iommu/io-pgtable.c
 create mode 100644 drivers/iommu/io-pgtable.h

-- 
2.1.1
