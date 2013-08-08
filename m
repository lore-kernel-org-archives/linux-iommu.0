From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 06/12] ARM: dts: Add description of System MMU of
	Exynos SoCs
Date: Thu, 08 Aug 2013 23:38:10 +0200
Message-ID: <5354557.DijgoUKjW2@flatron>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
	<003801ce8eb7$d7647f10$862d7d30$@samsung.com>
	<CAL_Jsq+_5GekzXpjWrtKZi2jWuxHSJxkPmVC4zmakfjAYai=eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAL_Jsq+_5GekzXpjWrtKZi2jWuxHSJxkPmVC4zmakfjAYai=eA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Keyyoung Park <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thursday 08 of August 2013 08:09:49 Rob Herring wrote:
> On Thu, Aug 1, 2013 at 8:05 AM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> 
wrote:
> >> -----Original Message-----
> >> From: Rob Herring [mailto:robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> >> Sent: Saturday, July 27, 2013 10:55 PM
> >> 
> >> On Fri, Jul 26, 2013 at 6:28 AM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> 
wrote:
> >> > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> > ---
> >> > 
> >> >  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |  103 +++++++
> >> >  arch/arm/boot/dts/exynos4.dtsi                     |  122 ++++++++
> >> >  arch/arm/boot/dts/exynos4210.dtsi                  |   25 ++
> >> >  arch/arm/boot/dts/exynos4x12.dtsi                  |   76 +++++
> >> >  arch/arm/boot/dts/exynos5250.dtsi                  |  291
> >> >  ++++++++++++++++++++ 5 files changed, 617 insertions(+), 0
> >> >  deletions(-)
> >> >  create mode 100644
> >> >  Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu
> >> >  .txt>> > 
> >> > diff --git
> >> > a/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmm
> >> > u.txt
> >> > b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmm
> >> > u.txt new file mode 100644
> >> > index 0000000..92f0a33
> >> > --- /dev/null
> >> > +++
> >> > b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmm
> >> > u.txt @@ -0,0 +1,103 @@
> >> > +Samsung Exynos4210 IOMMU H/W, System MMU (System Memory Management
> >> > Unit) +
> >> > +Samsung's Exynos architecture contains System MMU that enables
> >> > scattered +physical memory chunks visible as a contiguous region
> >> > to DMA-capable peripheral +devices like MFC, FIMC, FIMD, GScaler,
> >> > FIMC-IS and so forth.
> >> > +
> >> > +System MMU is a sort of IOMMU and support identical translation
> >> > table format to +ARMv7 translation tables with minimum set of page
> >> > properties including access +permissions, shareability and
> >> > security protection. In addition, System MMU has +another
> >> > capabilities like L2 TLB or block-fetch buffers to minimize
> >> > translation +latency.
> >> > +
> >> > +A System MMU is dedicated to a single master peripheral device. 
> >> > Thus, it is +important to specify the correct System MMU in the
> >> > device node of its master +device. Whereas a System MMU is
> >> > dedicated to a master device, the master device +may have more
> >> > than one System MMU.
> >> 
> >> I don't follow the last sentence. Can you elaborate on the type of
> >> connection you are talking about.
> > 
> > Grant also addressed that.
> > 
> > He corrected the sentence like the following:
> >   " Can I suggest rewriting the last two sentences to:
> >      The master device node must correctly specify at least one
> >      SystemMMU. A master  device may have more than one System MMU. "
> > 
> > I will change the sentence
> > 
> >> Also, please align with the ARM system MMU binding that Will Deacon
> >> has submitted particularly in terms of how master connections are
> >> described.
> > 
> > I didn't check it.
> > 
> > Should this align with ARM System MMU bindings?
> > System MMU in Exynos SoC is different from ARM System MMU.
> > It does not follows the specifications of ARM System MMU.
> 
> I'm not saying the h/w is the same or even the same spec, but how you
> describe a master to iommu connection needs to be done in the same
> way. This should be done in the same way for ALL iommu's. And if what
> is defined does not work for you, then we need to understand that and
> fix the binding now.

+1

All IOMMUs should use a generic IOMMU Device Tree bindings (and in 
general, the same should be true for all Device Tree bindings).

This means that if we already have some bindings for IOMMU, then they 
should be reused if possible or extended if there is anything missing.

Of course there might be things that such generic bindings can't specify. 
In this case device-specific properties can be introduced, but this is 
last resort.

Best regards,
Tomasz
