From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
 maximum segment size
Date: Tue, 29 Jan 2019 18:13:52 +0100
Message-ID: <20190129171352.GE15195@lst.de>
References: <20190129084342.26030-1-joro@8bytes.org> <20190129084342.26030-6-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129084342.26030-6-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 09:43:42AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Segments can't be larger than the maximum DMA mapping size
> supported on the platform. Take that into account when
> setting the maximum segment size for a block device.
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
