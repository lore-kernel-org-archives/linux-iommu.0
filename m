Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7AD19E97B
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059763; cv=none; b=EAvYm+WaLIKkn9ZsspW0q6RlTYM4+AD5TlPI3wSgarfZSOOndt+mhozr6TFQlL9LbJDQUCTclFCW/ACfnNOhlXKYV7xwNQFDARIpK8Gwv4GpiXQWg2KPxZdsGbMNDATwqITyQ5+xnsAK5SXCZOhAkd67gNISSoAZCUQTzw5JSQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059763; c=relaxed/simple;
	bh=7c5rwEMg8SrN1qzR5HQA9Xm/CmUTmi2KGtRzPG/E4B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3WEuktUZ1Gv1LyldsIfWSdd6GLgC4BF6DmoHyRXqd8GGxRPBI1wRoAXSWYNKmygqv44xAFCJWUG0X+NBEWnHtMtY2LtDMvh0tV+kYIBtei5VuKR2nlk/6MpVYVjJRBfe6rndQhSZuSCYACEWs0DgxNoJz7z1iYLBqSO1BWK+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Jm4e6K+C; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Jm4e6K+C"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4df2911ac5aso8889361cf.2
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 18:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760059761; x=1760664561; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c5rwEMg8SrN1qzR5HQA9Xm/CmUTmi2KGtRzPG/E4B0=;
        b=Jm4e6K+Chx35t+sv5M633IdZZXWze0I//ghXC0qYFAWrz2Fv92xSkZ+0jE6IveGc67
         jVdcNVUJ0MP4eSkRxaFgFzuRTEppellaYCmR6AIj91CI9ihAOjK/Ar5Z6Q/tWSz3Yr4+
         kC2qQgQirJxkRm2PJbGycxfSzqrTD51rSpBa+Z+hTJUiELK5jqwvzJCI3bDOLDdQGJr3
         qsY0Jlqn26rSs/To0akcEHnbQCFTJURXDD32fu5cZ4WTr0toD5OphZxboCZoC4lzCKlz
         PRBVotxp1a5KvFpu7QAfGmEt9YVvw/S/M52YnxOOlz2ST/ZtO4e0NqnMFf6QQ8WX012u
         ZO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059761; x=1760664561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c5rwEMg8SrN1qzR5HQA9Xm/CmUTmi2KGtRzPG/E4B0=;
        b=J0tZtECpIQf5X1Wk5DvmNA0QHA+J8cjo5sEavaWuRae5jMwiVJoUJcitzx/CxQHQ64
         HQz3fZvIIn+SalkqtZOM5shfB/BRJ4tOU2/f6HMD60xzWCxA7eyV/im1taogYPquvZXx
         a+f9kIQIm6/WuLqzz8wqo0VC2RVuJM4Cpy6igYHvSNHpsxZ22Cpjol6ZgXv8tc8GZRUL
         94hYrDRUrcZCKe0CEqTA+UK12iPOYPHbI5C1w2YZCe3VdgOff392rB3BMQtF/KrSTtCX
         R4vs4AVQUx1K+sKQRYqba2Q1Cu121Uw2ip6SbyUL3stChzEaTcn9X5l5r8a/SQOoKxYe
         zOdA==
X-Forwarded-Encrypted: i=1; AJvYcCU7qP3Hp6ldOu5Tsfq+084Ei7Pu0ecr27wKpEOvT+sL377F+qYwItslt7lJbyqDqf9Nun1wyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxOzjImna2l9DMCVTdiZbsoHiKOMXkuxBe2ZAOEYZeMkzo7HZa
	tnUjCEBTs3XKfflIXIyg2GpCTSC7SE52MvCDcHTU+1SsJgYVs8t2BKev0mMpE+vMgNIE2aE/E7g
	2eZbKVvU7iZyEQcSH9UW3VkIsTNAQPYuDz2ovdcDu5A==
X-Gm-Gg: ASbGncs8+FOZnyyPAos7exj2yX9N/qJ8em0ckinCdFkp2AWLrbUaLH1a8sGM5LlJQJ+
	IquRCr/WNo77ZxwPEpjDJ61isQbMWrul5ILBtLYuY85n8RrmP9Y3Dcfjme9jiQGm0Q+vCDdOb+W
	avqIVcf7ACd4byvTk6mtwF3A7Tc69mTalnVBwwIyzxWJD8+w/ZgeR0ryqBJsGzel+T8vbEL6Jr4
	3q/JCeFEHlPqPOJnijFR2IaDVNn
X-Google-Smtp-Source: AGHT+IFYIAwQ01bOh934nEooe6YyzjY9BSYL4qW3XccSVaxr7aFcJrk9W6LVbYGLQHAQNTZz3Rnu871Z5RCJbyw4chg=
X-Received: by 2002:a05:622a:4c18:b0:4d9:f929:1531 with SMTP id
 d75a77b69052e-4e6eace963bmr157505201cf.23.1760059761013; Thu, 09 Oct 2025
 18:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca> <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
 <20251002173715.GH3195829@ziepe.ca>
In-Reply-To: <20251002173715.GH3195829@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 21:28:44 -0400
X-Gm-Features: AS18NWDnCmbQmTfSFshrGhyBAifH9UjAR4aAfwdB_LFAs9e46ObD6oWFGCIZCGs
Message-ID: <CA+CK2bC58SLTrROtBQaegzSfjU+bwH_3pjjWdd+JTnHqQPuAwg@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:37=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 10:03:05AM -0700, Samiullah Khawaja wrote:
> > > I think the simplest thing is the domain exists forever until
> > > userspace attaches an iommufd, takes ownership of it and frees it.
> > > Nothing to do with finish.
> >
> > Hmm.. I think this is tricky. There needs to be a way to clean up and
> > discard the old state if the userspace doesn't need it.
>
> Why?
>
> Isn't "userspace doesn't need it" some extermely weird unused corner
> case?

It might be a corner case, but at cloud scale, even rare cases happen.
For example, if four VMs are resumed and one crashes while retrieving
half of its resources, we can't simply reboot the machine because of
that. We must have a way to recover the machine to a normal state,
even if some resources are not reclaimed. I would say that finish must
be properly backward-ordered, but we still should release resources
that are not reclaimed during finish, as well as those that were
reclaimed but later closed.

Pasha
