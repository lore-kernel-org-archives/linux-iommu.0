From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 14 Jan 2019 17:41:56 +0800
Message-ID: <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
 <20190111091502.GC5825@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111091502.GC5825@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de
List-Id: iommu@lists.linux-foundation.org


On 2019/1/11 下午5:15, Joerg Roedel wrote:
> On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
>> Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
>> all virtio devices under AMD-SEV guests?
> Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
> aperture, because that memory is not encrypted. The guest bounces the
> data then to its encrypted memory.
>
> Regards,
>
> 	Joerg


Thanks, have you tested vhost-net in this case. I suspect it may not work
