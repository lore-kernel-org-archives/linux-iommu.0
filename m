Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284383446DA
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186641; cv=none; b=lg6x0fgGKyFp2olje2/YKxWko0aQ+KZ9CNpA4It4fbBwAx+D8zqJUeMqkcMZ07aGODmkTKvUKtM4H0OaEB3ulGmgK0xlHrojCFoQsRrVVkfzxF9Hy2hOIl3e2qEQJbNiJU2w2lbclXkhKZzChRNYCSuaEuajq4wlgFyIVDqlE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186641; c=relaxed/simple;
	bh=EZu0RBNe8CrCV1HEExrFp8bYx7PPxrtsOnul+gMh2p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBksUFt5IEuj2ui4AzvqUQakvColFQnRddQuTyuIG/KLhYR11PK/aSNH80EmvYqLGG8XCrDWNwwcOxZBXjMIuyT3zELVj3qQt1smMn+aIdMBqv0UPug+Tik4PbQfLPosJhV7RA+2vYlJSqcesYI6hZLLfQEtSDH4hAd81LDeN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RximHYeO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RximHYeO"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4edf1be4434so1332671cf.1
        for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 11:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764186638; x=1764791438; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWelU42poZIxy2dr4VLVf29hmxsrX+k4eX1Z6rP2/c4=;
        b=RximHYeOMojWaAnnnoUnObTUR3v5FmjnL6KQEesEG1me98popzc9+tvQx73USPYvyv
         Icu+wcahx6G7RSSV1qpiEllz3k33yXznY3yS9g7fzP+1G6L9cvLZMsgZqFRgKh4BMSNz
         /2jKHiXexsIaQGykrQZThrnXj26Vto5dabMmxygXEuzisrm2i7PMfMrHdzY2lNoGFp5m
         rgIRBynHfE7KmIUVlJ3xlm+k0e/y4LBgy4+TPrD33NbZAfPRRw6ehobpP9+xL1HZUdND
         ksnuEUQvQUHG4JcCz+6qSdpbzeE7gXzaV/gghIIZbwHqqrn0sUuAuN/OXQVH4v7U9Ona
         or/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186638; x=1764791438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWelU42poZIxy2dr4VLVf29hmxsrX+k4eX1Z6rP2/c4=;
        b=aEAAKwi4tFQCoYHLLmgpuUjS1YGm7HXGEh8tAtRp/8GQSTJYUHwSd8NTpRG+uJdH6g
         sHn6RxsOgnIGscHj+rg/Q5MrtjMEgkh5e2BsbRlsnUvRX52ilEjx+A/TFRO1GgkXsKzQ
         j/yKj8SU0FOTeAKkrzDSDZzOF2ugclhbE9k3PJcWHkx24/+sNmnt3J2lybwwTqc4o1xf
         nhW/T/C0UpNofYHIgqTabzVbV49CJJ0YwDLwNDivQhAAvTBfM4x3O5PTACd2tzR7E+YY
         v4NXjvZZVmZYL/vvJXRa3LHQNecv38xEv8bpoMWh5hFnB6PJCBG9NvLIIH8Bm+MoYB1v
         YG9g==
X-Gm-Message-State: AOJu0YxSJJXF80blhoQDvnpiMh9/r0CikE4FAMSiD+cVeUzGQ5ojMVJt
	swGVQinAJibx+axQ8p1UAePMJlMbQxkto9o+MKf02kFuogtcO2xLciDpmvZPWSeK8yxNDC0jpJP
	j7lLE
X-Gm-Gg: ASbGncu2KyXTPdHlOKUDhRQ1NzWHmZhTO0GwRxOmEZF1AoG3mnuSmIKDIlGvq1AuDPP
	geuz+Bl7MQrqBT0gyZxo4oBY3suXoPd0OoS3dip4YwA+1A8bWuaQh5ecXir17SP0+T/cRNjHDfE
	Fs20LTBi+rRWIgnJRXqwM+nnqNLHYBLK6EWjC72VfcAxXdGaiZGc+C4Ld7nsPN/iMxOZ9H0Lb1E
	yDtLB83kRM5jQhf6s9Gz0K/dGbvsLrcvHeg2+zhwPJagAKaAmP1SFwSOtyKF4Sup6yAaPhjfR8b
	2H1jrsfzLg3Q58ke7oHUclSgfrjL2QJ54AyFnn9RJ1pPWjnsSHBt7j17FidDDOI9tuP3hunWT2/
	wSUZdyYsCCfpfqWBc1mX/84Nn+HEn01dST0x2j6qjljxSRvdZ90DOe9ed7PgL+jDgXj9kCECblm
	r6AK+dKpw5hPwdMUhByfTryKesdbufDH9I3oKNCbpmTV1IK/2OFREGPQpJ
