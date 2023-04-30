Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D823AE
	for <iommu@lists.linux.dev>; Sun, 30 Apr 2023 23:06:32 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-74e4f839ae4so80836385a.0
        for <iommu@lists.linux.dev>; Sun, 30 Apr 2023 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1682895991; x=1685487991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Psay3iWMJhmxHkZAg5Iuol6oj90ri2pdTt2YuZmWUE=;
        b=n3H6nqEHaqJne+lMWDC0WazrrjZKvmjwaYoQAJtpanf6mj6GHbj1dlXBHBaDdRJ+VJ
         sv7ABRjeVJaqylOzt45cK/IIUNW3mZClbmkW29YYN8dkoDJFikicRRqifcTXLvgdAP9I
         9Aksh8PYtpqGxA8F7/EEEOfpB6+1wdI0k/MwDx2UAOft1Q/qoqTVMv2BpEyDWEYGudFd
         Yf0K7EVCzbc2LnQNbHrulIeS/0IwOSNTkjedU4nS7B7KlWo++xnQ/sMFm6Bkz3VB7g2C
         l9KDF/fzGBQKKIi00h422ACQLJjY1qneZG0zqlOtnxIXUiZFxyc6LWGYB1wHbkPqYZG+
         KejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682895991; x=1685487991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Psay3iWMJhmxHkZAg5Iuol6oj90ri2pdTt2YuZmWUE=;
        b=CCNFQ+d2O9QiK0N2f0faWX/DF1HLPnmVgqcdRmtKvoLHrcEM99k1IsHPnyAx1U6qLr
         R3pQwn+bXxZpjzPjIJrsKfWglYl6v4BF4VeUamCSOHObtKcOlL4GQW6hmmCfIlmAi1WE
         v+7nxEXj00GeGqhwAQ+yFeFsQ9q8cBE8kb0kQT8uYCR7yK0JGmwo9u+KkeywzfpewozB
         C7FVu+Tv563lw7PMKsNfD4nf9fQzpK0r67mNipk2F2JKqizOjit6i8BtLs3WwKxVCmft
         +BaJdn20Cm5fbQXwUMV48i0f0mu1Tz0e+ZgPj8Ezz7Lv4IXdwPzG9TLmSGSPwTWN4iXT
         ui4g==
X-Gm-Message-State: AC+VfDzInMS02TsC1gUUPIhZLPT/ErRm/6hKn3nemL+rHRjGnteGu1r5
	G7PpeTAAggyHO+sZ426Hlevy/g==
X-Google-Smtp-Source: ACHHUZ7N8wIq7sna6v8mheeplG6fRtbWccoLeo3L3czcxGeQmS0itVhx8sZeyiIb+7kZSatIlT1rTg==
X-Received: by 2002:ad4:5967:0:b0:56f:37a:4561 with SMTP id eq7-20020ad45967000000b0056f037a4561mr15383256qvb.34.1682895991597;
        Sun, 30 Apr 2023 16:06:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x14-20020a0cda0e000000b006166a48357asm3485820qvj.60.2023.04.30.16.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 16:06:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ptG7i-005eii-Ev;
	Sun, 30 Apr 2023 20:06:30 -0300
Date: Sun, 30 Apr 2023 20:06:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
Message-ID: <ZE70doFi8X3KgfrV@ziepe.ca>
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
 <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>

On Sun, Apr 30, 2023 at 01:07:45PM -0700, Linus Torvalds wrote:
> On Sun, Apr 30, 2023 at 4:13 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > this pull-request is somewhat messier than usual because it has a lot of
> > conflicts with your tree. I resolved them in a test-merge and sorted it out
> > for you to compare your solution to mine (mine is also mostly similar to
> > the one in linux-next).
> 
> Your resolution is different from mine.
> 
> Some of it is just white-space differences etc, but some of it is meaningful.
> 
> For example, you have
> 
>                 if (mm->pasid < min || mm->pasid >= max)
> 
> in your iommu_sva_alloc_pasid(), which seems to have undone the change
> in commit 4e14176ab13f ("iommu/sva: Stop using ioasid_set for SVA"),
> which changed it to check for
> 
>            .. mm->pasid > max)
> 
> instead (which seems also consistent with what ida_alloc_range() does:
> 'max' is inclusive).

Yes, that is what the new function comment says it should do, and the
only caller is:

drivers/iommu/iommu-sva.c:      ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);

Which looks inclusive also

> You also seem to have kept the deleted <linux/ioasid.h> header file.

Should be deleted
 
> I'm also a bit unsure about what the intent with mm_valid_pasid() is.
> In commit cd3891158a77 ("iommu/sva: Move PASID helpers to sva code")
> that helper (under the previous name) got moved to a different header
> file, but in the process it also got done unconditionally as

I think the whole thing was originally a micro-optimization to remove
this if statement from some mm paths..

> But in your merge, you ended up splitting it into two versions again.
> 
> I don't think that's technically the "right" merge (it basically
> changes things wrt the two branches), but I do think it's nicer.

It is closer to the intent, I think

> Finally, I'm not happy with the Kconfig situation here. Commit
> 99b5726b4423 ("iommu: Remove ioasid infrastructure") removed
> CONFIG_IOASID, but left the
> 
>         select IOASID
 
> in the 'config INTEL_IOMMU' Kconfig case. I removed that as dead, but
> now we have that
> 
>         select IOMMU_SVA

We've had this longstanding confusion in the iommu layer that SVA and
PASID are one and the same thing, we are slowly reorganizing it.. For
now it is fine for IOMMU_SVA to cover the PASID allocator as the only
drivers that support PASID also support SVA.

Arguably the design is backwards and IOMMU_SVA should be user
selectable and it should turn off the SVA code entirely including the
driver code.

> Somebody should double-check my result, in other words.

I didn't notice anything wrong, I'm sure Lu and Yi will test it!

Thanks,
Jason
