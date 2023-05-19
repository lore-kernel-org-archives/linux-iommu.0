Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C07C
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 12:41:23 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A400368C7B; Fri, 19 May 2023 14:41:18 +0200 (CEST)
Date: Fri, 19 May 2023 14:41:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Cc: Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>,
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
Message-ID: <20230519124118.GA5869@lst.de>
References: <20230518134253.909623-1-hch@lst.de> <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl> <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGdLErBzi9MANL3i@mail-itl>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 19, 2023 at 12:10:26PM +0200, Marek Marczykowski-Górecki wrote:
> While I would say PCI passthrough is not very common for PV guests, can
> the decision about xen-swiotlb be delayed until you can enumerate
> xenstore to check if there are any PCI devices connected (and not
> allocate xen-swiotlb by default if there are none)? This would
> still not cover the hotplug case (in which case, you'd need to force it
> with a cmdline), but at least you wouldn't loose much memory just
> because one of your VMs may use PCI passthrough (so, you have it enabled
> in your kernel).

How early can we query xenstore?  We'd need to do this before setting
up DMA for any device.

The alternative would be to finally merge swiotlb-xen into swiotlb, in
which case we might be able to do this later.  Let me see what I can
do there.
