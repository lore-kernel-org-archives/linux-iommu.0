From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 02/13] iommu/amd: add several helper functions
Date: Fri, 28 Jul 2017 10:36:57 +0800
Message-ID: <20170728023657.GG24304@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
	<1500627551-12930-3-git-send-email-bhe@redhat.com>
	<20170727150612.GK3610@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170727150612.GK3610-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/27/17 at 05:06pm, Joerg Roedel wrote:
> On Fri, Jul 21, 2017 at 04:59:00PM +0800, Baoquan He wrote:
> > Move single iommu enabling codes into a wrapper function early_enable_iommu().
> > This can make later kdump change easier.
> > 
> > And also add iommu_disable_command_buffer and iommu_disable_event_buffer
> > for later usage.
> > 
> > Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

Forgot changing it after copying from command buffer code.

> 
> > + */
> > +static void iommu_disable_event_buffer(struct amd_iommu *iommu)
> 
> Please also use event_log here.

Sure, will change. Thanks.

> 
> > +{
> > +	iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
> > +}
> > +
