From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/5] swiotlb: Add is_swiotlb_active() function
Date: Thu, 24 Jan 2019 09:29:23 +0100
Message-ID: <20190124082923.GI32526@8bytes.org>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123163049.24863-3-joro@8bytes.org>
 <20190123212755.GA9032@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123212755.GA9032@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 23, 2019 at 10:27:55PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 23, 2019 at 05:30:46PM +0100, Joerg Roedel wrote:
> > +bool is_swiotlb_active(void)
> > +{
> > +	return !no_iotlb_memory;
> > +}
> 
> As I've just introduced and fixed a bug in this area in the current
> cycle - I don't think no_iotlb_memory is what your want (and maybe
> not useful at all): if the arch valls swiotlb_exit after previously
> initializing a buffer it won't be set.  You probably want to check
> for non-zero io_tlb_start and/or io_tlb_end.

Okay, but that requires that I also set io_tlb_start and friends back to
zero in the failure path of swiotlb_init(). Otherwise it could be left
non-zero in case swiotlb_init_with_tbl() returns an error.


Regards,

	Joerg
