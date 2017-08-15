From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] iommu/s390: Add support for iommu_device handling
Date: Tue, 15 Aug 2017 18:12:55 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1708151812240.1730@schleppi>
References: <1502274354-643-1-git-send-email-joro@8bytes.org> <alpine.LFD.2.20.1708102104390.4919@schleppi> <20170811073118.GF30515@8bytes.org> <alpine.LFD.2.20.1708111844340.1769@schleppi> <20170814162434.GF2853@suse.de> <alpine.LFD.2.20.1708151800210.1730@schleppi>
 <20170815161039.GH2853@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170815161039.GH2853@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 15 Aug 2017, Joerg Roedel wrote:
> On Tue, Aug 15, 2017 at 06:02:20PM +0200, Sebastian Ott wrote:
> > On Mon, 14 Aug 2017, Joerg Roedel wrote:
> > > I attach the patch I wrote to fix this, can you please test it together
> > > with the initial patch in this thread?
> > 
> > I did and can confirm that everything worked as expected!
> 
> Great, thanks a lot for your testing and thanks again for the effort to
> root-cause the crashes on s390x.
> 
> So, can I add an Acked-by to the initial patch and put it into the
> iommu-tree?

Yes, please do.
