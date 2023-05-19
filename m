Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD07C
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 12:59:02 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 725BF68C7B; Fri, 19 May 2023 14:58:57 +0200 (CEST)
Date: Fri, 19 May 2023 14:58:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when
 xen-pcifront is enabling
Message-ID: <20230519125857.GA6994@lst.de>
References: <20230518134253.909623-1-hch@lst.de> <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl> <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl> <20230519124118.GA5869@lst.de> <8617570c-6dc4-74f5-7418-98f04f7e0ece@citrix.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8617570c-6dc4-74f5-7418-98f04f7e0ece@citrix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 19, 2023 at 01:49:46PM +0100, Andrew Cooper wrote:
> > The alternative would be to finally merge swiotlb-xen into swiotlb, in
> > which case we might be able to do this later.  Let me see what I can
> > do there.
> 
> If that is an option, it would be great to reduce the special-cashing.

I think it's doable, and I've been wanting it for a while.  I just
need motivated testers, but it seems like I just found at least two :)
