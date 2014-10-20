From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/3] iommu: replace IOMMU_EXEC with IOMMU_EXEC and update
	ARM SMMU driver
Date: Mon, 20 Oct 2014 19:42:01 +0100
Message-ID: <20141020184201.GA1455@arm.com>
References: <1413205579-6124-1-git-send-email-a.motakis@virtualopensystems.com>
	<20141020153915.GH20301@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141020153915.GH20301-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 20, 2014 at 04:39:15PM +0100, Will Deacon wrote:
> On Mon, Oct 13, 2014 at 02:06:15PM +0100, Antonios Motakis wrote:
> > This patch series applies to Joerg Roedel's iommu/next branch, commit 09b5269a.
> > It replaces the IOMMU_EXEC flag used by the ARM SMMU driver to IOMMU_NOEXEC.
> > This is more enforceable, since the lack of the flag on hardware that doesn't
> > support it implies that the target memory will be executable.
> 
> Looks good to me; I'll take this via the arm-smmu tree and send it to Joerg
> along with anything else that gets queued for 3.19.

The 0-day builder spotted a new warning from this series:

   drivers/iommu/amd_iommu.c: In function 'amd_iommu_capable':
>> drivers/iommu/amd_iommu.c:3409:2: warning: enumeration value 'IOMMU_CAP_NOEXEC' not handled in switch [-Wswitch]
     switch (cap) {
     ^

I fixed it with the patch below, but I'd appreciate you and Joerg taking
a look too.

Cheers,

Will

--->8

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 505a9adac2d5..3d78a8fb5a6a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3411,6 +3411,8 @@ static bool amd_iommu_capable(enum iommu_cap cap)
                return true;
        case IOMMU_CAP_INTR_REMAP:
                return (irq_remapping_enabled == 1);
+       case IOMMU_CAP_NOEXEC:
+               return false;
        }
 
        return false;
