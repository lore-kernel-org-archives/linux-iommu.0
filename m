Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B329DB99
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136313; cv=none; b=ZkvXxoc+y36BtjZVw4oe8oK+vobQ8l29vB+rnAIRy62l3o9XcJFN3s3Sw7BewqjMUXsV6Al269wv5cBvFpLYN6qyrWNXuvqrkaDCSIUQxLmqm7H3N45O+sG6if+PLL/2/aTf4kL+oI++Os4UfNyvWqpQDXA0l3LgjUUitl/ciFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136313; c=relaxed/simple;
	bh=zyYW8dcPF6nH0CH0mjDbF/3PaopVMstsvWyWj5xGv1w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GWBQPaRTDSqftVnWUfcfX4rozXLK83nikNyz5sGMG9Vu5WgcEuhvaju/J2r/7uATJJLCrNvc6SK8p6H1M+hq6eCnWwzxX3q5CGegJXBMa+2wAcKyGp1hPKWfqCM4/h9nCH6PfhS0ztOckviRpUm4ypD+tH0Ge2nSkvQWXtCJbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZabpoYc; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZabpoYc"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e95627b120so34903f8f.1
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758136310; x=1758741110; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrARdai4TIWekf9/RUNeq+VchPKlvV4Ou8tril+TVSA=;
        b=JZabpoYc+K4l09QlgYFa1uX1Yyc5JMHrHw8aQfGfW7rB/kN0+MJO7WW1Xi+tx00NdT
         4lOFKltdlr9gxvQGegmJwD0cX2G4xqnwx6e0m1BwniQTQMssMnTq9IioHVF752EnZ4fr
         UsQvGL9zrmnPAl3kAtDhiOXnU/T9W6aPtfMX806e1ffscOwxpxBLZ+r7ptTbhq5Fq3uB
         dZUSnP/Uh2e1NZOCBF3qlDzVbOVxepNegr3VUNzGvOJM/Uiy8Hdtl2OFpy9Mwr3HdXPO
         PL9nucMc8Q9PkYoburhm0ZyKtxpn4POgW2Jqhd/5HDTcbtzSETp+0YSla0YNPHowc6Ky
         cEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136310; x=1758741110;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrARdai4TIWekf9/RUNeq+VchPKlvV4Ou8tril+TVSA=;
        b=L037EX8/fVvB7NvlorDCp1S+mw2bEnU6yIh73iCcVXX8DTv9x0KNZES7bHVz3DQz1X
         NP64qcVOHHh2U0rvhDJB1qrKC8JLOhJC5MhUi276LZJE9vJT2FoQBKtibuYJRU975ga4
         4MNedzWVWvuKzKNkyuzELwoc2KUdo0gPvQYoCjeQEok7/qbY3fO+zvQ2IBoEE2PAzxZ7
         J/Z5eGyKnpS20SRlr3cXyTAgRf8Fe/R//mmKnkcwUk5FhLgI+s2wqrL1z7LaMfJmhijD
         VK+3KPZ9y9ujKylx557tr+zIK8qJKd66/uBNqrmg38p4pKSpQrZUo2GJK5hFLu5mu7oX
         LwWg==
X-Gm-Message-State: AOJu0YwEpBW3B8ICH38uo4FIcSeBlWQxiZVarOY19MmIYalsszAFSx0n
	A3Se69OrKeqnHkMMzgKy8N3l8WQyPayoG3FWVFIxwtnxfxboMrBfg46wIZGxYSd70lSIJDUVLBQ
	v6ar1I5pN7oYSRytn+EWkYMOFQ2PCexytYTFivdnFG+eQ7zNKDEvko0EGIL19rIHRUt0wtmOp+f
	WorX5+eVeiy1LepCdIncoDTM7QBD0Emm9b5YsTDh64TEqI0A==
