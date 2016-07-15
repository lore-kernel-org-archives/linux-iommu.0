From: Matthias Brugger <mbrugger-IBi9RG/b67k@public.gmane.org>
Subject: Re: iommu/rockchip: Fix bugs and enable on ARM64
Date: Fri, 15 Jul 2016 17:32:02 +0200
Message-ID: <575f6cd7-6e03-e701-78ed-ea2fe9f7573c@suse.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
 <20160627125751.GN11432@8bytes.org> <577EFB86.1060502@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <577EFB86.1060502-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 08/07/16 03:01, Mark yao wrote:
> On 2016=E5=B9=B406=E6=9C=8827=E6=97=A5 20:57, Joerg Roedel wrote:
>> On Fri, Jun 24, 2016 at 10:13:25AM +0800, Shunqian Zheng wrote:
>>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 100 +++++++------
>>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   3 +
>>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 221
>>> ++++++++++++++++++++++++++--
>>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   9 ++
>>>   drivers/iommu/Kconfig                       |   2 +-
>>>   drivers/iommu/rockchip-iommu.c              | 181
>>> +++++++++++++++++------
>>>   6 files changed, 413 insertions(+), 103 deletions(-)
>> Applied the IOMMU patches, thanks.
>>
>>
>>     Joerg
>>
>>
>>
>>
>
> Hi Joerg
>
> The drm rockchip patches are dependent on iommu/rockchip patches, can
> you also apply these patches together? So that can avoid compile prob=
lem.
>

While at it. I don't see patch 8 (iommu/Kconfig) in linux-next.
I suppose you forgot to pick that one.

Regards,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
