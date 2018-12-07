From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] Refactor dummy DMA ops
Date: Fri, 7 Dec 2018 18:05:19 +0100
Message-ID: <20181207170519.GA26857@lst.de>
References: <cover.1544199754.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1544199754.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, iommu@lists.linux-foundation.org, m.szyprowski@samsung.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

So I'd really prefer if we had a separate dummy.c file, like in
my take on your previous patch here:

http://git.infradead.org/users/hch/misc.git/commitdiff/e01adddc1733fa414dc16cd22e8f58be9b64a025

http://git.infradead.org/users/hch/misc.git/commitdiff/596bde76e5944a3f4beb8c2769067ca88dda127a

Otherwise this looks fine.  If you don't minde I'll take your patches,
apply the move to a separate file and merge it into the above tree.
