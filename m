From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [PATCH v3 18/19] iommu: exynos: init from
	dt-specific callback instead of initcall
Date: Wed, 17 Dec 2014 22:58:47 +0100
Message-ID: <2127001.foickmBNkZ@wuerfel>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<2560037.PCKFDiopkL@wuerfel> <3147207.bM49L5sBIQ@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3147207.bM49L5sBIQ@avalon>
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
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wednesday 17 December 2014 18:02:51 Laurent Pinchart wrote:
> On Wednesday 17 December 2014 16:41:33 Arnd Bergmann wrote:
> > On Wednesday 17 December 2014 16:39:02 Laurent Pinchart wrote:
> > > On Wednesday 17 December 2014 15:27:36 Arnd Bergmann wrote:
> > > > On Wednesday 17 December 2014 01:24:42 Laurent Pinchart wrote:
> > > > > If we forbid the IOMMU driver from being compiled as a module can't we
> > > > > just rely on deferred probing ? The bus master driver will just be
> > > > > reprobed after the IOMMU gets probed, like for other devices.
> > > > > 
> > > > > This could fail in case the IOMMU device permanently fails to probe.
> > > > > There
> > > > > would be something very wrong in the system in that case, Enabling the
> > > > > bus
> > > > > masters totally transparently without IOMMU support could not be such
> > > > > a
> > > > > good idea.
> > > > 
> > > > I believe in the majority of cases today, the IOMMU is entirely
> > > > optional.
> > > > There are valid reasons for not including the IOMMU driver in the
> > > > kernel,
> > > > e.g. when you know that all the machines with that driver can DMA to
> > > > all of their RAM and you want to avoid the overhead of IOTLB misses.
> > > 
> > > Should that really be controlled by compiling the IOMMU driver out,
> > > wouldn't it be better to disable the IOMMU devices in DT in that case ?
> > 
> > It's a policy decision that should only depend on the user. Modifying the
> > DT is wrong here IMHO because the device is still connected to the IOMMU
> > in hardware and we should correctly represent that.
> 
> I was thinking about setting status = "disabled" on the IOMMU nodes, not 
> removing the IOMMU references in the bus master nodes.

But that still requires a modification of the DT. The hardware is the
same, so I don't see why we should update the dtb based on kernel
configuration.

	Arnd
