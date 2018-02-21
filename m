From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3] iommu/amd: Add support for fast IOTLB flushing
Date: Wed, 21 Feb 2018 14:05:57 +0700
Message-ID: <2e9a6834-36b2-8f65-ab07-914b8e3d5671@amd.com>
References: <1517374874-93978-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20180213132959.kkavgzt37hm7n2tt@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180213132959.kkavgzt37hm7n2tt-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 2/13/18 8:29 PM, Joerg Roedel wrote:
> Hi Suravee,
> 
> thanks for working on this.
> 
> On Wed, Jan 31, 2018 at 12:01:14AM -0500, Suravee Suthikulpanit wrote:
>> +static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
>> +				      unsigned long iova, size_t size)
>> +{
>> +	struct amd_iommu_flush_entries *entry, *p;
>> +	unsigned long flags;
>> +	bool found = false;
>> +
>> +	spin_lock_irqsave(&amd_iommu_flush_list_lock, flags);
> 
> I am not happy with introducing or using global locks when they are not
> necessary. Can this be a per-domain lock?
> 
> Besides, did you check it makes sense to actually keep track of the
> ranges here? My approach would be to just make iotlb_range_add() an noop
> and do a full domain flush in iotlb_sync(). But maybe you did
> measurements you can share here to show there is a benefit.
> 
> 
> 
> 	Joerg
> 

Alright, I'll send out v4 w/ iotlb_range_add() as no-op, and iotlb_sync()
as full domain flush. This should be sufficient to get start with adopting
the fast TLB flushing interface.

I'll submit support for fine-grain TLB invalidation as a separate series.

Thanks,
Suravee
