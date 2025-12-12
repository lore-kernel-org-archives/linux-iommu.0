Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B52AD4B
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765522075; cv=none; b=BT4D8VWJ2XsN81rm9x6DxmwdXnY+JpRKLaLNUN+WAiynYKE9PHJH/MQ+Dg4crpSmT6HYX10Ahg7dRvBqyi//kbgSazOOibomD4kLZ+pfLyg/1vc+sztoCa7b/9UvERKOBI9YqPAm5yb/gG1TOVHFaDSZlgGIqAvSaw56lhIFUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765522075; c=relaxed/simple;
	bh=mNPA0Zx5zJE0V5Ykx1kA3xRkPTgv1I96Rf9Qm9t4HXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2+APJps/Bjd3xzEkDuZDsngYm5bRY0g8GqTyv/y4ZqNqnvknhKDk2Fk5kOD2vZbK1DSLREI5gCljyOHXqwua89jEF7vXqsPjkLiQVIuXU2fBahePZx+xP9GDO1jfSBSn8mE1ylCta0YQoSgJquisJIuNdWNg5nQswj4+gqFOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dgj72V98; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dgj72V98"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2984dfae0acso14374525ad.0
        for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 22:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765522073; x=1766126873; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5UD+94K8SuhUoDTS3W7Fu40Oz07pgrXuttNFn52ITY=;
        b=dgj72V98Ac7HGfvzZahKRmagY7iPMOqSqQtW53UNkGIIivQoLE2pM/HuLF4n2nJx32
         bQjMW5VSPG4j7lPGB8WzJjIBeB0m8qEa1YX1K4UWbcVZ41+AaOoS6BbvHMMte7sxb03z
         5iD4Qs+wg75FP0o3gJWwigvlI6/sckWCuMFd1qRG3y0dEsK1u5jOLOUVOUBJQKpskA16
         sxXBVJoLnhWIe3tSt84UZimOKNQmjdIUWp8ujqkw8QAA2ImhWu6WV8m+X0zh4Tc6pvYy
         /zAUqBwvCl+p2HOnFH5xt20LqGRk6faDsQ9DlQfXX/s8tTUk/TJoC2d4t93SK5Tz01Oo
         sHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765522073; x=1766126873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5UD+94K8SuhUoDTS3W7Fu40Oz07pgrXuttNFn52ITY=;
        b=ZajeRKeqy1BE8HSqsQ9QktvZxKKRery6PcdJj2w8+YKNzal8n5zIPZQB5vN2c/Zymq
         bL7Eug87Vky451oZ6Coxuukb/duiLumAhv2I0wecL0IdMQCbVunczRXrKqbFRlYOkZpd
         gzn2Wp739GhTVd+HVU20O4lqZk9Plv+o3jiJHiWe337jEXb5DAHhJOKtiuZ4bS0SWBLn
         MJY5NIPpqLo1ik98xXRZzT/PSztSYLnMG1v0t4SywIHq7onPysHlaeoxQnY4kF+hauLF
         Q2LgVsRmGAz57qV5pQAD39eS4bnbgDI4RoMe+eu/PNDaqIjQ5TTx6XY0udT/4UKz9UnO
         1iDA==
X-Forwarded-Encrypted: i=1; AJvYcCV0PxTq9p5gxOlxvSU0Ak7pAVUC2vEKjFlJYITyX0KhWV5rjPb2YzzrKmtMqtmOS8g4g880gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzW6qgHj1ow9i2Z4rytQM9y10WT+mMSXduYzqZjjlc+f+DW8JE
	Eo4CutsSmxZ9m3GEr3Si1erfovXB5jnTNH9l0wmBuZElm7mu3CPrMKGgAMvpfQCjUH0=
X-Gm-Gg: AY/fxX6PauizAMGaM1mAPAm63z4NmGb+MqzYhPSQzOQQ8ZcQDV5O1ux6cALd1bFxTxf
	rur9gk0vCWXWzqFbiLLORdtx1tA/HDgUC8X839eZJzcklahCXGs9NGph3DMBahPH4geHgR6IGY3
	0qF6Lt+H19tBIAT1xq2Kdpq/3lkaiTpPQiO8N9k2A1h5oSYlxxsMrr3B47v04blQMa1ayTjkNag
	jYETnZ0edUcSxFHCCEN+g2qYkiV2NLEq8OsgSNXkg9VVuDT5Fk1/GV+4CoDF3u14AUFt93dE2al
	T3KIIo2sqAQnowuk0wTkBRv61VZLOPtPl1nYxGPt8NpVOCKjZGiPpECHrAkO22xz9YWWgdtHzYR
	R0BXkFaoiLTNVsa+swwOncvsnPc85DD9oR7q1d5o6ZpBwKkdoRgpTiKuw0Qdkg7caEWKb/KPf8U
	k0/UyBRVwU
