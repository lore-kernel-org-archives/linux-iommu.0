From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 6/9] iommu/amd: Add functions
	copy_command_buffer/copy_event_buffer
Date: Mon, 30 Nov 2015 20:02:18 +0800
Message-ID: <20151130120218.GE25496@dhcp-128-28.nay.redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
	<1446811851-20623-7-git-send-email-bhe@redhat.com>
	<20151127112446.GE24300@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151127112446.GE24300-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 11/27/15 at 12:24pm, Joerg Roedel wrote:
> On Fri, Nov 06, 2015 at 08:10:48PM +0800, Baoquan He wrote:
> >  
> > +static void copy_command_buffer(void)
> > +
> > +static void copy_event_buffer(void)
> > +{
> 
> There is no need to copy any of these buffers. For the command buffer
> you just need to safely reinialize the hardware to use your newly
> allocated buffer.
> 
> Same for the event buffer. But here it makes sense to actually check the
> old event buffer for content and print out the errors the old kernel
> didn't get a chance to handle before the crash.

OK, will check the old event buffer and then call
iommu_enable_command_buffer()/iommu_enable_event_buffer().
