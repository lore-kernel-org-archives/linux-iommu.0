From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: merge dma_direct_ops and dma_noncoherent_ops v2
Date: Mon, 10 Sep 2018 08:05:28 +0200
Message-ID: <20180910060533.27172-1-hch@lst.de>
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
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

While most architectures are either always or never dma coherent for a
given build, the arm, arm64, mips and soon arc architectures can have
different dma coherent settings on a per-device basis.  Additionally
some mips builds can decide at boot time if dma is coherent or not.

I've started to look into handling noncoherent dma in swiotlb, and
moving the dma-iommu ops into common code [1], and for that we need a
generic way to check if a given device is coherent or not.  Moving
this flag into struct device also simplifies the conditionally coherent
architecture implementations.

These patches are also available in a git tree given that they have
a few previous posted dependencies:

    git://git.infradead.org/users/hch/misc.git dma-direct-noncoherent-merge

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-noncoherent-merge

Changes since v1:
 - rebased to the latest Linus' tree which includes coherent dma support
   for arc
 - a couple tidyups suggested by Paul Burton
