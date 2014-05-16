From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
	Exynos System MMU
Date: Fri, 16 May 2014 09:39:24 +0900
Message-ID: <20140516093924.8ee826b9e7e346cb0144a0f1@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<6544270.ddFBoY6LMm@wuerfel> <20140428111802.GI19455@ulmo>
	<4780885.JaktFvJeC7@wuerfel> <20140515203729.GA7136@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140515203729.GA7136@mithrandir>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 15 May 2014 22:37:31 +0200, Thierry Reding wrote:
> On Mon, Apr 28, 2014 at 02:05:30PM +0200, Arnd Bergmann wrote:
> [...]
> > let me clarify by example:
> > 
> > 	iommu@1 {
> > 		compatible = "some,simple-iommu";
> > 		reg = <1>;
> > 		#iommu-cells = <0>; /* supports only one master */
> > 	};
> > 
> > 	iommu@2 {
> > 		compatible = "some,other-iommu";
> > 		reg = <3>;
> > 		#iommu-cells = <1>; /* contains master ID */
> > 	};
> > 
> > 	iommu@3 {
> > 		compatible = "some,windowed-iommu";
> > 		reg = <2>;
> > 		#iommu-cells = <2>; /* contains dma-window */
> > 	};
> > 
> > 	device@4 {
> > 		compatible = "some,ethernet";
> > 		iommus = <&/iommu@1>;
> > 	};
> > 
> > 	device@5 {
> > 		compatible = "some,dmaengine";
> > 		iommus = <&/iommu@2 0x40000000 0x1000000>,
> > 			 <&/iommu@3 0x101>;
> > 	};
> > 
> > The device at address 4 has a one-one relationship with iommu@1, so there
> > is no need for any data. device@5 has two master ports. One is connected to
> > an IOMMU that has a per-device aperture, device@5 can only issue transfers
> > to the 256MB area at 0x40000000, and the IOMMU will have to put entries for
> > this device into that address. The second master port is connected to
> > iommu@3, which uses a master ID that gets passed along with each transfer,
> > so that needs to be put into the IOTLBs.
> 
> iommu@3 and the second port of device@5 seem to match what we need for
> Tegra (and as I understand also Exynos). Can we settle on this for now
> so that Hiroshi and Cho can go update their drivers for this binding?
> 

Currently, Exynos IOMMU is the case of iommu@1.

But in the near future, it will support multiple masters with a single context
that means all masters that shares a single System MMU also views the same
address space.

For some cases, we may need iommu@3 that supports dma-window.

So, I have no other opinion.

By the way, iommu framework should allow to process the parameters
to 'iommus' property in the master nodes by iommu driver implementations
because it is depended on implementations.

> > A variation would be to not use #iommu-cells at all, but provide a
> > #address-cells / #size-cells pair in the IOMMU, and have a translation
> > as we do for dma-ranges. This is probably most flexible.
> 
> The remainder of this discussion seems to indicate that #iommu-cells and
> dma-ranges don't have to be mutually exclusive. For some IOMMUs it might
> make sense to use both.
> 
> In fact perhaps we should require every IOMMU user to also specify a
> dma-ranges property, even if for some cases the range would be simply
> the complete physical address space. Perhaps in analogy to the ranges
> property an empty dma-ranges property could be taken to mean all of the
> physical address space.
> 
> I'm aware that this doesn't cover any of the more exotic cases out
> there, but the fact is that we have real devices out there that ship
> with some variations of these simple IOMMUs and I don't think we're
> doing ourselves a favour by blocking support for these to be added on
> the hope of merging the perfect solution that covers all use-cases.
> Patches for Tegra have already been around for close to half a year.
> 
> Thierry
