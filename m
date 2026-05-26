Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053F3F9F20
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798970; cv=none; b=iXKwUQ0/QFSBtj3oTWuhVh+ADXxEDVUOmM2AaH1IRDEPhGP9Hm/7jS38k4GvBjeJ0fLwZ0nKdkiI1O7NCRTVq91HQSPD8Usd5IMTY5qnHoX7iqxiN6ECXBpGpOD9gSKIQl8tpDAbb8R7/RsWXmzUitpf5uH1Of8ggC4O0WplWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798970; c=relaxed/simple;
	bh=hw6zRpEYuxwE+11chULArvIU0PpoUuDjGViuYH/aeXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DLwbLvWyZ3A0XQZWj4KaJQmQKvBJmc/NWIWSCpreM08OyXnqRrm0OQu3AEc2kJXDTCB2K9XwpWg8u/IfY/iKMPnth57FkPmLLc7qf+vWcWtTRKBwbdsz3UBdYY6tnRE1GCq+1e47qqEOAcqyFYr7c5U9jtx//G4y+5WDeu0Uh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hgybow0r; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgybow0r"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837d0d71c61so5403122b3a.1
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 05:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779798969; x=1780403769; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V673JxVOaLJnhRNwY1KkynB6RZb0FVbqE1Xmria2HkI=;
        b=hgybow0rStUEa29PqkWRmGjDroZPUXcNhxVb4CkpIO1l0ioP+6vtlJl5me5qlNJGtZ
         b6o7orr33j6lAMhyjNb3TX4ZkTar/JQj2WeFoALNJuEDriTXjJUHoX912HFz9kFPPcnM
         noVZuLZnBYAC15sTi/XEIwQmIrSiMvP1kDUwfGzot2qh+PEvcp4XQgtZvpCRTv2Aopkh
         1qO69TVOvEsYoMQRtiU8UA4VMTi58nFeuGUqiGnQBwik+itrXQrbCrt1M6mGZcrZd1xd
         qSTyyZxMUHa+p1kz+pWhTZyORU37EgPybyw1+QF/5BIqYmpNB9CyxMHMWNIU5ADdSQi6
         kj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779798969; x=1780403769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V673JxVOaLJnhRNwY1KkynB6RZb0FVbqE1Xmria2HkI=;
        b=K9A8SoD9DwCQMLu+n6KFUBic/33rhUXk61FNHjaYQzAdJL8CUfVEdfEyHI35UCYMkY
         G1fuVjfqJC4dKsCIRxipF40DtsXP/Ifh0oaisU3eVl5QCOW57SXYN7YzVvYQBhn32M8K
         sabH9HZVQc526eaBzmZY0/+lMpiarIxVuTAa+lDWbHINB+nlWtTzmZ+3ibXs/Y7BdEK4
         LnjYsCjqwhx2U3IJiAuVofcqL6aUaFWi5Kh6V06jAau/nX5WFYh4qnDF2PywRIUDB5yp
         KuhCYQL6dkRdf1PAsucQ4Cj4A/Ndsc3FWAf7eR3GjLc7U9x8TNThwMkrjMxQkBslA4EF
         UQ8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9qnaOiH0sG75RGtoahJc3Ahdd6PAnc7enUp72tNba4QMskyPCstLJrYLwouzSNdANcB9JlOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2TwIKaVsxucRgdHwbLN2yt+nR0pROpQtLlUDcsIycbWs/Kii0
	jJNCfqM/3m8YC33o0vd3bXBCf49NYpcxE7MOTqmhWoKf0V31QjYfhvXivV22WuQ68AIAgvJkcQL
	lb3ZsfgxvvnwByjKkL5ZcKxBzLg==
X-Received: from pfbgt8.prod.google.com ([2002:a05:6a00:4e08:b0:837:aa2e:b191])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12dd:b0:82f:6841:8733 with SMTP id d2e1a72fcca58-8415f62643dmr17524566b3a.48.1779798968505;
 Tue, 26 May 2026 05:36:08 -0700 (PDT)
Date: Tue, 26 May 2026 12:36:06 +0000
In-Reply-To: <DM6PR11MB3690699A3178F1559D4BE1CA8C0B2@DM6PR11MB3690.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <DM6PR11MB3690699A3178F1559D4BE1CA8C0B2@DM6PR11MB3690.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526123606.2488278-1-joonwonkang@google.com>
Subject: RE: [PATCH v2] iommu: Allow device driver to use its own PASID space
 for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: kevin.tian@intel.com, jgg@ziepe.ca
Cc: Alexander.Grest@microsoft.com, alexander.shishkin@linux.intel.com, 
	amhetre@nvidia.com, baolu.lu@linux.intel.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	hpa@zytor.com, iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, 
	joonwonkang@google.com, joro@8bytes.org, jpb@kernel.org, kas@kernel.org, 
	kees@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nicolinc@nvidia.com, 
	peterz@infradead.org, praan@google.com, robin.murphy@arm.com, 
	ryasuoka@redhat.com, smostafa@google.com, sohil.mehta@intel.com, 
	tglx@kernel.org, will@kernel.org, x86@kernel.org, xin@zytor.com
Content-Type: text/plain; charset="UTF-8"

> > From: Joonwon Kang <joonwonkang@google.com>
> > Sent: Tuesday, May 26, 2026 2:58 PM
> > 
> > > On Mon, May 25, 2026 at 03:29:24PM +0000, Joonwon Kang wrote:
> > >
> > > > Currently, the only known expected user of the new kAPI is our team.
> > Since
> > > > I test if the patch resolves our problem before sending it, I believe it
> > > > should be good enough. Do you mean more than our team by
> > "accompanied
> > > > users"?
> > >
> > > He means you cannot send patches like this that only serve OOT drivers
> > > to the mainline kernel.
> > 
> > Hmm, it gets back to the chicken-and-egg problem. So, do you recommend
> > deferring the patch submission until we find a new in-tree user of the
> > new kAPI? I believe we will not make our module in-tree anytime soon.
> > Or, is it like I still can send the patch and get it reviewed although we
> > cannot merge it to the mainline?
> > 
> 
> It's not chicken-and-egg problem. Just always send them together.
> 
> so let's wait until your module is ready for in-tree review...

Since adding a new kAPI has this limitation, what do you think about the
idea of adding a new boot parameter to enforce disabling ENQCMD at EL0 and
using the non-global PASID space in that case? This way, I guess we could
resolve our issue without having to wait until we have new in-tree users.
Do you think it should have the same limitation?

Thanks,
Joonwon Kang
