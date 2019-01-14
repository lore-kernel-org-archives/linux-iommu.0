From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Date: Mon, 14 Jan 2019 12:12:13 +0100
Message-ID: <20190114111213.GA31455@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-4-hch@lst.de> <20190111175416.7d291e25@coco.lan>
 <20190114103139.GA31005@lst.de> <20190114090456.03071201@coco.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190114090456.03071201@coco.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Pawel Osciak <pawel@osciak.com>, Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 14, 2019 at 09:04:56AM -0200, Mauro Carvalho Chehab wrote:
> It would be good if you could later send us a stable branch where
> you merged, in order to allow us to run some tests with the new
> DMA mapping patchset and be sure that it won't cause regressions
> to videobuf2.

I can do that, but the series as sent should be testable, results
welcome!
