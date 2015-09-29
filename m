From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: break the for loop if an empty ir_ioapic
 entry found
Date: Tue, 29 Sep 2015 23:04:38 +0800
Message-ID: <20150929150438.GA2011@dhcp-17-102.nay.redhat.com>
References: <1443511569-9187-1-git-send-email-bhe@redhat.com>
 <20150929135033.GC7572@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150929135033.GC7572@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 09/29/15 at 03:50pm, Joerg Roedel wrote:
> On Tue, Sep 29, 2015 at 03:26:08PM +0800, Baoquan He wrote:
> > No need to continue the loop after it has been found.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  drivers/iommu/intel_irq_remapping.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> > index 9ec4e0d..37b93f5 100644
> > --- a/drivers/iommu/intel_irq_remapping.c
> > +++ b/drivers/iommu/intel_irq_remapping.c
> > @@ -841,8 +841,10 @@ static int ir_parse_one_ioapic_scope(struct acpi_dmar_device_scope *scope, > >  		if (ir_ioapic[count].iommu == iommu &&
> >  		    ir_ioapic[count].id == scope->enumeration_id)
> >  			return 0;
> > -		else if (ir_ioapic[count].iommu == NULL && free == -1)
> > +		else if (ir_ioapic[count].iommu == NULL && free == -1) {
> >  			free = count;
> > +			break;
> > +		}
> >  	}
> 
> The purpose of the loop is also to avoid duplicate entries, so we need
> to search it till the end, no?

Ah, yes, you are right, it's on purpose. So I will drop this one
and update the 2/2 only with your suggestion.
