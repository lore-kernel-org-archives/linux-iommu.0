From: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/amd: initialize devid variable before using it
Date: Mon, 27 Jun 2016 10:16:16 +0800
Message-ID: <CAKT61h8DfWHy2sbAx7JZ=Wj1QVw5oDZfiB--8cO9ii+6ZbioHQ@mail.gmail.com>
References: <20160626083329.674-1-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160626083329.674-1-nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

2016-06-26 16:33 GMT+08:00 Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>:
> Commit 2a0cb4e2d423 ("iommu/amd: Add new map for storing IVHD dev entry
> type HID") added a call to DUMP_printk in init_iommu_from_acpi() which
> used the value of devid before this variable was initialized.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 9e0034196e10..d091defc3426 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1107,13 +1107,13 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
>                                 break;
>                         }
>
> +                       devid = e->devid;
>                         DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %02x:%02x.%x\n",
>                                     hid, uid,
>                                     PCI_BUS_NUM(devid),
>                                     PCI_SLOT(devid),
>                                     PCI_FUNC(devid));
>
> -                       devid  = e->devid;
>                         flags = e->flags;
>

Sure, thanks for your patch.
This is my fault.

>                         ret = add_acpi_hid_device(hid, uid, &devid, false);
> --
> 2.9.0
>



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
