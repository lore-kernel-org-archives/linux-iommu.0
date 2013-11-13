From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 0/7] Unifying SMMU driver among Tegra SoCs
Date: Wed, 13 Nov 2013 08:04:19 +0200
Message-ID: <20131113080419.23aa9406a443523670e46dea@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
	<5282AE55.1040701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5282AE55.1040701-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 12 Nov 2013 23:40:21 +0100
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

> On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> > Hi,
> > 
> > This series provides:
> > 
> > (1) Unified SMMU driver among Tegra SoCs
> > (2) Multiple Address Space support(MASID) in IOMMU(SMMMU)
> > (3) Tegra IOMMU'able devices, most of platform devices are IOMMU'able.
> > 
> > There's been some discussion[1] about device population order, and I
> > added a IOMMU hook in driver core:
> > 
> >   [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
> > 
> > which is based on the following RFC patch:
> > 
> >   [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
> >   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html
> 
> I assume that "based on" means "is a new version of", so I don't need to
> look at the "PATCHv3+" patch, since this series replaces it?

Right.
