From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 2/7] iommu-api: Add map_range/unmap_range functions
Date: Thu, 10 Jul 2014 07:15:25 -0400
Message-ID: <CAF6AEGvpNXL3S1+M8yUcuAJ0GkOWh61=bcK1qzyL7n2oJrB+qQ@mail.gmail.com>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
	<1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
	<20140704072940.c1e8e8cdd38fbc295fe5c086@nvidia.com>
	<53BC6866.30803@codeaurora.org>
	<CAF6AEGvpD+gvDvQte6YVOP8Q6NeXsoReQ_waWqjsMjffUzALOA@mail.gmail.com>
	<53BDD834.5030405@codeaurora.org>
	<CAF6AEGucNbo7sm9oQWFq9hcfoSeR5DuwRcRUvG+Y2sxLaM7OTQ@mail.gmail.com>
	<20140710071014.GA17918@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140710071014.GA17918@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 10, 2014 at 3:10 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Jul 09, 2014 at 08:40:21PM -0400, Rob Clark wrote:
>> On Wed, Jul 9, 2014 at 8:03 PM, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> > On 7/8/2014 4:49 PM, Rob Clark wrote:
>> >> On Tue, Jul 8, 2014 at 5:53 PM, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> >>> Hi Hiroshi,
>> >>>
>> >>> On 7/3/2014 9:29 PM, Hiroshi Doyu wrote:
>> >>>> Hi Olav,
>> >>>>
>> >>>> Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> writes:
>> >>>>
>> >>>>> Mapping and unmapping are more often than not in the critical path.
>> >>>>> map_range and unmap_range allows SMMU driver implementations to optimize
>> >>>>> the process of mapping and unmapping buffers into the SMMU page tables.
>> >>>>> Instead of mapping one physical address, do TLB operation (expensive),
>> >>>>> mapping, do TLB operation, mapping, do TLB operation the driver can map
>> >>>>> a scatter-gatherlist of physically contiguous pages into one virtual
>> >>>>> address space and then at the end do one TLB operation.
>> >>>>>
>> >>>>> Additionally, the mapping operation would be faster in general since
>> >>>>> clients does not have to keep calling map API over and over again for
>> >>>>> each physically contiguous chunk of memory that needs to be mapped to a
>> >>>>> virtually contiguous region.
>> >>>>>
>> >>>>> Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> >>>>> ---
>> >>>>>  drivers/iommu/iommu.c | 24 ++++++++++++++++++++++++
>> >>>>>  include/linux/iommu.h | 24 ++++++++++++++++++++++++
>> >>>>>  2 files changed, 48 insertions(+)
>> >>>>>
>> >>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> >>>>> index e5555fc..f2a6b80 100644
>> >>>>> --- a/drivers/iommu/iommu.c
>> >>>>> +++ b/drivers/iommu/iommu.c
>> >>>>> @@ -898,6 +898,30 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>> >>>>>  EXPORT_SYMBOL_GPL(iommu_unmap);
>> >>>>>
>> >>>>>
>> >>>>> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
>> >>>>> +                struct scatterlist *sg, unsigned int len, int prot)
>> >>>>> +{
>> >>>>> +    if (unlikely(domain->ops->map_range == NULL))
>> >>>>> +            return -ENODEV;
>> >>>>> +
>> >>>>> +    BUG_ON(iova & (~PAGE_MASK));
>> >>>>> +
>> >>>>> +    return domain->ops->map_range(domain, iova, sg, len, prot);
>> >>>>> +}
>> >>>>> +EXPORT_SYMBOL_GPL(iommu_map_range);
>> >>>>
>> >>>> We have the similar one internally, which is named, "iommu_map_sg()",
>> >>>> called from DMA API.
>> >>>
>> >>> Great, so this new API will be useful to more people!
>> >>>
>> >>>>> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
>> >>>>> +                  unsigned int len)
>> >>>>> +{
>> >>>>> +    if (unlikely(domain->ops->unmap_range == NULL))
>> >>>>> +            return -ENODEV;
>> >>>>> +
>> >>>>> +    BUG_ON(iova & (~PAGE_MASK));
>> >>>>> +
>> >>>>> +    return domain->ops->unmap_range(domain, iova, len);
>> >>>>> +}
>> >>>>> +EXPORT_SYMBOL_GPL(iommu_unmap_range);
>> >>>>
>> >>>> Can the existing iommu_unmap() do the same?
>> >>>
>> >>> I believe iommu_unmap() behaves a bit differently because it will keep
>> >>> on calling domain->ops->unmap() until everything is unmapped instead of
>> >>> letting the iommu implementation take care of unmapping everything in
>> >>> one call.
>> >>>
>> >>> I am abandoning the patch series since our driver was not accepted.
>> >>> However, if there are no objections I will resubmit this patch (PATCH
>> >>> 2/7) as an independent patch to add this new map_range API.
>> >>
>> >> +1 for map_range().. I've seen for gpu workloads, at least, it is the
>> >> downstream map_range() API is quite beneficial.   It was worth at
>> >> least a few fps in xonotic.
>> >>
>> >> And, possibly getting off the subject a bit, but I was wondering about
>> >> the possibility of going one step further and batching up mapping
>> >> and/or unmapping multiple buffers (ranges) at once.  I have a pretty
>> >> convenient sync point in drm/msm to flush out multiple mappings before
>> >> kicking gpu.
>> >
>> > I think you should be able to do that with this API already - at least
>> > the mapping part since we are passing in a sg list (this could be a
>> > chained sglist).
>>
>> What I mean by batching up is mapping and unmapping multiple sglists
>> each at different iova's with minmal cpu cache and iommu tlb flushes..
>>
>> Ideally we'd let the IOMMU driver be clever and build out all 2nd
>> level tables before inserting into first level tables (to minimize cpu
>> cache flushing).. also, there is probably a reasonable chance that
>> we'd be mapping a new buffer into existing location, so there might be
>> some potential to reuse existing 2nd level tables (and save a tiny bit
>> of free/alloc).  I've not thought too much about how that would look
>> in code.. might be kinda, umm, fun..
>>
>> But at an API level, we should be able to do a bunch of
>> map/unmap_range's with one flush.
>>
>> Maybe it could look like a sequence of iommu_{map,unmap}_range()
>> followed by iommu_flush()?
>
> Doesn't that mean that the IOMMU driver would have to keep track of all
> mappings until it sees an iommu_flush()? That sounds like it could be a
> lot of work and complicated code.

Well, depends on how elaborate you want to get.  If you don't want to
be too fancy, it may just be a matter of not doing TLB flush until
iommu_flush().  If you want to get fancy and minimize cpu flushes too,
then iommu driver would have to do some more tracking to build up a
transaction internally.  I'm not really sure how you avoid that.

I'm not quite sure how frequent it would be that separate buffers
touch the same 2nd level table, so it might be sufficient to treat it
like N map_range and unmap_range's followed by one TLB flush.  I
would, I think, need to implement a prototype or at least instrument
the iommu driver somehow to generate some statistics.

I've nearly got qcom-iommu-v0 working here on top of upstream + small
set of patches.. but once that is a bit more complete, experimenting
with some of this will be on my TODO list to see what amount of
crazy/complicated brings worthwhile performance benefits.

BR,
-R

> Thierry
