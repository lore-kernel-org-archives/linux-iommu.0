From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] iommu: Disambiguate MSI region types
Date: Wed, 22 Mar 2017 16:16:42 +0100
Message-ID: <20170322151642.GD7315@8bytes.org>
References: <cover.1489683129.git.robin.murphy@arm.com>
	<a56c76f7276a12120ecd0675be4c69de58aec8ff.1489683129.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a56c76f7276a12120ecd0675be4c69de58aec8ff.1489683129.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 16, 2017 at 05:00:16PM +0000, Robin Murphy wrote:
> The introduction of reserved regions has left a couple of rough edges
> which we could do with sorting out sooner rather than later. Since we
> are not yet addressing the potential dynamic aspect of software-managed
> reservations and presenting them at arbitrary fixed addresses, it is
> incongruous that we end up displaying hardware vs. software-managed MSI
> regions to userspace differently, especially since ARM-based systems may
> actually require one or the other, or even potentially both at once,
> (which iommu-dma currently has no hope of dealing with at all). Let's
> resolve the former user-visible inconsistency ASAP before the ABI has
> been baked into a kernel release, in a way that also lays the groundwork
> for the latter shortcoming to be addressed by follow-up patches.
> 
> For clarity, rename the software-managed type to IOMMU_RESV_SW_MSI, use
> IOMMU_RESV_MSI to describe the hardware type, and document everything a
> little bit. Since the x86 MSI remapping hardware falls squarely under
> this meaning of IOMMU_RESV_MSI, apply that type to their regions as well,
> so that we tell the same story to userspace across all platforms.
> 
> Secondly, as the various region types require quite different handling,
> and it really makes little sense to ever try combining them, convert the
> bitfield-esque #defines to a plain enum in the process before anyone
> gets the wrong impression.
> 
> Fixes: d30ddcaa7b02 ("iommu: Add a new type field in iommu_resv_region")
> Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> CC: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> CC: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> CC: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Applied this one to iommu/fixes.
