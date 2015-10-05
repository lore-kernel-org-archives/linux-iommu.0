From: Joerg Roedel <joro@8bytes.org>
Subject: Re: Fwd: SWIOTLB on 32-bit PAE.
Date: Mon, 5 Oct 2015 12:00:52 +0200
Message-ID: <20151005100051.GA12506@8bytes.org>
References: <560E9007.1000604@t2data.com>
 <560E92A0.9030707@t2data.com>
 <20151003143630.GB17684@localhost>
 <20151003180007.GA4732@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151003180007.GA4732@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, christian.melki@t2data.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Oct 03, 2015 at 02:00:19PM -0400, Konrad Rzeszutek Wilk wrote:
> Aye. I presume that you had done a small change already for this?
> Would you be willing to post it on lkml and CC me ?

Yes, I also think it is needed. SWIOTLB already correctly handles
buffers in HighMem, so enabling it for 32-bit PAE should be easy. Please
also CC me on the patch.


	Joerg