X-Google-Smtp-Source: AGHT+IFU4nFii2n3WUxd0X+nyAHy/D3Snp9YG7y11dVkiaGuGYgBbTLNY7VTEwyRxnAIGt2I+DWuLA==
X-Received: by 2002:ac8:7dc5:0:b0:4ee:1bc7:9d8d with SMTP id d75a77b69052e-4efbd9141d4mr87183481cf.17.1764186638014;
        Wed, 26 Nov 2025 11:50:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efbd411763sm40074121cf.17.2025.11.26.11.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:50:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vOLXA-000000036QV-10ww;
	Wed, 26 Nov 2025 15:50:36 -0400
Date: Wed, 26 Nov 2025 15:50:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Borislav Petkov <bp@alien8.de>
Cc: iommu@lists.linux.dev, Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
Message-ID: <20251126195036.GA738503@ziepe.ca>
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
 <20251126160031.GGaSckH3SHrC8ckPa7@fat_crate.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126160031.GGaSckH3SHrC8ckPa7@fat_crate.local>

On Wed, Nov 26, 2025 at 05:00:31PM +0100, Borislav Petkov wrote:
> + Vasant.
> 
> On Wed, Nov 26, 2025 at 03:32:19PM +0100, Borislav Petkov wrote:
> > Hi,
> > 
> > this is latest Linus + latest tip/master. Box is Zen3. CCing AMD IOMMU folks
> > because the backtrace points to it.
> > 
> > Ideas?
> > 
> > [   12.946913] (journald)[506]: Found cgroup2 on /sys/fs/cgroup/, full unified hierarchy
> > [   12.948083] (journald)[506]: Successfully forked off '(sd-mkuserns)' as PID 507.
> > [   12.977579] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
> > [   12.983638] rcu: blocking rcu_node structures (internal RCU debug): l=1:0-15:0x1/.
> > [   12.983644] Sending NMI from CPU 1 to CPUs 0:
> > [   12.983652] NMI backtrace for cpu 0
> > [   12.983655] CPU: 0 UID: 0 PID: 504 Comm: (modprobe) Not tainted 6.18.0-rc7+ #1 PREEMPT(voluntary) 
> > [   12.983658] Hardware name: Supermicro Super Server/H12SSL-i, BIOS 2.5 09/08/2022
> > [   12.983660] RIP: 0010:delay_halt_mwaitx+0x37/0x40
> > [   12.983665] Code: 01 31 d2 89 d1 48 05 00 d0 3a 83 0f 01 fa b8 ff ff ff ff b9 02 00 00 00 48 39 c6 48 0f 46 c6 48 89 c3 b8 f0 00 00 00 0f 01 fb <5b> e9 ae 2b 1d ff 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> > [   12.983666] RSP: 0018:ffffc90000003d88 EFLAGS: 00000097
> > [   12.983668] RAX: 00000000000000f0 RBX: 0000000000000b9b RCX: 0000000000000002
> > [   12.983670] RDX: 0000000000000000 RSI: 0000000000000b9b RDI: 00000034e14b49dc
> > [   12.983671] RBP: 00000034e14b49dc R08: 000000000000006c R09: 0000000000000002
> > [   12.983672] R10: 0000000000000050 R11: 0000000000000002 R12: 00000000000001a4
> > [   12.983673] R13: 0000000000000002 R14: ffff888100064018 R15: ffff888100064000
> > [   12.983674] FS:  00007f8ae7452e00(0000) GS:ffff889086e58000(0000) knlGS:0000000000000000
> > [   12.983675] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   12.983676] CR2: 00007f8ae6c9a8a0 CR3: 0000000141913004 CR4: 0000000000770ef0
> > [   12.983677] PKRU: 55555554
> > [   12.983678] Call Trace:
> > [   12.983680]  <IRQ>
> > [   12.983682]  delay_halt+0x3b/0x60
> > [   12.983685]  iommu_completion_wait.part.0.isra.0+0xd3/0x100
> > [   12.983693]  domain_flush_complete+0x64/0xc0
> > [   12.983696]  amd_iommu_flush_iotlb_all+0x33/0x50
> > [   12.983700]  fq_flush_timeout+0x34/0xd0

This code in the AMD driver is spinning until the HW completes some
work

Maybe the HW has alot of work to do, or is slow, and this is
legitimately taking a long time? I don't expect
amd_iommu_flush_iotlb_all() to have a problem, that's pretty weird.

Does it eventually boot?

Jason
