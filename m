From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/5] virtio: Introduce virtio_max_dma_size()
Date: Wed, 30 Jan 2019 16:49:23 +0100
Message-ID: <20190130154922.GO32526@8bytes.org>
References: <20190129084342.26030-1-joro@8bytes.org>
 <20190129084342.26030-5-joro@8bytes.org>
 <e138b703-188c-59d2-edec-65fe3e76d229@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e138b703-188c-59d2-edec-65fe3e76d229@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "jfehlig@suse.com" <jfehlig@suse.com>, "Grimm, Jon" <Jon.Grimm@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "jroedel@suse.de" <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

Hi Tom,

On Wed, Jan 30, 2019 at 03:10:29PM +0000, Lendacky, Thomas wrote:
> On 1/29/19 2:43 AM, Joerg Roedel wrote:

> > +size_t virtio_max_dma_size(struct virtio_device *vdev)
> > +{
> > +	size_t max_segment_size = SIZE_MAX;
> > +
> > +	if (vring_use_dma_api(vdev))
> > +		max_segment_size = dma_max_mapping_size(&vdev->dev);
> > +
> > +	return max_segment_size;
> > +}
> 
> When I build with these patches and with the virtio devices as modules I
> get a build failure. Looks like this needs an EXPORT_SYMBOL_GPL().

Thanks for pointing that out, I added the missing EXPORTs and will send
a new version shortly.

Regards,

	Joerg
