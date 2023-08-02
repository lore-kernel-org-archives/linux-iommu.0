Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A65672
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 09:47:31 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B29368AFE; Wed,  2 Aug 2023 11:47:26 +0200 (CEST)
Date: Wed, 2 Aug 2023 11:47:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Stultz <jstultz@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Pintu Agarwal <pintu.ping@gmail.com>,
	Pintu Kumar <quic_pintu@quicinc.com>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	iommu@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Liam Mark <lmark@codeaurora.org>, Laura Abbott <labbott@redhat.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma
 region
Message-ID: <20230802094725.GA28241@lst.de>
References: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com> <20230731112155.GA3662@lst.de> <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com> <20230801171838.GA14599@lst.de> <CANDhNCq+3OEosUcQJ5GFgk+5OyG+JqXKM43UAo0aPz-V27OgAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCq+3OEosUcQJ5GFgk+5OyG+JqXKM43UAo0aPz-V27OgAA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 01, 2023 at 10:39:04PM -0700, John Stultz wrote:
> So, forgive me, I've not had a chance to look into this, but my
> recollection was "reserved" is the name we see on x86, but other names
> are possibly provided via the dts node?

Indeed, dma_contiguous_default_area can also be set through
rmem_cma_setup, which then takes the name from DT.

> I believe on the hikey board its "linux,cma" is the name, so forcing
> it to reserved would break that.
> 
> Maybe instead add a compat config option to force the cma name (so x86
> can set it to "default" if needed)?


I think we'll just need to leave it as-is.  I with dma-heaps had never
exposed the name to userspace, but we'll have to lіve with it now.
