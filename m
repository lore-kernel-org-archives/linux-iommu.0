From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: iommu/arm, smmu: add compatible string
 for Marvell
Date: Thu, 18 Oct 2018 15:48:01 -0500
Message-ID: <20181018204801.GA2009@bogus>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
 <1539604846-21151-4-git-send-email-hannah@marvell.com>
 <3ce1d67a-4e3c-e8d8-f7fc-79649f1def68@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3ce1d67a-4e3c-e8d8-f7fc-79649f1def68@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hannah@marvell.com, catalin.marinas@arm.com, will.deacon@arm.com, corbet@lwn.net, joro@8bytes.org, gregory.clement@bootlin.com, mark.rutland@arm.com, jason@lakedaemon.net, andrew@lunn.ch, sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, omrii@marvell.com, linux-kernel@vger.kernel.org, nadavh@marvell.com, iommu@lists.linux-foundation.org, thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.orgnd@arm.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 15, 2018 at 02:11:52PM +0100, Robin Murphy wrote:
> On 15/10/18 13:00, hannah@marvell.com wrote:
> > From: Hanna Hawa <hannah@marvell.com>
> > 
> > Add specific compatible string for Marvell usage due errata of
> > accessing 64bit registers of ARM SMMU, in AP806.
> > 
> > AP806 SOC use the generic ARM-MMU500, and there's no specific
> > implementation of Marvell, this compatible is used for errata only.
> 
> Given that, I think something more specific like:
> 
> 	"marvell,ap806-smmu", "arm,mmu-500";
> 
> would be most appropriate. Otherwise, if some future Marvell SoC were to
> ever come out with a *different* MMU-500 integration problem, you'd already
> have painted yourself into a corner.
> 
> Alternatively (or additionally), we could perhaps consider a separate
> property like "marvell,32bit-config-access", to mirror the existing handling
> of the secure integration bug.

The former please. We have learned our lesson there (though for some 
reason, that was the *only* SMMU problem in Calxeda Midway ;) ).

Rob
