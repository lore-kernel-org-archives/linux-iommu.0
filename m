Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D4BA3D
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763671552; cv=none; b=mgpO73KNLKZZTRtuFm3urEWV7cEga4YhF/l+6ZgGgsNuElVzosuw64++N3ZQOIj6CrtwSpEfkWiSSaGCUp/VhWwego70IG1vx8qw7SRKrfd5VW5BtEG0Ttp73gxPCRQlOFzk8nOkCWrAsq0+nxT/uHTw3UHSu7pCucgaRqaWNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763671552; c=relaxed/simple;
	bh=qoz6qigfTzsFDvTgSOCytL2T7X9SOv6py47DJ8WlMgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5qbdzcSUwe6Hvvu6Kl+Dh2jlE1xzuJ9bQD7fR9Jc/vOa0Xc9toDSvc7qlu98KNiOJsWONAZLr6P4Ghio3Cpy5JlMdRydtSspgavdJZtLaOdPdZDNrcgVmQqllK1og3pOoIqK33E/LGkCMMyWcS4nh7ZYcUZcoj0xQnNlTv4lIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3OReT6z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3OReT6z"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e13bf404so44945ad.0
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 12:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763671551; x=1764276351; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xOG3g31fEmS9rGAG7HpiZTqSQ9WhXCj+DMF3prNowSU=;
        b=b3OReT6zh/69AAPctdN2TaqNe1P/VJBrB2k3yENgGmXUGFNYqbC+kMN/I8np/QOM8R
         RDBju72mRJkiFRlRgfnDHVs21x020eLHFgK49d8BBKo+6ecIYLWG8xuJtlwC64LyF1b5
         2gOEfNo6nMIZXmDLdUTq0p4umbMSU6o0WMtJbbfgrcq/YVpbCeWx4Wuh4tpiWF8J+qLB
         NmkqnZyK3fqFsjTsZrN2XvXcPruDrWy1sFQz3J0pKpjyU9ngQep9MqZPDqygmRMiL/qt
         a85WEQZyRJMbxIuU7jsgoqd9JuwpJ1Tn07YXmLXvfP/23QtNM+qv8/gPJGqbpdYJi5vb
         ZuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763671551; x=1764276351;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOG3g31fEmS9rGAG7HpiZTqSQ9WhXCj+DMF3prNowSU=;
        b=JniIM8jWvFf9krpN9dKOB1SMS4KEMAZ+yIyPPgPDP1CvFA81pho0O1wM3FHBBcDEb0
         s3LyyKxxQu2GOKvHYSYIb6BBcQd20QsENe1IC/28do4czzw+4eSajArzikMs0ceDmECs
         ABfeeTj3rAYcY4Gnn7eCd9qhDd8n+IxKvPCOqoDRIKqR6xNPZnBqw3d/+7VuB2jnpj7G
         fZHH5lx+Zoj8ft3RUPAH+vi3C57tm1wkDO3gh6wQWNBQ1r8OAC5RgviYllELPkEne2nd
         cordXwd18CYphgMGukvzrJN6p9xWfU1SIs/96RGNUH2HfYYVpgL+epDX/aTWSlppjTqp
         47tQ==
X-Gm-Message-State: AOJu0Yw4VZK7yr4PQp12l4muebjLNZdt0+PzsJk7V8RDOujUWVA4f+Nq
	+94ms5VzSA51H+y6EyzyWogkcv2NlxTvUfn3uQqrBeHasNEl7eWglpeXTNtHVfVUkQ==
X-Gm-Gg: ASbGncv55aLtaFm8K8sZi03FNF51U3HLzzH2oMljoiyZ6aNfW9nw67aqHglDVY0DxwV
	sD9N9XcsW347ldyQRK0VPHKWpYmXXwanA+lThuaRU1NV9tRQvjPL5+Bcc71VAQkKxvzL90XZyg+
	lDFiZ48rxDqHzxYeCGp/wQRUQeMqBzL9mluwM6jXIqegwH7S1Dy4oJZw3DkuP4cDrb9yN5DPW+t
	Fve3wl0ppi7iXt9f89rWof6hovippeGL9BIcxvmQaay1jYv5mS93NqnfgnP7rnYd9yboQtNmQGG
	MevTZnUJiLbrML7BOBPpwHp+o9OdmDlYaKbuU1NyKpst330AWEqbxf7rms41PlfaKGR1UkK5bNY
	nQRayP0J+uiLrdZ1ICkZj93t2r9sT7rf0vXx633lEEZlYHoBsf0S/tq87V9U0QhiLXRe2UHtta/
	SklG01SI5DTsXZ5X5dW92MErVomyG4GS8AVNZpw9ray7cHHKoK
X-Google-Smtp-Source: AGHT+IHb2m49poOQo20ud9BjyOzNQATEcetaU+PIb4dUv1DtrFlosjpOMUKruGmDNho1dlrLUmaWuQ==
X-Received: by 2002:a17:902:ce8c:b0:294:ecba:c8e with SMTP id d9443c01a7336-29b6bcef60amr47515ad.3.1763671550560;
        Thu, 20 Nov 2025 12:45:50 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138bfdsm34637315ad.22.2025.11.20.12.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 12:45:50 -0800 (PST)
Date: Thu, 20 Nov 2025 20:45:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 2/8] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <aR99-oihNS8kLaDX@google.com>
References: <20251117191433.3360130-1-praan@google.com>
 <20251117191433.3360130-3-praan@google.com>
 <CAE2F3rD_HnZZz9XZTtpoWFfAsP-Rkiq2sAtmUR7xaH5_igYP0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rD_HnZZz9XZTtpoWFfAsP-Rkiq2sAtmUR7xaH5_igYP0Q@mail.gmail.com>

On Mon, Nov 17, 2025 at 07:48:12PM -0800, Daniel Mentz wrote:
> On Mon, Nov 17, 2025 at 11:15 AM Pranjal Shrivastava <praan@google.com> wrote:
> > +int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> > +                                   struct arm_smmu_queue *q)
> 
> Since this function is only ever used with the Command Queue (cmdq),
> could you simplify the signature by obtaining the queue pointer
> directly from &smmu->cmdq.q within the function?
> 

Ack. I'll pick up the cmdq from the smmu ptr.

> > +{
> > +       struct arm_smmu_queue_poll qp;
> > +       struct arm_smmu_ll_queue *llq = &q->llq;
> > +       int ret = 0;
> 
> I believe you don't need to initialize this to 0. It won't be used
> uninitialized.
> 

Ack.

> > +
> > +       queue_poll_init(smmu, &qp);
> > +       do {
> > +               if (queue_empty(llq))
> > +                       break;
> > +
> > +               ret = queue_poll(&qp);
> > +               WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
> > +
> > +       } while (!ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
> > +{
> > +       struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> > +       unsigned long flags;
> > +       int ret;
> > +
> > +       /*
> > +        * Since this is only called from the suspend callback, we
> > +        * should be able to acquire the exclusive lock without failing.
> > +        */
> > +       arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags);
> 
> If you assume that we're the exclusive user and then ignore the return
> value of arm_smmu_cmdq_exclusive_trylock_irqsave, I'm wondering if you
> can just skip the locking entirely.
> 

Correct, with this approach we can be sure that we are the only owner as
we'll be executing this much after setting the nr_users = 0;

> > +       ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
> > +       arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
> > +
> > +       if (ret)
> > +               return ret;
> > +
> > +       return 0;
> 
> Can you just always "return ret;". Wouldn't that be the same?
> 

We can, since we're suspending anyway even if this times out.

> > +}
> > +

Thanks,
Praan
