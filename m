From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] dma: Introduce dma_max_mapping_size()
Date: Tue, 15 Jan 2019 14:37:54 +0100
Message-ID: <20190115133754.GB29225@lst.de>
References: <20190115132257.6426-1-joro@8bytes.org> <20190115132257.6426-3-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115132257.6426-3-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

> +size_t dma_direct_max_mapping_size(struct device *dev)
> +{
> +	/*
> +	 * Return the minimum of the direct DMA limit and the SWIOTLB limit.
> +	 * Since direct DMA has no limit, it is fine to just return the SWIOTLB
> +	 * limit.
> +	 */
> +	return swiotlb_max_mapping_size(dev);

Well, if we don't actually use the swiotlb buffers despite it being
compiled in or even allocated we don't need the limit.
