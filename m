From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
Date: Mon, 7 May 2018 20:38:31 +0300
Message-ID: <8967e349-3af1-af17-dfa2-187d06dca18c@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
	<f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
	<20180427100202.GO30388@ulmo>
	<716edf58-38a7-21e5-1668-b866bf392e34@arm.com>
	<6827bda3-1aa2-da60-a749-8e2dd2e595f3@gmail.com>
	<20180507080420.GB18595@8bytes.org>
	<a6e26d17-97ac-d02e-7bf4-f009af1a25dc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a6e26d17-97ac-d02e-7bf4-f009af1a25dc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07.05.2018 18:51, Dmitry Osipenko wrote:

[snip]

> Secondly, the interesting part is that mapping / unmapping of a contiguous
> allocation (CMA using DMA API) is slower by ~50% then doing it for a sparse
> allocation (get_pages using bare IOMMU API). /I think/ it's a shortcoming of the
> arch/arm/mm/dma-mapping.c, which also suffers from other inflexibilities that
> Thierry faced recently. Though I haven't really tried to figure out what is the
> bottleneck yet and Thierry was going to re-write ARM's dma-mapping
> implementation anyway, I'll take a closer look at this issue a bit later.

Please scratch my accusation of ARM's dma-mapping, it's not the culprit at all.
I completely forgot that in a case of sparse allocation displays framebuffer
IOMMU mapping is "pinned" to the GART and hence it's not getting dynamically
mapped / unmapped during of my testing. I also forgot to set CPU freq governor
to "perfomance", that reduced 50% to 20% of the above perf difference. The rest
of the testing is unaffected, flushing after whole mapping is still much more
efficient than flushing after modification of each page entry. And yet again,
performance of sparse mapping is nearly the same as of contiguous mapping unless
sparse allocation is large and _very_ fragmented.
