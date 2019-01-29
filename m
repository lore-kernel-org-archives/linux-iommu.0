From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] virtio: Introduce virtio_max_dma_size()
Date: Tue, 29 Jan 2019 18:13:34 +0100
Message-ID: <20190129171334.GD15195@lst.de>
References: <20190129084342.26030-1-joro@8bytes.org> <20190129084342.26030-5-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129084342.26030-5-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 09:43:41AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This function returns the maximum segment size for a single
> dma transaction of a virtio device. The possible limit comes
> from the SWIOTLB implementation in the Linux kernel, that
> has an upper limit of (currently) 256kb of contiguous
> memory it can map. Other DMA-API implementations might also
> have limits.
> 
> Use the new dma_max_mapping_size() function to determine the
> maximum mapping size when DMA-API is in use for virtio.
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
