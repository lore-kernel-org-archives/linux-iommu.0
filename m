From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 0/9] Fix AMD IOMMU faults in kdump kernel
Date: Mon, 30 Nov 2015 19:16:45 +0800
Message-ID: <20151130111645.GA25496@dhcp-128-28.nay.redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
	<20151127113816.GG24300@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151127113816.GG24300-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Thanks a lot for reviewing this patchset.

On 11/27/15 at 12:38pm, Joerg Roedel wrote:
> On Fri, Nov 06, 2015 at 08:10:42PM +0800, Baoquan He wrote:
> > This is v2 draft patch set. It mainly functions as the following steps:
> > 
> > 1. Checking if it's in kdump kernel and previously enabled
> > 2. If yes do below operatons:
> >     a. Do not disable amd iommu and do not touch dev tables before coping old dev tables
> >     b. Copy dev table from old kernel and set the old domain id in amd_iommu_pd_alloc_bitmap
> >     c. Copy irq tables from old kernel
> >     d. Copy command buffer and event buffer
> >     e. Don't call update_domain() to set domain->pt_root to dev entries before device driver initialization.
> >     f. Reset the pre-enabled status in case IOMMU_DMA_OPS of state_next(). 
> > 
> > Existed problems:
> 
> "Existed" means here these problems are gone?

It should be existing, I used wrong word.

> 
> > 
> > 1. It always prints the following message whenever do a flush:
> > 
> > 	"AMD-Vi: Completion-Wait loop timed out"
> > 
> > 2. Maybe there's someing wrong with the old irq remapping handling, the hard disk can't be brought up
> > successfully. You can check the attached kdump kernel boot log with this patchset applied.
> 
> The reason is most likely that you didn't re-initialize the command
> buffer before doing any flushes. The you see the above Completion-Wait
> loop timeouts.

Yeah, you are right. I tried many kinds of calling, but didn't try
calling iommu_enable_command_buffer() earlier than copy_dev_tables().
Now I tried calling iommu_enable_command_buffer() and
iommu_enable_event_buffer() earlier than copy_dev_tables(), message "AMD-Vi:
Completion-Wait loop timed out" is gone on my AMD IOMMU V1 machine. On
my AMD A10-7850K which is AMD IOMMU V2 it still print that message, I am
debugging.

And problem that sata disk can't be brought up still exist.

Thanks
Baoquan
