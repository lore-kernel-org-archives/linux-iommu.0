From: "Lukoshkov, Maksim" <maksim.lukoshkov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 05/16] iommu/vt-d: support flushing more TLB types
Date: Mon, 20 Nov 2017 14:20:31 +0000
Message-ID: <04788a00-2075-7975-2f13-b9e032688305@intel.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-6-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1510944914-54430-6-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org" <Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/17/2017 18:55, Jacob Pan wrote:
> +void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +			u16 qdep, u64 addr, unsigned mask)
> +{
> +	struct qi_desc desc;
> +
> +	pr_debug_ratelimited("%s: sid %d, pfsid %d, qdep %d, addr %llx, mask %d\n",
> +		__func__, sid, pfsid, qdep, addr, mask);
>   	if (mask) {
>   		BUG_ON(addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1));
>   		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
> @@ -1352,7 +1366,41 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
>   		qdep = 0;
>   
>   	desc.low = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
> -		   QI_DIOTLB_TYPE;
> +		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_SID(pfsid);

QI_DEV_IOTLB_SID(pfsid) -> QI_DEV_EIOTLB_PFSID(pfsid)?

> +
> +	qi_submit_sync(&desc, iommu);
> +}
> +

Regards,
Maksim Lukoshkov
