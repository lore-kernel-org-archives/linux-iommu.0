From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: IO_PAGE_FAULTs on unity mapped regions during amd_iommu_init()
	in Linux 3.4
Date: Mon, 11 Feb 2013 11:49:01 -0800
Message-ID: <20130211194901.GA18115@kroah.com>
References: <1359657210.6061.3.camel@lorien2>
	<20130201130035.GE25591@8bytes.org>
	<1359743519.2759.38.camel@lorien2>
	<20130205133104.GC2532@8bytes.org>
	<CAKocOOO6Z2LyLYiuQMWf4iv4PAP8h5jbNWxRcSXKgXD1es6GYg@mail.gmail.com>
	<20130206121223.GT25591@8bytes.org>
	<1360204850.2615.10.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360204850.2615.10.camel@lorien2>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 06, 2013 at 07:40:50PM -0700, Shuah Khan wrote:
> On Wed, 2013-02-06 at 13:12 +0100, Joerg Roedel wrote:
> > On Tue, Feb 05, 2013 at 06:57:21AM -0700, Shuah Khan wrote:
> > > Thanks much. I will hang on to this test system for testing your fix.
> > 
> > Okay, here is the simple fix for v3.8-rc6. I guess it is not
> > straighforward to port it to v3.4, but it should be doable.
> > 
> > From 2ecf57c85e67e0243b36b787d0490c0b47202ba8 Mon Sep 17 00:00:00 2001
> > From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> > Date: Wed, 6 Feb 2013 12:55:23 +0100
> > Subject: [PATCH] iommu/amd: Initialize device table after dma_ops
> > 
> > When dma_ops are initialized the unity mappings are
> > created. The init_device_table_dma() function makes sure DMA
> > from all devices is blocked by default. This opens a short
> > window in time where DMA to unity mapped regions is blocked
> > by the IOMMU. Make sure this does not happen by initializing
> > the device table after dma_ops.
> > 
> > Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> 
> Joerg,
> 
> I tested your patch on 3.8. I was able to reproduce the problem and then
> apply your patch to verify that the problem is fixed. This patch applies
> cleanly to 3.7.6, however I could not reproduce the problem on 3.7.6
> without the patch. But the window exists on 3.7 as well. Your patch can
> be applied to 3.7.6 as is.
> 
> I back-ported the patch to 3.4 and 3.0 and tested. I am sending those
> patches after this email.
> 
> On 3.4.29 and 3.0.62 I was able to reproduce the problem and then
> applied the back-ported patch to verify that the problem is fixed.
> 
> Thanks again for the fix.

I'm lost here, why isn't this patch in Linus's tree already?  You seem
to be sending backports for something that isn't there to backport yet.

Please resend these patches to stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, with the upstream
git commit id, when they are in Linus's tree, there's nothing I can do
with them for now, sorry.

greg k-h
