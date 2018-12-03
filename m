From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Date: Mon, 3 Dec 2018 11:56:11 +0000
Message-ID: <53ab96d7-5dc9-e1a9-4cf2-bb8bf80a3acf@huawei.com>
References: <20181130175449.2625-1-cai@gmx.us>
	<b22d2ad6-2638-96d7-1df2-24701589202f@arm.com>
	<20181201163657.GA19557@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181201163657.GA19557-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Qian Cai <cai-0UDz38MK/Mo@public.gmane.org>, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, yisen.zhuang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/12/2018 16:36, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 07:39:50PM +0000, Robin Murphy wrote:
>> I was assuming the point was to also add something like
>>
>> 	default 131072 if HNS_ENET
>>
>> so that DMA debug doesn't require too much thought from the user. If they
>> still have to notice the overflow message and empirically figure out a
>> value that does work, rebuilding the kernel each time is far less
>> convenient than simply adding "dma_debug_entries=..." to their kernel
>> command line and rebooting, which they can do today. If they do already
>> know up-front that the default will need overriding and what the
>> appropriate value is, then the command line still seems seems just as
>> convenient.
>
> I'm not so fond of random drivers changing the defaults.  My idea
> was rather to have the config option so that the defconfig files for
> the Hisilicon SOCs with this hardware could select a larger number
> without making a total mess of the kernel configuration.
>
> If we really have to we could do different defaults, but I'd still
> much rather do this on a arch/platform basis than specific drivers.

As I understand, some drivers could even use much more than this 
(131072), to such a point where I can't imagine that we would want to 
set an arch default to support them. For this HNS_ENET case, it is arm64 
specific so it would be an arch defconfig.

Thanks,
John

> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
> .
>
