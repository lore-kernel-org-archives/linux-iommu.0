From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 04/23] ARM: dt: tegra30: Register AHB/IOMMU device first
Date: Wed, 26 Jun 2013 13:06:23 +0200
Message-ID: <20130626.140623.313229910934807681.hdoyu@nvidia.com>
References: <1372238906-9346-5-git-send-email-hdoyu@nvidia.com><20130626104514.GJ27083@manwe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130626104514.GJ27083@manwe>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 26 Jun 2013 12:45:14 +0200:

> * PGP Signed by an unknown key
> 
> On Wed, Jun 26, 2013 at 12:28:07PM +0300, Hiroshi Doyu wrote:
> > Move up AHB/IOMMU to register them earlier than others. IOMMU needs
> > AHB, and IOMMU needs to register all platform devices as
> > IOMMU'able. So AHB/IOMMU needs to be instanciated at very beginning.
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/tegra30.dtsi | 33 +++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> This just happens to work because DTC keeps the order from the DTS in
> the DTB and the Linux implementation sequentially instantiates devices
> from DT nodes. Neither should be assumed though when writing DTS files.
> Other implementations (DTC or OS) could do things differently.
> 
> But if I understand correctly there is another solution which should
> solve this issue properly.

As you've noticed:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/036746.html
