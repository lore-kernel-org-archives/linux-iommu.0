Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A177B
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 05:52:59 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02D1367373; Fri,  7 Apr 2023 07:52:55 +0200 (CEST)
Date: Fri, 7 Apr 2023 07:52:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Kim Phillips <kim.phillips@amd.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: Re: [RFC v1 1/4] dma-mapping: introduce the DMA_ATTR_MAY_SLEEP
 attribute
Message-ID: <20230407055254.GB6803@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <ea0646e0e63380bb8595fbac81c23aeca30feae9.1679309810.git.petr.tesarik.ext@huawei.com> <20230328035725.GA25506@lst.de> <f42723f3-6dda-037d-3dd2-dc60ac0dcc3d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f42723f3-6dda-037d-3dd2-dc60ac0dcc3d@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 28, 2023 at 09:21:10AM +0200, Petr Tesarik wrote:
> The full series in my local tree added it to the implementation of
> DRM_IOCTL_PRIME_FD_TO_HANDLE:

Umm, an all these are callers that absolutely never should even
end up in swiotlb.  If we have large buffers allocated by media
subsystems, we need to make sure they are fully addressable.
