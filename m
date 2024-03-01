Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E07E1
	for <iommu@lists.linux.dev>; Fri,  1 Mar 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300520; cv=none; b=JfbupZ/awi1lci/EVY4lxXoFcoqu7JTb9edCUmJ2UhUC/np5OpDihiNsYxH0ztcrukjJNhLl03cGQBq1mcrjxXAXHnyHdyIeJRc9FxZR7UhNkYsevRwWJ5qtHKrf0f2zJK3+2Jm5JvnKz2PJb4sdgZRTwErHzMFl4yGkMBkJRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300520; c=relaxed/simple;
	bh=2vk9V19VUlgEPl/3Idd/ZI+pMX1LOMB9aDys6AIl9Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qOSX2HUMTmJVdPvMj25Z9YeKcd1t801k9D4HAPwde3LBZDD9aF3EAJ2/q9BZOwY5frz6AnMGhWaAN77/41L5X40fTM6zfvv80NXZGWMuTJ79K0LhTP/GYa+iHvxdsRAdrpioWWVCqNjDhjGihjSEBPMG2Jju5+Ai9+L0x9wYIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGbAHFwx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGbAHFwx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709300517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IV5GI9ggtOV7YL4yWU+pWO5696jTgiyXslpZgRz6IkE=;
	b=YGbAHFwx9cZlClgyqjkFN/Qxb+1HTEWapkNxEfBO+uU2i+9ajKS3vAs4lR8LAnP4ZIW4v/
	sRf8cqeYYdRreXkkmDhnytFtppz/6ae6ZRk1Erci8cyYeBDPP4pJZpn7N4fUfipdGeT0dB
	4bz0dOjPiMICYIKBr7xQ5niylzMCapE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-XX7npshlMpy6hVSWq_-LbQ-1; Fri, 01 Mar 2024 08:41:56 -0500
X-MC-Unique: XX7npshlMpy6hVSWq_-LbQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a445a83754eso107923666b.3
        for <iommu@lists.linux.dev>; Fri, 01 Mar 2024 05:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300515; x=1709905315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IV5GI9ggtOV7YL4yWU+pWO5696jTgiyXslpZgRz6IkE=;
        b=ijzG1/Y03zOleeDbnF6lwEwr5YDyPqgGich7RUNjg9herSu53Bmorp2NmpmMpNgzJC
         T67AipJqSxTlaYDOgk1jK+9VzTQcmBEMf6KEQrfD+ZO8Rha0z9AFOkFi/JYqMJS2OSdO
         hTkEqdcEN9xZwve/+HRgamtyddEg9dpuOoD41CgBuYqUOGZWLKR+jYYtEYsPEbGf/vqU
         Oo8ZrjYX6gVw4x8aztEXi25wS18nmaobL6XOIWNSueGviuZhlN91/o/cPpc6EMxRWM/6
         rWEiKkKkjgLVwOQLAR6NicAdeN4czcj3mghyHPxzrRMu/9GI9sT/ZSIHSTxPzlMLpSz0
         nIGg==
X-Forwarded-Encrypted: i=1; AJvYcCWiuyRR8Idmd+T+zFqQFtK0ueApku0CYmz+oU2Epw/mHpuYXrx9S8nPtulsbY/DJSIo3ZacbAOomp1w2sVwM8YNkyTTMO4=
X-Gm-Message-State: AOJu0Yy+qZNce1klpcD2hMiF8TFIHc+k2qewKbON5e+BsbIIaNJ2LFgi
	QKNZbmZtgWMuY2iKR1nvIRZvp6MlFiDF7aWiLq+9MogpF4GEYZdHIo1Ppp27wf5/TRklXoKu/jm
	KXg7zICVViTmm0sTmu9xsFq+1FNemYbK8+InZmQ+cAZM5+72mBWBn
X-Received: by 2002:a17:906:b214:b0:a3f:9629:d305 with SMTP id p20-20020a170906b21400b00a3f9629d305mr1372878ejz.28.1709300515425;
        Fri, 01 Mar 2024 05:41:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLbgF6qBOfPODlpr/w/K+nFzei0cb6QwGv163EHqSi9QSh8ayVYUSqzu7zpVrOH7v0/7CwUQ==
X-Received: by 2002:a17:906:b214:b0:a3f:9629:d305 with SMTP id p20-20020a170906b21400b00a3f9629d305mr1372862ejz.28.1709300514951;
        Fri, 01 Mar 2024 05:41:54 -0800 (PST)
Received: from redhat.com ([2.52.158.48])
        by smtp.gmail.com with ESMTPSA id vk1-20020a170907cbc100b00a445c16d902sm1267866ejc.96.2024.03.01.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:41:54 -0800 (PST)
Date: Fri, 1 Mar 2024 08:41:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Message-ID: <20240301082703-mutt-send-email-mst@kernel.org>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
 <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
 <20240301064632-mutt-send-email-mst@kernel.org>
 <a00f0b55-0681-4e9c-b75e-e7e3d4110471@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a00f0b55-0681-4e9c-b75e-e7e3d4110471@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 12:42:39PM +0000, Robin Murphy wrote:
> On 2024-03-01 11:50 am, Michael S. Tsirkin wrote:
> > On Fri, Mar 01, 2024 at 11:38:25AM +0000, Robin Murphy wrote:
> > > Not only is this idea not viable, the entire premise seems flawed - the
> > > reasons for virtio needing to use the DMA API at all are highly likely to be
> > > the same reasons for it needing to use the DMA API *properly* anyway.
> > 
> > The idea has nothing to do with virtio per se
> 
> Sure, I can see that, but if virtio is presented as the justification for
> doing this then it's the justification I'm going to look at first. And the
> fact is that it *does* seem to have particular significance, since having up
> to 19 DMA addresses involved in a single transfer is very much an outlier
> compared to typical hardware drivers.

That's a valid comment. Xuan Zhuo do other drivers do this too,
could you check pls?

> Furthermore the fact that DMA API
> support was retrofitted to the established virtio design means I would
> always expect it to run up against more challenges than a hardware driver
> designed around the expectation that DMA buffers have DMA addresses.


It seems virtio can't drive any DMA changes then it's forever tainted?
Seems unfair - we retrofitted it years ago, enough refactoring happened
since then.


> > - we are likely not the
> > only driver that wastes a lot of memory (hot in cache, too) keeping DMA
> > addresses around for the sole purpose of calling DMA unmap.  On a bunch
> > of systems unmap is always a nop and we could save some memory if there
> > was a way to find out. What is proposed is an API extension allowing
> > that for anyone - not just virtio.
> 
> And the point I'm making is that that "always" is a big assumption, and in
> fact for the situations where it is robustly true we already have the
> DEFINE_DMA_UNMAP_{ADDR,LEN} mechanism.
> I'd consider it rare for DMA
> addresses to be stored in isolation, as opposed to being part of some kind
> of buffer descriptor (or indeed struct scatterlist, for an obvious example)
> that a driver or subsystem still has to keep track of anyway, so in general
> I believe the scope for saving decidedly small amounts of memory at runtime
> is also considerably less than you might be imagining.
> 
> Thanks,
> Robin.


Yes. DEFINE_DMA_UNMAP_ exits but that's only compile time.
And I think the fact we have that mechanism is a hint that
enough configurations could benefit from a runtime
mechanism, too.

E.g. since you mentioned scatterlist, it has a bunch of ifdefs
in place.

Of course
- finding more examples would be benefitial to help maintainers
  do the cost/benefit analysis
- a robust implementation is needed


-- 
MST