X-Google-Smtp-Source: AGHT+IE/wSFEaSIOL/io/GqUMdS/4N3/l1Wv9TP9hRQ2M6LcztpPNng5dXrReb1gF9DuJgNotR8IDC9W3BF9Qg==
X-Received: from wmlv10.prod.google.com ([2002:a05:600c:214a:b0:45b:9c60:76bb])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:186d:b0:3e7:486b:45cb with SMTP id ffacd0b85a97d-3ecdf9b8549mr2676797f8f.3.1758136309966;
 Wed, 17 Sep 2025 12:11:49 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:11:37 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917191143.3847487-1-smostafa@google.com>
Subject: [PATCH v2 0/3] Move io-pgtable-arm selftest to KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a small series to clean up the io-pgtable-arm library.

The first patch was originally part of the SMMUv3 KVM driver support[1],
which needed to factor out the kernel code from the io-pgtable-arm
library, and based on Jason=E2=80=99s suggestion this can be taken out as a
cleanup, and a step further to convert it to kunit.

The first patch just moves the code to a new file with no other changes,
so it can be easier to review with =E2=80=9C--color-moved=E2=80=9D

The second patch converts the sefltest to be modular, that is useful as
kunit can be a module and it can run anytime after boot.

The third patch registers the test using kunit, and converges some of
the APIs, some notes about that:

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
- Also, to make the test changes minimal, and the fail messages similar,
  =E2=80=9CKUNIT_FAIL()=E2=80=9D is used to fail all tests instead of using=
 KUNIT specific
  assertions.

- Instead of using faux device, we rely on kunit_device_register()

- The WARN is removed when a test fails, as that doesn=E2=80=99t seem to be=
 a pattern
  used with kunit.


Testing:
--------
- With CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=3Dy
  It will automatically run at boot as before this patch series.

- Otherwise with CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=3Dm:
  1) on module load:
     Once the module load the self test will run
     # modprobe io-pgtable-arm-selftests

  2) debugfs
     With CONFIG_KUNIT_DEBUGFS=3Dy You can run the test with
     # echo 1 > /sys/kernel/debug/kunit/io-pgtable-arm-test/run

  3) Using kunit.py
     You can also use the helper script which uses Qemu in the background

     # ./tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --a=
rch arm64 \
       --make_options LLVM=3D1 --kunitconfig ./kunit/kunitconfig
      [18:01:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D io-pgtable-arm-tes=
t (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      [18:01:09] [PASSED] arm_lpae_do_selftests
      [18:01:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] io-=
pgtable-arm-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      [18:01:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A failure at the test with the new implementation look as

[   66.624469]     # arm_lpae_do_selftests: EXPECTATION FAILED at drivers/i=
ommu/io-pgtable-arm-selftests.c:154
[   66.624505]     # arm_lpae_do_selftests: selftest: test failed for fmt i=
dx 0
[   66.624524]     # arm_lpae_do_selftests: cfg: pgsize_bitmap 0x20010000, =
ias 48-bit
[   66.624669]     # arm_lpae_do_selftests: data: 3 levels, 0x200 pgd_size,=
 16 pg_shift, 13 bits_per_level, pgd @ 00000000f200237d

Main changes in v2:
-------------------
- Make the test modular

v1: https://lore.kernel.org/linux-iommu/20250917140216.2199055-1-smostafa@g=
oogle.com/


[1] https://lore.kernel.org/all/20250819215156.2494305-5-smostafa@google.co=
m/


Mostafa Saleh (3):
  iommu/io-pgtable-arm: Move selftests to a separate file
  iommu/io-pgtable-arm-selftests: Modularize the test
  iommu/io-pgtable-arm-selftests: Use KUnit

 drivers/iommu/Kconfig                    |   4 +-
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 226 +++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 243 -----------------------
 drivers/iommu/io-pgtable-arm.h           |  41 ++++
 5 files changed, 270 insertions(+), 245 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

--=20
2.51.0.384.g4c02a37b29-goog

