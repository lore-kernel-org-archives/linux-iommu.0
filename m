From: Christoph Hellwig <hch@lst.de>
Subject: scsi fixes for non cache-coherent architectures (for 4.15 and stable)
Date: Tue, 21 Nov 2017 14:23:36 +0100
Message-ID: <20171121132339.1702-1-hch@lst.de>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Huacai Chen <chenhc@lemote.com>, linux-scsi@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Martin,

this series fixes scsi and libsas operations on platforms with cache
incoherent dma operations.  Patch 2 and 3 are originally from Huacai Chen,
but I've modified patch two so that it doesn't require his
dma_get_cache_alignment() rework, which I'd rather get into the next
merge window after the required fixups, and which isn't suitable for
a stable backport.  Patch 1 is new from me and makes sure
dma_get_cache_alignment is always available.  As on of the dma-mapping
maintainers I'd be happy with it going in through the scsi tree.
