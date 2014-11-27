From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 0/4] Genericise the IOVA allocator
Date: Thu, 27 Nov 2014 14:43:00 +0200
Message-ID: <54771C54.5080100@linux.intel.com>
References: <cover.1416931258.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1416931258.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Robin Murphy wrote:
> Hi all,
>
> I've been implementing IOMMU DMA mapping for arm64, based on tidied-up
> parts of the existing arch/arm/mm/dma-mapping.c with a clear divide
> between the arch-specific parts and the general DMA-API to IOMMU-API layer
> so that that can be shared; similar to what Ritesh started before and was
> unable to complete[1], but working in the other direction.
>
> The first part of that tidy-up involved ripping out the homebrewed IOVA
> allocator and plumbing in iova.c, necessitating the changes presented here.
> The rest is currently sat under arch/arm64 for the sake of getting it
> working quickly with minimal impact - ideally I'd move it out and port
> arch/arm before merging, but I don't know quite how impatient people are.
> Regardless of that decision, this bit stands alone, so here it is.
>
> Feel free to ignore patches 1 and 2, since I see Sakari has recently
> posted a more thorough series for that[2], that frankly looks nicer ;)
> I've merely left them in as context here.

Thank you. Could you review the set, please? I've gotten no comments on 
it so far.

You probably wouldn't need the 4th patch, and probably this isn't the 
right list to get that forward anyway.

> [1]:http://thread.gmane.org/gmane.linux.ports.arm.kernel/331299
> [2]:http://article.gmane.org/gmane.linux.kernel.iommu/7436

-- 
Kind regards,

Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
