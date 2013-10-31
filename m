From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Thu, 31 Oct 2013 09:14:05 +0100
Message-ID: <20131031.101405.2229107340254709582.hdoyu@nvidia.com>
References: <20131025091104.GG19622@ulmo.nvidia.com><52718122.9000206@wwwdotorg.org><20131030224108.GA6939@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131030224108.GA6939@mithrandir>
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:41:09 +0100:

> My earlier proposal for deferred interrupt reference resolution actually
> tries to solve that problem within the core. Essentially what it does is
> add a new function that gets called right before the driver's .probe()
> function, so that it can parse standard resources and services from DT,
> such as the interrupts property. This could theoretically be done for
> other resources such as reg as well, but it really only matters where
> the resource can be dynamic (as is the case for interrupts).
> 
> In this case I would envision a standard OF function to associate a
> device with its IOMMU. Perhaps something like:
> 
> 	int of_iommu_attach(struct device *dev);
> 
> That could be called by the core independent of the specific device and
> IOMMU. IOMMU-specifics can probably be handled using .of_xlate(), quite
> in a similar way to GPIO or regulators.
> 
> That way drivers can remain agnostic of the IOMMU while still being able
> to take advantage of deferred probing.

This could be simpler than making "bus_notifier" return "-EPROBE_DEFER".

The disadvantage of this is that we may need to provide the similar
of_<"subsystem">_attach() per subsytem if needed.

The version of "bus_notifier()" may be flexible since it just uses
the existing "bus_notifier()" framework although the return value
needs to be checked. This impact on the existing code isn't so small
unfortunately since NOTIFY_{DONE,OK,STOP,MASK,BAD} macros are used a
lot:(

I'll implement the version of "bus_notifier()" experimentally to see
how this looks like.
