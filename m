Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71F341056
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620439; cv=none; b=j5NxCnL0aEobZpxOz15lNRiij4nE0LqpmNw/kkGcMNlgFS/50ctjQ48cmOmvcFbxE/ONOO3zuFeWzQeSz/G8Z+fAb8C0QxsXcPEDa0b1lk+er49psvcwQW7AK1UkFK4QVb0GsfC0lgK6XjPVK7ecBv1ZgOLOeCYk9jXqK2N8dGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620439; c=relaxed/simple;
	bh=x4FbGO9rb3oDBd7srLGxGoyKvyyHdSRpv19OZNd+OHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWBlQ0xYP3UJ5QY8dMxkUjrGzHsdbmWR0NnRlMkKhU6QMzV+r5a4Tyg1NUiFCMh2xHmGd1LsMOKD6UJYPWIYRaIc8BYtFeQNd2TE3dq1jcaJTlCUWyxKBWOxuZ3Tg2FhBS3y8rUnYwhLhO7DKDW5AuCGK2qDex3oVjix8/L6VuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YVpd+4f0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YVpd+4f0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779d8286d8so10634725e9.0
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 05:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767620435; x=1768225235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1KqtsDg02Q4tg0OrM0LKqtAMxJWRmTEsyj+AQ7lEeQ=;
        b=YVpd+4f0mQ9AKbwrBnByrcEnPiEAPkdJqBb0fUcIW+9WnYnHrTG23Wt65WdDSlMFm3
         mIrN9UR7ouemMl0mQYr8gOgJa8lKgOENnWT8ToWBXoiLGie+/RHE/HxxttU/nAPLVItW
         4aP7cTJe5vnnO/wYhp1A+EU6oSmdqKRcUE0ZrQ5+RdrDeOc1XqgR3bIcJxdp7f2m6lv3
         23CeROYsXYqHb8Oe716UAK//ULXd2wAVSEyCwGP6U2NYbiQfl3yDeCIa/HrcbDSkIw4/
         vw4SoBlPTC//AC+Z9gp8/9YQOALOaTNm2XgfCrqU8h6K2XqjCjlLclsqd3N5mcPmYteb
         RQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620435; x=1768225235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1KqtsDg02Q4tg0OrM0LKqtAMxJWRmTEsyj+AQ7lEeQ=;
        b=XCKQYCTnYNsqvd37MlvhsVAbAMaUJpuDFkzQEfImpHN/dJn0hsOp4mqsM3EljD4GeX
         OJD35EFkdnXuakUxEqZl3PK1ETwBOGXATFZHtL1lj9n4SFbGraIQthnezAN3tJ08kiGx
         gHiJo9X9qbFGI4rF0qiIUHgqjA+X+vt/RMd3B6+98azd7xwaiKwohgKRVujWSUmc2U3Y
         BJuCSL3SCH/K95wtgJB/rBJm6xRXvxdUwBvTob9resG95HdEh0ofjvZ6UrwwdO5MQ8FQ
         s42cJ9S6/Ua+yG2gvpY7pNlIPAcrxLNuGdrBD7BMhUhPafPU6cKMhYAAJfeDOXg7SlxS
         UkkA==
X-Forwarded-Encrypted: i=1; AJvYcCWqUYmAu/1oclWYF8o9bd3r1nzdfCWzu77K86b3OOVwqfkZvt5TP2JT4Otw3TzR+mRi2YFxHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7SNc/JqTHBFx0JM3z9ZJBSW7Xssbz2fpM9cFL9L1g9V7mTzzM
	NN3wWx/09pXLjkdL++Jf44I0kUng1xiIaLnh+zSqlhMgi2eR9/TX7hoWh9LMYlOfZog=
X-Gm-Gg: AY/fxX6XJ5LBOrvgTr7OlW7UHT7vXsgvgPTFzezUaf1w9ieUY0xyDboAkGUKRutwnfO
	P7rwwZcjCUbcK4bJe87gDouUnMVnItrn+27PidsoWahIe2NN/pCcsfgp9/r6ou1aw80f+OAfLT2
	uY7EA2XW4UpgtpmDTxr0FwtN9DO/Fx2JYXtsQeiLnLXW2dNvIJPp5OzcDidq1N9a1VelnKBlxE0
	4YkmWuldOQI8sn0bMiD94NfNxSiLoLZmohDISWA4mr9XceVTJa1anpZ67gfP84o2GreAOBDZJXX
	nn7baI3SslGatK8s71CXunX9paiHFk0YJVQerbJKrUEH/0BlUDYUO7HG7ik3ANFynak8A9ghB+s
	l/8/u1T27GniVF7gLyKbG5IRPwEb3p3+I+POUBA5TpVWmEsomfiuy+NGX3Rgde+7R80/tzLJoXw
	uquwN4yHgvF3Uvn5lUP+EQ5owdRQC76TOOkw8osTEGK8Exs9ZpZ3C/1HHgUBSmsHhZZl/R3d6tK
	qN7
X-Google-Smtp-Source: AGHT+IFwXSkFSnAzDpXmvBfpaag5Ig2x/hY7lR/fPaiKG8l/aTMnGjVbJNKYUdmZgkyBxJqwrNsd/A==
X-Received: by 2002:a05:600c:4ed2:b0:477:9c9e:ec7e with SMTP id 5b1f17b1804b1-47d19597517mr371677315e9.6.1767620434763;
        Mon, 05 Jan 2026 05:40:34 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6be2ce32sm61878015e9.2.2026.01.05.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:40:34 -0800 (PST)
