From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 08/18] iommu/vt-d: Implement reserved region get/put
	callbacks
Date: Fri, 6 Jan 2017 12:45:54 +0100
Message-ID: <36bac0a9-89a6-ff7b-1870-a795a4f57700@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
	<1483643086-2883-9-git-send-email-eric.auger@redhat.com>
	<20170106110131.GM17255@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170106110131.GM17255-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 06/01/2017 12:01, Joerg Roedel wrote:
> On Thu, Jan 05, 2017 at 07:04:36PM +0000, Eric Auger wrote:
>> +static void intel_iommu_get_resv_regions(struct device *device,
>> +					 struct list_head *head)
>> +{
>> +	struct iommu_resv_region *reg;
>> +
>> +	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>> +				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
>> +				      0, IOMMU_RESV_NOMAP);
>> +	if (!reg)
>> +		return;
>> +	list_add_tail(&reg->list, head);
>> +}
> 
> That is different from what AMD does, can you also report the RMRR
> regions for the device here (as direct-map regions)?

if I return RMRR regions as direct mapped regions,
iommu_group_create_direct_mappings will perform the 1-1 mapping.

I am not familiar with the intel-iommu code but I guess this job
currently is done in the intel driver:
iommu_prepare_rmrr_dev -> iommu_prepare_identity_map
->domain_prepare_identity_map -> iommu_domain_identity_map?

What is your feeling?

Thanks

Eric
> 
> 
> 
> 	Joerg
> 
