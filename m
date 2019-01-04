From: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: remove unused attrs parameter to
 dma_common_get_sgtable
Date: Fri, 4 Jan 2019 08:26:51 +0100
Message-ID: <20190104072651.GA14560@lst.de>
References: <HK2PR03MB44183AC87F67594E93F31E75928E0@HK2PR03MB4418.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <HK2PR03MB44183AC87F67594E93F31E75928E0@HK2PR03MB4418.apcprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "hch@lst.de" <hch@lst.de>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "jgross@suse.com" <jgross@suse.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NingTing Cheng <chengnt@lenovo.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Huaisheng Ye <yehs2007@zoho.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 04, 2019 at 01:45:26AM +0000, Huaisheng HS1 Ye wrote:
> From: Stefano Stabellini <sstabellini@kernel.org>
> Sent: Friday, January 04, 2019 1:55 AM
> > On Thu, 3 Jan 2019, Huaisheng Ye wrote:
> > > From: Huaisheng Ye <yehs1@lenovo.com>
> > >
> > > dma_common_get_sgtable has parameter attrs which is not used at all.
> > > Remove it.
> > >
> > > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> > 
> > Acked-by: Stefano Stabellini <sstabellini@kernel.org>
> > 
> > FYI the patch doesn't apply cleanly to master.
> 
> Got it, I will rebase it to branch master and resend the patch later.

I think we can skip it.  For the next merge window I plan to remove
the fallbacks for get_sgtable and mmap and instead wire everything up
explicitly.  And to be a possible method instance it will have to match
the prototype and thus keep the unused argument.
