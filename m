From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Thu, 31 Oct 2013 17:46:03 +0100
Message-ID: <20131031.184603.979300613649357798.hdoyu@nvidia.com>
References: <52718122.9000206@wwwdotorg.org><20131031.101232.80781047726461143.hdoyu@nvidia.com><527286CC.9080404@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <527286CC.9080404-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Thu, 31 Oct 2013 17:35:24 +0100:

...
> >> ... and for the driver to explicitly parse that property, and wait
> >> until the driver for iommu_phandle is ready. Exactly the same as any
> >> other resource/service dependency.
> >>
> >> That will solve all the problems.
> >>
> >> The only downside is that every driver needs to contain code to parse
> >> that property. However, I think that's just one function call; the
> >> actual implementation of that function can be unified somewhere inside
> >> core code in drivers/iommu/.
> > 
> > Yes, but only missing part now is that, we could do this with
> > "bus_notifier", but the current bus_notifier doesn't have the feature
> > to return error(-EPROBE_DEFER). This could be modified so that
> > bus_notifier could return (-EPROBE_DEFER) to postpone
> > probing. Alternatively this could be done in some core probe code as
> > well as Thierry pointed out.
> > 
> > [1] In the reply of "[PATCHv3 14/19] iommu/tegra: smmu: Get "nvidia,memory-clients" from DT"
> 
> I think this should be done explicitly in drivers. It's much
> simpler,

Yes, we need to insert some IOMMU specific code in driver?

> and doesn't encode any knowledge of driver-specific bindings into some
> common bus notifier code.

I think that we cannot do that in drivers. We want to use drivers as
they are without any modifications indicating its dependency on
IOMMU because most of drivers are existing ones which nvidia doesn't
implement. We want to set up any IOMMU related thingy implicitly,
hided from driver. That's why we need to do this in bus_notifier or
driver core code.
