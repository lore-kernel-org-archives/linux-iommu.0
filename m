Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9413090C5
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383272; cv=none; b=u3lMwlFkR/WWGj+/adHFqjyU6Z2uhYZ+UgM+TnYo3ooqOIJPE+8GQM4eRgspkb+VJnHFe1WHj/4Na4nhABcv2cqoZsKf1r/idtlg+xE7b/3ZYvO69ffEQwziQ+3FTVom+AnJHAWESzXj02pBu05vso0H7n5j/ydJr4XMYcyZu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383272; c=relaxed/simple;
	bh=ejJ8WBiiXzLknFE5MeSm9cbu5Y9/2HuvAnkw91kSo4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4m5kCVr2UcrM637eLb9Y1JDx8IucKEqQ71mq/qZ4fpeVMAoXRqFZJpbKXVyQ85GtlB89iijh0rO7Uqosl4Bp6vAh+mgLspSNUgjEwoBpIjNLoJBelY6fgSs8GoRiKP/OYnp0gkvie4awk46bFq5JYf8tKcMfIpauTE2+bCcjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=nxx/8Gbf; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="nxx/8Gbf"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a2ee65171so44510917b3.2
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1774383270; x=1774988070; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pj8+8/JJ7h3b7BpKS3uF06MRnM+qUNB5Mr/NDCOtqmY=;
        b=nxx/8GbfaV8EbLcDXAQAKzJCLnqdV1DuOWdF0u48Axrjf9knfLVOqwojJCfRVOVIpj
         fpy55e8OINZM0HrRlGKq9aU9luDskNS8GM/9AnyYsG8+WNr+ZrcgHlaAEmjWTPP7NOgU
         X48GUy0nnh2tJQ3xNMTYqjiI70C+36BedOeSLZiapWraOMbnO8wUbxBn1TLh4LaHehcS
         /VNDwR4GvZkquWTRUeuLFbYjFqmR5e7zJoslaVKEZUViDmYggQ5HrL8951Mn7/UNI3Ev
         lTHaaN2lUAjDsoMw8FGRkDrsQ8kM+AQS7CYjp2kUL3UFsQ/fbPaGwPuwitfvr713HKBy
         4G6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774383270; x=1774988070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj8+8/JJ7h3b7BpKS3uF06MRnM+qUNB5Mr/NDCOtqmY=;
        b=khXhnEG4epNM9JyX47adnvMrJtW3pttbpx2g0Kb/2nDpt61Rjim2kbnJ1Osnc11KHK
         p1NGC/LNZMh9uDnZkIbycJ+GimTVo6xcAx+0am09KHbVkcIYDNsKojyoLC4F+46aJ861
         mWWn5+HG+QwVUWoNF6iaqIT3KDrOidK+ZksGaeDGhsoIGHrDOmHRYzBT8Z7RRUsrxDwB
         AlMWLQRKumGrHzKd7Gew05OBOLp1kTkp6fDxWuILGq534kzr6VhPVLZyy4+T9PtXeU+R
         U+cA3RfBmyZ5HTPzb+ho6gl3vnqedKx9uNhYnLtqdfTJhWxinfIau29aTtbfjchPenWz
         wdOA==
X-Forwarded-Encrypted: i=1; AJvYcCVV050VcZjmid7h4KvohiAIotlt7mRdvCUjgiUgzRuMK6JaJy1nAde+2YqHTCNWDuDi2iyi1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwwVdOCnEtNFwOPfCv3klnFnbS9ZLRERbNtkTeYwUYGN/Nuzio
	Uz7yX+jlxEmq6XvD/zdg9+n6YnSbhDs6ksQ4ePvqlFvTeKcgJWJh+fmW8b7+wS68+Ao=
X-Gm-Gg: ATEYQzzX2xUpYKhEiPLX7QNz2+TXf6GPpbCDhbi7uFlsFdnM5cjoLNl5vH7gdDQqBHI
	5UDBEzRV2FEVqkqUkfU+IIy90FaosWV1/R4PyXxby0l777oTWWAnv4jf7wGDNmMRr/nEWa+Bro1
	1QIWbajSUH838d9jbShlwrdoBQsigpGz8ECrW816LB6qTksTaiW3wLLEiIraweaKau4v2DK9qWQ
	vtA1B4sa6tJHWKKAa32s5Ba56GbYEX1HtlSR1Iyj8g9fMbV0oE2uzR2qZdPX8DnGaf9ruH1UZYd
	CdtJWJoOJ4yFEbeX8lnUZVH43u50EbBIhcQLxwFG7v7khc/cXrYDoL8O1YGyjme71avARd4kA9C
	9tISB+L3KNNun1IHfb0Hae2SRglHbnueZFmR37Np77+ezquqcE/cdMDrxfFGBz05XTFEWgPByMI
	JnvJv/tE8Bkxz9GueCoTscAL0n
X-Received: by 2002:a05:690c:d89:b0:798:6042:12b9 with SMTP id 00721157ae682-79acf397948mr12408687b3.19.1774383269665;
        Tue, 24 Mar 2026 13:14:29 -0700 (PDT)
Received: from localhost ([2603:6080:7702:ce00:dabb:c1ff:fe4f:43a2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79aca5fef49sm9513597b3.30.2026.03.24.13.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:14:28 -0700 (PDT)
Date: Tue, 24 Mar 2026 16:14:28 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	suravee.suthikulpanit@amd.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
Message-ID: <20260324201428.GA3698093@perftesting>
References: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>

On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> We are hitting the following soft lockup in production on v6.6 and
> v6.12, but the bug exists in all versions
> 

Can I get this reviewed/merged? I'm hitting this softlockup hundreds of times a
day in production and I need it in stable so I can have it backported to our
kernels. Thanks,

Josef
