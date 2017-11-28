From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Add debugfs extension to show
	register contents
Date: Tue, 28 Nov 2017 15:55:07 +0200
Message-ID: <1511877307.25007.467.camel@linux.intel.com>
References: <1511378746-109275-1-git-send-email-sohil.mehta@intel.com>
	<1511378746-109275-5-git-send-email-sohil.mehta@intel.com>
	<1511385559.25007.415.camel@linux.intel.com>
	<2824B99DC70CE746926327C52CA42F76378EA17D@ORSMSX111.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2824B99DC70CE746926327C52CA42F76378EA17D-8oqHQFITsIGkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Kammela, Gayatri" <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Shankar, Ravi V" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu,
	Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2017-11-27 at 20:52 +0000, Kammela, Gayatri wrote:

> > Moreover, see the patch I have just sent [1] and use same
> > DEFINE_SHOW_ATTRIBUTE() macro here. In that case we would easily
> > move it
> > to seq_file.h for everyone to use in the future.
> 
> That makes sense! I see your patch is not merged yet, so really cannot
> reuse the same macro. I will have to redefine it.

Since response from BT maintainer he won't take seq_file.h change, just
go ahead and create a same macro (with the same name) inside your
module.

In next cycle I can easily consolidate them in one patch then against
seq_file.h.

> > [1]: https://marc.info/?l=linux-bluetooth&m=151138535801354&w=2


-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
