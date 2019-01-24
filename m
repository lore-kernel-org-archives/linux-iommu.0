From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/5] swiotlb: Introduce swiotlb_max_mapping_size()
Date: Thu, 24 Jan 2019 09:24:31 +0100
Message-ID: <20190124082431.GH32526@8bytes.org>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123163049.24863-2-joro@8bytes.org>
 <20190123212813.GB9032@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123212813.GB9032@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 23, 2019 at 10:28:13PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 23, 2019 at 05:30:45PM +0100, Joerg Roedel wrote:
> > +extern size_t swiotlb_max_mapping_size(struct device *dev);
> 
> No need for the extern keyword on function declarations in headers.

Right, but all other function declarations in that header file have
'extern' too, so I added it also for that one.

Regards,

	Joerg
