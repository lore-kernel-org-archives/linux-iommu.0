From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2 2/4] iommu/arm-smmu-v3: Add tlbi_on_map option
Date: Thu, 17 Aug 2017 19:47:04 +0200
Message-ID: <d502e172-5e98-cbbb-6a72-db32c71006fc@redhat.com>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
	<1502459130-6234-3-git-send-email-eric.auger@redhat.com>
	<20170817163424.GC30719@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170817163424.GC30719-5wv7dgnIgG8@public.gmane.org>
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
Cc: mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 17/08/2017 18:34, Will Deacon wrote:
> On Fri, Aug 11, 2017 at 03:45:28PM +0200, Eric Auger wrote:
>> When running a virtual SMMU on a guest we sometimes need to trap
>> all changes to the translation structures. This is especially useful
>> to integrate with VFIO. This patch adds a new option that forces
>> the IO_PGTABLE_QUIRK_TLBI_ON_MAP to be applied on LPAE page tables.
>>
>> TLBI commands then can be trapped.
>>
>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>
>> ---
>> v1 -> v2:
>> - rebase on v4.13-rc2
>> ---
>>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 4 ++++
>>  drivers/iommu/arm-smmu-v3.c                             | 5 +++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>> index c9abbf3..ebb85e9 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>> @@ -52,6 +52,10 @@ the PCIe specification.
>>                          devicetree/bindings/interrupt-controller/msi.txt
>>                        for a description of the msi-parent property.
>>  
>> +- tlbi-on-map       : invalidate caches whenever there is an update of
>> +                      any remapping structure (updates to not-present or
>> +                      present entries).
>> +
> 
> My position on this hasn't changed, so NAK for this patch. If you want to
> emulate something outside of the SMMUv3 architecture, please do so, but
> don't pretend that it's an SMMUv3.
OK understood. I wanted to go down the road and enable DPDK use case
using the same solution as Intel.

So to me the approach is not adapted to SMMUv3 because
- SMMUv3 does not expose anything similar to the Intel Caching Mode
(when set, indicates the OS needs to invalidate TLB on map)
- SMMUv3 does not expose any IOVA range TLB invalidation command.

Do you agree with this conclusion? ACPI enablement was not a showstopper
I think.

I will see with Peter and other potential users in the community whether
it is worth to pursue the efforts on upstreaming the QEMU vSMMUv3
device, considering the VFIO/VHOST integration is made impossible.

Thanks

Eric

> 
> Will
> 
