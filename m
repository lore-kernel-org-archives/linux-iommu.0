From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3] iommu/arm-smmu: Plumb in new ACPI identifiers
Date: Wed, 21 Jun 2017 10:27:45 +0100
Message-ID: <20170621092744.GG3768@arm.com>
References: <063a50cff2942c96dc6f24d4f8c8a854a4a6cc30.1497886335.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <063a50cff2942c96dc6f24d4f8c8a854a4a6cc30.1497886335.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 19, 2017 at 04:41:56PM +0100, Robin Murphy wrote:
> Revision C of IORT now allows us to identify ARM MMU-401 and the Cavium
> ThunderX implementation. Wire them up so that we can probe these models
> once firmware starts using the new codes in place of generic ones, and
> so that the appropriate features and quirks get enabled when we do.
> 
> For the sake of backports and mitigating sychronisation problems with
> the ACPICA headers, we'll carry a backup copy of the new definitions
> locally for the short term to make life simpler.
> 
> CC: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # 4.10
> Acked-by: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Tested-by: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v3: The patch that actually landed in ACPICA was slightly tweaked for
>     self-consistency, so s/CAVIUM_SMMUV2/CAVIUM_THUNDERX/ to match.
> 
>  drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

I've picked this one up.

Will
