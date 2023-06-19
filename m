Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056685250
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 09:19:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AFC556732D; Mon, 19 Jun 2023 11:19:41 +0200 (CEST)
Date: Mon, 19 Jun 2023 11:19:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: unexport swiotlb_active v2
Message-ID: <20230619091941.GA17034@lst.de>
References: <20230612142542.111581-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612142542.111581-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Any comments?  I'd really like to finish this off this merge window..
