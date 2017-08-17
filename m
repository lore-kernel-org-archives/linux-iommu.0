From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: Avoid NULL group dereference
Date: Thu, 17 Aug 2017 17:41:01 +0200
Message-ID: <20170817154101.GL16908@8bytes.org>
References: <59a6c4f0a790eea40e2b2f2be840b63317dd44e4.1502966326.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59a6c4f0a790eea40e2b2f2be840b63317dd44e4.1502966326.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 17, 2017 at 11:40:08AM +0100, Robin Murphy wrote:
> The recently-removed FIXME in iommu_get_domain_for_dev() turns out to
> have been a little misleading, since that check is still worthwhile even
> when groups *are* universal. We have a few IOMMU-aware drivers which
> only care whether their device is already attached to an existing domain
> or not, for which the previous behaviour of iommu_get_domain_for_dev()
> was ideal, and who now crash if their device does not have an IOMMU.
> 
> With IOMMU groups now serving as a reliable indicator of whether a
> device has an IOMMU or not (barring false-positives from VFIO no-IOMMU
> mode), drivers could arguably do this:
> 
> 	group = iommu_group_get(dev);
> 	if (group) {
> 		domain = iommu_get_domain_for_dev(dev);
> 		iommu_group_put(group);
> 	}

Okay, so just to check I got it right: Drivers do the above to check
whether a device is managed by an IOMMU, and that crashes now because
the 'group == NULL' check was removed?

Regards,

	Joerg
