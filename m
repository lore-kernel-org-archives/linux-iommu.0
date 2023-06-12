Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97911FD8
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 06:47:49 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C601568AFE; Mon, 12 Jun 2023 08:47:38 +0200 (CEST)
Date: Mon, 12 Jun 2023 08:47:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
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
Message-ID: <20230612064738.GA19518@lst.de>
References: <20230518134253.909623-1-hch@lst.de> <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl> <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl> <c5defff8-882e-3482-0de1-e50a4bcdfa99@suse.com> <20230607131257.GB19206@lst.de> <79b26dac-b507-1c05-b499-784ca6ee3db0@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b26dac-b507-1c05-b499-784ca6ee3db0@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 09, 2023 at 05:38:28PM +0200, Juergen Gross wrote:
>>> guest started with e820_host=1 even if no PCI passthrough was planned.
>>> But this should be rather rare (at least I hope so).
>>
>> So is this an ACK for the patch and can we go ahead with it?
>
> As long as above mentioned check of the E820 map is done, yes.
>
> If you want I can send a diff to be folded into your patch on Monday.

Yes, that would be great!

