From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/7] iommu/of: Respect disabled IOMMUs
Date: Tue, 14 Jun 2016 15:11:48 +0100
Message-ID: <20160614141148.GH19407@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <aca0b44206c87f6cb75d156a53e08aa968981119.1464966939.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aca0b44206c87f6cb75d156a53e08aa968981119.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 03, 2016 at 06:15:36PM +0100, Robin Murphy wrote:
> If an IOMMU node is present in the DT but marked as disabled, we should
> avoid trying to do anything with it. We currently sort-of get away with
> this by virtue of a disabled device probably not having called
> of_iommu_set_ops(), but that is hardly safe to rely upon in general, and
> either way we don't want to treat it as an error condition with the
> resulting "Failed to initialise IOMMU" message.

What's the use-case for this? I ask because epapr says that the device
binding should provide details as to exactly what "disabled" means for
that device.

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
