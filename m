From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH v3 0/6] OMAP: iommu: hwmod, reset handling and runtime PM
Date: Wed, 17 Oct 2012 18:52:37 -0500
Message-ID: <CALLhW=5Fmjhd+w57Dmm2BLmBoHuC7_jprJndkw1dHoVzVu4TOg@mail.gmail.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
	<20121016172258.GT15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121016172258.GT15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 16 October 2012 12:22, Tony Lindgren <tony@atomide.com> wrote:
> * Omar Ramirez Luna <omar.luna@linaro.org> [121011 18:07]:
>> These patches are needed for remoteproc to work on OMAP4.
>>
>> Introduced iommu hwmod support for OMAP3 (iva, isp) and
>> OMAP4 (ipu, dsp), along with the corresponding runtime PM
>> and routines to deassert reset lines, enable/disable clocks
>> and configure sysc registers.
>>
>> Although IOMMU hwmod patches were already submitted in the past,
>> this series adds few more changes, like:
>> - New reset handling.
>> - Save and restore context code rework.
>> - Device tree bindings for OMAP3 and OMAP4.
>>
>> For this series I just dropped the patches already included in
>> mainline.
>
> These will need to be rebased on omap-for-v3.8/cleanup-headers-iommu
> when I have that pushed out as that removes plat/*iommu*.h files.

Ok, will wait and rebase on top of it.

Thanks,

Omar
