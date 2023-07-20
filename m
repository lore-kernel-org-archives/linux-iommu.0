Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C23361
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 08:47:40 +0000 (UTC)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1689842858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JL2+aJ5O5gUNHRDDxgtEpVboWWUfK6z9tvOlRoQ8myk=;
	b=xtQyII0x5U1qJFK0WPGA+HV++LxAJwxaVyUTgg84THCOFE6YEDyA6wDA+mVZU1Jke7uI3E
	jjnscDcehbsYcLIDxx7AgzgmrX/I1Ml3V9JTcGlNb+xJhhB4UiynyXS4y2wSwl1lzX8OJl
	NQaJw47b8YyWhWCfGBIn/6ohKJdHRuU=
Date: Thu, 20 Jul 2023 08:47:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
To: "Christoph Hellwig" <hch@lst.de>
Cc: corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, akpm@linux-foundation.org, paulmck@kernel.org,
 catalin.marinas@arm.com, rdunlap@infradead.org, peterz@infradead.org,
 rostedt@goodmis.org, kim.phillips@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20230720082517.GA7057@lst.de>
References: <20230720082517.GA7057@lst.de>
 <20230712074758.1133272-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT

July 20, 2023 at 4:25 PM, "Christoph Hellwig" <hch@lst.de> wrote:


>=20
>=20It turns out this doesn't apply at all. Can you resend it against
> Linus' latest tree?
>

It's based on linux-next tree.

This patch should be after my other patch in linux-next tree.
a960925a6b23("dma-contiguous: support per-numa CMA for all architectures"=
).
