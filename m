Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C3194
	for <iommu@lists.linux.dev>; Thu, 15 Sep 2022 01:40:48 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1663206046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHrMqKnOhvrceoKDNwr4kJF7nEDwLaJAxZRfEElDacM=;
	b=NOK9QL6c//UcrFx6c0l7e3u6T3ikeR3S7RiyaScZazN8wsGha6NRbAbuzX4Cfw2v+zq51Y
	7CWGErYlPAkwbIO4kuO4+cMqn8M24j/UIslfY4vEJndq6Dr5HZHgWQgt5QZbpKCgE0E2+f
	vqonwUNyZXx1RB2YKrAjmb9GjSVqg5M=
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 03/21] mm/hugetlb: correct demote page offset logic
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220913195508.3511038-4-opendmb@gmail.com>
Date: Thu, 15 Sep 2022 09:40:34 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Mike Rapoport <rppt@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Borislav Petkov <bp@suse.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>,
 - <devicetree-spec@vger.kernel.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Linux MM <linux-mm@kvack.org>,
 iommu@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CA76834-D826-4799-A114-0E27A10D062F@linux.dev>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-4-opendmb@gmail.com>
To: Doug Berger <opendmb@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev



> On Sep 14, 2022, at 03:54, Doug Berger <opendmb@gmail.com> wrote:
>=20
> With gigantic pages it may not be true that struct page structures
> are contiguous across the entire gigantic page. The mem_map_offset
> function is used here in place of direct pointer arithmetic to
> correct for this.
>=20
> Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

With Matthew=E2=80=99s suggestion.

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

