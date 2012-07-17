From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 0/6] OMAP: iommu: hwmod, reset handling and runtime PM
Date: Tue, 17 Jul 2012 13:51:12 +0300
Message-ID: <CAK=WgbbVvFoGRoitscvTRUWUWd=3HLiuvs6ZUNZnAbF67tXO5A@mail.gmail.com>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org> <20120717101100.GI4213@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120717101100.GI4213@amd.com>
Sender: linux-omap-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>, Paul Walmsley <paul@pwsan.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

+ Paul

On Tue, Jul 17, 2012 at 1:11 PM, Joerg Roedel <joerg.roedel@amd.com> wrote:
> On Fri, Jun 15, 2012 at 08:55:58PM -0500, Omar Ramirez Luna wrote:
>> Omar Ramirez Luna (6):
>>   ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected
>>   ARM: OMAP3: hwmod data: add mmu data for iva and isp
>>   ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp
>>   ARM: OMAP3/4: iommu: migrate to hwmod framework
>>   ARM: OMAP2+: iommu: add reset handling
>>   ARM: OMAP3/4: iommu: adapt to runtime pm
>
> What happens with this patch-set. Comments anyone? Ohad?

Looks like it depends on a few OMAP hwmod changes (reset handling)
which require Paul's ACK.

Ohad.
