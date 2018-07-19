From: Christoph Hellwig <hch@lst.de>
Subject: use the generic dma-noncoherent code for openrisc
Date: Thu, 19 Jul 2018 06:02:28 -0700
Message-ID: <20180719130232.1819-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Openrisc maintainers,

can you review these patches to switch openrisc to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.
