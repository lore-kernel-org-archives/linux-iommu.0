From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller support
Date: Thu, 30 Oct 2014 22:35:07 +0900
Message-ID: <54523E8B.7000900@nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com> <1413196434-5292-5-git-send-email-thierry.reding@gmail.com> <54520CFE.9060907@nvidia.com> <5452107D.8080207@nvidia.com> <54521181.8080005@nvidia.com> <54521B22.6070708@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54521B22.6070708-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Terje_Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/30/2014 08:04 PM, Terje Bergstr=F6m wrote:
> On 30.10.2014 12:22, Alexandre Courbot wrote:
>> So should I understand that the GPU group is for addresses without b=
it
>> 34 set (hence forcibly disabled) while GPUB is used when that bit is
>> set? Or is it something else?
>
> That's exactly correct. And only GPUB can be programmed to be SMMU
> translated.

Great, thanks for confirming!

Thierry, how do you want to address this? We could change the register=20
for the GPU group, or (maybe preferable if we want to reflect the actua=
l=20
hardware state) add the GPUB group. I don't know if that would be easy=20
though since we would have the problem of the gpusrd and gpuswr clients=
=20
ownership (seems like they would belong to both groups?)
