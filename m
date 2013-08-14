From: Sethi Varun-B16395 <B16395@freescale.com>
Subject: RE: [PATCH 1/3] powerpc: Add iommu domain pointer to device archdata
Date: Wed, 14 Aug 2013 16:44:18 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A42F5C6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1373863857-27239-1-git-send-email-Varun.Sethi@freescale.com>
 <20130814094802.GC4491@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D0A42CDB5@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130814161522.GP28811@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130814161522.GP28811@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "galak@kernel.crashing.org" <galak@kernel.crashing.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Yoder Stuart-B08248 <B08248@freescale.com>, Wood Scott-B07421 <B07421@freescale.com>
List-Id: iommu@lists.linux-foundation.org

Thanks Joerg.

> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Wednesday, August 14, 2013 9:45 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; benh@kernel.crashing.org;
> galak@kernel.crashing.org; alex.williamson@redhat.com; Yoder Stuart-
> B08248; Wood Scott-B07421
> Subject: Re: [PATCH 1/3] powerpc: Add iommu domain pointer to device
> archdata
> 
> On Wed, Aug 14, 2013 at 09:56:11AM +0000, Sethi Varun-B16395 wrote:
> > Please find the .config file attached with this mail.
> 
> Fantastic, thanks. The build works fine, I'll include the driver into my
> next-branch. I also have two minor clean-up patches on-top, just if you
> where wondering.
> 
> 
> 	Joerg
> 
> 
