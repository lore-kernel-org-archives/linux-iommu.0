Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D8139F
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 13:11:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 01FC26732D; Wed,  7 Jun 2023 15:11:05 +0200 (CEST)
Date: Wed, 7 Jun 2023 15:11:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lyude Paul <lyude@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
	Karol Herbst <kherbst@redhat.com>, xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/nouveau: stop using is_swiotlb_active
Message-ID: <20230607131104.GA19206@lst.de>
References: <20230518134253.909623-1-hch@lst.de> <20230518134253.909623-4-hch@lst.de> <b07c93bc7cb71a32091794cd97f7c702c34539da.camel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b07c93bc7cb71a32091794cd97f7c702c34539da.camel@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 18, 2023 at 04:30:49PM -0400, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Thanks for getting to this!

I've tentantively queued this up in the dma-mapping for-next tree.
Let me know if you'd prefer it to go through the nouveau tree.
