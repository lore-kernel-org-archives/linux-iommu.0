From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv7 10/12] iommu/tegra: smmu: allow duplicate ASID wirte
Date: Mon, 16 Dec 2013 12:19:37 -0700
Message-ID: <52AF5249.6050802@wwwdotorg.org>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
	<1386835033-4701-11-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386835033-4701-11-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> The device, which belongs to the same ASID, can try to enable the same
> ASID as the other swgroup devices. This should be allowed but just
> skip the actual register write. If the write value is different, it
> will return -EINVAL.

I guess this simplifies the body of the code a lot. Given this, I would
revise the code I suggested in response to a previous patch, to
something more like:

		offs = HWGRP_ASID_REG(i);
		val = smmu_read(smmu, offs);
		if (on) {
			if (WARN_ON(val && val != new_val))
				return -ENODEV;
			memcpy(c->hwgrp, map, sizeof(u64));
		} else {
			WARN_ON(val);
		}
		smmu_write(smmu, val, offs);

> +			if (val) {
> +				if (WARN_ON(val != mask))
> +					return -EINVAL;
> +				goto skip;

That means that:

a) No error is returned when the ASIDs don't match. Surely you still
want to return an error?

b) "skip" skips setting up all HWGRP IDs for the device, whereas perhaps
only 1 was shared yet the rest still need to be set up. If you really do
want to ignore the error, then surely you want "continue;" here not
"goto skip;"?

> +			}
...
> +skip:
>  	return 0;
