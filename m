From: Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Date: Thu, 6 Dec 2018 10:29:35 -0800
Message-ID: <A9F9D621-445E-4F3C-95FE-3963A3DAEF98@gmail.com>
References: <20181206153720.10702-1-hch@lst.de>
	<20181206184351.4d9ece54@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181206184351.4d9ece54-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jesper Dangaard Brouer <brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke-LJ9M9ZcSy1A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Ilias Apalodimas <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Josh Poimboeuf <jpoimboe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Tariq Toukan <tariqt-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> On Dec 6, 2018, at 9:43 AM, Jesper Dangaard Brouer <brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
> On Thu,  6 Dec 2018 07:37:19 -0800
> Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> 
>> Hi all,
>> 
>> a while ago Jesper reported major performance regressions due to the
>> spectre v2 mitigations in his XDP forwarding workloads.  A large part
>> of that is due to the DMA mapping API indirect calls.
>> 
>> It turns out that the most common implementation of the DMA API is the
>> direct mapping case, and now that we have merged almost all duplicate
>> implementations of that into a single generic one is easily feasily to
>> direct calls for this fast path.
>> 
>> This patch adds a check if we are using dma_direct_ops in each fast path
>> DMA operation, and just uses a direct call instead.  For the XDP workload
>> this increases the number of packets per second from 7,438,283 to
>> 9,610,088, so it provides a very significant speedup.
> 
> Full test report avail here:
> https://github.com/xdp-project/xdp-project/blob/master/areas/dma/dma01_test_hellwig_direct_dma.org
> 
> 
>> Note that the patch depends on a lot of work either queued up in the
>> DMA mapping tree, or still out on the list from review, so to actually
>> try the patch you probably want this git tree:
>> 
>> 
>>    git://git.infradead.org/users/hch/misc.git dma-direct-calls
>> 
>> Gitweb:
>> 
>>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls

Did you happen to see my RFC for "automatic" indirect call promotion? 

	https://lkml.org/lkml/2018/10/18/175

I hope to get v1 based on Josh responses next week.
