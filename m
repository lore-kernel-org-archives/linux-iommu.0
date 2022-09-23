Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3C3D90
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 14:49:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85C0367373; Fri, 23 Sep 2022 16:49:16 +0200 (CEST)
Date: Fri, 23 Sep 2022 16:49:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>, linux-kbuild@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ming Lin <ming.l@ssi.samsung.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] lib/sg_pool: change module_init(sg_pool_init) to
 subsys_initcall
Message-ID: <20220923144916.GA18811@lst.de>
References: <20220923113835.21544-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923113835.21544-1-masahiroy@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied with the typo fixes included.
