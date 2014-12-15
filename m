From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
	instead of initcall
Date: Mon, 15 Dec 2014 18:13:23 +0000
Message-ID: <20141215181323.GX20738@arm.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<1458739.IClpD3xz3i@avalon> <20141215174302.GU20738@arm.com>
	<4894156.QdIh4JzSl0@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4894156.QdIh4JzSl0@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 15, 2014 at 05:53:48PM +0000, Laurent Pinchart wrote:
> Hi Will,

Hello again :)

> On Monday 15 December 2014 17:43:02 Will Deacon wrote:
> > On Mon, Dec 15, 2014 at 05:27:30PM +0000, Laurent Pinchart wrote:
> > > On Monday 15 December 2014 17:17:00 Will Deacon wrote:
> > > > Creating the platform device manually for the IOMMU is indeed grotty,
> > > > but I don't really understand why it's needed. Interrupt controllers,
> > > > for example, seem to get by without one.
> > > 
> > > There's several reasons, one of the most compelling ones I can think of at
> > > the moment is runtime PM. IRQ controllers close to the CPU use CPU PM
> > > notifiers instead. Note that IRQ controllers that are further away from
> > > the CPU (such as GPIO-based IRQ controllers) are real platform devices
> > > and use runtime PM.
> >
> > Ok, that's a good point, but the IOMMU will still probe later anyway, right?
> 
> That depends on the driver implementation, using OF node match an IOMMU driver 
> doesn't have to register a struct driver. Assuming we require IOMMU drivers to 
> register a struct driver, a platform device should then be probed at a later 
> time.
> 
> However, if we wait until the IOMMU gets probed to initialize runtime PM and 
> make it functional, we'll be back in square one if the IOMMU gets probed after 
> the bus master, as the bus master could start issuing bus requests at probe 
> time with the IOMMU not powered yet.

True, but couldn't the early init code do enough to get the thing
functional? That said, I'm showing my ignorance here as I'm not familiar
with the PM code (and the software models I have for the SMMU clearly don't
implement anything in this regard).

> > > IOMMUs are not as low-level as system interrupt controllers or system
> > > clocks. I'm beginning to agree with Thierry that they should be treated
> > > as normal platform devices as they're not required earlier than probe
> > > time of their bus master devices.
> > 
> > Well, I think you'd have to propose patches for discussion since I'm
> > certainly not wed to the current approach; I just want something that
> > allows of_{dma,iommu}_configure to run with the information it needs.
> 
> Do we need of_dma_configure() to run when the device is created, or could we 
> postpone it to just before probe time ?

I'm not sure I can answer that one... Arnd?

Will
