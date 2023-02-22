Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9022F3F
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 14:49:01 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5EF19227AA8; Wed, 22 Feb 2023 15:48:57 +0100 (CET)
Date: Wed, 22 Feb 2023 15:48:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nick Alcock <nick.alcock@oracle.com>
Cc: mcgrof@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 21/27] kbuild, dma-mapping: benchmark: remove
 MODULE_LICENSE in non-modules
Message-ID: <20230222144856.GA14220@lst.de>
References: <20230222121453.91915-1-nick.alcock@oracle.com> <20230222121453.91915-22-nick.alcock@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222121453.91915-22-nick.alcock@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Wed, Feb 22, 2023 at 12:14:47PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules.

.. but this seems like a really odd design.  How is this going to
continue working once we can autogenerate the module license section
from the SPDX tags, which we eventually really should?
