Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793985931;
	b=c+lkuWZMd/LlNH9sVPbhukA57mkcG0Gt7QlWc6y6ZakYGOkiXh6mZHXq9vRePRTwJh7A
	 4sBUAU6B8CCN+c/bxeKqY991dB9pFSgipYLioXvQgmgIoHj9cD033zfVg32Kw1hzpXysX
	 zbhUfgCVd9TR/HdmKiR2RY+X/digtSiJfnlW3hdxtc8Gy04G4E64K/XtOiEsL0MOSjqzF
	 b8Xd0VV7C3KCywjL3G7OelbE4rEWqv7O8hKMMMj2kPfkUEXk7J8IwvK6r0JQf80Xj+7vF
	 P5CzaUDlTqBCzjRNoBuDUaUh6IyPrcZ9fEVcNDHIh+0PbsVAiLevv7+pGCaWSsGijdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
	b=uAMbhmg+K4jKwpOkvnHtVpFTCsFWZKaHLlfg6R5avuGvtZhpSMsvVcmDYWD9JW/nOvBF
	 SzkWT4Pqc6sU8jTItfb8GSq1rNmEYQbU9OW9mbFWtdmaxKmM8HtLpISPp48EhgcILHaP5
	 BENGZLNoPTmo53idHrOhH7f3kGpPl/qlKkZbnevmYGKO3vRuGbzZsRbCZCry7SilW15LW
	 LRcvWMAoA1v8jISgnMbP/DnDa2C+8SSvUMgieBara/pQAqjWY2s/BY/51DWbYLtjUTDkF
	 0sZpHzXfm5cLMGdMOJ8ZPYoSLqmfU7bRfrnNYbMdwne88bJUC6jEq4CZhpqFhHYhi2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LM9aHd8d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D0606A32C
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491D0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LM9aHd8d
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so1205e9.1
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793985929; cv=none;
        d=google.com; s=arc-20260327;
        b=CaAADB+ZYGSdehV/wBYt3cRvwinIqPAOhzKp22mETZ9dJ4vbQNOHrPBgdQtsQvonj/
         6LDtkeDoVoLnfB8K2VfhFX4lu7ym+EY8una+ypbnGr0BkEjsyeXUMGdkPvDFjitiSqwF
         3fXwQYpalM79E9AEFxztgG/zDT6AyZFfOwd69psnQCQ1CjD8i/dDR5B3yQY7RmyrQB8F
         YgtaTZ4LzLzy2TwKOPURukkPSp9HULoYx9bQjVcKGEmB5JpRmRisFtEDdwkAL7JBk2Qx
         jn4qEMiiX4J2I55eVL7aSU7K4k0Xl5mKCSuFDBSHk/TXt9GXkl5KMUcmhEdcrHfQB+18
         VFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        fh=lVVncB+VH8FzsWlOqVR/cGtGPfVaVwYvTR7xSNUYDKc=;
        b=eataCqwA2pE4+mMnvGGsl9RCQoBBjESpUXJ89RUDhfNceF/tfn5MTZVB2GsyfhlBi/
         CYVnIrArXZijX7Cy6kpoaBwe5rnHkIgXB4RiAXsPGuCpZJqkEpyCNem0uNxG8eNoYrbt
         JxrFD1yHSiAgMZUek/EZCq076l5gczfS61nBFeWEMbEcXcDvd6yb3UU6ElHfD9CXxJ2W
         8xtjrZRuLzb6K5jmVc97aRO0JdznTvpZm8KXtx6jbepwHxGYBJk0Mghs8lAS+2xLx18X
         aLbx5Nr1kbVxVrMemXfNtu0TH6Rm5WJmdqBrczV2UVAbkILD4w/Y88w+pXY00MvQ15WI
         C+cw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793985929; x=1794590729; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        b=LM9aHd8dGwa9CqFYDIt3mLVyqPP09L1a8BfjoT1cuLXbE34ShkTqgIEa2FRrbTI3Y4
         jT02wbTKFeyH+if7EHt83QUylLEsQ1ssvIlYFV6PxXtQNqaRooJ2C3wlN2rP/333QZ2g
         Qgh3nBjAC3eW1ARwsQixnNZ///2UcI7s/H1bSGxv15cTGQWAm2SKWSD+WHH+n2KZdpJY
         90mTsBhqqJMhCvz30RVYo/RckP7F8kFlRUyPVkkcxcWxLG55rLFIBFVXvtYae8uX6xuG
         m9kpgs3GIc6JaFbWK6mH31e17AogvT6Gvr7BRjEhXBEIqbXWIeb/iG+VsFZwvX/0yamR
         Faew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985929; x=1794590729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        b=pWnkW/xpFi8KfZ77XNlLYQVS+lDDJMJRuILdYhT7SdR2mSLr+cUavD6illu9cZQ8Gh
         VBQuGnT51lGTUnwoc1wy5K9r/ESHTI375Qoz8lkOLH0uw+c6AYRPvh6tDB0yl0JPcpUE
         PAIaHpuUUpFktHyiPastIVS0H24WZG2mDdvo4Vw1eQm8gzzU2QGBswn3oyLbkz8teJWi
         9IilzCl584aFPllC8Ous/nOlgs8oUAUzzlAK3MODUKf0+OFfWqhjzF8f1Bb9bdC4w+KZ
         UlBWduWma7lY/iBzGVD9ouWqlg13HxsWstYYYLEXZIrq+0qwMnCHW//JVGhJ3CxirUR3
         K7sQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLBo/vsDyDY6+maXvOwRuGq4ZJyQve4N7aRUoYgKegjewf5EjqJwsrGkUgmtc2Yzs3WgTWkQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/OvHBADyg5arH0apJeqtTemJ4iOojAWm8HB4RBJWex3hXG1HvX
	hckHytIuvNUUdX2+k1EreWNE1crnPfMXEQ4gqvXr/NTrTZaaT0KMlgIJu4HKCY76sad82MA9C0K
	+mZ/vEBZvpByNufRm6kL7OQsG78n1MZ/+529hNg6Y
