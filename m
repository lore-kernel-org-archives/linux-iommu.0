From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/vt-d: Don't consider copied context entries as
	present
Date: Thu, 11 Jun 2015 16:25:54 +0200
Message-ID: <20150611142554.GG16345@suse.de>
References: <1434030463-942-1-git-send-email-joro@8bytes.org>
	<1434030463-942-3-git-send-email-joro@8bytes.org>
	<1434031622.3907.40.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434031622.3907.40.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: zhen-hual-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 11, 2015 at 03:07:02PM +0100, David Woodhouse wrote:
> On Thu, 2015-06-11 at 15:47 +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > 
> > Hide the copied context entries from the IOMMU driver by
> > considering them as non-present. This is implemented by
> > setting the first AVL bit (bit 67) in the context entry to
> > one. If this bit is set, the context_present() function
> > returns false.
> > 
> > Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> In the extended context entry, bit 67 is the PGE bit. There are no bits
> which are available to software, to my knowledge.

Okay, reading the VT-d spec again, the extended context-entry table seem
to exist in parallel to the current context-entry table, right? So this
patch should still work, even with extended entries present.

If that's true, then we only need to consider the kdump case while
setting up the extended context table entry (which means don't trust any
content that is already there).


	Joerg
