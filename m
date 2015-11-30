From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 3/9] iommu/amd: make several functions globally seen
Date: Mon, 30 Nov 2015 19:31:54 +0800
Message-ID: <20151130113154.GC25496@dhcp-128-28.nay.redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
	<1446811851-20623-4-git-send-email-bhe@redhat.com>
	<20151127110609.GB24300@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151127110609.GB24300-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 11/27/15 at 12:06pm, Joerg Roedel wrote:
> On Fri, Nov 06, 2015 at 08:10:45PM +0800, Baoquan He wrote:
> > They will be called later when copy old dev/irq tables. It's better to use them
> > then call iommu_flush_all_caches() since iommu_flush_all_caches() will
> > iterate many empty table entries.
> 
> You only flush all table entries on old AMD IOMMUs. Newer ones have a
> flush_all command that is used when available. Besides that, the AMD
> IOMMU hardware is usually fast so that even flushing all dte entries is
> not a bottleneck (it is done during suspend/resume, for example).
> 
> Have you made different experiences?

Since before too many lines of Comopletion-Wait loop timeouts message
are printed, especially on my AMD-A10-7850K its last devid is 0xffff.
Then it will check and print 0xffff Comopletion-Wait message. So I used
this to make it fewer.

Now on AMD IOMMU V1 machine I called iommu_enable_command_buffer()
earlier and then call iommu_flush_all_caches(iommu), it works well. But
on AMD A10-7850K it still printed 0xffff lines of message.
