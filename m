From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 01/18] iommu/dma: Allow MSI-only cookies
Date: Fri, 6 Jan 2017 12:12:20 +0000
Message-ID: <ae222579-6939-b89a-80c2-9ee8f147299e@arm.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
	<1483643086-2883-2-git-send-email-eric.auger@redhat.com>
	<20170106105945.GK17255@8bytes.org>
	<b058a7f9-84bf-1d5c-1c24-24da251cc964@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b058a7f9-84bf-1d5c-1c24-24da251cc964-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/01/17 11:46, Auger Eric wrote:
> 
> 
> On 06/01/2017 11:59, Joerg Roedel wrote:
>> On Thu, Jan 05, 2017 at 07:04:29PM +0000, Eric Auger wrote:
>>>  struct iommu_dma_cookie {
>>> -	struct iova_domain	iovad;
>>> -	struct list_head	msi_page_list;
>>> -	spinlock_t		msi_lock;
>>> +	union {
>>> +		struct iova_domain	iovad;
>>> +		dma_addr_t		msi_iova;
>>> +	};
>>> +	struct list_head		msi_page_list;
>>> +	spinlock_t			msi_lock;
>>> +	enum iommu_dma_cookie_type	type;
>>
>> Please move the type to the beginning of the struct and add a comment
>> how the type relates to the union.
> 
> Sure
> 
> Thank you for the review.

FWIW I already had a cleaned up version of this patch, I just hadn't
mentioned it. I've pushed out an update with that change added too[1].

Robin.

[1]:http://linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/misc

> 
> Best regards
> 
> Eric
>>
>>
>>
>> 	Joerg
>>
