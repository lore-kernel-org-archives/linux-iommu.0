From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 08/16] ARM: OMAP3: remove deprecated
 CONFIG_OMAP_IOMMU_IVA2
Date: Fri, 28 Feb 2014 19:58:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402281958170.453@utopia.booyaka.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com> <1392315347-32967-9-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1392315347-32967-9-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 13 Feb 2014, Suman Anna wrote:

> From: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> CONFIG_OMAP_IOMMU_IVA2 was defined originally to avoid conflicting
> usage by tidspbridge and other iommu users. The same can be achieved
> by marking the DT node disabled, so remove this obsolete flag and
> the corresponding hwmod data can be enabled.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> [s-anna@ti.com: revise commit log]
> Signed-off-by: Suman Anna <s-anna@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

Am assuming that someone else will be merging this as part of the entire 
series.

- Paul
