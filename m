Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8982FD7A7
	for <iommu@lists.linux.dev>; Mon, 13 Oct 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347961; cv=none; b=IiOtMkhyEaqwPFc+NAzHFKQCPUVjLM83w/h0IrwdmbAOWQjo/OrHUQRDWcec88+eOdWqRVGs6BEkcrbe8aTEN9vLKbyw0gtWAe+DgwEv5/iuh1hwFCdnCfBEPyCwgtFqp5vxrTh3yo4vacQFyy6JAhNU36vYVJwwanp+mihIP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347961; c=relaxed/simple;
	bh=/RdAf5lc8yISn7YJzDBYoS5c95yTpesCdkfWXNuZnG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQZP3Q1MNwNlHDvu689gBEFv6coQ6ouiNUKDB6hZ/KypUhebaKrEwQhu3qiW3gnUA5BXJxVDX5aN5iSUglTZHjrxayEJU7jPYqJtymj+Qn9Y+f6evR29Bre6mMR0qEiTXOMp0lxJdK/okBEXo6IPP+E68EPK98Yv87DYGOG1YFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wghQByFk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wghQByFk"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4308afd43f0so1102965ab.0
        for <iommu@lists.linux.dev>; Mon, 13 Oct 2025 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760347958; x=1760952758; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cY5pJObfGgpMBLjEh34BMdDJO3is2w6d+mwNZItIM0=;
        b=wghQByFkm3afDNt27WlC5l4c2inVxFbcCDcmSzqoN/UlDr6yqyR4L8WWTYDzpt71TC
         p/TT3ROYSqx7z2m/9aP5TjDnJHJKrWHk3w3CjJ0URYikbxE5JDTjH5HT/lRelA1iAo4H
         HjCuToSERJDb0MtiM5g7W3uBnBYhykQYP9+SxYpKTZVdCbnSJQ+4o3lC3y36cat9nC2U
         k9aW+VXmXV3c3lX7LSNodNszx9391dCyj/y5o2EYLL/qin/EJi/5N7W/U2HWqzyZLEO2
         lCBq1z7QC49K+EX80An9LBrT6bJWgbHP696aoZ2sffTt5cH6XzLNgezOBqJIHJmwaZqr
         L0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347958; x=1760952758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cY5pJObfGgpMBLjEh34BMdDJO3is2w6d+mwNZItIM0=;
        b=QxiBWyPHG1kZIz4H2WH4e/s4acJOuh5s28fuFx6PLBufJo/+z+0c8Vvlcqf8Go62wA
         y9SzUfG+LFba41wrRaYjWZYCLpu/hJhePLV9jIbqw6tMSeAwBZYT2c0okQR6SdOB1ucQ
         Nsm5n4ZKERFln44QR7orECFXK5mvVJ7ANcTjHTsNmIP70SNtMTumXKUnOjVMAZcXwiLT
         48JRjsjm7TA+k13+G5nIZ0XRI62m9hTBpwoDWqjzA5ETmyRu7mgx0tbwhrfwc5Om65Cv
         a/TWOyt86cgL4SQfEMrJh99NmEYC7aigW1DaBaexRjeXMplejE84I4VFJo8WTMJ3OP23
         W4Sw==
X-Gm-Message-State: AOJu0YytUZZnbF+Z4FbWkwAwpy+Zx1juXFUxMPIysI6iiGhFtVnpuXVt
	f9cGadVtEyhdA8gjJ09vm+9/SPv+56NTtewt7WR9uNWkU14j+DqiCDfFBEjBCn8nEtjwqvJI4Gp
	sUJmhnrf0NPb5PvEJHdIw7YLGb0aCjXc0b9FAcx2sici0T8lvUkUs5E45
X-Gm-Gg: ASbGncvQn1BRRj1DOzMC/YKsrBLMAxkhzLjHeUfqZcTLjEoqw9tKrCy8i3XfhYyR9xe
	W5MyAB1JwiKb8VhJ/nkiKGBLDJ8TIskJ89u4jt9CZ4HzoN9T4Rd5GQEJTm4E7Pk+JiAthpRi5qt
	gh3ZrCyZ1vzRACgb7m2l/qTX2LiKHKaqh6K6t1yuOQl8wyyz7Zl1MGbElAUd2MnFMUmxdn3BzJB
	2zu+7Y9Aw+UGXzz8rbq1ES1HzrwFIAoztEtZdP2X7VFBGNNnks8oVPG1l3SFoTq9ghhU54=
X-Google-Smtp-Source: AGHT+IFD0U0uqRWglh/byx1FjKPjMX0/8ojaak8mgzvQHmpOzLLzkC7WYtfOUF9FNclcN4ih9bpH9zBVGTGC6vHRbs8=
X-Received: by 2002:ac8:590e:0:b0:4e6:e07f:dc98 with SMTP id
 d75a77b69052e-4e6eabcf4camr36864821cf.9.1760347957508; Mon, 13 Oct 2025
 02:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250929155001.3287719-1-smostafa@google.com>
