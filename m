Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE9296BCB
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117749; cv=none; b=ppCd/Gaajf4urQHBor10eBxkJU+3sKMzT/9EQb6F268d62hj2QOTYerZvYrXpxNFYrGcxKGVJScQDTyxGOH0/ajBndtoalGdVmXhfLcmuTjVqg3tjK1SWptK+wvu4QpeMwEjD6MMQjEaV+Njo/4DoaDkaAFjw6vpCs9rdeTTZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117749; c=relaxed/simple;
	bh=fslEfQVFSDy3MdRZz+1IJQFEJXxKgiBQB/ipShdsiCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p27Zm/hSEwmpl9JhqsBf+Tr4KYJgXHpEeHMao6P5vMPe4lJaNnWCpG/MfPyvrExlHSfXPyAxKNM2Ssr13c427ckn4nUoPWnWCMt6Xtx8X41YB1eAE6z9ystJF0KEC9lAiYnAGKRiAW2BHUVaEzLKKiFUcXq0yIQeM9Gj6i8KvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLngiFBc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLngiFBc"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45df609b181so55653425e9.2
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758117746; x=1758722546; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngN4kxVQKLMv2TlOZWI2DrSijnc3KpLfGOwuclV4Snc=;
        b=YLngiFBcofEQ43iiIwXmF0gsKCfuxgcDpRq1HxRSFRrrvnZkSYrZtDN+ZkSwwCU6tY
         4YGjdseRxABHEUnl3vp9ngJzx43F3PFIf2D4MNaACe2rfkEuOypoRfwhVTi8Duc+jAhX
         dKD4G/+2p/XBfjTtmnKIIiuJqUDO4+j5xnwyeyPrx8y0v3J9JwkCq/HdMwZoAi8mzfLr
         wISoLztbtq4Mo6j91IysETsX+iuPtGfDQ/zi9o1qNzl3YdG2Ah3kH0OAmkDo2+iqLDQb
         TOC1QrWC4OmEJU1LWDWAAbnrDsQUIZH5Yn4FUqLbfeU7h/dr1kiw6UGisVDu8zRuA1LZ
         93gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117746; x=1758722546;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngN4kxVQKLMv2TlOZWI2DrSijnc3KpLfGOwuclV4Snc=;
        b=u0Dal7Y2HJRemzyNzoo1ncy/Yp8REdAmVuvnCB5+1TEOU7KnJd4FHFRYh2Quzc+xI5
         4uP4zrwQd52Pt7BNHUj5N5Q6+oXYmoBFeIMKaRT9H4V04UhZlzLJgAkWDvbF6Lw/BGyx
         1PqpnJoSJx/dUyeEnRoS2Wvd9rhvuL7+CQSnlVEix07pSxrqr1KaoHCrWOIVa5eey97A
         6wxf68FO+0Tov8Bd1ZumrzEmIlNO+m60vj16UO+AAMZRDZfDrhfaW5mcGVMwUp80nnTA
         dvoT0M30jbSIqCiNVmcd3ZrMIZ7wqs9lkwh4d6ZS99Iud0ee+2X1DlpAXwz/nxhPfykY
         8iLg==
X-Gm-Message-State: AOJu0YyRBztDZ2UmBywqggf8zYYZvCAd7axwfr7CHMohQep9Vc3zN8o3
	chzKUTyVXDePZI3Yt54UfdNjgyOwmk/jsIyZmCw8jDsXpXMD4j1s5vUQdO1mUcMxFVbHTT6A09b
	WB94i16pCN8cOYc7z0DowcInGu6g7OmkWvZ9M0z0O3gKX84BCUA6sfpuBM18pY3h8a5K3K0iRZ7
	zOhf/9tfzzV/1JT4q1STGyL0htymCHmUJUXdGoNXeWeJLCeg==
X-Google-Smtp-Source: AGHT+IFdG0Nhhw1O1UF5cygDkCqoxwKDzBO775bZilL9ZTcI8tzFDCdOk8xitUr+etVtXwIkoCMI0q6cwt5MfA==
X-Received: from wmtk6.prod.google.com ([2002:a05:600c:c4a6:b0:45b:89e7:5038])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:354c:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-46205fa5930mr21477245e9.21.1758117745343;
 Wed, 17 Sep 2025 07:02:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:02:01 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917140216.2199055-1-smostafa@google.com>
Subject: [PATCH 0/2] Move io-pgtable-arm selftest to KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a small series to clean up the io-pgtable-arm library.

The first patch was originally part of SMMUv3 KVM driver support[1],
which was needed to factor out the kernel code from the io-pgtable-arm
library, and based on Jason=E2=80=99s suggestion this can taken out as a cl=
eanup
and to converge to kunit.

The first patch just moves the code to a new file with no other changes,
so it can be easier to review it with =E2=80=9C--color-moved=E2=80=9D

The second patch registers the test using kunit, and converges some of
the APIs, some notes about that:

Dealing with __init:
--------------------
At the moment, all the test code and data are part of the init section.
To avoid changing all the functions and data and removing them from the
init section, we can rely on the kunit =E2=80=9Ckunit_test_init_section_sui=
te=E2=80=9D
to keep the test in the init section.
That will make the results only available on debugfs (there is no
possibility to run them after boot) unlike the SMMUv3 tests for example
which can run on-demand.

As the of results are saved in the kunit structs, they can=E2=80=99t be tag=
ged
as __init_data, instead they are be tagged to __refdata to avoid the
modpost warning, as it=E2=80=99s guaranteed that kunit will only access the=
 results,
not the test after init.

Instead, we can remove the __init constraint, and be able to run the tests
on-demand, and possibly compile it as a module.

Granularity of tests:
---------------------
To make the series easier to review, the series changes the test to run in
kunit without making intrusive changes to the test itself.
It=E2=80=99s possible to refactor the tests to have smaller granularity (al=
though
I think that would make it less efficient as we might create the same io-pg=
table
config multiple times) and integrate them in kunit as multiple tests, that
change would be more intrusive, if you think that is the right approach,
I can add a couple of more patches re-writing the tests.

Other changes:
--------------
- Also, to make the test changes minimal, and fail messages similar, =E2=80=
=9CKUNIT_FAIL=E2=80=9D
  is used to fail all tests instead of using KUNIT specific assertions.

- Instead of using faux device, we rely on kunit_device_register()

- The WARN is removed when a test fails, as that doesn=E2=80=99t seem to be=
 a pattern
  used with kunit.


A failure at the test with the new implementation look as
[    2.115982]     # io_pgtable_arm_test_run: EXPECTATION FAILED at drivers=
/iommu/io-pgtable-arm-selftests.c:94
[    2.118381]     # io_pgtable_arm_test_run: selftest: test failed for fmt=
 idx 0
[    2.118501]     # io_pgtable_arm_test_run: cfg: pgsize_bitmap 0x40201000=
, ias 32-bit
[    2.118863]     # io_pgtable_arm_test_run: data: 3 levels, 0x20 pgd_size=
, 12 pg_shift, 9 bits_per_level, pgd @ 00000000a15afb2d


[1] https://lore.kernel.org/all/20250819215156.2494305-5-smostafa@google.co=
m/


Mostafa Saleh (2):
  iommu/io-pgtable-arm: Move selftests to a separate file
  iommu/io-pgtable-arm-selftest: Use KUnit

 drivers/iommu/Kconfig                    |   2 +-
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 223 +++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 243 -----------------------
 drivers/iommu/io-pgtable-arm.h           |  41 ++++
 5 files changed, 266 insertions(+), 244 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

--=20
2.51.0.384.g4c02a37b29-goog

