From: Sethi Varun-B16395 <B16395@freescale.com>
Subject: RE: [RFC][PATCH 1/3] iommu/fsl: Store iommu domain information
 pointer in archdata.
Date: Thu, 4 Oct 2012 16:30:58 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D1EFD59@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1348060632-12997-1-git-send-email-b16395@freescale.com>
 <1348060632-12997-2-git-send-email-b16395@freescale.com>
 <5BDB4D18-CB0D-4EBA-B38F-A278B7C00A61@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5BDB4D18-CB0D-4EBA-B38F-A278B7C00A61@kernel.crashing.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "joerg.roedel@amd.com" <joerg.roedel@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, September 19, 2012 7:20 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; joerg.roedel@amd.com; linux-
> kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Sethi Varun-B16395
> Subject: Re: [RFC][PATCH 1/3] iommu/fsl: Store iommu domain information
> pointer in archdata.
> 
> 
> On Sep 19, 2012, at 8:17 AM, <b16395@freescale.com>
> <b16395@freescale.com> wrote:
> 
> > From: Varun Sethi <Varun.Sethi@freescale.com>
> >
> > Add a new field in the device (powerpc) archdata structure for storing
> > iommu domain information pointer. This pointer is stored when the
> > device is attached to a particular domain.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > arch/powerpc/include/asm/device.h |    4 ++++
> > 1 files changed, 4 insertions(+), 0 deletions(-)
> 
> Not too familiar, but what does the IBM Server IOMMU do for iommu_domain?
>
[Sethi Varun-B16395] I am not sure if the IBM iommu driver implements the iommu
API.

-Varun
 
