From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] swiotlb: Introduce swiotlb_max_mapping_size()
Date: Tue, 29 Jan 2019 18:12:29 +0100
Message-ID: <20190129171229.GA15195@lst.de>
References: <20190129084342.26030-1-joro@8bytes.org> <20190129084342.26030-2-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129084342.26030-2-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 09:43:38AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The function returns the maximum size that can be remapped
> by the SWIOTLB implementation. This function will be later
> exposed to users through the DMA-API.
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
