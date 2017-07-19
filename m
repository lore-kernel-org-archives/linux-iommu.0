From: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] Optimise 64-bit IOVA allocations
Date: Wed, 19 Jul 2017 09:37:43 +0100
Message-ID: <CAKv+Gu8x1ssF0g-e=ycpfy6jw8mNfVrx5VQJhjtz2D9Gd4zA-Q@mail.gmail.com>
References: <cover.1500396007.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1500396007.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 18 July 2017 at 17:57, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi all,
>
> In the wake of the ARM SMMU optimisation efforts, it seems that certain
> workloads (e.g. storage I/O with large scatterlists) probably remain quite
> heavily influenced by IOVA allocation performance. Separately, Ard also
> reported massive performance drops for a graphical desktop on AMD Seattle
> when enabling SMMUs via IORT, which we traced to dma_32bit_pfn in the DMA
> ops domain getting initialised differently for ACPI vs. DT, and exposing
> the overhead of the rbtree slow path. Whilst we could go around trying to
> close up all the little gaps that lead to hitting the slowest case, it
> seems a much better idea to simply make said slowest case a lot less slow.
>
> I had a go at rebasing Leizhen's last IOVA series[1], but ended up finding
> the changes rather too hard to follow, so I've taken the liberty here of
> picking the whole thing up and reimplementing the main part in a rather
> less invasive manner.
>
> Robin.
>
> [1] https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg17753.html
>
> Robin Murphy (1):
>   iommu/iova: Extend rbtree node caching
>
> Zhen Lei (3):
>   iommu/iova: Optimise rbtree searching
>   iommu/iova: Optimise the padding calculation
>   iommu/iova: Make dma_32bit_pfn implicit
>
>  drivers/gpu/drm/tegra/drm.c      |   3 +-
>  drivers/gpu/host1x/dev.c         |   3 +-
>  drivers/iommu/amd_iommu.c        |   7 +--
>  drivers/iommu/dma-iommu.c        |  18 +------
>  drivers/iommu/intel-iommu.c      |  11 ++--
>  drivers/iommu/iova.c             | 112 ++++++++++++++++-----------------------
>  drivers/misc/mic/scif/scif_rma.c |   3 +-
>  include/linux/iova.h             |   8 +--
>  8 files changed, 60 insertions(+), 105 deletions(-)
>

These patches look suspiciously like the ones I have been using over
the past couple of weeks (modulo the tegra and host1x changes) from
your git tree. They work fine on my AMD Overdrive B1, both in DT and
in ACPI/IORT modes, although it is difficult to quantify any
performance deltas on my setup.

Tested-by: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
