From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 25 Oct 2013 10:25:49 +0200
Message-ID: <20131025.112549.2040849946958069337.hdoyu@nvidia.com>
References: <20131024.122115.1035609747068925560.hdoyu@nvidia.com><20131025001038.77299C403B6@trevor.secretlab.ca><20131025075652.GB19622@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131025075652.GB19622-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 25 Oct 2013 09:56:55 +0200:

> > > This patch is a part of HACK to control device instanciation order. We
> > > have an IOMMU device(platform) which needs to be instanciated earlier
> > > than other (platform)devices so that IOMMU driver would configure them
> > > as IOMMU'able device.
> > 
> > Ideally the drivers depending on the IOMMU would return -EPROBE_DEFER if
> > the IOMMU driver isn't set up so that you don't need to play games with
> > probe order. Creating certain platform devices early is a really ugly
> > and fragile solution.
> > 
> > Besides, probe order of device drivers is far more about link order of
> > the kernel than it is about when of_platform_device_create() is called.
> > Fiddling with the initcall level on the IOMMU driver (while not
> > recommended) may very well have the effect you desire.
> 
> This is actually "the other problem that I'm aware of that could benefit
> from [interrupt resolution at probe time]". My idea was that once we had
> a way within the driver core to resolve interrupt references at probe
> time it could be used for potentially many other resources as well. Some
> of the resources like GPIOs and regulators are obviously not something
> that the core can or should be requesting, but mostly resources that you
> don't actually need to control after probing (such as interrupts) would
> be a good fit because otherwise people would write the same boilerplate
> over and over again.
> 
> IOMMUs seem to me to be in that same category. As far as I can tell, an
> IOMMU driver registers the IOMMU for a given bus, upon which every
> device can simply be used (mostly transparently) with that IOMMU. While
> I haven't figured out how exactly, I'm pretty sure we can take advantage
> of the resolution of resources at probe time within the core to both
> keep drivers from having to do anything in particular and at the same
> time have code to determine if the IOMMU driver hasn't been probed yet
> and return -EPROBE_DEFER appropriately.

Can you explain the above a bit more?

Originally I thought that what Grant suggested would work ok with this patch.
