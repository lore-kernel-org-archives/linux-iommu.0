From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Thu, 07 Aug 2014 14:52:56 -0700
Message-ID: <53E3F538.8030000@codeaurora.org>
References: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
	<1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
	<20140805151323.GB19709@laptop.dumpdata.com>
	<53E26127.1040805@codeaurora.org>
	<20140806201740.GW9809@8bytes.org>
	<53E2BA2D.1050007@codeaurora.org> <20140807062410.GC17340@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140807062410.GC17340@ulmo>
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
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 8/6/2014 11:24 PM, Thierry Reding wrote:
> On Wed, Aug 06, 2014 at 04:28:45PM -0700, Olav Haugan wrote:
>> On 8/6/2014 1:17 PM, Joerg Roedel wrote:
>>> On Wed, Aug 06, 2014 at 10:08:55AM -0700, Olav Haugan wrote:
>>>> so you are suggesting that I check in "bus_set_iommu()" whether the
>>>> driver has set the map_sg/unmap_sg function pointers or not and if not
>>>> set it to the default? Is bus_set_iommu() the only way drivers can set
>>>> up the callbacks?
>>>
>>> This doesn't work as the iommu_ops are now const. You have to either
>>> update the iommu drivers individually to point to the default function,
>>> or you do the check in the API function itself and fall back to the
>>> default it no call-back is provided.
>>>
>>
>> Ok, then I think it is better to just leave the fallback where it is now
>> in the function itself.
> 
> What Konrad was suggesting is what I also proposed. The idea is to
> implement a fallback as standalone function, then make all drivers use
> that by default in the struct iommu_ops that they register. When drivers
> implement an optimized version they can simply replace the fallback
> implementation with their own.
> 

Ok, I can do that. I misunderstood the point of the fallback. I thought
the point of the fallback was to catch drivers that forget/neglect to
implement this callback. If that is not a concern I will update my patch
to create a separate function that I will point all existing drivers to.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
