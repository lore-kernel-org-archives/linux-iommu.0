Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55079D0
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 11:23:30 +0000 (UTC)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684149808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6Ilqn7gAfhO8uMRZGXX1Jq1gxLBqE6k0MyZNiV0LaA=;
	b=IkAcFrSDAqg/cSC/BtURjOLFbWSORRUcdYYTXMvp8T614UEs35Swwlf/Ky+P/IL9OdWIUC
	ufrXtwzVTG87dBVJEFxTQEb58TUKGzMmX0Q+PrKCLUjKR7fTtCijqkb/b8oUyqh5Vdk8WZ
	7Ng5Grf+u4JJmJ3d++e+El29FbP5uHM=
Date: Mon, 15 May 2023 11:23:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <055f964384a2bb4ba51c64a0be6072c9@linux.dev>
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all
 architectures
To: "Christoph Hellwig" <hch@lst.de>
Cc: corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, paulmck@kernel.org,
 bp@suse.de, akpm@linux-foundation.org, peterz@infradead.org,
 rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
 thunder.leizhen@huawei.com, ardb@kernel.org, bhe@redhat.com,
 anshuman.khandual@arm.com, song.bao.hua@hisilicon.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
In-Reply-To: <20230515094955.GB23880@lst.de>
References: <20230515094955.GB23880@lst.de>
 <20230512094210.141540-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT

May 15, 2023 5:49 PM, "Christoph Hellwig" <hch@lst.de> wrote:=0A=0A> This=
 looks fine to me. Can you please work with Barry to make sure=0A> the sl=
ight different place of the initcall doesn't break anything=0A> for his s=
etup? I doubt it would, but I'd rather have a Tested-by:=0A> tag.=0A=0ABa=
rry's email is no longer in use. I can't reach him.
