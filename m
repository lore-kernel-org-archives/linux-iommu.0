From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 0/5] Generic IOMMU page table framework
Date: Fri, 16 Jan 2015 14:01:31 +0000
Message-ID: <20150116140130.GQ7091@arm.com>
References: <1420811657-21321-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420811657-21321-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 09, 2015 at 01:54:12PM +0000, Will Deacon wrote:
> This is version two of the patch series I originally posted here:
> 
>   v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306786.html
> 
> Changes since v1 include:
> 
>  - Separated 32-bit and 64-bit regimes
>  - Limited pgd allocation when a full page is not required
>  - Addition of NS quirk, needed by Laurent for the Renesas IOMMU
>  - Added kerneldoc for the API to IOMMU drivers
>  - A few minor changes after feedback on the list
> 
> All feedback welcome,

I've not received any feedback on this revision of the series, but it's
working well for me and Laurent showed that it works with his IOMMU too.

Joerg -- can I include this in my pull request for 3.20, or is there
anything further you'd like me to address? The code is completely
self-contained, so I wouldn't expect any impact on IOMMU drivers that
don't explicitly use the new page table API.

Thanks,

Will

> --->8
> 
> Laurent Pinchart (1):
>   iommu: io-pgtable-arm: add non-secure quirk
> 
> Will Deacon (4):
>   iommu: introduce generic page table allocation framework
>   iommu: add ARM LPAE page table allocator
>   iommu: add self-consistency tests to ARM LPAE IO page table allocator
>   iommu/arm-smmu: make use of generic LPAE allocator
> 
>  MAINTAINERS                    |   1 +
>  arch/arm64/Kconfig             |   1 -
>  drivers/iommu/Kconfig          |  32 +-
>  drivers/iommu/Makefile         |   2 +
>  drivers/iommu/arm-smmu.c       | 886 +++++++++++-------------------------
>  drivers/iommu/io-pgtable-arm.c | 986 +++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c     |  82 ++++
>  drivers/iommu/io-pgtable.h     | 143 ++++++
>  8 files changed, 1506 insertions(+), 627 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm.c
>  create mode 100644 drivers/iommu/io-pgtable.c
>  create mode 100644 drivers/iommu/io-pgtable.h
> 
> -- 
> 2.1.4
> 
