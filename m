From: Christoph Hellwig <hch@lst.de>
Subject: document dma-direct zone selection
Date: Mon,  1 Oct 2018 13:10:15 -0700
Message-ID: <20181001201016.32639-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

this patch documents the dma-direct zone selection, as it doesn't
seem quite obvuious enough.