In-Reply-To: <20250929155001.3287719-1-smostafa@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 13 Oct 2025 10:32:25 +0100
X-Gm-Features: AS18NWBnoAflrsPjZ5od3RG3GtAXLBcqTt1b7ZmUjAfG8TvaxEyJScccM8v1Vt4
Message-ID: <CAFgf54opaN2GciRzRv_BJ2SJZybSJ6ib+mkVvHY0K5A1h0-5pg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Move io-pgtable-arm selftest to KUnit
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 4:50=E2=80=AFPM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> This is a small series to clean up the io-pgtable-arm library.
>
> The first patch is a small clean up to reduce the depedencies of the
> test before moving it.
>
> The second patch was originally part of the SMMUv3 KVM driver support[1],
> which needed to factor out the kernel code from the io-pgtable-arm
> library, and based on Jason=E2=80=99s suggestion this can be taken out as=
 a
> cleanup, and a step further to convert it to kunit.
>
> The second patch just moves the code to a new file with no other changes,
> so it can be easier to review with =E2=80=9C--color-moved=E2=80=9D
>
> The third patch converts the sefltest to be modular, that is useful as
> kunit can be a module and it can run anytime after boot.
>
> The fourth patch registers the test using kunit, and converges some of
> the APIs, some notes about that:
>
> Granularity of tests:
> ---------------------
> To make the series easier to review, the series changes the test to run i=
n
> kunit without making intrusive changes to the test itself.
> It=E2=80=99s possible to refactor the tests to have smaller granularity (=
although
> I think that would make it less efficient as we might create the same io-=
pgtable
> config multiple times) and integrate them in kunit as multiple tests, tha=
t
> change would be more intrusive, if you think that is the right approach,
> I can add a couple of more patches re-writing the tests.
>
> Other changes:
> --------------
> - Also, to make the test changes minimal, and the fail messages similar,
>   =E2=80=9CKUNIT_FAIL()=E2=80=9D is used to fail all tests instead of usi=
ng KUNIT specific
>   assertions.
>
> - Instead of using faux device, we rely on kunit_device_register()
>
> - The WARN is removed when a test fails, as that doesn=E2=80=99t seem to =
be a pattern
>   used with kunit.
>
>
> You can find the instructions on how to run kunit in the last patch commi=
t message.
>
> A failure at the test with the new implementation look as
> [  191.675985]     # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x200=
10000, IAS 40 OAS 48
> [  191.676057]     # arm_lpae_do_selftests: EXPECTATION FAILED at drivers=
/iommu/io-pgtable-arm-selftests.c:91
> [  191.676087]     # arm_lpae_do_selftests: selftest: test failed for fmt=
 idx 0
>
> Changes in v5:
> --------------
> - Rebase on iommu/next tree
> - Collected Jason and Praan Rbs
> - Move back #include <slab.h> to the main file.
>
> v4: https://lore.kernel.org/linux-iommu/20250922090003.686704-1-smostafa@=
google.com/
>
> Main changes in v4:
> -------------------
> - Remove one missed __init.
> - Change the kconfig dependencies back as it broke ARM
> https://lore.kernel.org/all/202509201819.f369wBHc-lkp@intel.com/
>
> v3: https://lore.kernel.org/all/20250919133316.2741279-1-smostafa@google.=
com/
>
> Main changes in v3:
> -------------------
> - Move back unused code
> - Simplify printing based on Jason comments + some renames
> - Collect Jasons Rb
> v2: https://lore.kernel.org/all/20250917191143.3847487-1-smostafa@google.=
com/
>
> Main changes in v2:
> -------------------
> - Make the test modular
> v1: https://lore.kernel.org/linux-iommu/20250917140216.2199055-1-smostafa=
@google.com/
>
> [1] https://lore.kernel.org/all/20250819215156.2494305-5-smostafa@google.=
com/
>
>
> Mostafa Saleh (4):
>   iommu/io-pgtable-arm: Simplify error prints for selftests
>   iommu/io-pgtable-arm: Move selftests to a separate file
>   iommu/io-pgtable-arm-selftests: Modularize the test
>   iommu/io-pgtable-arm-selftests: Use KUnit
>
>  drivers/iommu/Kconfig                    |  11 +-
>  drivers/iommu/Makefile                   |   1 +
>  drivers/iommu/io-pgtable-arm-selftests.c | 221 +++++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c           | 203 ---------------------
>  4 files changed, 228 insertions(+), 208 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c
>
>
> base-commit: 5f4b8c03f41782f37d278946296d9443a7194153
> --

Pinging, as this has been reviewed for while, Is there anything
blocking it or any more feedback?

Thanks,
Mostafa

> 2.51.0.536.g15c5d4f767-goog
>
