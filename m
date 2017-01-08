From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 07/18] iommu: Implement reserved_regions iommu-group
	sysfs file
Date: Sun, 8 Jan 2017 17:26:53 +0100
Message-ID: <24abe958-6a79-5766-653b-b355a85f2be4@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
	<1483643086-2883-8-git-send-email-eric.auger@redhat.com>
	<20170106110039.GL17255@8bytes.org>
	<888d3750-817c-77d1-8154-e77cf8c3ad4b@redhat.com>
	<20170106124816.GQ17255@8bytes.org>
	<0858b719-2888-0645-66d2-56fe698f4e2f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0858b719-2888-0645-66d2-56fe698f4e2f-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

Hi,

On 06/01/2017 18:18, Auger Eric wrote:
> Hi Joerg, Robin,
> 
> On 06/01/2017 13:48, Joerg Roedel wrote:
>> On Fri, Jan 06, 2017 at 12:46:05PM +0100, Auger Eric wrote:
>>> On 06/01/2017 12:00, Joerg Roedel wrote:
>>
>>>> I think it also makes sense to report the type of the reserved region.
>>>
>>> What is the best practice in that case? Shall we put the type enum
>>> values as strings such as:
>>> - direct
>>> - nomap
>>> - msi
>>>
>>> and document that in Documentation/ABI/testing/sysfs-kernel-iommu_groups
>>
>> Yes, a string would be good. An probably 'reserved' is a better name
>> than nomap?
> the iommu_insert_resv_region() function that builds the group reserved
> region list sorts all regions and handles the case where there is an
> overlap between regions. Current code does not care about the type of
> regions. So in case a NOMAP region overlaps with a direct-mapped region,
> what is reported to the user space is the superset and the type depends
> on the overlap. This was suggested by Robin at some point to handle
> overlaps.
> 
> I guess I should merge regions only in case the types equal?
> 
> I remember that Alex thought that user-space should not care so much
> about the type of the regions so I tought it was better for the
> user-space to have a minimal view of the regions.
> 
> On the other hand, this issue of merging regions of different types
> should not happen often but I prefer to highlight the potential issue.

> 
> What is your guidance?

Please forget the question. From an API point of view It does not make
sense that iommu_insert_resv_region() merges regions of a different
types since the type field becomes unreliable. I will fix this.

Thanks

Eric
> 
> Thanks
> 
> Eric
>>
>>
>> 	Joerg
>>
