From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Using OMAP3 ISP live display and snapshot sample applications
Date: Fri, 10 Feb 2012 16:10:18 +0100
Message-ID: <20120210151018.GS22598@amd.com>
References: <CAOy7-nNSu2v9VS9Bh5O5StvEAvoxA4DqN7KdSGfZZSje1_Fgnw@mail.gmail.com>
	<201201111041.06017.laurent.pinchart@ideasonboard.com>
	<CAOy7-nOrTESdfG+_njJgcVUAiLuks_21=GFMBK-2b5mK9UJwpg@mail.gmail.com>
	<1717097.bU1IFGjUNt@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1717097.bU1IFGjUNt@avalon>
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
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, James <angweiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 09, 2012 at 08:25:27AM +0100, Laurent Pinchart wrote:
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 1b31421..2ec48f2 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_XEN)		+= xen/
>  
>  # regulators early, since some subsystems rely on them to initialize
>  obj-$(CONFIG_REGULATOR)		+= regulator/
> +obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
>  
>  # tty/ comes before char/ so that the VT console is the boot-time
>  # default.
> @@ -125,7 +126,6 @@ obj-y				+= clk/
>  
>  obj-$(CONFIG_HWSPINLOCK)	+= hwspinlock/
>  obj-$(CONFIG_NFC)		+= nfc/
> -obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
>  
>  # Virtualization drivers
>  obj-$(CONFIG_VIRT_DRIVERS)	+= virt/
> 
> Ohad, Joerg, would this be an acceptable fix ? If so I'll submit a patch.

I also want to understand the problem first. Can you provide some
context?


	Joerg


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
