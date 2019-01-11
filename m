From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/3] swiotlb: Export maximum allocation size
Date: Fri, 11 Jan 2019 10:12:31 +0100
Message-ID: <20190111091231.GB5825@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
 <20190110134433.15672-2-joro@8bytes.org>
 <20190110170205.GB27546@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110170205.GB27546@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 10, 2019 at 12:02:05PM -0500, Konrad Rzeszutek Wilk wrote:
> Why not use swiotlb_nr_tbl ? That is how drivers/gpu/drm use to figure if they
> need to limit the size of pages.

That function just exports the overall size of the swiotlb aperture, no?
What I need here is the maximum size for a single mapping.

Regards,

	Joerg
