From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 14 Jan 2019 19:12:08 +0000
Message-ID: <cb290df3-4e17-a403-6d69-cf5a8a41c987@arm.com>
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
 <20190111091502.GC5825@8bytes.org>
 <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
 <20190114095002.GA29874@lst.de>
 <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
 <20190114131114-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114131114-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: iommu@lists.linux-foundation.org

On 14/01/2019 18:20, Michael S. Tsirkin wrote:
> On Mon, Jan 14, 2019 at 08:41:37PM +0800, Jason Wang wrote:
>>
>> On 2019/1/14 下午5:50, Christoph Hellwig wrote:
>>> On Mon, Jan 14, 2019 at 05:41:56PM +0800, Jason Wang wrote:
>>>> On 2019/1/11 下午5:15, Joerg Roedel wrote:
>>>>> On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
>>>>>> Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
>>>>>> all virtio devices under AMD-SEV guests?
>>>>> Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
>>>>> aperture, because that memory is not encrypted. The guest bounces the
>>>>> data then to its encrypted memory.
>>>>>
>>>>> Regards,
>>>>>
>>>>> 	Joerg
>>>>
>>>> Thanks, have you tested vhost-net in this case. I suspect it may not work
>>> Which brings me back to my pet pevee that we need to take actions
>>> that virtio uses the proper dma mapping API by default with quirks
>>> for legacy cases.  The magic bypass it uses is just causing problems
>>> over problems.
>>
>>
>> Yes, I fully agree with you. This is probably an exact example of such
>> problem.
>>
>> Thanks
> 
> I don't think so - the issue is really that DMA API does not yet handle
> the SEV case 100% correctly. I suspect passthrough devices would have
> the same issue.

Huh? Regardless of which virtio devices use it or not, the DMA API is 
handling the SEV case as correctly as it possibly can, by forcing 
everything through the unencrypted bounce buffer. If the segments being 
mapped are too big for that bounce buffer in the first place, there's 
nothing it can possibly do except fail, gracefully or otherwise.

Now, in theory, yes, the real issue at hand is not unique to virtio-blk 
nor SEV - any driver whose device has a sufficiently large DMA segment 
size and who manages to get sufficient physically-contiguous memory 
could technically generate a scatterlist segment longer than SWIOTLB can 
handle. However, in practice that basically never happens, not least 
because very few drivers ever override the default 64K DMA segment 
limit. AFAICS nothing in drivers/virtio is calling 
dma_set_max_seg_size() or otherwise assigning any dma_parms to replace 
the defaults either, so the really interesting question here is how are 
these apparently-out-of-spec 256K segments getting generated at all?

Robin.
