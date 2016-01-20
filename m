From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Wed, 20 Jan 2016 21:18:58 +0800
Message-ID: <20160120131858.GB10598@x1.redhat.com>
References: <56957209.1080202@compro.net>
	<20160113030950.GB11902@dhcp-128-28.nay.redhat.com>
	<20160120123116.GF18805@8bytes.org> <569F858E.4060701@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <569F858E.4060701-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/20/16 at 08:03am, Mark Hounschell wrote:
> On 01/20/2016 07:31 AM, Joerg Roedel wrote:
> >Hi Baoquan,
> >
> >On Wed, Jan 13, 2016 at 11:09:50AM +0800, Baoquan He wrote:
> >>Seems 0f:00.0 is not attached to a group so that it get a domain. Can
> >>you also paste your "lspci -t" and "lspci -vvv" output? Here 0f:00.0
> >>should be a pci bridge which need set the same domain with its
> >>peripheral 0000:0f:04.0.
> >>
> >>Please apply this patch and try again.
> >
> >Thanks for the fix, mind submitting it so that I can queue it and send
> >it upstream after the merge window closes?
> >
> >
> >
> >	Joerg
> 
> I suspect the fix is just not complete yet as my box is still hosed.

No, the io_page_fault is caused by the not correct alias setting so that
the scsi storage controller like 0f:04.0/0a:0a.0 can't be handled
correclty. You can see that their alias are 0f:00.0 and 09:00.0 which
are reported in io_page_fualt.

But the other 2 disks still didn't come up, I suspect if the irq is not
set right. This should be another different issue, no any idea yet.

Thanks
Baoquan
