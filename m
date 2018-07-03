From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
Date: Tue, 03 Jul 2018 08:55:40 -0700
Message-ID: <d93bfa0f52d8907019b16336645986cd339ebf75.camel@perches.com>
References: <20180703064005.18908-1-colin.king@canonical.com>
         <6763ec382f8d629f5f356f4cc023f20c2f76b26a.camel@perches.com>
         <d27fe634-89cf-7d9a-3e3d-a2baafabf0be@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d27fe634-89cf-7d9a-3e3d-a2baafabf0be@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gary R Hook <ghook@amd.com>, Colin King <colin.king@canonical.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2018-07-03 at 07:56 -0500, Gary R Hook wrote:
> On 07/03/2018 05:07 AM, Joe Perches wrote:
> > On Tue, 2018-07-03 at 07:40 +0100, Colin King wrote:
> > > Currently tag is being assigned but not used, it is missing from
> > > the dev_err message, so add it in.
> > > 
> > > Cleans up clang warning:
> > > warning: variable 'tag' set but not used [-Wunused-but-set-variable]
> > 
> > []
> > > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > 
> > []
> > > @@ -616,9 +616,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
> > >   		pasid = ((event[0] >> 16) & 0xFFFF)
> > >   			| ((event[1] << 6) & 0xF0000);
> > >   		tag = event[1] & 0x03FF;
> > > -		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
> > > +		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%03x]\n",
> > >   			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> > > -			pasid, address, flags);
> > > +			pasid, address, flags, tag);
> > 
> > Seems to have a superfluous ] that should be removed.
> 
> Yeah, I pretty much messed up all of the log messages in that function. 
> My apologies. I'll create a patch for that problem; it shouldn't be 
> fixed here.

I also wonder why event is declared volatile and then
dereferenced with [<constant>] multiple times.

Maybe each array dereference should be stored as a
local variable instead.
