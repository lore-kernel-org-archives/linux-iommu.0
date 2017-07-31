From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 02/13] iommu/amd: add several helper functions
Date: Mon, 31 Jul 2017 18:01:11 +0800
Message-ID: <20170731100111.GA29157@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-3-git-send-email-bhe@redhat.com>
 <20170727150612.GK3610@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727150612.GK3610@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 07/27/17 at 05:06pm, Joerg Roedel wrote:
> On Fri, Jul 21, 2017 at 04:59:00PM +0800, Baoquan He wrote:
> > Move single iommu enabling codes into a wrapper function early_enable_iommu().
> > This can make later kdump change easier.
> > 
> > And also add iommu_disable_command_buffer and iommu_disable_event_buffer
> > for later usage.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  drivers/iommu/amd_iommu_init.c | 42 +++++++++++++++++++++++++++++++-----------
> >  1 file changed, 31 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> > index e39857ce6481..4ca6e3257d92 100644
> > --- a/drivers/iommu/amd_iommu_init.c
> > +++ b/drivers/iommu/amd_iommu_init.c
> > @@ -634,6 +634,14 @@ static void iommu_enable_command_buffer(struct amd_iommu *iommu)
> >  	amd_iommu_reset_cmd_buffer(iommu);
> >  }
> >  
> > +/*
> > + * This function disables the command buffer
> > + */
> > +static void iommu_disable_command_buffer(struct amd_iommu *iommu)
> > +{
> > +	iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
> > +}
> > +
> >  static void __init free_command_buffer(struct amd_iommu *iommu)
> >  {
> >  	free_pages((unsigned long)iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
> > @@ -666,6 +674,14 @@ static void iommu_enable_event_buffer(struct amd_iommu *iommu)
> >  	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
> >  }
> >  
> > +/*
> > + * This function disables the command buffer
> 
> s/command buffer/event log/
> 
> > + */
> > +static void iommu_disable_event_buffer(struct amd_iommu *iommu)
> 
> Please also use event_log here.

I found the event log related handling functions all take
xxx_event_buffer names, like:
alloc_event_buffer()
iommu_enable_event_buffer()
free_event_buffer()

So for consistency, I plan to still use iommu_disable_event_buffer().
Maybe later we can change them in a clean up patch independently.

Thanks
Baoquan

> 
> > +{
> > +	iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
> > +}
> > +
