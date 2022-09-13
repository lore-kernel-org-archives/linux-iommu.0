Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36764671B
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 23:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/9i0RT8xYnvhhYLydSNCy5w2V2bVU0zcdBS2b/Mx3KU=; b=t4p3qotLpiXBOK695FV6Av3c7P
	V9ch6wXoz1ze/fCRWkrmnKtiyv6PaIrGIqra//NJzO/QtAuQ55T8o35R8QevMFZ/1RRuhOIdBe0Pb
	avPTqmgXSgQ1OqwAURW4GVR+y4TIRhuAIq14QtDmIXoVDxzd3jv5vBBLC5789Wo00msxADOfYqo6d
	IP7LviZekrBf8W8u1g4RbQ1Bpc1F0suAv1V7jHk0oBFLZ2XyQNjY80HoVM4apaNTL112jO+GQTaU6
	lzWwjEfT/q37SX/2QQDb5Eon30dK0Xg8IzwevJjJleospvIdLzX/LFXnkA3JNVm5WeLcfH8+OuinY
	ThNQ8k1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYFQ0-00HI4E-6B; Tue, 13 Sep 2022 23:34:16 +0000
Date: Wed, 14 Sep 2022 00:34:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Doug Berger <opendmb@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	- <devicetree-spec@vger.kernel.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 03/21] mm/hugetlb: correct demote page offset logic
Message-ID: <YyETeBdbldnoRZ+x@casper.infradead.org>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-4-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913195508.3511038-4-opendmb@gmail.com>

On Tue, Sep 13, 2022 at 12:54:50PM -0700, Doug Berger wrote:
> With gigantic pages it may not be true that struct page structures
> are contiguous across the entire gigantic page. The mem_map_offset
> function is used here in place of direct pointer arithmetic to
> correct for this.

We're just eliminating mem_map_offset().  Please use nth_page()
instead.

>  	for (i = 0; i < pages_per_huge_page(h);
>  				i += pages_per_huge_page(target_hstate)) {
> +		subpage = mem_map_offset(page, i);
>  		if (hstate_is_gigantic(target_hstate))
