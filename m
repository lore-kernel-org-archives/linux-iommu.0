From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: updates for 3.18
Date: Thu, 25 Sep 2014 15:35:15 +0200
Message-ID: <20140925133515.GA28786@8bytes.org>
References: <20140922131810.GE25809@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140922131810.GE25809-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin.Murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 22, 2014 at 02:18:10PM +0100, Will Deacon wrote:
> Mitchel Humpherys (1):
>       iommu/arm-smmu: fix bug in pmd construction
> 
> Robin Murphy (2):
>       iommu/arm-smmu: fix architecture version detection
>       iommu/arm-smmu: support MMU-401
> 
> Will Deacon (5):
>       iommu/arm-smmu: allow translation stage to be forced on the cmdline
>       iommu/arm-smmu: add support for multi-master iommu groups
>       iommu/arm-smmu: put iommu_domain pointer in dev->archdata.iommu
>       iommu/arm-smmu: use page shift instead of page size to avoid division
>       iommu/arm-smmu: don't bother truncating the s1 output size to VA_BITS
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
>  drivers/iommu/arm-smmu.c                           | 201 ++++++++++++---------
>  2 files changed, 121 insertions(+), 81 deletions(-)

Pulled, thanks Will.
