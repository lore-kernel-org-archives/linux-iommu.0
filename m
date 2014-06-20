From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Fri, 20 Jun 2014 20:55:23 +0200
Message-ID: <63766434.z4MqtGKoIA@wuerfel>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com> <39682213.otHMo6zoRf@wuerfel> <20140620175051.GE30656@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140620175051.GE30656@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Cho KyongHo <pullip.cho@samsung.com>, Dave P Martin <Dave.Martin@arm.com>, Hiroshi Doyu <hd>
List-Id: iommu@lists.linux-foundation.org

On Friday 20 June 2014 18:50:51 Will Deacon wrote:
> On Fri, Jun 20, 2014 at 04:53:08PM +0100, Arnd Bergmann wrote:
> > On Wednesday 18 June 2014 11:14:39 Will Deacon wrote:
> > > On Wed, Jun 18, 2014 at 12:37:16AM +0100, Thierry Reding wrote:
> > >   - Each master has a set of fixed StreamIDs
> > >   - StreamIDs can be remastered by adding a constant offset (this could also
> > >     be used to describe RequesterID -> StreamID mapping)
> > > 
> > > I'd hope this would be sufficient for most people. Dynamic ID assignment can
> > > be worked out later (I'm not even sure it belongs in this binding) and any
> > > mappings other than `add a constant offset' can be treated on a case-by-case
> > > basis. We don't want to throw the kitchen sink at a language for describing
> > > arbitrary transformations!
> > > 
> > > > We've had similar discussions before (power sequences anyone?) where we
> > > > tried to come up with a generic way to describe something in device tree
> > > > that just didn't work out too well. Some things are better done in code,
> > > > so I think we should at least consider that possibility rather than
> > > > blindly try and force everything into device tree.
> > > 
> > > If we can support 90% of SoCs with a simple DT-based description, we can
> > > address the corner cases as they arise. I'm not ruling our hardcoding
> > > topology if we have no choice, but I don't think that's a healthy place to
> > > start from.
> > 
> > So we could use the "arm,gicv3" comaptible string for all those that
> > have a relatively simple mapping, and describe that mapping entirely
> > in DT properties, but use a different compatible string for those
> > SoCs that have a mapping which we can't easily describe, and then
> > put that into code?
> 
> That doesn't sound unreasonable, but I don't think we should commit to
> putting things into code until they come along and we can't describe them.

Yes, that makes sense. But it's good to know that we have the option so
we don't have to cover all corner cases with the binding.

	Arnd
