Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C537139E
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637750; cv=none; b=rt5uno0wNLJRBOMOr25SycWCnhEwZasWk6BTqy4eNDxCU4LBET7WLRhDhGKgTV/66cvUhXo3OpLkjTPla8t/Kts0ZT+z2vT83sFuXJL9XiZ3KSl3wJfRc0etx3EYyyeMjs1jLY6BZdm++BcVMnig8pQJWpd0hzmfX+eREQManqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637750; c=relaxed/simple;
	bh=hANOivVIYR7EShD/fOlaDcQiemx66hUbCeB5UoCLsXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYr3OHQJN1SywYa62usOXO5ByHIiQRD40EuVP9dTraa3d8sKFhm6m8faNSWYIex72mQxrgVeOBXeIrWCQmit1KgZDh4qXiSzlf9cPADBG3ruv7oIh/aQYclpOi1Yj52ZKjqmJTrJ+kcmuUJz4fAcPqKDvdyebN9VQbiwfLJZYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlHEq5+1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlHEq5+1"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so5567573e87.1
        for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741637747; x=1742242547; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hANOivVIYR7EShD/fOlaDcQiemx66hUbCeB5UoCLsXI=;
        b=PlHEq5+1rrGk2KRuhLvQOqkVXKJX6HxXMzoNLxizm5vtrH/eZfcF9bFJLa9HbtHe4D
         0Hhf3IDDZmMgyrICUdAYLFkdiabC4uUSmDE0FGhwSncCVs4Y2pB+GBqoYp9xL3idGBmN
         pdBH4NnrbKFuLsZJLKL60EbI1Pa7o1EWfXTpDefw2vu44k5FQS6iuxbD+qnkMEQXkXmp
         yuBmWwgbyM8bacGBujbQnTLO2ABJOzWl2/57yAC7WaiOqxeR4vx/dPeJhieRPe4sgKo7
         i86aVYc791BMm8Cgi75cw5DHWyUDiMlzQ+1VnnnbHVloWTAowmfZNKofR8u16aDtALjF
         wG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637747; x=1742242547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hANOivVIYR7EShD/fOlaDcQiemx66hUbCeB5UoCLsXI=;
        b=XWnNtyRt+G+p6tmaTE1BM8l/HtLx41EcKEvsdwSXgYAZ1EeOwpjv0BQc8uLt3Gwr4B
         y210GqT8mEYIc7QbDuv+NgaKJvM9s1zH1XCdZEVrip1FXXSET2IJaH772v+D+FPp1m8d
         8A78pcxfup3685fKiVFT/iZHeD2I43U2OcXHodqNwHILiRhsJV0bMtrXPVzsT1URnFqU
         9Fjjic660R+n117nQafreefcsJZKMfLaYm1+vrMhUkbpNMhBTgBwndcfdX1x3J6Gl1Xb
         0LnGaK93SIsuj9eTExM/QeyGpTXCgG8uEw5K+Jx9XJhEERNU7cqRdnBqb0VyOZBi6UUe
         pgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtcxh6tey9/JBSO/XZC5w8FAbYgaG7uYa0e+TaoOItHCPfmKrrqi81Rh+M+cNf0JAJruQ+Ng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxha2Ggf5J78TxLWD3z6acg99sF7itays2YAoP/dQ3aYuu12/Fw
	te1gAzbXcndwIATIZ+TIMl2FibgpIMUlkqXKB+LLYbq2suO3NQlQ4itg6WwLBPEXAiuW4TEC7wZ
	WKGcYW15uFBaYN7OrV7KLnigyulI=
X-Gm-Gg: ASbGncsB7mGGWxakPuOtOTNlanslT3Ru0Aire8ZLxPiDU/uG5iuGgh1W/7eEVbK4zXc
	zpHlcOYRGOiuCJPeddyZ8E0XW7fjUZyzLdM7gxbNZLHOrfFrV/a88iiPlDS4yDAV6nCehuLojH1
	0DukAMZlo4QYWDzfDRIFdC7pKDxImYjUubhaRsjEQfQumsjmKda8ThMCRHLn8=
