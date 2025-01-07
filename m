Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A449433AD
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263619; cv=none; b=tY6J7Fo04xLzEP8bFxb+5Mpdwo490qsGz0toEd5lVB1tCi719qDLK8vsMY01GMI8xYwua+tVZ0896E+sEGvB6/nYnkTu+vDV4GxO1utGUN1++XaoZJMkcxOpG7oGtRP5iQ0qPKQQlxmp4NnsUkLIhH6jDAhgOMgb9fUtjC03R+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263619; c=relaxed/simple;
	bh=GnC9g6z307dLDtyo2LZl3efcrpZxudO80UZjLWvMufI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDeTPGgAG14GggeBT+PZiOAPbFysa4HkIX/7PnJEmi1wh4PZze5ZNHFkCLZgnCQoore2Rax48oKuZBm1LcjuVsJwNuOyybhdGcACeAKBZySTUI2J6KumuHa2lKLWrV8w+finUeMxIRkimP8n5mhCNLgmWLvMpuhganI+endbLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGCXF3Hp; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGCXF3Hp"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a777958043so61792285ab.2
        for <iommu@lists.linux.dev>; Tue, 07 Jan 2025 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736263616; x=1736868416; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYd26+ANvMzt3bh8JMGQhBXRVd6LUHx6ZcNpu+1HZ/s=;
        b=IGCXF3Hp3sCuq6GahDF3VAfJOPfkXvTuDFKQg3jUWR+qNySynL+pjlJM61kRipXRby
         5Hrapix0UqjpEwHzmlZj8klJd0KAi23VVCk3Zy7eJxH9MzichEfjnrnxz0o1JqcykDSM
         APwQhMyaHooAClDBQRYvcRi0Z8Y+rJDoNDUMzDPDjTFhcNK7qoddcLqoU4m9OOtKH/FM
         QjygnZ+vXD4snnTS/0S5RExDEBzJshF2z8u1T7SSrnCTyJVSdACypDVU48d5JNOoUBj6
         ILdFmHbBfy8c5QHXpe01GfvUmzLBT677dOAPxsh/IatSP2t+4hRRmqDXU6qrVanZitWI
         phUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736263616; x=1736868416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYd26+ANvMzt3bh8JMGQhBXRVd6LUHx6ZcNpu+1HZ/s=;
        b=jjAp00O9Zkk7P0Ga78TeuGwzAIAT2YSoayiyjdY7129QgkYD19cd/dO7SreY2Lw16h
         W4MeYR+jBFvly5PpAd86KJR2MLATYURxyHv6+bVQE6tuJhDVznpR2GpwMSuOFwye1zsw
         vmoa43zJJsMGpaIKkccciki4d52R0Y2yF0W7oRZTOTz5gfh1GsQ9g7qOOSp0GQVnS2/5
         KinZrJDQXglQYQfCFeKD+hAY5VbIxjYDmIb06s4KxwqsKf1d3E8mL/FpSqdlBzc6QJQi
         u1Y7XLk+r2KmqIekwuEhJNV4+ePxo2KSF91MS8BS/8PYjh8ZtbVcMLPfnG1ZqnUnD1py
         yQ/w==
X-Gm-Message-State: AOJu0YzHUDHDHxmsJGEqCEjUkV/YP054wj2qoYeHKVgTPK+1SrPhWOoy
	xuoaNUXxlbMVeeg9lGiJNsa0w7ncIgZFJRu0eAkNGjJ0YZJwBPp7yUOhh+qw0/4FWp1jVEbtTDP
	aOw3eWBbsL4XCXuXJi7OMAcc0geI=
X-Gm-Gg: ASbGncvQaQ5okQ7M+wOYHaKjUrqOWCeFKiKn7EjOhuT53VePGoaE9BzbTQnGle764JL
	zNVYjGaMHFxTeX+tkEUYw4TRbM7cTM1ck+Xe2P3IREqYj3OBVeCqxWjJfpMwoZdh6ZyRH
X-Google-Smtp-Source: AGHT+IHwuMLCJR6Vl2J967epV117Dufpeur0fSxmS2hJJtoEYpotAHxco0Dw2fvR3j5a3grMMCdXDq+mOt2AdoHs9GI=
X-Received: by 2002:a05:6e02:20eb:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3c2d2568e30mr508063205ab.9.1736263615657; Tue, 07 Jan 2025
 07:26:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250102183232.115279-1-robdclark@gmail.com> <20250107125738.GA6991@willie-the-truck>
In-Reply-To: <20250107125738.GA6991@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 7 Jan 2025 07:26:44 -0800
Message-ID: <CAF6AEGtZSOMi-=AOmjoXSVkwfyvKOymSuRRMZ7jOcM2wyhu5qg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Only enable stall on smmu-v2
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:57=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jan 02, 2025 at 10:32:31AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > On mmu-500, stall-on-fault seems to stall all context banks, causing th=
e
> > GMU to misbehave.  So limit this feature to smmu-v2 for now.
> >
> > This fixes an issue with an older mesa bug taking outo the system
> > because of GMU going off into the weeds.
> >
> > What we _think_ is happening is that, if the GPU generates 1000's of
> > faults at ~once (which is something that GPUs can be good at), it can
> > result in a sufficient number of stalled translations preventing other
> > transactions from entering the same TBU.
>
> MMU-500 is an implementation of the SMMUv2 architecture, so this feels
> upside-down to me. That is, it should always be valid to probe with
> the less specific "SMMUv2" compatible string (modulo hardware errata)
> and be limited to the architectural behaviour.

I should have been more specific and referred to qcom,smmu-v2

> So what is about MMU-500 that means stalling doesn't work when compared
> to any other SMMUv2 implementation?

Well, I have a limited # of data points, in the sense that there
aren't too many a6xx devices prior to the switch to qcom,smmu-500..
but I have access to crash metrics for a lot of sc7180 devices
(qcom,smmu-v2), and I've been unable to find any signs of this sort of
stall related issue.

So maybe I can't 100% say this is qcom,smmu-500 vs qcom,smmu-v2, vs
some other change in later gens that used qcom,smmu-500 or some other
factor, I'm not sure what other conclusion to draw.

BR,
-R
