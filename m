Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E34A24;
	Tue, 18 Oct 2022 11:02:49 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1BE7E68C4E; Tue, 18 Oct 2022 13:02:44 +0200 (CEST)
Date: Tue, 18 Oct 2022 13:02:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Beulich <jbeulich@suse.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	regressions@lists.linux.dev, xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev, Robert Beckett <bob.beckett@collabora.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: i915 "GPU HANG", bisected to a2daa27c0c61 "swiotlb: simplify
 swiotlb_max_segment"
Message-ID: <20221018110243.GA4655@lst.de>
References: <20221018082413.GA25785@lst.de> <a5966644-72d7-4b25-83d1-9765d0593e44@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5966644-72d7-4b25-83d1-9765d0593e44@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 18, 2022 at 10:57:37AM +0200, Jan Beulich wrote:
> Shouldn't this then be xen_pv_domain() that you use here, and - if you
> really want IS_ENABLED() in addition - CONFIG_XEN_PV?

I'll need help from people that understand Xen better than me what
the exact conditions (and maybe also comments are).
