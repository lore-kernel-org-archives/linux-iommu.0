From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-debug: Only skip one stackframe entry
Date: Thu, 11 Apr 2019 19:26:58 +0200
Message-ID: <20190411172658.GA30605@lst.de>
References: <20190410215925.8458-1-swood@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190410215925.8458-1-swood@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Wood <swood@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: iommu@lists.linux-foundation.org

Thomas just posted a major rework in this area.  I think you are
best off rebasing it on top of that series and feeding it to him.

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
