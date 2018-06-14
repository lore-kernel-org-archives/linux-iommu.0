From: Christoph Hellwig <hch@lst.de>
Subject: [RFC] move dma mapping code to kernel/dma
Date: Thu, 14 Jun 2018 14:00:27 +0200
Message-ID: <20180614120029.27315-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

I'm tempted to send this little file move series to Linus around -rc1
where it would cause the least harm.

Opinions?
