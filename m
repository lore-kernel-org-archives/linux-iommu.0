From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] dma: Uninline dma_max_mapping_size()
Date: Thu, 31 Jan 2019 09:43:51 -0500
Message-ID: <20190131094319-mutt-send-email-mst@kernel.org>
References: <20190130164007.26497-1-joro@8bytes.org>
 <20190130164007.26497-4-joro@8bytes.org>
 <20190131104129.GA9241@lst.de>
 <20190131130127.GP32526@8bytes.org>
 <20190131143723.GA32329@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131143723.GA32329@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de, Thomas.Lendacky@amd.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 03:37:23PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 31, 2019 at 02:01:27PM +0100, Joerg Roedel wrote:
> > On Thu, Jan 31, 2019 at 11:41:29AM +0100, Christoph Hellwig wrote:
> > > Sorry for not noticing last time, but since 5.0 we keep all non-fast
> > > path DMA mapping interfaces out of line, so this should move to
> > > kernel/dma/mapping.c.
> > 
> > Okay, attached patch does that. It applies on-top of this patch-set.
> > 
> > Michael, feel free to either apply this on-top of the patch-set or merge
> > the diff into patch 3, whatever you prefer.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> I'd prefer it to be squashed if possible.

OK. Joerg can you repost the series with this squashed
and all acks applied?
