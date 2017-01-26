From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC 1/4] iommu: dma: track mapped iova
Date: Thu, 26 Jan 2017 11:45:25 +0900
Message-ID: <CANqRtoSCo3FiQNiPVNx0Ttw31rUHw1OmmckKex42VPmmizKi8g@mail.gmail.com>
References: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1485348842-23712-2-git-send-email-yoshihiro.shimoda.uh@renesas.com> <6939083c-ce85-952c-58cb-aba68d7afb92@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <6939083c-ce85-952c-58cb-aba68d7afb92@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, joro <joro@8bytes.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <damm+renesas@opensource.se>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin, Shimoda-san, everyone,

On Thu, Jan 26, 2017 at 1:27 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 25/01/17 12:53, Yoshihiro Shimoda wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> To track mapped iova for a workaround code in the future.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  drivers/iommu/dma-iommu.c | 29 +++++++++++++++++++++++------
>>  include/linux/iommu.h     |  2 ++
>
> So what's being added here is a counter of allocations within the
> iova_domain held by an iommu_dma_cookie? Then why is it all the way down
> in the iommu_domain and not in the cookie? That's needlessly invasive -
> it would be almost understandable (but still horrible) if you needed to
> refer to it directly from the IOMMU driver, but as far as I can see you
> don't.

You are very correct about all points. =)

As you noticed, the counter is kept per-domain. History is a bit
blurry but I think the reason for my abstraction-breaking is that i
decided to implement the simplest possible code to get the reset
callback to near the iova code and the domain level seemed suitable as
a first step. Moving it to a different level is of course no problem.

My main concern for this series is however if a subsystem-level
intrusive workaround like this ever could be beaten into acceptable
form for upstream merge.The code is pretty simple - the main portion
of the workaround is this counter that used to detect when the number
of mapped pages drops back to zero together with the callback. But
unless the code can be made pluggable it introduces overhead for all
users.

In your other email you asked what happens if the counter never drops
to zero. You are right that this workaround is not a general-purpose
fix suitable for all kinds of devices. Because of that the workaround
is designed to be enabled on only some of the IPMMU instances on the
system. It is also most likely an errata workaround for a particular
ES version, so we would most likely have to enable it with
soc_device_match().

I'll reply to patch 3/4 with some more details.

Thanks!

/ magnus
