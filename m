Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B44BA40
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 22:09:49 +0000 (UTC)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CB48F2244AB;
	Fri, 24 Feb 2023 23:09:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1677276581;
	bh=z5wVjlFzP6+7rcAdcOf5K1vLtbKr92VWi0iR167otfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPiyZ69+JY5nsXLhGsE5CjQzhKAimnKhdKLmupytNqF+53ODv3wP8ngrx23CSH9C1
	 DQ9uYwueBQeFqr9gsEoY+Iecqfj5Y1+Q5+XeXmCo2suRserZlZ7983vjZ9X05KJuOf
	 JcjjQVMNYA18LQ04HBMXrCJVMF3rbRSGQyiQthRM4w2cShqrapr+qi0qjVNRmcwRqZ
	 5uGcFShnFCLAZv69/WDwTWUlnvMCIkFvU3uWfGt3emXOOqrhUOo/wXHgUKqhDY4pzQ
	 qofgFiwJbgkECN69M3/ZelG5+c4T9yICzffjg5kmJjvnx+wmvmXNF3w8pC5XjcVHzC
	 maXE3a4VMXLhg==
Date: Fri, 24 Feb 2023 23:09:40 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.3
Message-ID: <Y/k1pGjjRIznCIu2@8bytes.org>
References: <Y/SGAafMEGBn4fWy@8bytes.org>
 <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>

On Fri, Feb 24, 2023 at 01:46:47PM -0800, Linus Torvalds wrote:
> Ok. I wil be doing x86-64 and arm64 allmodconfig builds, but if there
> are any cases outside of that set that triggers, I won't norice.
> 
> That _should_ certainly cover the majority of any new code that might
> have a semantic conflict, though.

Aside from the conflicts with upstream, which I resolved in the merge
commit, the only other conflict that Stephen reported for linux-next was
in the rdma tree, iirc. So fingers crossed that this is the only one.

Regards,

	Joerg
