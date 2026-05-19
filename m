Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06410366DA3
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223849; cv=pass; b=rpjIj6ZF5DkT5nUFWmsllaO+tLkxqBg070XtRCvNu59/bC+DGppnE9luv3Ovji3dghSBSfOEwjerby87ii8tbBFfyCkR7w0L4SXilpvZL/Bnw6JzJKoOc7A5QL+b6Zg/S5UrOXGN3M7v7dQltx1Wsb30G+Ng2AewymtepowWE9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223849; c=relaxed/simple;
	bh=UI7Yy/AUKawJ1CXhCsWZmhD6VQri2hzEYyhv8IKC608=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQT75DTxUw9GVyiFINbYJiyZl/7vKftvawd1Pf1vVPqGLPnLTQTE/q6WYuSzKuEpjGkbmqIPJXCG2AkICAiKrDhAOM5btBq8ziMvbAdDZufrKQMeDEHM1m+U1vKCjlwWpcHu9IS7eO77VWp/G5ZRQeMEeuqzSXfphlqfEPTWdW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eG0e1VZG; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eG0e1VZG"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-515548f390fso13801cf.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779223847; cv=none;
        d=google.com; s=arc-20240605;
        b=Lafq5Po1eub8POBe+MRuqXrfwE1Q4+iEic99I8s42T0Xvf5+DtG9Yytp4WmTS1xsS3
         ayS3IZ+E+4BBHooRh5gKFSPfoVBY4QVarJBkqwmG7GSnlMOkRsA1LTQvqeV75ZqyUUzJ
         p7nlHKzSkGeqPMPmGG11qMNVL95BdU1FNcBjlpTNr87JQEkIROQRo7ucnOFEa3/nB31Q
         aw0y8fC9U7UlhAOF5ge2AYpRPM4aotV1XqDXYJ9FhPGuqbmXdOpsh1Wh4mdxlDTSUjvX
         5n2q9ZU534vQcmXvTul0XLBXSsY1Jq5HZYNhobqkyCu9PBz0kkbGTaz8GehDWc8cOTSk
         8Wsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4QDMEmsI+BnHnpkxFbvXdiT3cC8vd0R8/CbFZKp50g=;
        fh=l6d/N6u1hLHPo4TGqiX7B6XhUFrf2YjgyiVnG6QkPqQ=;
        b=XId8OBmWgB94iD37kQXBZ1l94jdM4M5zOZVW62m0zpHCdX/EKoez9gYA/KqpWq/eWV
         18gdfVn3V6kqR/8BrDwHVnzJb0Oq4+ydBwm+nyeo1fCjZhuRG3anLXUL6C2Fl4DXYi/T
         UNiNEpmHpukTEAgPRy+aA9cPvaJeZs0JArgaFehs6o8VAjjaybzfuXCWujdwUz6R11E1
         Pk87xzIGXddUlNF2tmXel+QrQMr23TF+EeSOl/Dv/T0bbeCUDguRItzUffkHWWz3dsDA
         XfLr8Zkwal9bE8HM71+ZRS71FTlib8XCcFpNaOZvROsAwj94UR2d3St56HkEStCLG+Bn
         X3mw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779223847; x=1779828647; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4QDMEmsI+BnHnpkxFbvXdiT3cC8vd0R8/CbFZKp50g=;
        b=eG0e1VZGhL73pUcXLQv3inCTHNgMPbqO/CZpXsxeutTdu7T71Q6kV9KIdqmAolerSJ
         Q1EMlPLtkltsqxmGmcLP6YZDngNhsIe7Lj4cHtxdi7YYD9SmgUHzamJ1n2uvQQwWnsCm
         SHRWo5ldOKtsmRXP7OAxp1kOm82uT3HRD9O0mKyxXJJCOJbf09bgc4rzU2oOFFAmltYM
         GM60Tij+NbffLISEdczQxzTz3f3g9axuBeJWjeCoP9Q4O05s2WpH6k8OedKr2Uc/ayV9
         nOzwq+f0b8lxSveG/atQSIBpS/F9g2Ahc+v26kQxGmh/qsFe548vLshC6nYJxnfhkfVi
         EENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223847; x=1779828647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4QDMEmsI+BnHnpkxFbvXdiT3cC8vd0R8/CbFZKp50g=;
        b=VI0M5tbBRdJkFwnaxBg7XFYuqdK3rVt6ILzeXRmxJcBjdD4GrXf/bgu8bw001fSWH/
         hURK2rIkzYj0INxhzoojCrfAVQs8PygHiAK4VUQqGNEw+QJ9UvT/E/6iznM4sXGqeob5
         cFHhmiuapoL8lJUgJwbagYizGe//uHZKgjC3Tg9n4KCsqf6fBxJMcDkjEt+x8T620E8i
         w3G1mUfQb4rZvwDehUbjPJl866MHMlQ9vLi4UynMP5ULVksFkkvG9iohKKBuv1jSEVTW
         0vONUZWlEqesMXWG6lRYijTEd4RJnPC2KROa2ybldBvf5L/s9p1E745sjDe4Sr5fPZm2
         MTSQ==
