Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A647B
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 14:21:28 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AB801FD7A;
	Mon, 22 Aug 2022 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1661178086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IEU+aYjqkWSSgkevWjw+jiompUJ5KbhBmDIvKBs70uA=;
	b=rCtHS21fIAGgjvJ1XCdTgBAxGFqSPEXhiwaSjA0AzY2/HsVmKnevHXd8oq9dAT7rAZk+kV
	jI6jkthjhAkJ9JHw0K14V9ME/I5dl4oI7zkWX/YBP9tlZEGN4KDs/ngRvVoQSp9pHAABa4
	QAwZj3sG3Vis8gN4D51sKhQ2/GMc10w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C12713523;
	Mon, 22 Aug 2022 14:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id aAIRGOaQA2N6egAAMHmgww
	(envelope-from <mhocko@suse.com>); Mon, 22 Aug 2022 14:21:26 +0000
Date: Mon, 22 Aug 2022 16:21:25 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <YwOQ5Q+aZRBB0xk+@dhcp22.suse.cz>
References: <20220817060647.1032426-1-hch@lst.de>
 <20220817060647.1032426-4-hch@lst.de>
 <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz>
 <20220821104416.GC30530@lst.de>
 <YwNBHbYXpatJHD0K@dhcp22.suse.cz>
 <20220822111447.GA8935@lst.de>
 <YwNx6Q+FSwpKUOQ2@dhcp22.suse.cz>
 <20220822122759.GA14932@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822122759.GA14932@lst.de>

On Mon 22-08-22 14:27:59, Christoph Hellwig wrote:
> On Mon, Aug 22, 2022 at 02:09:13PM +0200, Michal Hocko wrote:
> > OK, so you are worried about configurations that lack ZONE_DMA32 because
> > that memory range is covered by ZONE_DMA? I thought though simply do not
> > have CONFIG_ZONE_DMA32. Or am I wrong here?
> 
> Zones can disappear when they are empty.  Normally that affects
> ZONE_NORMAL and ZONE_HIGHMEM, but it can also happen to ZONE_DMA32
> when there is not enough memory.

Correct but that is essentially the same problem as ZONE_DMA becoming
empty. Or maybe I am just completely missing what you are trying to
say/ask?

My whole point was that if those zones are configured and you cannot
pre-allocate the pool then this can be either a result of OOM on that
zone or zone completely empty. In either case the pool would be empty
and if that is something worth bothering^Wnotifying an admin about then
better provide something useful rather than over messaging for one case
and be silent about the other. See my point?

-- 
Michal Hocko
SUSE Labs