X-Google-Smtp-Source: AGHT+IGwbzDVrXV70eVmsdOraqUbyJCccW/7i4feXqbhKMbNHq3VJ3UtgTJDZtW8NLFupCXRRUQ0/OJpixF6VaKoHRw=
X-Received: by 2002:a05:6512:281b:b0:545:eef:83f1 with SMTP id
 2adb3069b0e04-54990e5e126mr5308092e87.17.1741637746856; Mon, 10 Mar 2025
 13:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
 <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com> <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
 <c99db1aa-8b3e-4a8d-8cee-b9574686cb7f@arm.com>
In-Reply-To: <c99db1aa-8b3e-4a8d-8cee-b9574686cb7f@arm.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 10 Mar 2025 15:15:33 -0500
X-Gm-Features: AQ5f1JoVCp031Gb_geASbG5I-LIXlAD9YBo601M-R75x92j2OnP9rX5cIKHcrko
Message-ID: <CALHNRZ884fF4kpM_=N4d1vR27-9BOeaS7_cN_JhKN0S6MYQVQw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in arm_smmu_v3
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 2:52=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-03-10 4:45 pm, Aaron Kling wrote:
> > On Mon, Mar 10, 2025 at 7:42=E2=80=AFAM Robin Murphy <robin.murphy@arm.=
com> wrote:
> >>
> >> On 2025-03-10 6:11 am, Aaron Kling via B4 Relay wrote:
> >>> From: Aaron Kling <webgeek1234@gmail.com>
> >>>
> >>> If ARCH_QCOM is enabled when building arm_smmu_v3,
> >>
> >> This has nothing to do with SMMUv3, though?
> >>
> >>> a dependency on
> >>> qcom-scm is added, which currently cannot be disabled. Add a prompt t=
o
> >>> ARM_SMMU_QCOM to allow disabling this dependency.
> >>
> >> Why is that an issue - what problem arises from having the SCM driver
> >> enabled? AFAICS it's also selected by plenty of other drivers includin=
g
> >> pretty fundamental ones like pinctrl. If it is somehow important to
> >> exclude the SCM driver, then I can't really imagine what the use-case
> >> would be for building a kernel which won't work on most Qualcomm
> >> platforms but not simply disabling ARCH_QCOM...
> >>
> >
> > I am working with the android kernel. The more recent setup enables a
> > minimal setup of configs in a core kernel that works across all
> > supported arch's, then requires further support to all be modules. I
> > specifically am working with tegra devices. But as ARCH_QCOM is
> > enabled in the core defconfig, when I build smmuv3 as a module, I end
> > up with a dependency on qcom-scm which gets built as an additional
> > module. And it would be preferable to not require qcom modules to boot
> > a tegra device.
>
> That just proves my point though - if you disable ARM_SMMU_QCOM in that
> context then you've got a kernel which won't work properly on Qualcomm
> platforms, so you may as well have just disabled ARCH_QCOM anyway. In
> fact the latter is objectively better since it then would not break the
> fundamental premise of "a core kernel that works across all supported
> arch's" :/

I'm not sure this is entirely true. Google's GKI mandates a fixed core
kernel Image. This has the minimal configs that can't be built as
modules. Then each device build is supposed to build independent sets
of modules via defconfig snippets that support the rest of the
hardware. Then what gets booted on a device is a prebuilt core kernel
image provided by Google, plus the modules built by the vendor. In
this setup, qcom-scm and ARM_SMMU_QCOM are modules and not part of the
core kernel. For a qcom target, arm_smmu_v3 would be built with
ARM_SMMU_QCOM. But then any non-qcom target that needs arm_smmu_v3
currently builds and deps qcom-scm. But there's no technical reason
they need that dep.
>
> Maybe if you can find a viable way to separate out all the arm-smmu-qcom
> stuff into its own sub-module which only loads when needed, or possibly
> make SCM a soft-dep (given that we already have to cope with it being
> loaded but not initialised yet) then that might be a reasonable change
> to make; as it stands, I don't think this patch is. And it's definitely
> not a stable "fix" either way.

The cc stable could be dropped. But I'm working with android forks of
6.6 and 6.12 currently, so I was hoping to get this pushed back to
stable, which would eventually filter its way over there.

>
> But frankly, weird modules happen. Why the heck is parport_pc currently
> loaded on my AArch64 workstation!? I can't even begin to imagine, but
> I'll live...

This is fair. But I've got to try at least to make the module
spaghetti make sense. If no one tries, it just gets worse.
>
> Thanks,
> Robin.

Sincerely,
Aaron
