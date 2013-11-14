From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
Date: Thu, 14 Nov 2013 07:41:45 +0100
Message-ID: <20131114.084145.998129499909471378.hdoyu@nvidia.com>
References: <5282C512.5090900@wwwdotorg.org><20131113094517.4608edf4302b61e3c4402a25@nvidia.com><5283BDBF.9020509@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5283BDBF.9020509-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 13 Nov 2013 18:58:23 +0100:

> >  smmu: iommu@xxxxxx {
> >        #iommu-cells = <3>;
> >        ^^^^^^^^^^^^^^^^^^
> >    };
> > 
> >    host1x {
> >            compatible = "nvidia,tegra30-host1x", "simple-bus";
> >            iommu = <&smmu 0x??????? 0x??????? "asid">;
> > 	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#######
> >            gr3d {
> >                    compatible = "nvidia,tegra30-gr3d";
> >                    iommu = <&smmu 0x??????? 0x???????>;
> >            }
> > 
> > I think that this "asid" part can be set 0 in tegra??.dtsi and the
> > actual value can be overwritten in tegra??-<boardname>.dts file.
> 
> The one issue here is that we can only override entire properties, so
> it's not possible for a board file to *just* replace the ASID, it'd have
> to duplicate the entire property, just to change the one value.
> 
> Is the ASID mapping really likely to be board-specific though? To my
> naive thinking, it seems that the chip design (e.g. number of
> peripherals, number of available ASIDs) would tend to imply the
> device->ASID mapping, since it would have been considered as part of
> chip design. Hence, wouldn't soc.dtsi typically specify the expected
> ASID mapping, and boards rarely if ever override it?
> 
> If the ASID mapping really is likely to vary per board, perhaps it makes
> sense to put it into a separate property somehow so it's easier to override?

  Older Tegra like T30: swgroups > asid(==4)
  Newer Tegra         : swgroups < asid

At newer Tegra, each swgroup should have one asid. In older Tegra,
there aren't many options how to assign ASID since # of AS is 4, and
we know which one should be isolated/protected first. Even we can fix
this assignment for a SoC, not for a board.

Also I think that a newer tegra won't care this mapping since all will
have an own AS. So maybe the binding between "swgroup" and "asid"
should be another one, since this info is only needed for the older
Tegra. For example:

  smmu: iommu@xxxxxx {
        #iommu-cells = <2>;

	/*
	 * This as <-> swgroups mapping is only needed for older tegra.
	 */
	as-swgroups = <0x??????? 0x???????,  /* AS[0]: assigned swgroups bits */
		       0x??????? 0x???????,  /* AS[1]: assigned swgroups bits */
		       0x??????? 0x???????,  /* AS[2]: assigned swgroups bits */
		       0x??????? 0x???????>; /* AS[3]: assigned swgroups bits */
    };
 
    host1x {
            compatible = "nvidia,tegra30-host1x", "simple-bus";
            iommus = <&smmu 0x??????? 0x???????>;
            gr3d {
                    compatible = "nvidia,tegra30-gr3d";
                    iommus = <&smmu 0x??????? 0x???????>;
            }
   };

Then we would push this mapping info into DT only for older
Tegra. Newer Tegra won't care where each swgroup will get its own.