X-Gm-Message-State: AOJu0YzdRXeFSThmhhe4QyhRs8vAPVxtkJhwfqyRd/O/Y1EXh6ESsM6V
	yVKPt82luvp5zIVk5X6ADVSXZn5QqIDlIhEiO66fYMYyp2lZi063dM7eERy+ss20e1DHx2NWG6l
	hdxQytA1DGDSDqjPt6BKFFUjG6knT8zaxoxoNaYq4
X-Gm-Gg: Acq92OENrqKdYuRSh9CJX4cQ1dfyatXKgbR5ZgwFDmEq6Xk8VBpiBckMRzulzVegZah
	s/9RHub/5Eb6DYxTZvfVkc7d2mqj1sM90U1ddwomryGrj9RXzyK6ht06JBZpnax6+d0hC2hplcL
	SHHmivFlpSoQd9ECUBmU87r2neiZoNpneCARSoG9WWgmydy7BduyMwupz6PoVas1kjT3AVzssAB
	B62dm+KGGh64/Vn3pCbDHbg5ofWpWjBkLF22iPJ0eyTM4eAjw5EUzYR9psFLjheEqke7tfyZKhm
	RLD91O0k44BI4MEc0Z3uNyMTs0pnJcfFmuLGRnsAUGFvaUsJ
X-Received: by 2002:a05:622a:1f0c:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-5167937eeeamr33662871cf.8.1779223846066; Tue, 19 May 2026
 13:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com> <20260414194702.1229094-8-praan@google.com>
 <CAE2F3rCaBWtRruBbZcedrsLnkkETSniTWoxxYn+Lkac9ttsshQ@mail.gmail.com> <aejP5Yk72_FtZnIo@google.com>
In-Reply-To: <aejP5Yk72_FtZnIo@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 19 May 2026 13:50:35 -0700
X-Gm-Features: AVHnY4JwpFjkT9rm4MfBv1NN3q4y7OMopDf20ebfRmMrDdf5jsVUtIgiztKWXbQ
Message-ID: <CAE2F3rAWu7v1OXuGuSOrKVXiaSe+ePP7mMVjYZ9z0P0181areQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 6:41=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
> > > +
> > > +/*
> > > + * This should always return true if devlinks are setup correctly
> > > + * and the client using the SMMU is active.
> > > + */
> > > +__maybe_unused bool arm_smmu_rpm_get_if_active(struct arm_smmu_devic=
e *smmu)
> > > +{
> > > +       if (!arm_smmu_is_active(smmu))
> > > +               return false;
> >
> > I'm wondering if this check is redundant. What would happen if we remov=
ed it?
> >
>
> You're right that pm_runtime_get_if_active() shall suffice. However, I
> added the arm_smmu_is_active() check as a lockless fast path for maps

It appears as if you're optimizing the RPM_SUSPENDED case at the
expense of the RPM_ACTIVE case. In the RPM_ACTIVE case, we now perform
an additional READ_ONCE(smmu->cmdq.q.llq.prod) that wouldn't otherwise
be necessary.

I expect unmap operations to complete much quicker in the
RPM_SUSPENDED case anyway, as we skip all communication with the SMMU.
Consequently, there is less motivation to optimize for that specific
scenario.

>
> Consider a scneario where there're high-frequency unmaps (unmap-storm)
> while the SMMU is suspended. Without this check, every thread would
> contend for the dev->power.lock spinlock inside the RPM core
> (pm_runtime_get_if_active) just to discover the device is not active.
>
> This check allows CPUs to elide the command immediately without
> contending for the dev->power.lock spinlock inside the RPM core
> (get_if_active call) and avoids unnecessary cacheline bouncing when the
> SMMU is suspended.
