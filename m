From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/7] Introduce automatic DMA configuration for IOMMU
	masters
Date: Tue, 02 Sep 2014 08:26:01 +0200
Message-ID: <540562F9.2030508@samsung.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1409327670-3495-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 2014-08-29 17:54, Will Deacon wrote:
> This patch series is an RFC to implement IOMMU master configuration into
> of_dma_configure. I haven't yet ported any IOMMU drivers to it, so it
> remains untested, but I wanted to get some early feedback to ensure that
> this doesn't end up going in the wrong direction.
>
> The idea comes out of my understanding following discussions with Arnd
> and David at Kernel Summit / LinuxCon in Chicago. Essentially:
>
>    - Allow IOMMUs to be probed early and set up per-instance data on their
>      of_node
>
>    - Add a new callback to the iommu_ops structure for adding a device
>      with a set of opaque IDs (e.g. Stream IDs or Requester IDs)
>
>    - Add an of_iommu_configure function, called from of_dma_configure,
>      which registers the master IDs with the correspond IOMMU before
>      probing the master itself
>
>    - Where applicable, create an IOMMU domain per device and swizzle the
>      DMA ops for that device to use the IOMMU variants.
>
> I haven't bothered doing anything clever with the DMA masks yet, so I
> wouldn't be surprised if we end up chewing through tonnes of memory
> allocating IOMMU domains that are far too big at the moment. Again, this
> is just an RFC and I'd welcome comments on the general direction of the
> series.

Thanks for your patches, I wasn't aware the fact that you are working on
this. When do you plan to send a second version? I would like to rebase
my Exynos IOMMU patches (https://lkml.org/lkml/2014/8/5/183) on top of
your work, but I wonder if I should select this version as a base or wait
a bit for an update.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
