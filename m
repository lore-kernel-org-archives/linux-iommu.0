From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: Using OMAP3 ISP live display and snapshot sample applications
Date: Thu, 23 Feb 2012 19:01:05 +0200
Message-ID: <CAK=WgbY5V=ZxVf2xisWuQbVwFyth9rQ8WaXiMkpjUHnMyyCSvQ@mail.gmail.com>
References: <CAOy7-nNSu2v9VS9Bh5O5StvEAvoxA4DqN7KdSGfZZSje1_Fgnw@mail.gmail.com>
	<20120214104436.GU22598@amd.com> <13567544.qv9HnVLVXR@avalon>
	<2017729.C83vkrQlqN@avalon>
	<CAK=Wgbbq_7fmtRxSN+ZSY6X0opPMfR3QLNkBmWxZdXf_91wk5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAK=Wgbbq_7fmtRxSN+ZSY6X0opPMfR3QLNkBmWxZdXf_91wk5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Thu, Feb 23, 2012 at 6:59 PM, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 609ea2d..f992395 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -412,7 +412,7 @@ static void __exit omap2_mbox_exit(void)
> =A0 =A0 =A0 =A0platform_driver_unregister(&omap2_mbox_driver);
> =A0}
>
> -module_init(omap2_mbox_init);
> +subsys_initcall(omap2_mbox_init);
> =A0module_exit(omap2_mbox_exit);
>
> =A0MODULE_LICENSE("GPL v2");

And this, too:

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4e661f0..95adb7e 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1222,7 +1222,7 @@ static int __init omap_iommu_init(void)

        return platform_driver_register(&omap_iommu_driver);
 }
-module_init(omap_iommu_init);
+subsys_initcall(omap_iommu_init);

 static void __exit omap_iommu_exit(void)
 {
