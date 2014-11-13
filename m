From: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH v7 00/12] NVIDIA Tegra memory controller and IOMMU support
Date: Thu, 13 Nov 2014 12:40:40 +0200
Message-ID: <54648AA8.2020509@kapsi.fi>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com> <1550140.Lb4KHPOqX1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1550140.Lb4KHPOqX1@wuerfel>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/13/2014 12:12 PM, Arnd Bergmann wrote:
> On Thursday 13 November 2014 10:32:25 Thierry Reding wrote:
>> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> This is the sixth installment in the Tegra IOMMU and memory controller
>> support series. This version addresses the final outstanding comments from
>> Olof about using proper Kconfig symbols to track the dependencies. It also
>> splits up the driver into one part that implements the memory controller
>> only and a second part that implements the SMMU. This plays nicely with
>> the new Kconfig options introduced.
>>
>> Patch 1 is a preparatory patch that exposes the memory controller clock.
>>
>> Patches 2 and 3 is a pair of precursory patches needed to make this all
>> work on 64-bit ARM in the future.
>>
>> The device tree binding for the Tegra memory controller is added in patch
>> 4 and patch 5 is the bulk of the series that move the existing memory
>> controller and IOMMU drivers into the new unified driver that supports
>> Tegra30, Tegra114 and Tegra124.
>
> I just noticed that patch 5 has never made it into my inbox in any of the
> submissions. Did it get filtered by the mailing list?

I have received patch 5 just fine through linux-tegra. The patch is 
rather long though, so something filtering it wouldn't be that surprising.

>
> 	Arnd

Mikko
