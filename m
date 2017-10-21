From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
	from devices
Date: Sat, 21 Oct 2017 11:47:53 -0400
Message-ID: <683a518d-0e22-c855-2416-2e097ec3291d@codeaurora.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
	<20171006133203.22803-6-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171006133203.22803-6-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Just some improvement suggestions.

On 10/6/2017 9:31 AM, Jean-Philippe Brucker wrote:
> +	spin_lock(&iommu_process_lock);
> +	idr_for_each_entry(&iommu_process_idr, process, i) {
> +		if (process->pid != pid)
> +			continue;
if you see this construct a lot, this could be a for_each_iommu_process.

> +
> +		if (!iommu_process_get_locked(process)) {
> +			/* Process is defunct, create a new one */
> +			process = NULL;
> +			break;
> +		}
> +
> +		/* Great, is it also bound to this domain? */
> +		list_for_each_entry(cur_context, &process->domains,
> +				    process_head) {
> +			if (cur_context->domain != domain)
> +				continue;
if you see this construct a lot, this could be a for_each_iommu_process_domain.

> +
> +			context = cur_context;
> +			*pasid = process->pasid;
> +
> +			/* Splendid, tell the driver and increase the ref */
> +			err = iommu_process_attach_locked(context, dev);
> +			if (err)
> +				iommu_process_put_locked(process);
> +
> +			break;
> +		}
> +		break;
> +	}
> +	spin_unlock(&iommu_process_lock);
> +	put_pid(pid);
> +
> +	if (context)
> +		return err;

I think you should make the section above a independent function and return here when the
context is found.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
