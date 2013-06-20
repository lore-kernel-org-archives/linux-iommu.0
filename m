From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] amd_iommu: Fix leak in free_pagetable()
Date: Thu, 20 Jun 2013 22:04:06 +0200
Message-ID: <20130620200406.GE11309@8bytes.org>
References: <20130618014459.20440.73844.stgit@bling.home>
	<20130618015116.20711.90269.stgit@bling.home>
	<20130620182808.GC11309@8bytes.org>
	<1371755280.30572.4.camel@ul30vt.home>
	<20130620192638.GD11309@8bytes.org>
	<1371757608.30572.18.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371757608.30572.18.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 20, 2013 at 01:46:48PM -0600, Alex Williamson wrote:
> But that's true of a bug in any kernel code.  I think the only danger
> unique to recursion is using too much stack space, but I doubt that's
> really an issue for a tiny function with a fixed depth like this.  In
> case you didn't notice, I did send a recursive version along with the
> flat version, but I stupidly used the same subject for both.  It's a
> little less code and a tiny bit easier to understand than the macro
> version.  Up to you though.

Well, the limited kernel stack is exactly the problem for an
unterminating recursion. The size of the stack-footprint does also not
really matter in this situation, the code will overwrite random kernel
memory when the stack overflows. And that memory could potentially
contain data that is about to be written to disk and destroy file
systems.


	Joerg