Date: Mon, 5 Jan 2026 14:40:31 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 05/15] dma-debug: track cache clean flag in entries
Message-ID: <20260105144031.2520c81b@mordecai>
In-Reply-To: <20260105073621-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
	<0ffb3513d18614539c108b4548cdfbc64274a7d1.1767601130.git.mst@redhat.com>
	<20260105105433.5b875ce3@mordecai>
	<20260105073621-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 07:37:31 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jan 05, 2026 at 10:54:33AM +0100, Petr Tesarik wrote:
> > On Mon, 5 Jan 2026 03:23:10 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > If a driver is buggy and has 2 overlapping mappings but only
> > > sets cache clean flag on the 1st one of them, we warn.
> > > But if it only does it for the 2nd one, we don't.
> > > 
> > > Fix by tracking cache clean flag in the entry.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  kernel/dma/debug.c | 27 ++++++++++++++++++++++-----
> > >  1 file changed, 22 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > > index 7e66d863d573..43d6a996d7a7 100644
> > > --- a/kernel/dma/debug.c
> > > +++ b/kernel/dma/debug.c
> > > @@ -63,6 +63,7 @@ enum map_err_types {
> > >   * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
> > >   * @paddr: physical start address of the mapping
> > >   * @map_err_type: track whether dma_mapping_error() was checked
> > > + * @is_cache_clean: driver promises not to write to buffer while mapped
> > >   * @stack_len: number of backtrace entries in @stack_entries
> > >   * @stack_entries: stack of backtrace history
> > >   */
> > > @@ -76,7 +77,8 @@ struct dma_debug_entry {
> > >  	int		 sg_call_ents;
> > >  	int		 sg_mapped_ents;
> > >  	phys_addr_t	 paddr;
> > > -	enum map_err_types  map_err_type;
> > > +	enum map_err_types map_err_type;  
> > 
> > *nitpick* unnecessary change in white space (breaks git-blame).
> > 
> > Other than that, LGTM. I'm not formally a reviewer, but FWIW:
> > 
> > Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> > 
> > Petr T  
> 
> 
> I mean, yes it's not really required here, but the padding we had before
> was broken (two spaces not aligning to anything).

Oh, you're right! Yes, then let's fix it now, because you touch the
neighbouring line.

Sorry for the noise.

Petr T

> > > +	bool		 is_cache_clean;
> > >  #ifdef CONFIG_STACKTRACE
> > >  	unsigned int	stack_len;
> > >  	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
> > > @@ -472,12 +474,15 @@ static int active_cacheline_dec_overlap(phys_addr_t cln)
> > >  	return active_cacheline_set_overlap(cln, --overlap);
> > >  }
> > >  
> > > -static int active_cacheline_insert(struct dma_debug_entry *entry)
> > > +static int active_cacheline_insert(struct dma_debug_entry *entry,
> > > +				   bool *overlap_cache_clean)
> > >  {
> > >  	phys_addr_t cln = to_cacheline_number(entry);
> > >  	unsigned long flags;
> > >  	int rc;
> > >  
> > > +	*overlap_cache_clean = false;
> > > +
> > >  	/* If the device is not writing memory then we don't have any
> > >  	 * concerns about the cpu consuming stale data.  This mitigates
> > >  	 * legitimate usages of overlapping mappings.
> > > @@ -487,8 +492,16 @@ static int active_cacheline_insert(struct dma_debug_entry *entry)
> > >  
> > >  	spin_lock_irqsave(&radix_lock, flags);
> > >  	rc = radix_tree_insert(&dma_active_cacheline, cln, entry);
> > > -	if (rc == -EEXIST)
> > > +	if (rc == -EEXIST) {
> > > +		struct dma_debug_entry *existing;
> > > +
> > >  		active_cacheline_inc_overlap(cln);
> > > +		existing = radix_tree_lookup(&dma_active_cacheline, cln);
> > > +		/* A lookup failure here after we got -EEXIST is unexpected. */
> > > +		WARN_ON(!existing);
> > > +		if (existing)
> > > +			*overlap_cache_clean = existing->is_cache_clean;
> > > +	}
> > >  	spin_unlock_irqrestore(&radix_lock, flags);
> > >  
> > >  	return rc;
> > > @@ -583,20 +596,24 @@ DEFINE_SHOW_ATTRIBUTE(dump);
> > >   */
> > >  static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
> > >  {
> > > +	bool overlap_cache_clean;
> > >  	struct hash_bucket *bucket;
> > >  	unsigned long flags;
> > >  	int rc;
> > >  
> > > +	entry->is_cache_clean = !!(attrs & DMA_ATTR_CPU_CACHE_CLEAN);
> > > +
> > >  	bucket = get_hash_bucket(entry, &flags);
> > >  	hash_bucket_add(bucket, entry);
> > >  	put_hash_bucket(bucket, flags);
> > >  
> > > -	rc = active_cacheline_insert(entry);
> > > +	rc = active_cacheline_insert(entry, &overlap_cache_clean);
> > >  	if (rc == -ENOMEM) {
> > >  		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
> > >  		global_disable = true;
> > >  	} else if (rc == -EEXIST &&
> > > -		   !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_CPU_CACHE_CLEAN)) &&
> > > +		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> > > +		   !(entry->is_cache_clean && overlap_cache_clean) &&
> > >  		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> > >  		     is_swiotlb_active(entry->dev))) {
> > >  		err_printk(entry->dev, entry,  
> 

