Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF83C3BF7
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778706; cv=none; b=YN9Un4LAuP5AHjRRQxtJsRiyvXF5dl1OS1roXQWRLKfsh5xMRZmHQ9t71CCpPNpFHBV8dAjlS8c+OYEdlUu56x1iKGM54VBFKgTsyx1Vn5Ed2XqkYv97H+P+TxQCyOkKGc9rRJ7jHbMejglBysSNiBcPaq3hM5kirpJV6mCk5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778706; c=relaxed/simple;
	bh=A5kMyvtgXf2gpMtkwVwVcrw8Vh59O1u6RmE+QPEUXTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uim99IjR9JY44ppYUMNfW4G67zNltwAoQh2zDB1MdJD1xFe5uIwAYG8xiy3uqiK+E45GblruGAFj402UUbpG1zFk5VQityA9rDmnDaV/cfm2VeHPg/0l2AQvqzT6YxZK9LbzsDCVOeGzDjFzFQ+jAQwpynqZWN4x3poI7q9nNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kk+Ck3bS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kk+Ck3bS"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-369ef27fd09so8332543a91.3
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779778705; x=1780383505; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdQjmHgCA99B/85Oyl/wYQVRe3ldFqiFSU1yS4ZaDZw=;
        b=kk+Ck3bS33K4Ovq4WgjOgKBrXFxcSJwqy4hZ0gCE3hCeSpaOb70KCgAHQ8mYRwlJrR
         dnJ9i2dhbO0FXlfOiWflS1RSBfUaasOZdBaweHmI739P/MYsISqvspiKqawQU3nLBUjW
         IMwaiyhYRN3TuBN0QLJ+tqmZk5fVuPECxs8Dr9taKRmust6cRqYS6vKXO45bAlY65JXc
         1KRUddmm5/gdKlOVNy2z91mcz4dACqX1T+9/tsGxR1e/AHqj4d41/PcxCQnVHBe6UyQZ
         K8n06g3fxqFTlRVaNBpFab3LIjUUDTfMz8AVGhYzwtqWdc7Wg0/vYgXDsIkFT0olZRzH
         XEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778705; x=1780383505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdQjmHgCA99B/85Oyl/wYQVRe3ldFqiFSU1yS4ZaDZw=;
        b=ba/EQWBu+SDRyWXfdG/JS9DQIlrLzN7b9pEnMvLkBe9d8UUFblxE3sVn+e/8Sr5Be6
         fAw19cBT+z7r5zYMiyGE2JEYXuSUQA4e5407flGLcsM7VO3rhMOA6W2YWwH0iK/RmLcE
         OoqdezCAy6o4DUtz1H041/KTVjbqW57uUCpLQd54aHgH5WWDSYWbfrmhVJe6s40B1WWI
         5kXCLDGawePJsmqRvmxapNpemvUW+or6SrRwoXHVTQs5zbEu76sbIYZDNBwQUtg67ZtE
         hnRIrRgE4To+sLlsTUyYy/aDqE/n9SXcmN/n7ANov9aDJ1fZklkHBqKNs4DDsZmX501T
         diig==
X-Forwarded-Encrypted: i=1; AFNElJ+dNrsoU6HGTExM6SThYI9sLDL+1gtVwBnqBwZXg332hcLIx6etE57JiEOgODBfA92rsll5pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaoOyzKrc6eCdlQ/CNDbuQCNfwFOo2P8mabmEJTpI/fHOlx4mg
	ubU0/DcEzccGtKXug3R83FssTrxwT+B0Uoag5XIDm+TYPkQBqD3Lk90u0SPFGl3LA5qXOdfF8WC
	NyNp2oU7YZFx0kAmdd2Hqj0ev5w==
X-Received: from pjbsz6.prod.google.com ([2002:a17:90b:2d46:b0:369:4369:c7f9])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b51:b0:369:971:4883 with SMTP id 98e67ed59e1d1-36a674f49bemr16530730a91.17.1779778704573;
 Mon, 25 May 2026 23:58:24 -0700 (PDT)
Date: Tue, 26 May 2026 06:58:22 +0000
In-Reply-To: <20260525164715.GA2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260525164715.GA2487554@ziepe.ca>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526065822.914216-1-joonwonkang@google.com>
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

> On Mon, May 25, 2026 at 03:29:24PM +0000, Joonwon Kang wrote:
> 
> > Currently, the only known expected user of the new kAPI is our team. Since
> > I test if the patch resolves our problem before sending it, I believe it
> > should be good enough. Do you mean more than our team by "accompanied
> > users"?
> 
> He means you cannot send patches like this that only serve OOT drivers
> to the mainline kernel.

Hmm, it gets back to the chicken-and-egg problem. So, do you recommend
deferring the patch submission until we find a new in-tree user of the
new kAPI? I believe we will not make our module in-tree anytime soon.
Or, is it like I still can send the patch and get it reviewed although we
cannot merge it to the mainline?

Thanks,
Joonwon Kang
