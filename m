From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC 3/3] iommu: dma-iommu: use common implementation also on ARM
	architecture
Date: Tue, 15 Mar 2016 13:03:04 +0100
Message-ID: <56E7F9F8.6030203@samsung.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
	<1455870164-25337-4-git-send-email-m.szyprowski@samsung.com>
	<CANqRtoRiZOPhCBo38zVLL6tQB2aBLy3uWWbqJJypxEFDXJwF1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CANqRtoRiZOPhCBo38zVLL6tQB2aBLy3uWWbqJJypxEFDXJwF1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2016-03-15 12:18, Magnus Damm wrote:
> Hi Marek,
>
> On Fri, Feb 19, 2016 at 5:22 PM, Marek Szyprowski
> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> This patch replaces ARM-specific IOMMU-based DMA-mapping implementation
>> with generic IOMMU DMA-mapping code shared with ARM64 architecture. The
>> side-effect of this change is a switch from bitmap-based IO address space
>> management to tree-based code. There should be no functional changes
>> for drivers, which rely on initialization from generic arch_setup_dna_ops()
>> interface. Code, which used old arm_iommu_* functions must be updated to
>> new interface.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
> Thanks for your efforts and my apologies for late comments. Just FYI
> I'll try your patch (and this series) with the ipmmu-vmsa.c driver on
> 32-bit ARM and see how it goes. Nice not to have to support multiple
> interfaces depending on architecture!

Thanks for testing!

> One question that comes to mind is how to handle features.
>
> For instance, the 32-bit ARM code supports DMA_ATTR_FORCE_CONTIGUOUS
> while the shared code in drivers/iommu/dma-iommu.c does not. I assume
> existing users may rely on such features so from my point of view it
> probably makes sense to carry over features from the 32-bit ARM code
> into the shared code before pulling the plug.

Right, this has to be added to common code before merging.

> I also wonder if it is possible to do a step-by-step migration and
> support both old and new interfaces in the same binary? That may make
> things easier for multiplatform enablement. So far I've managed to
> make one IOMMU driver support both 32-bit ARM and 64-bit ARM with some
> ugly magic, so adjusting 32-bit ARM dma-mapping code to coexist with
> the shared code in drivers/iommu/dma-iommu.c may also be possible. And
> probably involving even more ugly magic. =)

Having one IOMMU driver for both 32-bit and 64-bit ARM archs is quite easy
IF you rely on the iommu core to setup everything. See exynos-iommu driver
- after my last patches it now works fine on both archs (using arch
specific interfaces). Most of the magic is done automatically by
arch_setup_dma_ops().

The real problem is the fact that there are drivers (like DRM) which rely
on specific dma-mapping functions from ARM architecture, which need to be
rewritten.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
