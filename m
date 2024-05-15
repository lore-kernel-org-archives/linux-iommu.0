Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2D7443E
	for <iommu@lists.linux.dev>; Wed, 15 May 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775848; cv=none; b=NYmU5nx28zdDKgFIbxUtq5uglGhgWQj2MLlt9BsnJ6YLmgE33NMOPxHmnD178hBbVUdoXPeEmH7Y9JxtxJOdzQ5S/NID6h1OBaJHLfcSsA97NLy1dfEkfjEszP3iswyhcPZC63jhKN9Rx3CLyc0BJuOM/VOgHRp2T9jeqAS3UAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775848; c=relaxed/simple;
	bh=4+KfGkFHnXnfeiiqw1n5KZYFBRATt/3WBm0/6HQCsXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WxtgDDLPI9I/PcUs3KOo1uAARnORKiss3AQA+l/IR4VXtBLcUH+ACzA26nARPxYZAEf53Rh4ZTZ7aKcfLJA3jvYuKAio3dnypAzifMEII9Wj3odDtrhWYaTUL8LTOFvXtUUxo0X8cKuLY4d3on8RJNt+GnltfjQJOhOrYfKj350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=khh65UF6; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="khh65UF6"
Received: from fedor-21d0 (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id E55E74076720;
	Wed, 15 May 2024 12:15:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E55E74076720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1715775311;
	bh=HDwiITVAhgMeGNymYNoEWwNrSE2oaf7c2NuxaCTQgOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=khh65UF6Ts9c3SgqC/gXzjpuylzMFS5EN/Hl2V9m1ocmPgRSuBk+ItQQA2cHF3mQd
	 vyfSbhxOfFwRUAZ0RCCgePdBsSvS9deKVxcB6+F0Qcc8+43pHrG1YPAy8VKJFepgWJ
	 1oyICLIty80I7OBJlQJSuRw2M5u+eFDO7t4GvBmo=
Date: Wed, 15 May 2024 15:14:59 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Xiang Chen <chenxiang66@hisilicon.com>, Barry Song <21cnbao@gmail.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 1/4] dma-mapping: benchmark: fix up kthread-related
 error handling
Message-ID: <20240515-91223372820af49c191c67fc-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11456e13-23f8-43f7-8ffd-cd4e4ff825d7@arm.com>

Hi,

Thanks for review of the series!

Robin Murphy wrote:
> On 2024-05-04 12:47 pm, Fedor Pchelkin wrote:
> > kthread creation failure is invalidly handled inside do_map_benchmark().
> > The put_task_struct() calls on the error path are supposed to balance the
> > get_task_struct() calls which only happen after all the kthreads are
> > successfully created. Rollback using kthread_stop() for already created
> > kthreads in case of such failure.
> > 
> > In normal situation call kthread_stop_put() to gracefully stop kthreads
> > and put their task refcounts. This should be done for all started
> > kthreads.
> 
> Although strictly there were two overlapping bugs here, I'd agree that 
> it really doesn't seem worth the bother of trying to distinguish them. 
> I'm far from a kthread expert, but as best I can tell this looks like it 
> achieves a sensible final state. Modulo one nit below,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> > Found by Linux Verification Center (linuxtesting.org).
> > 
> > Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---
> >   kernel/dma/map_benchmark.c | 16 ++++++++++------
> >   1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> > index 02205ab53b7e..2478957cf9f8 100644
> > --- a/kernel/dma/map_benchmark.c
> > +++ b/kernel/dma/map_benchmark.c
> > @@ -118,6 +118,8 @@ static int do_map_benchmark(struct map_benchmark_data *map)
> >   		if (IS_ERR(tsk[i])) {
> >   			pr_err("create dma_map thread failed\n");
> >   			ret = PTR_ERR(tsk[i]);
> > +			while (--i >= 0)
> > +				kthread_stop(tsk[i]);
> 
> I think this means we'd end up actually starting the threads purely to 
> get them to see the KTHREAD_SHOULD_STOP flag and exit again? Not that 
> I'm too fussed about optimising an unexpected error path, however I 
> can't help but wonder if we might only need a put_task_struct() if we 
> can safely assume that the threads have never been started at this point.

The threads have been already started to the moment by
kthread_create_on_node() but put to uninterruptible sleep: please see
kthread() function. They just have to be explicitly awakened, find that
the KTHREAD_SHOULD_STOP flag was set and perform do_exit() in order to
terminate and release all resources. The thread_fn won't be executed in
such case.

I feel there is no more convenient way for doing this differently than
calling kthread_stop(). And the comment for kthread_stop() actually implies
that it is intended to work also just after kthread creation.

Calling put_task_struct() in that place will hit WARN_ON(!tsk->exit_state).
I'd say the last call to this function should be made after (or in result
of) the do_exit().
