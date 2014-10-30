From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller support
Date: Thu, 30 Oct 2014 19:22:57 +0900
Message-ID: <54521181.8080005@nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com> <1413196434-5292-5-git-send-email-thierry.reding@gmail.com> <54520CFE.9060907@nvidia.com> <5452107D.8080207@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5452107D.8080207-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Terje_Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 30, 2014 at 7:18 PM, Terje Bergstr=F6m <tbergstrom@nvidia.c=
om>=20
wrote:
 > On 30.10.2014 12:03, Alexandre Courbot wrote:
 >> I had to change the .reg of TEGRA_SWGROUP_GPU to 0xaac to get the I=
OMMU
 >> to work with GK20A. The reason is still not completely clear to me,=
 but
 >> if you look at the TRM you see that 0xaa8 is basically constant, wi=
th
 >> the SMMU translation bit hardcoded to DISABLE (and the ASID field b=
eing
 >> meaningless in that case). However right after that register you ha=
ve a
 >> functional one named GPUB instead of GPU, and this one is fully
 >> writeable (and has the expected effect).
 >
 > GPU has two SW group IDs, because it accesses memory both with and
 > without translation. The bit 34 in addresses in f.ex. PTE chooses
 > between the two.

Indeed, to enable SMMU translation I have to program 0xaac correctly=20
*and* set the bit 34 of every address that needs to go through the SMMU=
=2E

 > GPU is hard-wired to disable translation. For GPUB translation can b=
e
 > enabled.

So should I understand that the GPU group is for addresses without bit=20
34 set (hence forcibly disabled) while GPUB is used when that bit is=20
set? Or is it something else?
