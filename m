From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 5/8] iommu/amd: copy old trans table from old kernel
Date: Wed, 28 Sep 2016 21:01:36 +0800
Message-ID: <20160928130136.GA9185@x1.redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
	<1473951806-25511-6-git-send-email-bhe@redhat.com>
	<20160920124031.GD3541@8bytes.org>
	<20160928013702.GH14155@x1.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160928013702.GH14155-ejN7fcUYdH/by3iVrkZq2A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/28/16 at 09:37am, Baoquan He wrote:
> Hi Joerg,
> 
> On 09/20/16 at 02:40pm, Joerg Roedel wrote:
> > > +	if ( !is_pre_enabled) {
> > > +		for_each_iommu(iommu)
> > > +			early_enable_iommu(iommu);
> > > +	} else {
> > > +		if (copy_dev_tables()) {
> > > +			pr_err("Failed to copy DEV table from previous kernel.\n");
> > > +			/*
> > > +			 * If failed to copy dev tables from old kernel, continue to proceed
> > > +			 * as it does in normal kernel.
> > > +			 */
> > > +			for_each_iommu(iommu) {
> > > +				clear_translation_pre_enabled(iommu);
> > > +				early_enable_iommu(iommu);
> > > +			}
> > > +		} else {
> > > +			pr_info("Copied DEV table from previous kernel.\n");
> > > +			for_each_iommu(iommu) {
> > > +				iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
> > > +		                iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
> > 
> > Could you move that into new helpers (iommu_disable_command_buffer...)?
> 
> Did you mean wraping iommu_feature_disable(iommu, CONTROL_CMDBUF_EN) into a
> helper function like iommu_disable_command_buffer(), and wraping
> iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN) into
> iommu_disable_event_buffer()?
> 
> I retest with not disabling command buffer and event log here, it works
> on amd iommu v1 and v2 systems. So if I understand your comment
> correctly, there's no need to add "iommu_feature_disable(iommu,
> CONTROL_CMDBUF_EN)"  and "iommu_feature_disable(iommu,
> CONTROL_EVT_LOG_EN)" here. I remember I added them here because more
> IO_PAGE_FAULT messages are printed without them. But now it seems not to
> related to them. So I will remove above two lines of code.

Oh, sorry, please ignore this. It will print many lines of below message
if do not disable cmd buffer and event log here.

[    0.455642] AMD-Vi: Completion-Wait loop timed out
