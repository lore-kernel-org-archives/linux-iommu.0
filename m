From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/5] dma: Introduce dma_max_mapping_size()
Date: Wed, 23 Jan 2019 22:29:21 +0100
Message-ID: <20190123212921.GC9032@lst.de>
References: <20190123163049.24863-1-joro@8bytes.org> <20190123163049.24863-4-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123163049.24863-4-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org


This looks ok, but could really use some documentation in
Documentation/DMA-API.txt.
