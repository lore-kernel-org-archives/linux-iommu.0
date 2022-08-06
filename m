Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990377C
	for <iommu@lists.linux.dev>; Sat,  6 Aug 2022 20:29:09 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id E46AE641; Sat,  6 Aug 2022 22:29:00 +0200 (CEST)
Date: Sat, 6 Aug 2022 22:28:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v5.20
Message-ID: <Yu7PBwJy8LbI/aTs@8bytes.org>
References: <YuzlAT7RW1U36+ap@8bytes.org>
 <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>

On Sat, Aug 06, 2022 at 12:39:54PM -0700, Linus Torvalds wrote:
> I'm currently bisecting a boot failure on my desktop, and it's gone
> into the iommu code.
> 
> I'm assuming it's the 64-bit thing, but I'll bisect further to make sure.
> 
> If it is, it will be reverted as hopelessly optimistic.

A faster way to track down whether this change causes the boot failures
on your machine is to boot with iommu.forcedac=0 to disable the new
behavior and see if the issue goes away.

Please let me know if I can help with anything.

Regards,

	Joerg
