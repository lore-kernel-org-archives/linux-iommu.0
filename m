Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5423C514
	for <iommu@lists.linux.dev>; Sat, 31 May 2025 05:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748668823; cv=none; b=pjtEUK7Lg0ZZD4Q4QJ3OCAyyraSToTY4JufXYE9DP27dRUmG6TvOE3BieWIuJNbqyH7eh8FhnIxaMsxuQpv7Md2FYORacs0NJDBj9qK21lqV7LZwkpDj31JwbT2l4CPnaqYa8jLcT4ml9qmhOJ439S22G8/6whePRI3hzCe2iqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748668823; c=relaxed/simple;
	bh=b9ukqDvrkKLIVbh+PT8qxjXuVTRljNucBJtIcPquS/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nU4+Eultsp3F4AGxUDZMse9cOtX89XvAOfiApWebZn5kD4C0+TV9dvo1g4K5BqUqyURh8gq6uNFIoiXNIJVPQZtYYv2YC6HD0yyyfFQldFIsjFiEVYuf+pwrYGStjJpsC+HZ1yLAlGxIW+AT4jv1vjtlr+EizLwO+WaaiqL6iZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IK+C0e+g; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IK+C0e+g"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-602e203db66so4541437a12.1
        for <iommu@lists.linux.dev>; Fri, 30 May 2025 22:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748668819; x=1749273619; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jEfD/+DM5D2k/gXm81XhYIsGawr1I/4vC95VspHPajY=;
        b=IK+C0e+gLASAnugXlIJ4tJ50rgYuhEValVN9yF/KCzvuEGLrJwWjx0m54T0Oyq0iOU
         TWo1DL7wAWdEzhmNR87ayeSDhf+aBaLrpyYbeIf+41Nq+H+5G4hAkvqt/Q2KHO7DrfvY
         wxndj/mJl+d4SHDADKoX7b0OajWmpkyzeF3Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748668819; x=1749273619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEfD/+DM5D2k/gXm81XhYIsGawr1I/4vC95VspHPajY=;
        b=XDpaMIEuz2VtSBhkN93cGeXxbdh3+k8Pc9uh0KFcuNmKTVFhwjRjoy9MCacqNlp3yn
         wUgms/E8dV4/hiXNC/znE+EEP7z+tqP1D0II+DNxzqtqVsk+vctbcoO4PjtWzt8lPQY5
         1zH1zo5DK4jWdriNBF01R1jaSFzUR6Cnn+7wxrBY73oHJvsVUMvNMx203nejv8f3Ib+C
         e8CJmN90/h/ebdZXvnvt3ORJuy3LiaMSfFdK7ek5p/Xca6bKTZxSOP1CAHJwQEUxelhh
         TN+0g4bw266lmQt8u7xYJJEarhwhOrYnkF971ySjy4G5dOT5U3VLtf3gbkk9XNkVaL1Z
         EmDg==
X-Forwarded-Encrypted: i=1; AJvYcCWy4VHB4B92dgQWY9hz1ikgHygAK5G+mCMiurTEKvJgWkjjVCV1g/JqHwGUzyRhLJ9Fg6gO6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi44meaMtQ2JbJ8jcjZBY+MX00kkg6/1zGeJ8MiBBSefoo5/E2
	MIsH+oXW4GMm3uzgD9Z7JPrt+EAu+hjAdtGYwO0pgD0J/1T/bJowBcixZR9kQ0oKTXwvhsv6r6R
	9q1k8f2Y=
X-Gm-Gg: ASbGncsa7AEuoMJ00m8+ZN+Ekq1G4pbA9l9KeJvS9WfjZ/UesQb2828CnGw8FD9mhTS
	zPRHavIaDURzS4z8f5f11kf1LJ45GKf8vY2uT7CE6eE91ftgiljKRsXpWxCFalWKdS1TfZSM0xv
	G1lDtttln79i9F9F5Npvhb0JaJ3ZFqSApmXPXSfIN5khuYSgdh/eD5056Ee4TxaF1GKCuybZtYq
	WUnS0vJwfPNFMmbXyrD9Lru21KitcXO0eHP4FrETozbKkVZAQS9gTNTOlQFHx7d6opdivNsYsCY
	BD+qE0KG35Dml/JpJW9gKK+jNLMtDA3WIuL0Pg7b/nf6l+cfkZjlcFoGuff6nsucMarrQwJ1st2
	IPMraBWEOcknqGa4HdfFkUC5v0qXUWxv3e2On
X-Google-Smtp-Source: AGHT+IGLjEmuEmCr+A+wP8D0kKpWiWMzUnyFAXBVapS4meMW950RSz4ufzZPqW+Yh9Tr/irOGPXmrg==
X-Received: by 2002:a17:907:3e0e:b0:ad8:96d2:f3e with SMTP id a640c23a62f3a-adb493e3ff8mr80028666b.22.1748668819361;
        Fri, 30 May 2025 22:20:19 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e87esm439845666b.63.2025.05.30.22.20.18
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 22:20:18 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-602e203db66so4541415a12.1
        for <iommu@lists.linux.dev>; Fri, 30 May 2025 22:20:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfDPTyqGVGDY624LLShvfU0VU7eRo5mvu+ajp8A2IbDeL3PC45plrosNAIhXnPQE/xf4leXw==@lists.linux.dev
X-Received: by 2002:a05:6402:40c6:b0:5fb:3a35:b8d8 with SMTP id
 4fb4d7f45d1cf-605b796da8emr804228a12.20.1748668818330; Fri, 30 May 2025
 22:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aDmght5YpHmJ6qZ2@8bytes.org> <CAHk-=wguPX5w3UVmQpOk+v1ahJwRzRNXKHUJB92cwJfNpMU4ZA@mail.gmail.com>
In-Reply-To: <CAHk-=wguPX5w3UVmQpOk+v1ahJwRzRNXKHUJB92cwJfNpMU4ZA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 May 2025 22:20:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4qRwm7AQ8sBmQj7qECzgAhj4r73RtCDfmHo5SdcN0Jw@mail.gmail.com>
X-Gm-Features: AX0GCFv-R_VgM748qQ2znX8oK1KrQk1cZwPxjrDOqD14wEHAYhom0j694KMvVuE
Message-ID: <CAHk-=wh4qRwm7AQ8sBmQj7qECzgAhj4r73RtCDfmHo5SdcN0Jw@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.16
To: Joerg Roedel <joro@8bytes.org>, Rolf Eike Beer <eb@emlix.com>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 May 2025 at 21:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Bah. This seems very broken.
>
> I haven't bisected it, but my arm64 build - which I sadly didn't end
> up doing earlier today - breaks with modpost errors:
>
>    ERROR: modpost: "arm_smmu_make_cdtable_ste"
> [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!

Ok, bisected to commit e436576b0231 ("iommu: make inclusion of
arm/arm-smmu-v3 directory conditional").

Which explains why I didn't see any obvious code changes that would
explain that.

This is with a plain "make allmodconfig" build, and I think the issue
is that CONFIG_ARM_SMMU_V3 is 'm', not 'y', and the change didn't take
that modular case into account at all.

I'll revert it, but I'll wait until tomorrow to see if somebody has an
alternative fix.

            Linus
