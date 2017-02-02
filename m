From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [RFC 3/3] iommu/arm-smmu: detach DMA domain if driver is managing
	iommu
Date: Thu, 2 Feb 2017 09:40:21 +0530
Message-ID: <010801d27d0a$488e8390$d9ab8ab0$@codeaurora.org>
References: <20170201152341.29142-1-robdclark@gmail.com>
	<20170201152341.29142-4-robdclark@gmail.com>
	<CAF6AEGvXc1dUaqQ6=yp9XCZTv6y1r7jNJohrksO0=EJ1+UFY5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAF6AEGvXc1dUaqQ6=yp9XCZTv6y1r7jNJohrksO0=EJ1+UFY5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Rob Clark' <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'linux-arm-msm' <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>, 'Jordan Crouse' <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, 'Mark Rutland' <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

>On Wed, Feb 1, 2017 at 10:23 AM, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Before the driver is probed, arm_smmu_add_device() helpfully attaches
>> an IOMMU_DOMAIN_DMA domain.  Which ofc does not support stalling, and
>> when the driver later attaches a domain that can_stall to an smmu that
>> can stall, the default _DMA domain prevents stalling from being enabled.
>> (And will cause further problems later)
>>
>> One simple way to deal with this is simply toss the default _DMA domain
>> if the driver attaches it's own domain.
>>
>> TODO maybe the tracking of list of attached domains should be done in
>> iommu core, so the detach can happen outside of group->mutex.
>>
>> Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 96a1be6..50bf135 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1323,6 +1323,21 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>
>>         smmu = fwspec_smmu(fwspec);
>>
>> +       /*
>> +        * If driver is explicitly managing the iommu, detatch any previously
>> +        * attached _DMA domains.
>> +        *
>> +        * TODO maybe this logic should be in iommu_attach_device() so it can
>> +        * happen outside of holding group->mutex??
>> +        */
>> +       if (domain->type != IOMMU_DOMAIN_DMA) {
>> +               struct arm_smmu_domain *other_domain, *n;
>> +
>> +               list_for_each_entry_safe(other_domain, n, &smmu->domain_list, domain_node)
>> +                       if (other_domain->domain.type == IOMMU_DOMAIN_DMA)
>> +                               arm_smmu_detach_dev(&other_domain->domain, dev);
>

So the arm_smmu_detach_dev api is no more there and is removed now.
Also this will be a problem when multiple devices share the iommu, we end up
removing domains used by other devices. Should this not be done
per-device which does not want to use the DMA domain ?

>hmm, we might want to unhook dev->archdata.dma_ops here too..
>
>I'm thinking maybe on arm64 __generic_dma_ops() should fall back to
>swiotlb ops instead of dummy_ops if archdata.dma_ops is NULL, so that
>we could just set it to NULL here?
>

hmm, both not attaching the default dma domain and not setting the dma_ops
is tried in this series as well [1]

[1] https://www.spinics.net/lists/arm-kernel/msg556081.html

>(Is there really any purpose for having the dummy-ops??)
>

To enforce setting arch_setup_dma_ops for device so that the
devices can do cache coherent transactions, otherwise disable the dma
capability of the device. I see that this was introduced as a part of
making ACPI_CCA_REQUIRED to be set in arm64 and later
generalized.


Regards,
 Sricharan

>BR,
>-R
>
>> +       }
>> +
>>         if (WARN_ON(!list_empty(&smmu_domain->domain_node)))
>>                 return -EINVAL;
>>
>> --
>> 2.9.3
>>
