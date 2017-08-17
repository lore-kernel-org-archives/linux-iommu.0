From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu: Avoid NULL group dereference
Date: Thu, 17 Aug 2017 17:56:23 +0100
Message-ID: <eef03509-2b1f-0e49-4e47-84e968a07746@arm.com>
References: <59a6c4f0a790eea40e2b2f2be840b63317dd44e4.1502966326.git.robin.murphy@arm.com>
	<20170817154101.GL16908@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170817154101.GL16908-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
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
Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/08/17 16:41, Joerg Roedel wrote:
> On Thu, Aug 17, 2017 at 11:40:08AM +0100, Robin Murphy wrote:
>> The recently-removed FIXME in iommu_get_domain_for_dev() turns out to
>> have been a little misleading, since that check is still worthwhile even
>> when groups *are* universal. We have a few IOMMU-aware drivers which
>> only care whether their device is already attached to an existing domain
>> or not, for which the previous behaviour of iommu_get_domain_for_dev()
>> was ideal, and who now crash if their device does not have an IOMMU.
>>
>> With IOMMU groups now serving as a reliable indicator of whether a
>> device has an IOMMU or not (barring false-positives from VFIO no-IOMMU
>> mode), drivers could arguably do this:
>>
>> 	group = iommu_group_get(dev);
>> 	if (group) {
>> 		domain = iommu_get_domain_for_dev(dev);
>> 		iommu_group_put(group);
>> 	}
> 
> Okay, so just to check I got it right: Drivers do the above to check
> whether a device is managed by an IOMMU, and that crashes now because
> the 'group == NULL' check was removed?

Indeed - the typical context is network descriptors that don't have
space to store the CPU virtual address of the buffer, so when a packet
arrives the driver has to work backwards from the DMA address, in this
sort of pattern:

	addr = desc[idx]->addr;
	domain = iommu_get_domain_for_dev(dev);
	if (domain)
		addr = iommu_iova_to_phys(domain, addr)
	buf = phys_to_virt(addr)

(the GIC thing is similar but in reverse, with a physical address which
may or may not need replacing with an IOVA). Unless we were to change
the interface to be iommu_get_domain_for_group(), I think it makes sense
for it to remain valid to call for any device.

Robin.
