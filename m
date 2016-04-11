From: "Wan, Vincent" <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [patch] iommu/amd: Signedness bug in acpihid_device_group()
Date: Mon, 11 Apr 2016 07:22:52 +0000
Message-ID: <DM3PR1201MB10232C2338DEECF7E74AAAA2E6940@DM3PR1201MB1023.namprd12.prod.outlook.com>
References: <20160411071446.GB10739@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160411071446.GB10739@mwanda>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Dan Carpenter [mailto:dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org]
> Sent: Monday, April 11, 2016 3:15 PM
> To: Joerg Roedel; Wan, Vincent
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; kernel-
> janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: [patch] iommu/amd: Signedness bug in acpihid_device_group()
> 
> "devid" needs to be signed for the error handling to work.
> 
> Fixes:b097d11a0fa3f ('iommu/amd: Manage iommu_group for ACPI HID
> devices')
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index c430c10..12f7779 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -283,7 +283,7 @@ static struct iommu_dev_data *get_dev_data(struct
> device *dev)  static struct iommu_group *acpihid_device_group(struct device
> *dev)  {
>  	struct acpihid_map_entry *p, *entry = NULL;
> -	u16 devid;
> +	int devid;

Sure, thanks for your patch.

Wan Zongshun.

> 
>  	devid = get_acpihid_device_id(dev, &entry);
>  	if (devid < 0)
