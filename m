Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041732D785
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R75DKRAG"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-586940ee5a5so435111eaf.0
        for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698320471; x=1698925271; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLNTg7ehEKZxV7vTljjTdg5VnMvDILeA+3MbDYFCwn8=;
        b=R75DKRAGuqMEcmh/Z/00XpjYkcjKwcKHQOSC6DfMOBTEBiWHX7RCGXsyow6NBBm1HN
         pqFZM26GOWZqq1Q9MMzW3PVM6BpiX2eEejelfN8LtGZ+uScVALcXSaR4YFtklWJzBFes
         5CIrKna7LlZBRNMwGr0zF52lvG241FP7rPR3k2RD4w5DvC8+wQ1LlRLreZ67tEnQANYj
         x73dx37UYcSiFWowp0x9nLq6sS/+GXHi3Vn18Ss6OgG25IwB2+5/XQD1kEfzcU6ZBSv9
         ExnyABiMp/Ek5SqFOre19H1VTAYfxLtUWVRrb2QI2lNAUxyFUoLQc4CSecaeUpzQj5fS
         oF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698320471; x=1698925271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLNTg7ehEKZxV7vTljjTdg5VnMvDILeA+3MbDYFCwn8=;
        b=Vx1MVyzIuhz7ksQ0crPYqxPFLofhBYkQlu05HI+UOT3FfbfYqWcsnPYuwdmI+F1Bna
         +El780ZepPdOR4sizbkGmiZZKt4oIcPKuIFIx1lRH2AlobUiyze8y8Pk91t21Gk3Ca9A
         NvZu+r1eBNnIeuqeVYEuLInzagvb5ctm0o1OabHv4pCbZ++XtOj1S24kuzIGNoB75d1u
         DFCabevod0W2IDPpf9h5JWpR1fu0nawCxYDd2PwbJU+X1DTjWwIjjQDR8+XpVj/n/Jbi
         mc/YHuFkAFgQBON60XqTBGgPdE9Bat1WKQdq8Grp9xA5s9n70dIyrOEqJNa3Z0iGSskK
         BJBQ==
X-Gm-Message-State: AOJu0Yzh29asGV67yEdTr69QFIfZvueZVKrNR9yKf/xILFmkfvy82/H8
	XFsr97ZiYfQbYn4PQFHWDRG7Mw==
X-Google-Smtp-Source: AGHT+IHWMB/ksANaifdTpLAGghTDYRn/7xMWVD082ShcgmYVOdJbdiat4/OU3rVqHMdqUxHA9VxDZA==
X-Received: by 2002:a4a:8515:0:b0:583:fc94:c3f3 with SMTP id k21-20020a4a8515000000b00583fc94c3f3mr17207199ooh.9.1698320470873;
        Thu, 26 Oct 2023 04:41:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id 184-20020a4a01c1000000b005813f95e695sm448856oor.41.2023.10.26.04.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 04:41:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qvyjc-004zhX-Sz;
	Thu, 26 Oct 2023 08:41:08 -0300
Date: Thu, 26 Oct 2023 08:41:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in
 iommufd_ioas_iova_ranges
Message-ID: <20231026114108.GS691768@ziepe.ca>
References: <000000000000d621b406088a2f55@google.com>
 <20231026110502.2046-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026110502.2046-1-hdanton@sina.com>

On Thu, Oct 26, 2023 at 07:05:02PM +0800, Hillf Danton wrote:
> On Wed, 25 Oct 2023 15:32:20 -0300 Jason Gunthorpe <jgg@ziepe.ca>
> > On Wed, Oct 25, 2023 at 06:11:01AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    c3200081020d Merge tag 'block-6.6-2023-10-20' of git://git..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15013471680000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=45f6cae2ca8c1f71e529
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/caa5c1eed3ec/disk-c3200081.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/7990a3a9f71e/vmlinux-c3200081.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/015551ac9acc/bzImage-c3200081.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com
> > > 
> > > ==================================================================
> > > BUG: KASAN: slab-use-after-free in __up_read+0xb3/0x690 kernel/locking/rwsem.c:1342
> > > Read of size 8 at addr ffff8880283c9068 by task syz-executor.2/30372
> > 
> > Oh *ugh* I knew about this limitation once and forgot about it
> > apparently.
> > 
> >   CPU 0         CPU1
> >  down_read()
> >  up_read()
> >                 down_write()
> >                 up_write()
> > 		kfree()
> >  [..]
> >   tail portion of up_read()
> > 
> > I suppose the rwsem should be turned into a refcount and completion
>
> The line [1] syzbot caught is before preempt is disabled, 

So? It is SMP.

> so no lock is released yet, and the report is a simple uaf with
> nothing to do with down_write().

down_write() is one of the concurrent paths toward kfree.

        tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
         ^^^^ This allows the down_write to proceed to kfree

	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
		      RWSEM_FLAG_WAITERS)) {
		clear_nonspinnable(sem);
		rwsem_wake(sem);
	}

And so if we are unlucky we can UAF someplace in this latter part.

Actually, this is a problem but it is not this problem since the sybot
traces don't show it going down the down_write side

I guess this is still just problems with the iommufd_object_remove,
since put is ordered 

	refcount_dec(&obj->users);
	up_read(&obj->destroy_rwsem);

And remove doesn't touch the destroy_rwsem so it simple UAFs anywhere
in up_read and that matches the syzcaller trace of concurrent destroy

Jason
