From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Fri, 11 Jan 2019 11:29:31 +0800
Message-ID: <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
References: <20190110134433.15672-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110134433.15672-1-joro@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, "Michael S . Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de
List-Id: iommu@lists.linux-foundation.org


On 2019/1/10 下午9:44, Joerg Roedel wrote:
> Hi,
>
> there is a problem with virtio-blk driven devices when
> virtio-ring uses SWIOTLB through the DMA-API. This happens
> for example in AMD-SEV enabled guests, where the guest RAM
> is mostly encrypted and all emulated DMA has to happen
> to/from the SWIOTLB aperture.
>
> The problem is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb. When
> the virtio-blk driver tries to read/write a block larger
> than that, the allocation of the dma-handle fails and an IO
> error is reported.
>
> This patch-set adds a check to the virtio-code whether it
> might be using SWIOTLB bounce buffering and limits the
> maximum segment size in the virtio-blk driver in this case,
> so that it doesn't try to do larger reads/writes.


Just wonder if my understanding is correct IOMMU_PLATFORM must be set 
for all virtio devices under AMD-SEV guests?

Thanks


>
> Please review.
>
> Thanks,
>
> 	Joerg
>
> Joerg Roedel (3):
>    swiotlb: Export maximum allocation size
>    virtio: Introduce virtio_max_dma_size()
>    virtio-blk: Consider virtio_max_dma_size() for maximum segment size
>
>   drivers/block/virtio_blk.c   | 10 ++++++----
>   drivers/virtio/virtio_ring.c | 11 +++++++++++
>   include/linux/swiotlb.h      | 12 ++++++++++++
>   include/linux/virtio.h       |  2 ++
>   4 files changed, 31 insertions(+), 4 deletions(-)
>
