From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v3 10/10] iommu/sva: Add support for private PASIDs
Date: Wed, 17 Oct 2018 15:21:43 +0100
Message-ID: <3e1b58bb-eb16-5855-2922-2b15b37ba971@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-11-jean-philippe.brucker@arm.com>
	<20181012143229.GI9977@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181012143229.GI9977-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andrew.murray-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jordan,

On 12/10/2018 15:32, Jordan Crouse wrote:
> On Thu, Sep 20, 2018 at 06:00:46PM +0100, Jean-Philippe Brucker wrote:
>> Provide an API for allocating PASIDs and populating them manually. To ease
>> cleanup and factor allocation code, reuse the io_mm structure for private
>> PASID. Private io_mm has a NULL mm_struct pointer, and cannot be bound to
>> multiple devices. The mm_alloc() IOMMU op must now check if the mm
>> argument is NULL, in which case it should allocate io_pgtables instead of
>> binding to an mm.
>>
>> Signed-off-by: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
>> ---
>> Sadly this probably won't be the final thing. The API in this patch is
>> used like this:
>>
>>         iommu_sva_alloc_pasid(dev, &io_mm) -> PASID
>>         iommu_sva_map(io_mm, ...)
>>         iommu_sva_unmap(io_mm, ...)
>>         iommu_sva_free_pasid(dev, io_mm)
>>
>> The proposed API for auxiliary domains is in an early stage but might
>> replace this patch and could be used like this:
>>
>>         iommu_enable_aux_domain(dev)
>>         d = iommu_domain_alloc()
>>         iommu_attach_aux(dev, d)
>>         iommu_aux_id(d) -> PASID
>>         iommu_map(d, ...)
>>         iommu_unmap(d, ...)
>>         iommu_detach_aux(dev, d)
>>         iommu_domain_free(d)
>>
>> The advantage being that the driver doesn't have to use a special
>> version of map/unmap/etc.
>
> Hi Jean-Phillippe -
>
> Have you thought about this any more? I want to send out a
> refresh for the per-context pagetables for arm-smmu so if we want to change
> the underlying assumptions this would be a great time.
>
> For my part I'm okay with either model. In fact the second one is closer
> to the original implementation that I sent out so I have a clear development
> path in mind for either option depending on what the community decides.

We'll probably go with the second model. I'm trying to make the latest
version work with SMMUv3
(https://lwn.net/ml/linux-kernel/20181012051632.26064-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org/)
and I'd like to send an RFC soon

Thanks,
Jean
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