X-Gm-Gg: AYBFou2GtMZA5e8/6G1VUGErzXl4n8jAFlSBasIbRGdoLOE62m4DQYaUheuDMOCbO6z
	Z7dTcARyT1qdzdjzs7oE07A3JOepe/ct0U7bINjFbS/smZDqXIRh/5y1Qv1UEKSo0VTaWQ/wMyO
	eC03du9NfQb2XruOcNik3mUGvavR2VyD6FKnfK/Aq5XZzVvcWoAkQcO4I8q+7xhLRacMpFWcLq2
	Boy/IVpZFE/YrUmtyeBlyPRvNeu1Tl7scEuBDZla+9GdlJEwrhW5elgmXmBsX0wbN/DS/Hv2y8Z
	L+kINl3Uqa/mG8EDR+BSQC5lA8Y7HC8pLTZa1zFdY7Yr6qkNz6hL5SxF1ggdnfSTUJMT+pjhXXs
	tQFc2/tJc5XHkgerFV3iRTv0sUhh4ogVEk6gNMosFPE645Un19dX438wluET6O69EcaexSN8XXw
	Q/QE8C06dBKNxVxHq9wx20yH4SzhiNS9Y6vckCG9rMZqRo
X-Received: by 2002:a05:600d:644f:20b0:4a2:a8c:22ae with SMTP id
 5b1f17b1804b1-4b78a315689mr14125e9.12.1793985928307; Fri, 06 Nov 2026
 09:25:28 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106131829.3228926-1-cui.tao@linux.dev> <20261106131829.3228926-3-cui.tao@linux.dev>
 <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
In-Reply-To: <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 6 Nov 2026 09:25:16 -0800
X-Gm-Features: AclHuK_zmhBLd-fBLwMoqE-7QVB_DAT0nisVVyTe7VWHd67XlQDn1ECR61povKo
Message-ID: <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tao Cui <cui.tao@linux.dev>, akpm@linux-foundation.org, dgilbert@interlog.com, 
	mkp@kernel.org, loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com, 
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com, 
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca, 
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org, 
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org, 
	phasta@kernel.org, joro@8bytes.org, will@kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com, 
	mason@kernel.org, aesteve@redhat.com, harry@kernel.org, vbabka@suse.cz, 
	cuitao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:23=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 11/6/26 14:18, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> >
> > udmabuf pins the pages of a memfd and hands them out as a dma-buf.  The
> > data pages keep the accounting of the memfd they were instantiated in,
> > but the bookkeeping around them does not: the page pointer array and
> > the pinned_folios array, both sized by the buffer page count, plus the
> > transient folios array sized by the memfd folio count, are plain
> > GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
> > memory, and size_limit_mb defaults to INT_MAX.
> >
> > Charge the three kvmalloc allocations so the creator pays for the
> > metadata it induces.  The system heap in the same subsystem already
> > accounts its buffer allocation;

Only if the mem_accounting param is set to true. We (Android)
currently depend on it being disabled because system heap buffers
don't have a single owner for their entire lifetime (ownership often
changes immediately after they are allocated), and the kernel doesn't
have the ability to switch who is charged for the buffer memory quite
yet. Albert is working hard on it at the moment.

Could you update the message to note the mem_accounting param pls?

> > the data pages here stay with the
> > memfd.

memfd / udmabuf is a little special because it uses shmem for the
backing store, which is already tracked by memcg under all conditions
(except hugetlb). We don't currently use udmabuf, so the lack of memcg
charge transfer for udmabuf is not an issue. But once we get charge
transfer working for the system heap it'd be good to follow up with
udmabuf.

> T.J. needs to take a look here, but I fear that this might break uAPI.

Thanks for looping me in Christian. The buffer allocations cost
gigabytes, but these metadata arrays are only 4MB per 1GB of buffer,
so I don't expect charging them to break anyone. Leaving them
uncharged is an accounting gap though, since someone could spam many
udmabufs from the same memfd and only pay for the memfd pages once. So
this change is ok with me.

> A lot of the DMA-buf resources are intentionally not charged against memc=
g.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>

With the commit message updated to mention the mem_accounting param:
Reviewed-by: T.J. Mercier <tjmercier@google.com>
