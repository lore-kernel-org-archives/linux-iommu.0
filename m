Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA702CA5
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 17:18:43 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF5E46732D; Tue,  1 Aug 2023 19:18:38 +0200 (CEST)
Date: Tue, 1 Aug 2023 19:18:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Pintu Kumar <quic_pintu@quicinc.com>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
	iommu@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Liam Mark <lmark@codeaurora.org>, Laura Abbott <labbott@redhat.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma
 region
Message-ID: <20230801171838.GA14599@lst.de>
References: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com> <20230731112155.GA3662@lst.de> <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 01, 2023 at 10:42:42PM +0530, Pintu Agarwal wrote:
> > I agree that reserved is not a very useful name.  Unfortuately the
> > name of the region leaks to userspace through cma_heap.
> >
> > So I think we need prep patches to hardcode "reserved" in
> > add_default_cma_heap first, and then remove the cma_get_name
> > first.
> 
> Sorry, but I could not fully understand your comments.
> Can you please elaborate a little more what changes are required in
> cma_heap if we change "reserved" to "global-cma-region" ?

Step 1:

Instead of setting exp_info.name to cma_get_name(cma);
in __add_cma_heap just set it to "reserved", probably by passing a name
argument.  You can also remove the unused data argument to __add_cma_heap
and/or just fold that function into the only caller while you're at it.

Step 2:

Remove cma_get_name, as it is unused now.

Step 3:

The patch your previously sent.

> You mean to say there are userspace tools that rely on this "reserved"
> naming for global cma ?

Yes.
