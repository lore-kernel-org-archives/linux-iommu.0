From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/mediatek: select ARM_DMA_USE_IOMMU
Date: Mon, 29 Feb 2016 11:47:28 +0000
Message-ID: <56D42FD0.8030302@arm.com>
References: <1456737553-496245-1-git-send-email-arnd@arndb.de>
	<2734684.OJWJHS6snX@wuerfel> <56D429F0.7010409@arm.com>
	<5357325.sBkT8ESvOS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5357325.sBkT8ESvOS@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 29/02/16 11:29, Arnd Bergmann wrote:
> On Monday 29 February 2016 11:22:24 Robin Murphy wrote:
>>>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>> index b325954cf8f8..ea0998921702 100644
>>>>> --- a/drivers/iommu/Kconfig
>>>>> +++ b/drivers/iommu/Kconfig
>>>>> @@ -341,6 +341,7 @@ config MTK_IOMMU
>>>>>      bool "MTK IOMMU Support"
>>>>>      depends on ARM || ARM64
>>>>>      depends on ARCH_MEDIATEK || COMPILE_TEST
>>>>> +   select ARM_DMA_USE_IOMMU
>>>>
>>>> If going down this route, I'd be inclined to add an "if ARM" there, just
>>>> for clarity.
>>>
>>> That would run into the NEED_SG_DMA_LENGTH problem on other architectures
>>> that don't already set it, right?
>>
>> Sorry, I'm lost - wouldn't "depends on ARM || ARM64" make other
>> architectures moot? arm64 already has NEED_SG_DMA_LENGTH=y by default.
>>
>
> Nevermind, I didn't notice the dependency on the architecture.
>
> What is keeping us from having 'depends on ARM || ARM64 || COMPILE_TEST'?

IIRC it got changed because the kbuild test robot was consistently 
blowing up due to missing definitions on things like parisc.

Robin.

> I assume it doesn't work yet, but it would be nice to get that done
> at some point so we can take advantage of automated build testing like
> coverity.
>
> 	Arnd
>
