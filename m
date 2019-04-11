From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-debug: Only skip one stackframe entry
Date: Thu, 11 Apr 2019 19:28:35 +0200
Message-ID: <20190411172835.GA30904@lst.de>
References: <20190410215925.8458-1-swood@redhat.com> <20190411172658.GA30605@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411172658.GA30605@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Wood <swood@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 11, 2019 at 07:26:58PM +0200, Christoph Hellwig wrote:
> Thomas just posted a major rework in this area.  I think you are
> best off rebasing it on top of that series and feeding it to him.

Actually..  Given that this series hasn't been merged yet and given
how trivial this change is I might just feed it to Linus with my
next merge request tomorrow.  That is probably easier for everyone.
