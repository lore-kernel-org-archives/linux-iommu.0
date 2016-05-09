From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 4.7
Date: Mon, 9 May 2016 12:06:15 +0200
Message-ID: <20160509100615.GE9801@suse.de>
References: <20160504134531.GA31744@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160504134531.GA31744-5wv7dgnIgG8@public.gmane.org>
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
Cc: arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 04, 2016 at 02:45:31PM +0100, Will Deacon wrote:
> Peng Fan (1):
>       iommu/arm-smmu: Clear cache lock bit of ACR
> 
> Robin Murphy (7):
>       iommu/arm-smmu: Differentiate specific implementations
>       iommu/arm-smmu: Convert ThunderX workaround to new method
>       iommu/arm-smmu: Work around MMU-500 prefetch errata
>       io-64-nonatomic: Add relaxed accessor variants
>       iommu/arm-smmu: Tidy up 64-bit/atomic I/O accesses
>       iommu/arm-smmu: Decouple context format from kernel config
>       iommu/arm-smmu: Support SMMUv1 64KB supplement
> 
> Tirumalesh Chalamarla (2):
>       iommu/arm-smmu: Add support for 16 bit VMID
>       iommu/arm-smmu: Workaround for ThunderX erratum #27704
> 
>  Documentation/arm64/silicon-errata.txt             |   2 +
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
>  drivers/iommu/arm-smmu.c                           | 291 +++++++++++++++------
>  include/asm-generic/io.h                           |   4 +-
>  include/linux/io-64-nonatomic-hi-lo.h              |  25 ++
>  include/linux/io-64-nonatomic-lo-hi.h              |  25 ++
>  6 files changed, 265 insertions(+), 83 deletions(-)

Pulled, thanks Will.
