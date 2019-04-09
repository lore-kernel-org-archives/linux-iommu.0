From: Christoph Hellwig <hch@lst.de>
Subject: per-device dma_map_ops for intel-iommu?
Date: Tue, 9 Apr 2019 15:59:24 +0200
Message-ID: <20190409135924.GA11431@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi David and Joerg,

do you remember a good reason why intel-iommu is not using per-device
dma_map_ops like the AMD iommu or the various ARM iommus?

Right now intel-iommu.c contains a half-asses reimplementation of the
dma direct code for the iommu_no_mapping() case, and it would seem
much nicer to just fall back to that case and not even call into
intel-iommu in that case.
