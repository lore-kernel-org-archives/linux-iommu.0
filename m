From: Christoph Hellwig <hch@lst.de>
Subject: revert dma direct internals abuse
Date: Mon,  8 Apr 2019 12:55:24 +0200
Message-ID: <20190408105525.5493-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Hellstrom <thellstrom@vmware.com>
Cc: Deepak Rawat <drawat@vmware.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

unfortunately it took less than a merge window for the:

/*
 * All the dma_direct_* declarations are here just for the indirect call bypass,
 * and must not be used directly drivers!
 */

warning in dma-mapping.h to be ignored.  This series reverts the offender
to keep our API clean.

Thomas: please talk me first about your needs and I'll be happy to figure out
a proper API for what you want to do.
