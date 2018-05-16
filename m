From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: add swiotlb support for riscv
Date: Wed, 16 May 2018 16:42:59 +0200
Message-ID: <20180516144302.823-1-hch@lst.de>
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
To: palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org
Cc: linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Current 64-bit RISC-V cores don't have any iommu support, so they need
iommu support when used with more than 4GB DRAM (or even just address
space depending on the SBI).  This wires the support up based on
earlier patches from Palmer.

Note that the patches are on to of the dma mapping tree as they require
the swiotlb Kconfig consolidation, and should probably merged through
that tree as well.

Git tree:

    git://git.infradead.org/users/hch/misc.git riscv-swiotlb

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/riscv-swiotlb
