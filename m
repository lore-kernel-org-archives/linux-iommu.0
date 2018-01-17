From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 12/13] iommu/rockchip: Add runtime PM support
Date: Wed, 17 Jan 2018 16:48:46 +0800
Message-ID: <5A5F0DEE.9030508@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
	<20180116132540.18939-13-jeffy.chen@rock-chips.com>
	<CAAFQd5DCxgsL52+5XetV9MRDecL7dN6_QdHysKUOWaEqSf=ijw@mail.gmail.com>
	<5A5EFAB2.7040001@rock-chips.com>
	<CAAFQd5ATRh5hdJhVxDoXjFz72cBmv-yNaW7v-eUxkVRYA3=uJg@mail.gmail.com>
	<5A5F00D1.5010506@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5A5F00D1.5010506-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

On 01/17/2018 03:52 PM, JeffyChen wrote:
> Hi Tomasz,
>
> On 01/17/2018 03:38 PM, Tomasz Figa wrote:
>>>> >>Don't we need to check here (and in _shutdown() too) if we have a
>>>> >>domain attached?
>>> >
>>> >hmmm, right, the startup might been called by resume, so should check
>>> >iommu->domain here.
>>> >
>>> >but the shutdown would be called at the end of detach or suspend, it
>>> could
>>> >be not attached or attached.
>> If startup might be called by resume, without domain attached, what
>> prevents shutdown from being called by suspend after that resume,
>> still without domain attached? Is it guaranteed that if resume is
>> called, someone will attach a domain before suspend is called?
>>
> no, the shutdown would be called by:
> 1/ end of detach_dev
> so it would be not attached at that time
>
> 2/ suspend
> so it could be attached, and also could be not attached
>
>
> anyway, i think the shutdown would work without domain attached(just
> disable paging and clear the iommu bases) ;)
>
hmmm, i see the problem.

so we need to:
1/ move shutdown a little earlier in detach_dev, so it could still see 
the iommu->domain

2/ check iommu->domain in shutdown, to prevent unnecessary shutdown


or maybe just add iommu->domain check in suspend and resume.
>> Best regards,
>> Tomasz
>>
>>
>>
>
