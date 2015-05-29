From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] iommu/arm=smmu: Add driver for ARM SMMUv3 devices
Date: Fri, 29 May 2015 11:15:37 +0200
Message-ID: <20150529091537.GH13130@8bytes.org>
References: <1432743960-25205-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432743960-25205-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark.Rutland-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 27, 2015 at 05:25:57PM +0100, Will Deacon wrote:
> Will Deacon (3):
>   Documentation: dt-bindings: Add device-tree binding for ARM SMMUv3
>     IOMMU
>   iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices
>   drivers/vfio: Allow type-1 IOMMU instantiation on top of an ARM SMMUv3
> 
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   37 +
>  MAINTAINERS                                        |    3 +-
>  drivers/iommu/Kconfig                              |   13 +
>  drivers/iommu/Makefile                             |    1 +
>  drivers/iommu/arm-smmu-v3.c                        | 2670 ++++++++++++++++++++
>  drivers/vfio/Kconfig                               |    2 +-
>  6 files changed, 2724 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>  create mode 100644 drivers/iommu/arm-smmu-v3.c

Applied, thanks.
