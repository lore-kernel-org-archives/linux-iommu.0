From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 25 Jun 2014 11:27:50 +0200
Message-ID: <4839521.56FtveYIl6@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com> <4855051.rhxSrNMNLg@wuerfel> <20140625091702.GF6153@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140625091702.GF6153@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Olav Haugan <ohaugan@codeaurora.org>, Rob Herring <robherring2@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Stephen Warren <swarren@wwwdotorg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kumar Gala <galak@codeaurora.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Cho KyongHo <pullip.cho@samsung.com>, Dave P Martin <Dave.Martin@arm.com>"linux-arm-kernel@lists.infradead.org" <li>
List-Id: iommu@lists.linux-foundation.org

On Wednesday 25 June 2014 10:17:02 Will Deacon wrote:
> On Tue, Jun 24, 2014 at 07:20:56PM +0100, Arnd Bergmann wrote:
> > On Tuesday 24 June 2014 19:11:50 Will Deacon wrote:
> > > On Tue, Jun 24, 2014 at 06:57:44PM +0100, Olav Haugan wrote:
> > > > We do describe the masked StreamID (SID) but we need to specify the mask
> > > > that the SMMU should apply to the incoming SIDs, right?
> > > > 
> > > > We have a bus master that emits 43 unique SIDs. However, we have only 40
> > > > SMMU_SMRn registers in the SMMU. So we need to mask out some of the
> > > > incoming SID bits so that the 43 SIDs can match one of 40 entries in the
> > > > SMR.
> > > 
> > > Hmm, so you're talking about stream matching, right? That doesn't belong in
> > > the device-tree. I appreciate that the current driver does a terrible job at
> > > allocating the SMRs (it's bloody difficult!), but we should try to improve
> > > the dynamic behaviour instead of moving configuration of the SMMU out into
> > > device-tree, where it's inflexible at best.
> > > 
> > > There have been patches previously posted by Andreas Herrmann helping here.
> > > I'd be glad to see them revived.
> > 
> > Note that there are areas where we have in the past decided that dynamic
> > configuration is just too hard for the kernel to do and that we're better
> > off putting the configuration into DT. Pinctrl and clocks are at least
> > partially in that category.
> > 
> > It's always best if you can get the kernel to do things in the ideal
> > way where that is possible, but getting there may be just not worth it.
> > 
> > I have no idea where it should be for SMMU, but it's something to consider:
> > if you can take reasonable shortcuts by reading parts of the configuration
> > from DT, you may just as well do that.
> 
> I treat this in the same manner as the topology bindings we discussed
> previously; we should do a best-effort to configure things dynamically and
> solve corner-cases and quirks as special cases.

I think the situation is a bit different here: It's less about the corner
cases for the SMMU, but about the question whether it makes more sense to
have the kernel figure out the settings, or have them come from DT
all the time.

As I said, I can't tell which approach is best here, but it sounds to
me we should either do dynamic configuration and get it right, or
hardcode the configuration it all the time if we can't.

	Arnd
