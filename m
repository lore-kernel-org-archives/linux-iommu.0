From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Add support for ARM SMMU architectures 1 and 2
Date: Wed, 26 Jun 2013 11:48:05 +0200
Message-ID: <20130626094805.GS11309@8bytes.org>
References: <1372095086-15681-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372095086-15681-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 24, 2013 at 06:31:23PM +0100, Will Deacon wrote:
> Will Deacon (3):
>   documentation: iommu: add description of ARM System MMU binding
>   iommu: add support for ARM Ltd. System MMU architecture
>   MAINTAINERS: add entry for ARM system MMU driver
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   70 +
>  MAINTAINERS                                        |    6 +
>  drivers/iommu/Kconfig                              |   13 +
>  drivers/iommu/Makefile                             |    1 +
>  drivers/iommu/arm-smmu.c                           | 1969 ++++++++++++++++++++
>  5 files changed, 2059 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt
>  create mode 100644 drivers/iommu/arm-smmu.c

Applied this series to the new arm/smmu branch, thanks Will.
