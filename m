From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Fix unity mapping initialization race
Date: Mon, 11 Jul 2016 11:39:07 +0200
Message-ID: <20160711093907.GD12639@8bytes.org>
References: <1467820838-5059-1-git-send-email-joro@8bytes.org>
 <57823445.1020808@iommu.org>
 <20160711071959.GB12639@8bytes.org>
 <57836609.5060406@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57836609.5060406@iommu.org>
Sender: stable-owner@vger.kernel.org
To: Wan Zongshun <vw@iommu.org>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 11, 2016 at 05:25:29PM +0800, Wan Zongshun wrote:
> Okay, this patch should also better to general case not only unity-mapping.
> 
> How about the interrupt remap function? Do we need same considering
> for IV bit enable for interrupt remap?

No, there are no unity mappings for irqs, so we are not running into the
same race here.

> Sorry, why you still say this 'init_device_table_dma' can block DMA?
> I just think this function will enable DMA transfer, since  we set
> the V and TV bits, right? or I misunderstand what "block DMA" mean?

When the V and TV bits are not set, it means that all DMA from that
device-id is forwared untranslated by the IOMMU. But if we set V and TV
it means that there is translation information, and the IOMMU translates
the requests using the rest of the DTE information. As all other bits
are 0, this means that page-table-level is 0 (== no page-table) and that
the global IW and IR bits are 0 too (== no read and write permissions).
So all requests are blocked.



	Joerg
