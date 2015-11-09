From: Christoph Hellwig <hch@lst.de>
Subject: use dma_map_ops for all architectures
Date: Mon,  9 Nov 2015 19:17:05 +0100
Message-ID: <1447093041-21832-1-git-send-email-hch@lst.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Ley Foon Tan <lftan@altera.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Chris Metcalf <cmetcalf@ezchip.com>, linux-snps-arc@lists.infraded.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

This series converts all remaining architectures to use dma_map_ops
and the generic implementation of the DMA API.  This not only
simplifies the code a lot, but also prepares for possible future
changes like more generic non-iommu dma_ops implementations or generic
per-device dma_map_ops.

A git tree is also available at:

	http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/dma-mapping-cleanups

