Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6489182
	for <iommu@lists.linux.dev>; Sat, 24 Jun 2023 00:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47185C433C8;
	Sat, 24 Jun 2023 00:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1687567248;
	bh=tVg5s9VJqtFDSCB4yf/yVZmsm6c9AOFNIJmymZLmQXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2qp1uOot+UAgUcb76qH1ad157/Hycte5aC0DoRw2TJHQYoKtbkg8eXZUTAZHsJUj7
	 AuxEbij+raRz67arMMpNbuOOf59d30MNdX2GBpsASw1bVgEDP0sawF2CB12dn6miqR
	 heDOOOryHpBmd8PqehNqIjKVWuY/v7Q74uo+VaZU=
Date: Fri, 23 Jun 2023 17:40:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: "Yajun Deng" <yajun.deng@linux.dev>, "Christoph Hellwig" <hch@lst.de>,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, paulmck@kernel.org,
 bp@suse.de, peterz@infradead.org, rdunlap@infradead.org,
 kim.phillips@amd.com, rostedt@goodmis.org, thunder.leizhen@huawei.com,
 ardb@kernel.org, bhe@redhat.com, anshuman.khandual@arm.com,
 song.bao.hua@hisilicon.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Barry Song <baohua@kernel.org>
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all
 architectures
Message-Id: <20230623174046.66ce934bcf5c1303003a5afc@linux-foundation.org>
In-Reply-To: <20230515133821.769158bb@meshulam.tesarici.cz>
References: <20230515094955.GB23880@lst.de>
	<20230512094210.141540-1-yajun.deng@linux.dev>
	<055f964384a2bb4ba51c64a0be6072c9@linux.dev>
	<20230515133821.769158bb@meshulam.tesarici.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 15 May 2023 13:38:21 +0200 Petr Tesařík <petr@tesarici.cz> wrote:

> On Mon, 15 May 2023 11:23:27 +0000
> "Yajun Deng" <yajun.deng@linux.dev> wrote:
> 
> > May 15, 2023 5:49 PM, "Christoph Hellwig" <hch@lst.de> wrote:
> > 
> > > This looks fine to me. Can you please work with Barry to make sure
> > > the slight different place of the initcall doesn't break anything
> > > for his setup? I doubt it would, but I'd rather have a Tested-by:
> > > tag.  
> > 
> > Barry's email is no longer in use. I can't reach him.
> 
> Which one? I would hope that his Gmail account is still valid:
> 
>   Barry Song <21cnbao@gmail.com>
> 

Maybe his kernel.org address works...

I have this patch stuck in limbo for 6.4.  I guess I'll carry it over
into the next -rc cycle, see what happens.

fwiw, it has been in -next for six weeks, no known issues.
