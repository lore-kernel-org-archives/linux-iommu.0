From: Christoph Hellwig <hch@lst.de>
Subject: use the generic dma-noncoherent code for microblaze
Date: Thu, 19 Jul 2018 05:54:38 -0700
Message-ID: <20180719125440.424-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Michal,

can you review these patches to switch microblaze to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.
