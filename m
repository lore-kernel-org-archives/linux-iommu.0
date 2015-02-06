From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: question about AMD IOMMU IO_PAGE_FAULT event and PRI
Date: Fri, 6 Feb 2015 13:11:38 +0100
Message-ID: <20150206121138.GS3702@8bytes.org>
References: <CALu9Y57totEk4o+r7EKOK0kZjPNmnBJBQvhLkGmtyrv1EgCNvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALu9Y57totEk4o+r7EKOK0kZjPNmnBJBQvhLkGmtyrv1EgCNvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hann Huang <gic4107-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Hann,

On Fri, Feb 06, 2015 at 11:45:55AM +0800, Hann Huang wrote:
> Hi all,
> 
> I did some experiment which needs two-stage address translation (GVA->GPA->
> SPA).
> After setting the mode bit in DTE to 100b, I got lots of IO_PAGE_FAULT event
> but no any PPR request.

Did you also install a valid page-table before changing the mode-bit?

> While turn off the GPA-to-SPA translation, PPR request comes and no
> IO_PAGE_FAULT event.
> 
> My question is :
> In what situation IO_PAGE_FAULT event generate, and how about PRI request?
> Can IO_PAGE_FAULT event be fixed? (such as handle the page fault and send
> COMPLETE_PPR_REQUEST?)

Basic answer is, you get an IO_PAGE_FAULT for all translation errors in
the l1 page-table (the one where the page-table root it specified in the
DTE).

For any page-fault in l2 page-tables (where you have one page-table per
pasid) you get a PRI fault. But note that the peripheral PCI device needs to
support ATS and PRI for this to work.


	Joerg
