From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 21/22] iommu/tegra: smmu: Support Multiple ASID
Date: Tue, 30 Jul 2013 08:22:53 +0300
Message-ID: <20130730082253.be35a8ddadbe757100e92c10@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-22-git-send-email-hdoyu@nvidia.com>
	<51E8535A.30605@wwwdotorg.org>
	<20130729.133155.1836775489422797370.hdoyu@nvidia.com>
	<51F6A943.8000004@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51F6A943.8000004-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 29 Jul 2013 19:41:23 +0200
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
...
> > I think that this belongs to the system operation policy. Which H/W
> > should be configured to which Address Space(AS). This put all AHB
> > clients(PPCS) into AS[1](SYSTEM_PROTECTED), and the rest into
> > AS[0](SYSTEM_DEFAULT). AHB clients are mainly traditional H/Ws like
> > USB and SD/MMC so that they should be kept separated from the smart
> > IOMMU clients like host1x.
> > 
> > Is there any place to configure this kind of board specific policy
> > rather than here?
> 
> I'm not sure that answers the question I asked.
> 
> I mean that the driver expects that two AS always exist;
> SYSTEM_PROTECTED and SYSTEM_DEFAULT. However, the set of extant ASs is
> IIRC defined by the DT content. What if the DT doesn't define two ASs?
> Shouldn't there at least be an error-check for this case, so the driver
> doesn't just blindly continue and access smmu_handle->map[1] when the
> map[] array only has 1 entry?

OK, now I got it.

We can create multiple maps on the same AS in theory. So the limitation
is only for how many maps S/W creaed. This can/should be checked only
within kernel side. No constraints from DT.