X-Google-Smtp-Source: AGHT+IEDr6x5lMmk7yRCk1YDxnVVbrQsihBGYKGVmuDQ6uZLA//CTjlQltsGGHAq349t4npQd0rTbA==
X-Received: by 2002:a17:903:1d2:b0:264:70da:7a3b with SMTP id d9443c01a7336-29f23ccc747mr14213565ad.49.1765522073078;
        Thu, 11 Dec 2025 22:47:53 -0800 (PST)
Received: from ziepe.ca (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b36a8csm43227715ad.1.2025.12.11.22.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 22:47:52 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vTwwP-00025a-GH;
	Fri, 12 Dec 2025 02:47:49 -0400
Date: Fri, 12 Dec 2025 02:47:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: syzbot <syzbot+e06bb7478e687f235ad7@syzkaller.appspotmail.com>,
	iommu@lists.linux.dev, joro@8bytes.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iommu?] kernel BUG in iommu_pages_start_incoherent
Message-ID: <aTu6lckiUr5R7MsQ@ziepe.ca>
References: <693a39de.050a0220.4004e.02ce.GAE@google.com>
 <aTp0jpmWZ49Ql-Kp@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTp0jpmWZ49Ql-Kp@google.com>

On Thu, Dec 11, 2025 at 04:36:46PM +0900, Will Deacon wrote:

> > kernel BUG at arch/x86/mm/physaddr.c:28!
> > Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> > CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:__phys_addr+0x16b/0x180 arch/x86/mm/physaddr.c:28
> > Code: 8b b3 00 e9 45 ff ff ff e8 b2 af 4b 00 48 c7 c7 f0 33 fb 8d 48 89 de 4c 89 f2 e8 50 c0 52 03 e9 4d ff ff ff e8 96 af 4b 00 90 <0f> 0b e8 8e af 4b 00 90 0f 0b e8 86 af 4b 00 90 0f 0b 0f 1f 00 90
> > RSP: 0018:ffffc9000aae5f80 EFLAGS: 00010093
> > RAX: ffffffff817610fa RBX: 0000778000000000 RCX: ffff8880007ca4c0
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000778000000000
> > RBP: ffffc9000aae6130 R08: ffffffff8e26c433 R09: 1ffffffff1c4d886
> > R10: dffffc0000000000 R11: fffffbfff1c4d887 R12: 0000000000000011
> > R13: dffffc0000000000 R14: 0000000080000000 R15: dffffc0000000000
> > FS:  00007fae02b026c0(0000) GS:ffff88808d23e000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fae01d2dea0 CR3: 000000000b669000 CR4: 0000000000352ef0
> > Call Trace:
> >  <TASK>
> >  virt_to_folio include/linux/mm.h:1432 [inline]
> >  virt_to_ioptdesc drivers/iommu/iommu-pages.h:49 [inline]
> >  iommu_pages_start_incoherent+0x52/0x310 drivers/iommu/iommu-pages.c:148
> >  _table_alloc drivers/iommu/generic_pt/iommu_pt.h:377 [inline]
> >  table_alloc drivers/iommu/generic_pt/iommu_pt.h:408 [inline]

I think it is:

+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -372,7 +372,7 @@ static inline struct pt_table_p *_table_alloc(struct pt_common *common,
 
        table_mem = iommu_alloc_pages_node_sz(iommu_table->nid, gfp,
                                              log2_to_int(lg2sz));
-       if (pt_feature(common, PT_FEAT_DMA_INCOHERENT) &&
+       if (pt_feature(common, PT_FEAT_DMA_INCOHERENT) && table_mem &&
            mode == ALLOC_NORMAL) {
                int ret = iommu_pages_start_incoherent(
                        table_mem, iommu_table->iommu_device);

Fault injection triggered an allocation failure while emulating a VT-d
iommu that uses cache flushing..

I will send a fix when I'm able.

Jason
