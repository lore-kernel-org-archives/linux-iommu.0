From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: Using OMAP3 ISP live display and snapshot sample applications
Date: Thu, 09 Feb 2012 08:25:27 +0100
Message-ID: <1717097.bU1IFGjUNt@avalon>
References: <CAOy7-nNSu2v9VS9Bh5O5StvEAvoxA4DqN7KdSGfZZSje1_Fgnw@mail.gmail.com>
	<201201111041.06017.laurent.pinchart@ideasonboard.com>
	<CAOy7-nOrTESdfG+_njJgcVUAiLuks_21=GFMBK-2b5mK9UJwpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOy7-nOrTESdfG+_njJgcVUAiLuks_21=GFMBK-2b5mK9UJwpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: James <angweiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi James,

(CC'ing Ohad, Joerg and the IOMMU mailing list)

On Wednesday 08 February 2012 16:29:14 James wrote:
>
> I baked a new kernel from your branch using OE & your defconfig but I got a
> "Kernel Panic" when booting it.
> 
> Attached is the console log from the Overo+Tobi board+Caspa setup.
> 
> Can you advise my next course of resolution?

Does the following patch fix the problem ?

diff --git a/drivers/Makefile b/drivers/Makefile
index 1b31421..2ec48f2 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_XEN)		+= xen/
 
 # regulators early, since some subsystems rely on them to initialize
 obj-$(CONFIG_REGULATOR)		+= regulator/
+obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
 
 # tty/ comes before char/ so that the VT console is the boot-time
 # default.
@@ -125,7 +126,6 @@ obj-y				+= clk/
 
 obj-$(CONFIG_HWSPINLOCK)	+= hwspinlock/
 obj-$(CONFIG_NFC)		+= nfc/
-obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
 
 # Virtualization drivers
 obj-$(CONFIG_VIRT_DRIVERS)	+= virt/

Ohad, Joerg, would this be an acceptable fix ? If so I'll submit a patch.

-- 
Regards,

Laurent Pinchart
