From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/23] ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
Date: Wed, 26 Jun 2013 13:02:27 +0200
Message-ID: <20130626.140227.471410226520470110.hdoyu@nvidia.com>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com><20130626101816.GE27083@manwe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130626101816.GE27083@manwe>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 26 Jun 2013 12:18:17 +0200:

> > diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> [...]
> > @@ -23,3 +24,13 @@ Example:
> >  		nvidia,swgroups = <0x00000000 0x000779ff>;
> >  		nvidia,ahb = <&ahb>;
> >  	};
> > +
> > +	host1x {
> > +		compatible = "nvidia,tegra30-host1x", "simple-bus";
> > +		nvidia,memory-clients = <SWGID_HC>;
> 
> And this could use the SWGID(HC) to match up with how GPIOs are
> referenced in the DTS files. Though I see that the clocks don't use a
> parameterized version either, so things are inconsistent anyway. But if
> SWGID() isn't used then maybe it shouldn't be provided by the header
> file in the first place.

I think that the above SWGID_* is still easier to understand which
swgroup a device belongs to rather than raw number intuitively.

> Oh, one other thing: both GPIO and CAR use the TEGRA_ prefix, perhaps
> this should use it as well?

Sounds quite reasonable to me.
