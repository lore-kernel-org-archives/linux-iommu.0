From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 14 Jan 2019 13:20:45 -0500
Message-ID: <20190114131114-mutt-send-email-mst@kernel.org>
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
 <20190111091502.GC5825@8bytes.org>
 <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
 <20190114095002.GA29874@lst.de>
 <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 14, 2019 at 08:41:37PM +0800, Jason Wang wrote:
> 
> On 2019/1/14 下午5:50, Christoph Hellwig wrote:
> > On Mon, Jan 14, 2019 at 05:41:56PM +0800, Jason Wang wrote:
> > > On 2019/1/11 下午5:15, Joerg Roedel wrote:
> > > > On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
> > > > > Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
> > > > > all virtio devices under AMD-SEV guests?
> > > > Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
> > > > aperture, because that memory is not encrypted. The guest bounces the
> > > > data then to its encrypted memory.
> > > > 
> > > > Regards,
> > > > 
> > > > 	Joerg
> > > 
> > > Thanks, have you tested vhost-net in this case. I suspect it may not work
> > Which brings me back to my pet pevee that we need to take actions
> > that virtio uses the proper dma mapping API by default with quirks
> > for legacy cases.  The magic bypass it uses is just causing problems
> > over problems.
> 
> 
> Yes, I fully agree with you. This is probably an exact example of such
> problem.
> 
> Thanks

I don't think so - the issue is really that DMA API does not yet handle
the SEV case 100% correctly. I suspect passthrough devices would have
the same issue.

In fact whoever sets IOMMU_PLATFORM is completely unaffected by
Christoph's pet peeve.

Christoph is saying that !IOMMU_PLATFORM devices should hide the
compatibility code in a special per-device DMA API implementation.
Which would be fine especially if we can manage not to introduce a bunch
of indirect calls all over the place and hurt performance.  It's just
that the benefit is unlikely to be big (e.g. we can't also get rid of
the virtio specific memory barriers) so no one was motivated enough to
work on it.

-- 
MST
