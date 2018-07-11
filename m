From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] xtensa: use generic dma_noncoherent_ops
Date: Wed, 11 Jul 2018 10:57:30 -0700
Message-ID: <CAMo8BfKzV6fhANk=ymsWFWoVtsYq3wXh559==rfjG2FimEC3+g@mail.gmail.com>
References: <20180619070316.26327-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180619070316.26327-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Tue, Jun 19, 2018 at 12:03 AM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> Switch to the generic noncoherent direct mapping implementation.
>
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/xtensa/Kconfig                   |   3 +
>  arch/xtensa/include/asm/Kbuild        |   1 +
>  arch/xtensa/include/asm/dma-mapping.h |  26 ------
>  arch/xtensa/kernel/pci-dma.c          | 130 +++-----------------------
>  4 files changed, 19 insertions(+), 141 deletions(-)
>  delete mode 100644 arch/xtensa/include/asm/dma-mapping.h
>
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index d575e8701955..373708c77367 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -5,11 +5,14 @@ config ZONE_DMA
>  config XTENSA
>         def_bool y
>         select ARCH_NO_COHERENT_DMA_MMAP if !MMU
> +       select ARCH_HAS_SYNC_DMA_FOR_CPU
> +       select ARCH_HAS_SYNC_DMA_FOR_DEVICE

This breaks alphabetical order of selects. Otherwise LGTM.
Sorry for the delay.
Acked-by: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Will you submit it further or should I take it into the xtensa tree?
-- 
Thanks.
-- Max
