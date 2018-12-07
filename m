From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [RFC] avoid indirect calls for DMA direct mappings v2
Date: Fri,  7 Dec 2018 11:07:05 -0800
Message-ID: <20181207190720.18517-1-hch@lst.de>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jesper Dangaard Brouer <brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke-LJ9M9ZcSy1A@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilias Apalodimas <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Jonathan Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tariq Toukan <tariqt-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi all,

a while ago Jesper reported major performance regressions due to the
spectre v2 mitigations in his XDP forwarding workloads.  A large part
of that is due to the DMA mapping API indirect calls.

It turns out that the most common implementation of the DMA API is the
direct mapping case, and now that we have merged almost all duplicate
implementations of that into a single generic one is easily feasily to
direct calls for this fast path.

This series adds consolidate the DMA mapping code by merging the
swiotlb case into the dma direct case, and then treats NULL dma_ops
as an indicator that that we should directly call the direct mapping
case.  This recovers a large part of the retpoline induces XDP slowdown.

This works is based on the dma-mapping tree, so you probably want to
want this git tree for testing:

    git://git.infradead.org/users/hch/misc.git dma-direct-calls.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls.2

Changes since v1:
 - now also includes all the prep patches relative to the dma-mapping
   for-next tree
 - move various slow path functions out of line
 - use a NULL dma ops as the indicate to use the direct mapping path
 - remove dma_direct_ops now that we always call it without the indirection
 - move the dummy dma ops to common code
 - explicitly st the dummy dma ops for devices that are indicates as not
   DMA capable by firmware
