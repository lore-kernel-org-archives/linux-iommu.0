Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7229113
	for <iommu@lists.linux.dev>; Wed, 17 May 2023 06:57:05 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 713536732A; Wed, 17 May 2023 08:56:53 +0200 (CEST)
Date: Wed, 17 May 2023 08:56:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	"Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Borislav Petkov <bp@suse.de>, Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Kim Phillips <kim.phillips@amd.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 RESEND 4/7] swiotlb: Dynamically allocated bounce
 buffers
Message-ID: <20230517065653.GA25016@lst.de>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com> <346abecdb13b565820c414ecf3267275577dbbf3.1683623618.git.petr.tesarik.ext@huawei.com> <BYAPR21MB168874BC467BFCEC133A9DCDD7789@BYAPR21MB1688.namprd21.prod.outlook.com> <20230516061309.GA7219@lst.de> <20230516083942.0303b5fb@meshulam.tesarici.cz> <ZGPEgsplBSsI9li3@arm.com> <20230517083510.0cd7fa1a@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517083510.0cd7fa1a@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

Just thinking out loud:

 - what if we always way overallocate the swiotlb buffer
 - and then mark the second half / two thirds / <pull some number out
   of the thin air> slots as used, and make that region available
   through a special CMA mechanism as ZONE_MOVABLE (but not allowing
   other CMA allocations to dip into it).

This allows us to have a single slot management for the entire
area, but allow reclaiming from it.  We'd probably also need to make
this CMA variant irq safe.

This could still be combined with more aggressive use of per-device
swiotlb area, which is probably a good idea based on some hints.
E.g. device could hint an amount of inflight DMA to the DMA layer,
and if there are addressing limitations and the amout is large enough
that could cause the allocation of a per-device swiotlb area.

