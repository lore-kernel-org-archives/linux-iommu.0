From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Fix leaks in pagetable freeing
Date: Sat, 5 Oct 2013 16:41:48 -0700
Message-ID: <20131005234148.GB18223@kroah.com>
References: <20130615161614.2107.41044.stgit@bling.home>
	<20131002084431.GA20568@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131002084431.GA20568-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 02, 2013 at 10:44:31AM +0200, Borislav Petkov wrote:
> On Sat, Jun 15, 2013 at 10:27:19AM -0600, Alex Williamson wrote:
> > At best the current code only seems to free the leaf pagetables and
> > the root.  If you're unlucky enough to have a large gap (like any
> > QEMU guest with more than 3G of memory), only the first chunk of leaf
> > pagetables are freed (plus the root).  This is a massive memory leak.
> > This patch re-writes the pagetable freeing function to use a
> > recursive algorithm and manages to not only free all the pagetables,
> > but does it without any apparent performance loss versus the current
> > broken version.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > ---
> > 
> > Suggesting for stable, would like to see some soak time, but it's
> > hard to imagine this being any worse than the current code.
> 
> Btw, I have a backport for the 3.0.x series which builds fine here, in
> case you guys are interested :)

Thanks, now applied.

greg k-h
