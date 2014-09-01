From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [PATCH 10/29] drivers: add
	DRIVER_HAS_OWN_IOMMU_MANAGER flag
Date: Mon, 01 Sep 2014 15:14:45 +0200
Message-ID: <2864762.XVyAv0xVzJ@wuerfel>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
	<5493968.dbuSPSqts4@wuerfel> <54046186.5030407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54046186.5030407-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Monday 01 September 2014 14:07:34 Marek Szyprowski wrote:
> On 2014-09-01 13:56, Arnd Bergmann wrote:
> > On Monday 01 September 2014 12:47:08 Marek Szyprowski wrote:
> >>> Who do you think needs to set this flag, and who needs to read it?
> >> In the proposed solution Exynos IOMMU driver creates a separate IO
> >> address space
> >> for every client device in a system and binds it to the default
> >> dma-mapping space
> >> for the given device. When drivers are doing its own management of IO
> >> address
> >> space, instead of relying on what is available by default with dma-mapping
> >> interface, this will require releasing of the previously created default
> >> structures and resources. So this flag is set by the driver doing its own
> >> management of io address space. The flags is then checked by Exynos
> >> IOMMU driver
> >> to avoid creating the default dma-mapping address space for devices
> >> which driver
> >> does its own management.
> > I don't completely understand it yet. I would assume the device
> > to be added to the default domain at device creation time
> > (of_platform_populate), way before we know which device driver
> > is going to be used. How can this prevent the iommu driver
> > from doing the association with the domain?
> 
> of_platform_populate() is too early to do the association, because that 
> time the
> exynos iommu driver is even not yet probed.

Please have a look at the "Introduce automatic DMA configuration for IOMMU
masters" series that Will Deacon sent out the other day. The idea is that
we are changing the probe order so that the iommu gets initialized early
enough for all IOMMU association to be done there.

> The association with default dma-mapping domain is done in
> IOMMU_GROUP_NOTIFY_BIND_DRIVER notifier, just before binding the driver 
> to the
> given device. This way iommu driver can check dev->driver->flags and 
> skip creating
> default dma-mapping domain if driver announces that it wants to handle it by
> itself.

I really want to kill off those notifiers.

	Arnd
