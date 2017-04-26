From: Sunil Kovvuri <sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: Return IOVA in iova_to_phys when SMMU
	is bypassed
Date: Wed, 26 Apr 2017 16:13:29 +0530
Message-ID: <CA+sq2Ce2UVi04VtD4KLDsNk2baN1kq_vN2KOrEt9a_cB0gJ0vw@mail.gmail.com>
References: <1493114272-30093-1-git-send-email-sunil.kovvuri@gmail.com>
	<20170426100150.GE21744@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170426100150.GE21744-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 26, 2017 at 3:31 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Sunil,
>
> On Tue, Apr 25, 2017 at 03:27:52PM +0530, sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> For software initiated address translation, when domain type is
>> IOMMU_DOMAIN_IDENTITY i.e SMMU is bypassed, mimic HW behavior
>> i.e return the same IOVA as translated address.
>>
>> This patch is an extension to Will Deacon's patchset
>> "Implement SMMU passthrough using the default domain".
>>
>> Signed-off-by: Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> ---
>>
>> V2
>> - As per Will's suggestion applied fix to SMMUv3 driver as well.
>
> This follows what the AMD driver does, so:
>
> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Thanks,

>
> but I still think that having drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> poke around with the physical address to get at the struct pages underlying
> a DMA buffer is really dodgy.

Driver is not dealing with page structures to be precise, just like
for any other NIC device, driver needs to know the virtual address
of the packet to where it's DMA'ed, so that SKB if framed and
handed over to network stack. Due to reasons mentioned below,
in this driver it's not possible to maintain a list of DMA addresses to
Virtual address mappings. Hence using IOMMU API, DMA address
is translated to physical address and finally to virtual address. I don't
see anything dodgy here.

> Is there no way this can be avoided, perhaps by tracking the pages some other way

I have explained that in the commit message
--
    Also VNIC doesn't have a seperate receive buffer ring per receive
    queue, so there is no 1:1 descriptor index matching between CQE_RX
    and the index in buffer ring from where a buffer has been used for
    DMA'ing. Unlike other NICs, here it's not possible to maintain dma
    address to virt address mappings within the driver. This leaves us
    no other choice but to use IOMMU's IOVA address conversion API to
    get buffer's virtual address which can be given to network stack
    for processing.
--

>(although I don't understand why you're having to mess with the page reference
>counts to start with)?
Not sure why you say it's a mess, adjusting page reference counts is quite
common if you check other NIC drivers. On ARM64 especially when using
64KB pages, if we have only one packet buffer for each page then we
will have to set aside a whole lot of memory which sometimes is not possible
on embedded platforms. Hence multiple pkt buffers per page, and page reference
is set accordingly.

>
> At least, I think you should be checking the domain type in
> nicvf_iova_to_phys, which clearly expects a DMA domain if one exists at all.

Probably, but I don't think network maintainers would be okay with it, since
such stuff should be hidden from a network driver's point of view. In reverse
the argument can be that NIC driver shouldn't even have to check if domain
is set or not.

Thanks,
Sunil.

>
> Joerg: sorry, this is another one for you to pick up if possible.
>
> Cheers,
>
> Will
>
>>  drivers/iommu/arm-smmu-v3.c | 3 +++
>>  drivers/iommu/arm-smmu.c    | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 05b4592..d412bdd 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -1714,6 +1714,9 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>>       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>       struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>>
>> +     if (domain->type == IOMMU_DOMAIN_IDENTITY)
>> +             return iova;
>> +
>>       if (!ops)
>>               return 0;
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index bfab4f7..81088cd 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1459,6 +1459,9 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
>>       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>       struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
>>
>> +     if (domain->type == IOMMU_DOMAIN_IDENTITY)
>> +             return iova;
>> +
>>       if (!ops)
>>               return 0;
>>
>> --
>> 2.7.4
>>
