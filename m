From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
Date: Wed, 7 Nov 2018 17:53:36 +0100
Message-ID: <20181107165336.GB19831@8bytes.org>
References: <20181107131850.11584-1-geert+renesas@glider.be>
 <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com>
 <20181107153418.cge2dj5zmztahxrf@8bytes.org>
 <CAMuHMdWPkMtnGrxrtFGmyJ5NEvSSCiMUVXXBWX+NS-J4tQXLAw@mail.gmail.com>
 <20181107160341.pfpukoqhyhapfzpn@8bytes.org>
 <f8259910-3e07-497b-9f18-6bcb47430cff@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f8259910-3e07-497b-9f18-6bcb47430cff@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 07, 2018 at 04:17:09PM +0000, Robin Murphy wrote:
> FWIW it looks like it *has* always been possible to hit this crash by
> allocating a domain and freeing it again without attaching any devices, it's
> just highly improbable for any sane code to do that explicitly, so the real
> latent triggers are failure paths in external callers (which in this case
> are themselves only being reached thanks to my bug elsewhere).

Okay, given this, it probably makes more sense to change the fixes tag.
This is what I just committed:

Fixes: d25a2a16f0889 ('iommu: Add driver for Renesas VMSA-compatible IPMMU')

Regards,

	Joerg
