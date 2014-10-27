From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] arm: dma-mapping: fix compilation error when CONFIG_MMU is
	not present
Date: Mon, 27 Oct 2014 12:59:44 +0100
Message-ID: <544E33B0.4020405@samsung.com>
References: <1413734340-53108-1-git-send-email-stefan.hengelein@fau.de>
	<5444BCFF.8030803@samsung.com>
	<CABv5NL_GdtZegpw8wxau9oD6xXWdX3GUySLqCaoaoa549Kg_GQ@mail.gmail.com>
	<5445A345.7010401@codeaurora.org> <5448B930.7070800@samsung.com>
	<CABv5NL_E83CgBcHbAqo9xejWAEamO3oxX6ZjU+fo9X6k4cE_1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CABv5NL_E83CgBcHbAqo9xejWAEamO3oxX6ZjU+fo9X6k4cE_1w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stefan Hengelein <stefan.hengelein-d40JDW7QUjc@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Valentin Rothberg <valentinrothberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-10-24 15:15, Stefan Hengelein wrote:
> Hello,
>
> adding a dependency to CONFIG_ARM_DMA_USE_IOMMU is probably not a good
> idea anyways.
> If you read the Documentation/kbuild/kconfig-language.txt, you will see that:
> 1. in general, selected options should have no prompt and no dependencies
> 2. giving ARM_DMA_USE_IOMMU a dependency on MMU will and cannot solve
> the problem, since ARM_DMA_USE_IOMMU itself is selected by several
> sources and select will not enforce dependencies to be resolved (to be
> precise, it will simply ignore them). Thus, CONFIG_MMU will not be
> enabled (as you can see in your warning).
> If you want to ensure CONFIG_MMU is enabled when
> CONFIG_ARM_DMA_USE_IOMMU is selected, the selecting options (e.g.
> SHMOBILE_IOMMU) should have a dependency on MMU.
> However, i'm not sure if that's the right way to solve it, since it
> will hide these options when MMU is not enabled.
>
> Making the whole IOMMU subsystem depend on MMU would probably also
> solve the problem. Is there any situation where it would make sense to
> use an IOMMU without an MMU?

IMHO such configuration doesn't make sense and hiding IOMMU section
completely when non-MMU systems are enabled is the right approach.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
