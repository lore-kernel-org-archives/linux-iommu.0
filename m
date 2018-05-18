From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: arc dma mapping cleanups/fixes and generic noncohernt dma code
Date: Fri, 18 May 2018 14:49:36 +0000
Message-ID: <dfa0f4a194553f9bdd7bf4d56ac75d91cedc2609.camel@synopsys.com>
References: <20180518134545.5036-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180518134545.5036-1-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <22E6DD384DB708419DE976E2DECD507B-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Fri, 2018-05-18 at 15:45 +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series continues consolidating the dma-mapping code, with a focus
> on architectures that do not (always) provide cache coherence for DMA.
> Three architectures (arm, mips and powerpc) are still left to be
> converted later due to complexity of their dma ops selection.
> 
> The dma-noncoherent ops calls the dma-direct ops for the actual
> translation of streaming mappins and allow the architecture to provide
> any cache flushing required for cpu to device and/or device to cpu
> ownership transfers.  The dma coherent allocator is for now still left
> entirely to architecture supplied implementations due the amount of
> variations.  Hopefully we can do some consolidation for them later on
> as well.
> 
> Because this series sits on top of two previously submitted series
> a git tree might be useful to actually test it.  It is provided here:
> 
>     git://git.infradead.org/users/hch/misc.git arc-dma
> 
> Gitweb:
> 
>     https://urldefense.proofpoint.com/v2/url?u=http-3A__git.infradead.org_users_hch_misc.git_shortlog_refs_heads_arc-2Ddma&d=DwIBAg&c=DPL6_X_6JkXFx7
> AXWqB0tg&r=lqdeeSSEes0GFDDl656eViXO7breS55ytWkhpk5R81I&m=QNC0zOG4bRotSxdjQfFXl0dAQJCtnxtF9435wAuJlu0&s=Wad1ptsFpknoSn0ebr3_QMJn9G_D3eIS-LYMwGfOJ-
> I&e=
> 
> Changes since previous bigger series:
>  - take the offset into account in noncoherent_dma_map_page (Alexey Brodkin)
>  - fix dma directions in arc (Alexey Brodkin)
>  - split arc changes into smaller patches

I really like this series especially how it trimmed down arch/arc/mm/dma.c:
---------------------------->8----------------------------
git diff --stat HEAD~4
 arch/arc/Kconfig                   |   4 +++
 arch/arc/include/asm/Kbuild        |   1 +
 arch/arc/include/asm/dma-mapping.h |  21 ---------------
 arch/arc/mm/cache.c                |   2 +-
 arch/arc/mm/dma.c                  | 162 ++++++++++------------------------------------------------------------------------------------------------
---------
---------------------------->8----------------------------

So if we set aside my complaints about direction in arch_sync_dma_for_{device|cpu}()...

Tested-by: Alexey Brodkin <abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>

Let's still wait for Vineet's ack as he's the chief maintainer for ARC :)

-Alexey 
