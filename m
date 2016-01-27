From: Anup Patel <anup.patel@broadcom.com>
Subject: RE: [RFC PATCH 6/6] iommu/arm-smmu: Update bindings document for
 smmu-inst-as-data DT option
Date: Wed, 27 Jan 2016 14:22:23 +0000
Message-ID: <39063E8F96E11742B35A201CC5D095B7BAEAEE@SJEXCHMB10.corp.ad.broadcom.com>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
 <1453872079-27140-7-git-send-email-anup.patel@broadcom.com>
 <20160127122842.GA21064@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160127122842.GA21064@leverpostej>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Device Tree <devicetree@vger.kernel.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Vikram Prakash <vikramp@broadcom.com>, Linux Kernel <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: 27 January 2016 17:59
> To: Anup Patel
> Cc: Catalin Marinas; Joerg Roedel; Will Deacon; Robin Murphy; Sricharan R;
> Linux IOMMU; Linux ARM Kernel; Rob Herring; Pawel Moll; Ian Campbell; Kumar
> Gala; Device Tree; Ray Jui; Scott Branden; Vikram Prakash; Linux Kernel; bcm-
> kernel-feedback-list
> Subject: Re: [RFC PATCH 6/6] iommu/arm-smmu: Update bindings document for
> smmu-inst-as-data DT option
> 
> On Wed, Jan 27, 2016 at 10:51:19AM +0530, Anup Patel wrote:
> > This patch adds info about 'smmu-inst-as-data' DT option in ARM
> > SMMUv1/SMMUv2 driver bindings document.
> >
> > Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> > Reviewed-by: Ray Jui <rjui@broadcom.com>
> > Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
> > Reviewed-by: Scott Branden <sbranden@broadcom.com>
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > index 7180745..4c4d03e 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > @@ -49,6 +49,14 @@ conditions.
> >                    NOTE: this only applies to the SMMU itself, not
> >                    masters connected upstream of the SMMU.
> >
> > +- smmu-inst-as-data : Treat privilege/unprivilege instruction fetch as
> > +                  data read for SMMUv2. The SMMU driver by default provides
> > +                  unprivilege read-write permission in page table entries.
> > +                  For SMMUv2, privilege instruction fetch from MMU masters
> > +                  will cause a context fault for unprivilege read-write
> > +                  pages. To allow both privilege and unprivilege instruction
> > +                  fetch, we have to forcefully treat it as data read.
> 
> What is this needed for? Which masters do instruction fetches through the
> SMMU, and when?
> 
> Surely this should only need to aplly to a subset of transactions?

The boot_manager of PL330 does privileged instruction fetches which
cause privilege-level context fault in SMMU because current SMMU
driver provides unprivileged read-write permissions.

Regards,
Anup
