From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA
 operation
Date: Mon, 27 Aug 2018 10:41:31 +0200
Message-ID: <20180827084131.GA21563@lst.de>
References: <20180719125635.824-1-hch@lst.de> <20180719125635.824-2-hch@lst.de> <20180725032948.GG12771@codeaurora.org> <20180725043927.GA10827@lst.de> <20180731152229.GA956@lst.de> <20180807070136.GA32634@lst.de> <20180808001927.GA20752@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808001927.GA20752@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Given that it didn't make 4.19-rc1, I'll pull this into the dma-mapping
tree first thing for 4.20 as I have some other changes that will go on
top of it.
