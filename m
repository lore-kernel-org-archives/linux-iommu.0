Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693379;
	b=JHrnCe1wxyZg/mcluv4vn/hEmAjhVvsTmpKTACpIfq9+sL7USRgnrvDlbgGq37fVlPQt
	 bwcoZudYbGEMhSC01yeOxe0hka/uVXmfGFf20OQgCEsBysT/L5XAqOyKSfTSxohouPRkv
	 zG/a3NuoUnDNjgO3PYTaCxBQMZ1BCxDFJ1IgGHVAbEi+6b3srOGC6EWY6Ses/6YprEi9V
	 zkP2rUKFlNSoeKNz8Dj0c2UP7lvEEBU9yXO25D8Sy7ppWKPbpErULfscKPVTLPuk8R6/n
	 r7ZnVtFnVKYHvvcrKBohkWgQHztZEEcN9qEPVG3exaFi4QtTHHqlBfMfBSTk5IKpFUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693379;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=2on3ft6XH1eubxEl0nHP4ZK9AQjcmYaJw++Tp033neA=;
	b=Avvos8dEvTEaL71tzosDOPXps5k3XG3M9qnn9ECN7ejGO9rC9+BnZRRhCU26egXoTHP6
	 QNowjEOhso2P7Qy8GHgPhEnRDwQKVjdQTlEY6GIu4PH9L9wk8ndDA/i3wrfFgHQSbcBYp
	 BbapCreTR6vY8BdPzY1jpsp4aGvTDetRejVTUtyFb92lvzYEQhP8cxZps1tqWgONcuhX7
	 LLt6UCvG9eTjMtKBi2yt0PV3XnAdAe93aogPhyLyRyMetI1VUT43/6/eOJJYzbh0oo0Qn
	 U7plsJnfQcSLeiIpDTJO9z1XPoDzUM8Z9gUfIx+fOKWC0VMpINcvlSarQbSwYMk9S4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71471606D804;
	Tue,  3 Nov 2026 08:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71471606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E82268B05; Tue,  3 Nov 2026 09:09:34 +0100 (CET)
Date: Tue, 3 Nov 2026 09:09:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Luigi Rizzo <lrizzo@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
Message-ID: <20261103080933.GA4213@lst.de>
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org> <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com> <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com> <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com> <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com> <20261023145023.GH3977851@ziepe.ca>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023145023.GH3977851@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 23, 2026 at 11:50:23AM -0300, Jason Gunthorpe wrote:
> > Disk I/O is still potentially affected by the same problems
> > (cost if io mapping/unmapping, iotlb thrashing, bounce buffers
> > in confidential computing...)
> 
> The disk folks already have a proposal to address all of this using
> io_uring and preallocated buffers. I really doubt yet another version
> is going to be interesting there.

Huh?  If you mean the dma-buf I/O it doesn't really have anything
to do with disks, except that this is the first user.  The dma-buf
iovec can work for every ->read_iter/->write_iter consumer, and
should be adopted more broadly.  Including by networking instead of
their own totally weird different world.

