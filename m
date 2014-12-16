From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [PATCH v3 18/19] iommu: exynos: init from
	dt-specific callback instead of initcall
Date: Tue, 16 Dec 2014 13:10:59 +0100
Message-ID: <1921117.BkWucCVOZq@wuerfel>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<1681211.YVY9bd22gV@wuerfel> <24892200.rsOlz53AM6@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <24892200.rsOlz53AM6@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tuesday 16 December 2014 14:07:11 Laurent Pinchart wrote:
> Hi Arnd,
> 
> On Tuesday 16 December 2014 12:40:28 Arnd Bergmann wrote:
> > On Monday 15 December 2014 18:13:23 Will Deacon wrote:
> > >>>> IOMMUs are not as low-level as system interrupt controllers or
> > >>>> system clocks. I'm beginning to agree with Thierry that they should
> > >>>> be treated as normal platform devices as they're not required
> > >>>> earlier than probe time of their bus master devices.
> > >>> 
> > >>> Well, I think you'd have to propose patches for discussion since I'm
> > >>> certainly not wed to the current approach; I just want something that
> > >>> allows of_{dma,iommu}_configure to run with the information it needs.
> > >> 
> > >> Do we need of_dma_configure() to run when the device is created, or
> > >> could we postpone it to just before probe time ?
> > > 
> > > I'm not sure I can answer that one... Arnd?
> > 
> > I believe we could postpone it to probe time, but I'd rather not.
> > The way I see the arguments in favor, we have mainly cosmetic arguments:
> > 
> > - Doing it at probe time would eliminate the ugly section magic hack
> > - iommu drivers could be implemented as loadable modules with platform
> >   drivers, for consistency with most other drivers
> 
> The main argument, from my point of view, is that handling IOMMUs are normal 
> platform devices allow using all the kernel infrastructure that depends on a 
> struct device. The dev_* print helpers are nice to have, but what would make a 
> big difference is the ability to use runtime PM.

Right, I agree that would be nice.

> > On the other hand, I see:
> > 
> > - DMA configuration is traditionally done at device creation time, and
> >   changing that is more likely to introduce bugs than leaving it
> >   where it is.
> > - On a lot of machines, the IOMMU is optional, and the probe function
> >   cannot know the difference between an IOMMU driver that is left out
> >   of the kernel and one that will be initialized later, using a fixed
> >   entry point for initializing the IOMMU makes the behavior consistent
> 
> I'm not advocating for IOMMU support being built as a loadable module. It 
> might be nice from a development point of view, but that's about it.

We'd still have to deal with deferred probing, or with ordering the iommu
initcalls before the dma master initcalls in some other way, so the
problem is not that different from loadable modules. Do you have an idea
for how to solve that?

	Arnd
