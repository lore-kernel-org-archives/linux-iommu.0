Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A773CC7F1
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785061; cv=none; b=ONhI2t5O2oeWVaj7HP1aitwQjBGBzA8jERwUmYX+kEnhvCzUC+1vjWwoKTJA+ndAkb2G7WHzWmS6bSz5+g8cxCIuSt7CaqugRR7Uj5A4GIzkiB4PTLsCYeQ4fXLaIOFyT8Frb4etHM4SB3KiUHb06Yfx1hH3x1QtnSOGBB9rEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785061; c=relaxed/simple;
	bh=3UQoDR82NrQAeJag21GJ4s+TVpWujoRONwWsciGfEc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qk2dIDp7Pa5VjnQObmovUH0P58RkNL2HaSyXuZ34gnIv+dJdSTyeBxwTTlur4OnQIDSuOOyZATwhNSnY0NP8b3LgZQ7jWBbhRT6ywgVi0M021bNKvWtjB4Bti4482Txwy+JRttvQWfSw+XGGWQyep+Nl7Um2kpdXbALhqUvVMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEly2MjJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEly2MjJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365ff2ab7beso11076920a91.1
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779785059; x=1780389859; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=loKnNwev14YsoZE1d3o7thL81Z2AYxmRTfk6YoLUrR0=;
        b=nEly2MjJj42PXAu3EZkxpjWuoO51aL/LyEvNPLR6JlP2Y9EW8tKUeS/pkSTk5JyFUW
         LVtqWtAoj8UuWzgny3u7c9D/Ifujz5giOXRr8YsHmaLveNpojNiPhvY+7U4QOSQgPOWz
         GKoR/OcM0yrz7B993Dzewq84Y08hF4s/IKpX4gsTyg/i8YxY4wdOF37jrRl5dtNeLRvE
         29sg9ikzhEaKaRLIfNfgDECuq3iPwytB43CpFBUQtb9v91CvO5j5N20h2QGykNkmmcMw
         sZhAuCv2KHrH1HazBTbLw+dpMCjWG6q5Up+yR9dNhNYtPjVz4EiRCWWYE3Y0w/KkvOWx
         Oh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779785059; x=1780389859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loKnNwev14YsoZE1d3o7thL81Z2AYxmRTfk6YoLUrR0=;
        b=bbPr1gBpPnsumvEWlMk1rJNgtQjx8stlRRW/RcT8Rj6kOO4GTCnL0Ijj/V+jzH3toQ
         Xvq8xV82O5bAM4c+mEmbiz2B81EVxm6qVQXSTUur84xvpKEnmgGCUuQxbgjJOcQd6B88
         yaOVk5RTTVEQnSmKS1KSlZ+ZiiVLR3XiMN+SISE+vMcIbNMUwrrwEJZQzGXP/u4lODUR
         HCSeWFpdmOH6brpalQl68x2oUVcdtMrxQm6D0SvznYklwj3h2jfkv5DZteq49k0vIe3t
         5QSQjSSg9By6a9OEeOhM0jEXTXu0d1EpxfBPQpNJbfS9aEztvIGBAO+xGfxy25AmIHiP
         DLLg==
X-Forwarded-Encrypted: i=1; AFNElJ8US7fuSn/zz7O3c+nh3ewxww172MRWD3rigH0OR/kIT22NM/PRaK0KfeXNmL2lengEAq99lQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+2m9pJ8tVxM3N9C3yFtv5B5kHtVv85YvJAiJdl8m8sDNgsjz0
	4+JvwYEo/bLC/wz82qnYHYrhhSsgBk2ZhkhWDkNAtLd27Iv9KncpnPaaGOwOuyUiGsT3AixzN9a
	jtL4shWfWBiPqz7duWO/bCW45lg==
X-Received: from pjut3.prod.google.com ([2002:a17:90a:d503:b0:366:dd9b:644c])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5383:b0:368:7d4e:e778 with SMTP id 98e67ed59e1d1-36a6c78e968mr12498373a91.11.1779785059258;
 Tue, 26 May 2026 01:44:19 -0700 (PDT)
Date: Tue, 26 May 2026 08:44:17 +0000
In-Reply-To: <DM6PR11MB3690699A3178F1559D4BE1CA8C0B2@DM6PR11MB3690.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <DM6PR11MB3690699A3178F1559D4BE1CA8C0B2@DM6PR11MB3690.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526084417.970873-1-joonwonkang@google.com>
Subject: RE: [PATCH v2] iommu: Allow device driver to use its own PASID space
 for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: kevin.tian@intel.com
Cc: Alexander.Grest@microsoft.com, alexander.shishkin@linux.intel.com, 
	amhetre@nvidia.com, baolu.lu@linux.intel.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	hpa@zytor.com, iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, 
	jgg@ziepe.ca, joonwonkang@google.com, joro@8bytes.org, jpb@kernel.org, 
	kas@kernel.org, kees@kernel.org, linux-arm-kernel@lists.infradead.org, 
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

Alright, thanks. I will wait until any in-tree users show up in the future
and continue working on this then. Please let me know if there is any
request later.

Appreciate all for reviewing the patches from RFC to this point :)

Thanks,
Joonwon Kang
