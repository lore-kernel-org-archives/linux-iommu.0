From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: return devid as alias for ACPI HID devices
Date: Tue, 25 Sep 2018 15:31:43 +0200
Message-ID: <20180925133143.h46eopc5j7mnw5ac@suse.de>
References: <20180918101058.2365-1-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180918101058.2365-1-arindam.nath-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Arindam,

On Tue, Sep 18, 2018 at 03:40:58PM +0530, Arindam Nath wrote:
> @@ -246,7 +246,13 @@ static u16 get_alias(struct device *dev)
>  
>  	/* The callers make sure that get_device_id() does not fail here */
>  	devid = get_device_id(dev);
> +
> +	/* For ACPI HID devices, we simply return the devid as such */
> +	if (!dev_is_pci(dev))
> +		return devid;
> +

Does this fix some bug? If there is no alias defined for the device-id,
it should just return the correct devid even without that change.

Regards,

	Joerg
