From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Tue, 12 Aug 2014 06:48:54 -0400
Message-ID: <CAF6AEGvZUanVtPxAt76+AAdOaNwyMJ3cmcJ1srsEYBeG7ELkBQ@mail.gmail.com>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
	<1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
	<871tsm5vcn.fsf@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <871tsm5vcn.fsf@nvidia.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Olav Haugan <ohaugan@codeaurora.org>, "joro@8bytes.org" <joro@8bytes.org>, "laurent.pinchart+renesas@ideasonboard.com" <laurent.pinchart+renesas@ideasonboard.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "s-anna@ti.com" <s-anna@ti.com>, "mitchelh@codeaurora.org" <mitchelh@codeaurora.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 11, 2014 at 9:51 PM, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
> Hi Olav,
>
> Olav Haugan <ohaugan@codeaurora.org> writes:
>
>> @@ -93,6 +94,10 @@ enum iommu_attr {
>>   * @detach_dev: detach device from an iommu domain
>>   * @map: map a physically contiguous memory region to an iommu domain
>>   * @unmap: unmap a physically contiguous memory region from an iommu domain
>> + * @map_sg: map a scatter-gather list of physically contiguous memory chunks
>> + * to an iommu domain
>> + * @unmap_sg: unmap a scatter-gather list of physically contiguous memory
>> + * chunks from an iommu domain
>>   * @iova_to_phys: translate iova to physical address
>>   * @domain_has_cap: domain capabilities query
>>   * @add_device: add device to iommu grouping
>> @@ -110,6 +115,11 @@ struct iommu_ops {
>>                    phys_addr_t paddr, size_t size, int prot);
>>         size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>>                      size_t size);
>> +       int (*map_sg)(struct iommu_domain *domain, unsigned long iova,
>> +                       struct scatterlist *sg, unsigned int nents, int prot,
>> +                       unsigned long flags);
>> +       int (*unmap_sg)(struct iommu_domain *domain, unsigned long iova,
>> +                       size_t size, unsigned long flags);
>
> Do you have any exmaple/explanation for the above "flags"?
>
> Is this going to be used for iommu global/standard attribute or SoC
> spcific one?

iirc, one plan for 'flags' was some sort of DONT_FLUSH_TLB flag for
drivers which wanted to map/unmap N buffers with a single flush at the
end.  There might have been some other usages envisioned.

BR,
-R
