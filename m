From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Clean up address masking
Date: Mon, 26 Feb 2018 18:04:56 +0000
Message-ID: <20180226180455.GB26147@arm.com>
References: <cover.1512038236.git.robin.murphy@arm.com>
	<24f90689e35a90a337601943a48902a7ab6a7c4d.1512038236.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <24f90689e35a90a337601943a48902a7ab6a7c4d.1512038236.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kristina.martsenko-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Thu, Dec 14, 2017 at 04:58:50PM +0000, Robin Murphy wrote:
> Before trying to add the SMMUv3.1 support for 52-bit addresses, make
> things bearable by cleaning up the various address mask definitions to
> use GENMASK_ULL() consistently. The fact that doing so reveals (and
> fixes) a latent off-by-one in Q_BASE_ADDR_MASK only goes to show what a
> jolly good idea it is...
> 
> Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: Clean up one more now-unnecessary linewrap
> 
>  drivers/iommu/arm-smmu-v3.c | 53 ++++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 32 deletions(-)

Whilst I agree that using GENMASK is better, this patch does mean that the
driver is (more) inconsistent with its _MASK terminology in that you can't
generally tell whether a definition that ends in _MASK is shifted or not,
and this isn't even consistent for fields within the same register.

Should we be using GENMASK/BIT for all fields instead and removing all of
the _SHIFT definitions?

Will
