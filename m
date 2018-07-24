From: Christoph Hellwig <hch@lst.de>
Subject: use the generic dma-noncoherent code for sh V2
Date: Tue, 24 Jul 2018 14:01:42 +0200
Message-ID: <20180724120147.15096-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

can you review these patches to switch sh to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.

Changes since V1:
 - fixed two stupid compile errors and verified them using a local
   cross toolchain instead of the 0day buildbot
