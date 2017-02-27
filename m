From: Oleksandr Tyshchenko <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 0/2] Misc fixes for ARM page table allocator (long/short
	descriptor format)
Date: Mon, 27 Feb 2017 14:30:24 +0200
Message-ID: <1488198626-1884-1-git-send-email-olekstysh@gmail.com>
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
Cc: vlad.babchuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, andrii.anisov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andr2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, al1img-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joculator-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi.

There is a small patch series which contains the same fix for both
descriptor formats based on the preceding RFC patches:
https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020411.html
https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020477.html

Oleksandr Tyshchenko (2):
  iommu/io-pgtable-arm: Check for leaf entry before dereferencing it
  iommu/io-pgtable-arm-v7s: Check for leaf entry before dereferencing it

 drivers/iommu/io-pgtable-arm-v7s.c | 6 +++++-
 drivers/iommu/io-pgtable-arm.c     | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.7.4
