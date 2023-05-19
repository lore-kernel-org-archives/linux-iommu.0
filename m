Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58592633
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 04:04:16 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AB6268AFE; Fri, 19 May 2023 06:04:05 +0200 (CEST)
Date: Fri, 19 May 2023 06:04:05 +0200
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
Message-ID: <20230519040405.GA10818@lst.de>
References: <20230518134253.909623-1-hch@lst.de> <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGZr/xgbUmVqpOpN@mail-itl>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 18, 2023 at 08:18:39PM +0200, Marek Marczykowski-Górecki wrote:
> On Thu, May 18, 2023 at 03:42:51PM +0200, Christoph Hellwig wrote:
> > Remove the dangerous late initialization of xen-swiotlb in
> > pci_xen_swiotlb_init_late and instead just always initialize
> > xen-swiotlb in the boot code if CONFIG_XEN_PCIDEV_FRONTEND is enabled.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Doesn't it mean all the PV guests will basically waste 64MB of RAM
> by default each if they don't really have PCI devices?

If CONFIG_XEN_PCIDEV_FRONTEND is enabled, and the kernel's isn't booted
with swiotlb=noforce, yes.

