From: Christoph Hellwig <hch@lst.de>
Subject: use generic dma-direct and swiotlb code for x86
Date: Mon,  5 Mar 2018 09:46:42 -0800
Message-ID: <20180305174655.9878-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, David Woodhouse <dwmw2@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

this series switches the x86 code the the dma-direct implementation
for direct (non-iommu) dma and the generic swiotlb ops.  This includes
getting rid of the special ops for the AMD memory encryption case and
the STA2x11 SOC.  The generic implementations are based on the x86
code, so they provide the same functionality.
