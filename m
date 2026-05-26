Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D871199FAC
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799609; cv=none; b=OeCO+UKuqjhTdFCDeBpnj/OxAwn0SfeVRNZ+F0Fev82Q8C2NPo7uVa9pnI4ySwn3Nc2JLvq2N7nDmCkyDdVFh33nDzLg/QEDNjGj4FR1RX3Uxk+wZ6U4dyit8hMBVcGDv0YLygQ4pLf6ZYi8u/16iWiIguOzxMupDtJ3njFxrgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799609; c=relaxed/simple;
	bh=+hRCNp3yRrFFeHRFFnlkcM+fPzzhC3iINewSunuMq3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=opWVsn68Dmwcpt4pwr8+y6u42Gion80aaMGaSPSjoHhgNcu4Oac5xd6Ea1/D7Xaap7qntIkXKO8C1eEqQOad4fl+lnfGv6JOOVELZXhTiEKPiDb9wOevptXzRfZI4e24kUb4Jv1nPK5sNsfnHCtJROJRXKPFbqltjtXCi1d2Q3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0hzi1KD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0hzi1KD"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c81086bf930so7032420a12.1
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779799608; x=1780404408; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHjPWhLuYkDH4+fqjN1tzfTEtaV0zDhulaeTcgzzM9c=;
        b=m0hzi1KDiWSus+IGPUPeNHLmlckbq1h6cAoJvIm3q3Z+N+jczb6LHch7fhlgUM6irG
         mbEK7WT7fyUpKSlyGxpSup+avjHRzFk9pCsnkDGgHtnspYD7+RRI8j36WYX9yf7dqRku
         oYtKoSWzWq1EBD4KCRjaR6x00+dHyYaiuQpe6T3yx0jDFvtW3Qe6z7RlyJ8RCFM2hLk+
         vqzPzbJbsZ8cJv72baY3B/hoEaZ2PPu/jT+f5OuS4gkB/1DLpZbAQez4bAFvyaGMwFVa
         kaEW9x+yZWvczugb/KYQk8lo16vNKN/PugQcYQg6I3RtdXHAtamWFYJuEK94zLOHSeR0
         bkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779799608; x=1780404408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHjPWhLuYkDH4+fqjN1tzfTEtaV0zDhulaeTcgzzM9c=;
        b=EPdLhXQJCq3W1CvOyxZvvbBSE40QzJqrNhdqQX5ui74POZkWHV/6wWmF4r1c5Xr3fN
         X4fWbJTxSiJFUQwVtx11OaZbd+5fm3i1420wWWBwZ6oaQw8wZNbXD+7zSl0TKzPZVVzR
         ciuihpdL3jUeH+lWnpZwDov/d/B89KZjdEBq4BULsnJHnw2zECsl7Nv1r1BLb0u8xNhL
         dh7fGW637ql7L3qH2ujkkWkNbucTF8MP9jr7sZNs3bF8+61At+PJwI0ZMLosmPXvfOwg
         oqlYORjlQHqCigPspoKJuPPuurF3v+RnW9g0ICHPKeVZHk8BbLBICOXoX8kU8f1LfEOP
         /Yxg==
X-Forwarded-Encrypted: i=1; AFNElJ/0LGhcbnQL+OClrGVoZ4wF/Tx7nmN8O9Y6oQzRP+EsiB5TUb13K8n8ESbGHu36d9e4LzD7nA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw18QcbB2VUEH7CSHW20zuh/fkzSmFiagPVjIy82Ydy63VF5jPZ
	Fcy/D7nC2RdvhXh7Xj78pMEmUrNjpqj45gUJ8SsM3Cj4ACbkMTCnDq3V3usZ5FiTu7cb7kYK8Rh
	mnSNUMmBl5aYcP4hRdcyyQb2qHA==
X-Received: from pfvo11.prod.google.com ([2002:a05:6a00:1b4b:b0:82f:8e5d:a777])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3c89:b0:3b3:dd0:a624 with SMTP id adf61e73a8af0-3b32978b421mr14638532637.23.1779799607252;
 Tue, 26 May 2026 05:46:47 -0700 (PDT)
Date: Tue, 26 May 2026 12:46:45 +0000
In-Reply-To: <20260526123903.GF2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260526123903.GF2487554@ziepe.ca>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526124645.2494330-1-joonwonkang@google.com>
Subject: Re: [PATCH v2] iommu: Allow device driver to use its own PASID space
 for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: jgg@ziepe.ca
Cc: Alexander.Grest@microsoft.com, alexander.shishkin@linux.intel.com, 
	amhetre@nvidia.com, baolu.lu@linux.intel.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	hpa@zytor.com, iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, 
	joonwonkang@google.com, joro@8bytes.org, jpb@kernel.org, kas@kernel.org, 
	kees@kernel.org, kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nicolinc@nvidia.com, 
	peterz@infradead.org, praan@google.com, robin.murphy@arm.com, 
	ryasuoka@redhat.com, smostafa@google.com, sohil.mehta@intel.com, 
	tglx@kernel.org, will@kernel.org, x86@kernel.org, xin@zytor.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, May 26, 2026 at 12:36:06PM +0000, Joonwon Kang wrote:
> > > > From: Joonwon Kang <joonwonkang@google.com>
> > > > Sent: Tuesday, May 26, 2026 2:58 PM
> > > > 
> > > > > On Mon, May 25, 2026 at 03:29:24PM +0000, Joonwon Kang wrote:
> > > > >
> > > > > > Currently, the only known expected user of the new kAPI is our team.
> > > > Since
> > > > > > I test if the patch resolves our problem before sending it, I believe it
> > > > > > should be good enough. Do you mean more than our team by
> > > > "accompanied
> > > > > > users"?
> > > > >
> > > > > He means you cannot send patches like this that only serve OOT drivers
> > > > > to the mainline kernel.
> > > > 
> > > > Hmm, it gets back to the chicken-and-egg problem. So, do you recommend
> > > > deferring the patch submission until we find a new in-tree user of the
> > > > new kAPI? I believe we will not make our module in-tree anytime soon.
> > > > Or, is it like I still can send the patch and get it reviewed although we
> > > > cannot merge it to the mainline?
> > > > 
> > > 
> > > It's not chicken-and-egg problem. Just always send them together.
> > > 
> > > so let's wait until your module is ready for in-tree review...
> > 
> > Since adding a new kAPI has this limitation, what do you think about the
> > idea of adding a new boot parameter to enforce disabling ENQCMD at EL0 and
> > using the non-global PASID space in that case? This way, I guess we could
> > resolve our issue without having to wait until we have new in-tree users.
> > Do you think it should have the same limitation?
> 
> No, you can't hack up the kernel for OOT drivers.

Alright, thanks for the confirmation.

Thanks,
Joonwon Kang
