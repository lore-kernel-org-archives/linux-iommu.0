Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC74C7C;
	Tue, 18 Oct 2022 14:55:55 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD2FD68C4E; Tue, 18 Oct 2022 16:55:50 +0200 (CEST)
Date: Tue, 18 Oct 2022 16:55:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Beulich <jbeulich@suse.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
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
Message-ID: <20221018145550.GA21066@lst.de>
References: <20221018082413.GA25785@lst.de> <a5966644-72d7-4b25-83d1-9765d0593e44@suse.com> <20221018110243.GA4655@lst.de> <d67ceabb-b31a-59e6-fc77-8d6c48b277f2@suse.com> <20221018143320.GA19106@lst.de> <e0448dac-a35e-cfd0-c087-411558512b5e@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0448dac-a35e-cfd0-c087-411558512b5e@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 18, 2022 at 04:53:50PM +0200, Juergen Gross wrote:
>> If we don't need the IS_ENABLED is not needed I'm all for dropping it.
>> But unless I misread the code, on arm/arm64 even PV guests are 1:1
>> mapped so that all Linux physically contigous memory also is Xen
>> contigous, so we don't need the hack.
>
> There are no PV guests on arm/arm64.

Ok, that's the part I was missing.  In that case we should be fine
without the IS_ENABLED indeed.
