Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302B3074B6
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161011; cv=none; b=jX58LqK3ncoQcvPQ70NgrgjF3lihQuhge1Rm0nAz/OzC0oYv4dqidZhE3khmbu0G1tse6oCRjY1+fRoK+94Zrfhu046HEqHH67nqAeH4od7b8uOlcIZyCDpAge80gVeHGbZFBaut573V2sjs10XXCcXRhJfpJ9xMHbFrhOutays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161011; c=relaxed/simple;
	bh=TM00Q67lZErWUQoxa1jS1p9j0/eIwOVnpK328AUsNfw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SRLM04nDmFIC2bBExp7jtitt6y+LlCFNU87ShXVvrGjH+VnPq2IX1W3Mq+urdmN+EFzM9SyX6Pbp5qPRxbJDT8bdATZOHn+/MIAkOfBmlurlJiqvIT4qpnVjVb0PykhqbDX6UVmPYh2hJXIt0vX++7Avf7CJ/Vcqy2+sV6yyxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itz/p5ys; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itz/p5ys"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3f93db57449so2899443f8f.2
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759161007; x=1759765807; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeGiAhQBgE5SioCpTqIS2Jf/K9QNAbJm22HCuBejOhw=;
        b=itz/p5yshGkLqz9yT4MwWf1NJ4aF/vI7guoSi9pyF2n5aMPOFy6XrwhYQr06n9T1Y/
         PYKn/Fba1+MHBFvQqmsNvYt0Om1QMk7OJ+NWTMk/2oDY38ypNvyaYzb0GczjjGgRqJ2W
         xN4nXQdm6wYkojKpcnJLZIXaxbWkzIebh+ksH/gy9d9BZ5Zv8xYyWVsHBj0K3utI+LH+
         2spOYl/TFNqk0LU+I16ypthQQ1Pu1Jwa0kJhU8wD9Xs4ObPzN2E+YcOM2v3QiInMg57f
         mbvH4utnkYMVngqZVFPs7qkfg1RBpdqlQ0k4TsnDe0wiqtf7/lLG+Mdee1fYx7YLsNU1
         Ymbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161007; x=1759765807;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeGiAhQBgE5SioCpTqIS2Jf/K9QNAbJm22HCuBejOhw=;
        b=vzHWA4Ifcvgik56TlTWxhZTS9gPkFGWc+OXiBa72aVvt07Pb08GdyO5FWcavQ8zvfY
         GXCb2Dtohc0a8wdhfJ0GcOZ4dYIvgcxobDquEmWidaZa4ZcGYxDrRuqJaDNwLuMxH1TJ
         qcRlpHIKFnlYEN+jzMWBnKf3qpmgj3uqlY8PDEOQK2fEdFZ3cdCBSsYmPhNQDyx8rfNB
         AOTLIyZtZvaSNIDhii+FjzOC+oLPCYNgI3BDl11QeZewVL8EF+P+jGKpAGdWIHDMrkIu
         0PbC7eqbJJ/SoNUeODVWXiSten8uFNEMtZ63tdFdZFqYw//NQiYfDMi1EYfwkf/Fy7lX
         nNgg==
X-Gm-Message-State: AOJu0YwoPcejp2Y/XUwJJekjWwSy6vo/DmO9te0n8jTlFF4OLPedwQs7
	3reu3u6pJ3euCk7xxRo1PaYWOHNAzi+xXyqsC0Q/rkWc1Qmdb/lxualEOQdIbopTkPue/LsbhNG
	a40e+ZfJgrk2gouwHSJN+0fbesWTAH4YxXDBIix0bf/0D94dG2j6pQykJ36ZcuF/MwiIUGS8gxe
	uRWzIi+dlrYd8zFUJDfJAyikwuf32lvpIC/DW75OWoJPtNpg==
X-Google-Smtp-Source: AGHT+IEICyelSc+dhdigiShqJvTBGgipfMzl1NQ4eObmUtfk5GsCQRpuD8i813yQYt9a5FCkGAW67AoXY8BgRw==
X-Received: from wmoz15.prod.google.com ([2002:a05:600c:78f:b0:458:bdde:5c9b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4024:b0:3ec:d7c4:25d5 with SMTP id ffacd0b85a97d-40e4be0cb3amr13969388f8f.50.1759161007523;
 Mon, 29 Sep 2025 08:50:07 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:49:55 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250929155001.3287719-1-smostafa@google.com>
Subject: [PATCH v5 0/4] Move io-pgtable-arm selftest to KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a small series to clean up the io-pgtable-arm library.

The first patch is a small clean up to reduce the depedencies of the
test before moving it.

The second patch was originally part of the SMMUv3 KVM driver support[1],
which needed to factor out the kernel code from the io-pgtable-arm
library, and based on Jason=E2=80=99s suggestion this can be taken out as a
cleanup, and a step further to convert it to kunit.

The second patch just moves the code to a new file with no other changes,
so it can be easier to review with =E2=80=9C--color-moved=E2=80=9D

The third patch converts the sefltest to be modular, that is useful as
kunit can be a module and it can run anytime after boot.

The fourth patch registers the test using kunit, and converges some of
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


You can find the instructions on how to run kunit in the last patch commit =
message.

A failure at the test with the new implementation look as
[  191.675985]     # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010=
000, IAS 40 OAS 48
[  191.676057]     # arm_lpae_do_selftests: EXPECTATION FAILED at drivers/i=
ommu/io-pgtable-arm-selftests.c:91
[  191.676087]     # arm_lpae_do_selftests: selftest: test failed for fmt i=
dx 0

Changes in v5:
--------------
- Rebase on iommu/next tree
- Collected Jason and Praan Rbs
- Move back #include <slab.h> to the main file.

v4: https://lore.kernel.org/linux-iommu/20250922090003.686704-1-smostafa@go=
ogle.com/

Main changes in v4:
-------------------
- Remove one missed __init.
- Change the kconfig dependencies back as it broke ARM
https://lore.kernel.org/all/202509201819.f369wBHc-lkp@intel.com/

v3: https://lore.kernel.org/all/20250919133316.2741279-1-smostafa@google.co=
m/

Main changes in v3:
-------------------
- Move back unused code
- Simplify printing based on Jason comments + some renames
- Collect Jasons Rb
v2: https://lore.kernel.org/all/20250917191143.3847487-1-smostafa@google.co=
m/

Main changes in v2:
-------------------
- Make the test modular
v1: https://lore.kernel.org/linux-iommu/20250917140216.2199055-1-smostafa@g=
oogle.com/

[1] https://lore.kernel.org/all/20250819215156.2494305-5-smostafa@google.co=
m/


Mostafa Saleh (4):
  iommu/io-pgtable-arm: Simplify error prints for selftests
  iommu/io-pgtable-arm: Move selftests to a separate file
  iommu/io-pgtable-arm-selftests: Modularize the test
  iommu/io-pgtable-arm-selftests: Use KUnit

 drivers/iommu/Kconfig                    |  11 +-
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 221 +++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 203 ---------------------
 4 files changed, 228 insertions(+), 208 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c


base-commit: 5f4b8c03f41782f37d278946296d9443a7194153
--=20
2.51.0.536.g15c5d4f767-goog

