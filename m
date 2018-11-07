From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
Date: Wed, 7 Nov 2018 17:03:41 +0100
Message-ID: <20181107160341.pfpukoqhyhapfzpn@8bytes.org>
References: <20181107131850.11584-1-geert+renesas@glider.be>
 <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com>
 <20181107153418.cge2dj5zmztahxrf@8bytes.org>
 <CAMuHMdWPkMtnGrxrtFGmyJ5NEvSSCiMUVXXBWX+NS-J4tQXLAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWPkMtnGrxrtFGmyJ5NEvSSCiMUVXXBWX+NS-J4tQXLAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 07, 2018 at 04:50:40PM +0100, Geert Uytterhoeven wrote:
> It only got triggered by the combination of commits 6c2fb2ea76361da9
> ("of/device: Set bus DMA mask as appropriate") and b4ebe6063204da58
> ("dma-direct: implement complete bus_dma_mask handling"), which is being
> fixed by "of/device: Really only set bus DMA mask when
> appropriate" (https://patchwork.kernel.org/patch/10670177/).

Okay, but the bug is triggered since 6c2fb2ea76361da9, so I took this
one for the fixes-tag.

Thanks,

	Joerg
