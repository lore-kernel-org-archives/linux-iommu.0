From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: Using OMAP3 ISP live display and snapshot sample applications
Date: Thu, 23 Feb 2012 18:59:05 +0200
Message-ID: <CAK=Wgbbq_7fmtRxSN+ZSY6X0opPMfR3QLNkBmWxZdXf_91wk5A@mail.gmail.com>
References: <CAOy7-nNSu2v9VS9Bh5O5StvEAvoxA4DqN7KdSGfZZSje1_Fgnw@mail.gmail.com>
	<20120214104436.GU22598@amd.com> <13567544.qv9HnVLVXR@avalon>
	<2017729.C83vkrQlqN@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2017729.C83vkrQlqN@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, James <angweiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Thu, Feb 23, 2012 at 6:38 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> Ping ? I've discussed this with Ohad last week, and we agreed that there was
> indeed an issue with the IOMMU subsystem and/or the OMAP3 IOMMU driver. Could
> you please have a look at my explanation below ?

Oops - for some reason I didn't realize I had an action item, my bad :)

Can you try the below and tell me if it helps ?

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 609ea2d..f992395 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -412,7 +412,7 @@ static void __exit omap2_mbox_exit(void)
        platform_driver_unregister(&omap2_mbox_driver);
 }

-module_init(omap2_mbox_init);
+subsys_initcall(omap2_mbox_init);
 module_exit(omap2_mbox_exit);

 MODULE_LICENSE("GPL v2");


If it works for you I'd prefer something in those lines, because it
makes the problem (and its solution) more visible/explicit.

Anyway I'd only consider this as an interim solution until the
deferred probing mechanism (by Grant) is merged.

Thanks!
Ohad.
