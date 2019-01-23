From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] swiotlb: Add is_swiotlb_active() function
Date: Wed, 23 Jan 2019 22:27:55 +0100
Message-ID: <20190123212755.GA9032@lst.de>
References: <20190123163049.24863-1-joro@8bytes.org> <20190123163049.24863-3-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123163049.24863-3-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 23, 2019 at 05:30:46PM +0100, Joerg Roedel wrote:
> +bool is_swiotlb_active(void)
> +{
> +	return !no_iotlb_memory;
> +}

As I've just introduced and fixed a bug in this area in the current
cycle - I don't think no_iotlb_memory is what your want (and maybe
not useful at all): if the arch valls swiotlb_exit after previously
initializing a buffer it won't be set.  You probably want to check
for non-zero io_tlb_start and/or io_tlb_end.
