Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F84284894
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531609; cv=none; b=LohVokL23+oY2QxWWoPmuw2tVmcn2dmDw7U0RQ37a49LDH+ayx5JlXUDjeyGwpM48IHQW7DNrJXUw7EwUV8BPI1SOvLCydHuWfJtIrHrkHa4KRi/Q8IbZSrMWuj7r/EYazKEMe2SVXC0YsqVslTGNUgJfwAhw4zTYHXNzchs3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531609; c=relaxed/simple;
	bh=w3yp2JrNnsSF3+6X/xTHjw+JwtJyjw6GCrUHlSgXglY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fk7dceSCWU5u250Kkeqle9JxS17pBi+Nq85FYwnYA+nqz+YOKmJuUywNI2+mcm9MdU0rwKu2LXZHEPMkwjTrW6qMOD1FuFml9EPppuEgfMQ46EaAhhQ92GtVK+0qzMpxcy/xJuWwqkXE7Ll5cpCFj1oI9qlnUt2HhHqoeBSFvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bQJ6Jz4; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bQJ6Jz4"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b2e9e07a887so11527866b.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758531605; x=1759136405; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJqhgJyvnD5d6YT81nFGxO9YqrSRYT6f3jsmSzdijO4=;
        b=4bQJ6Jz4202WW67e7zPAJJMKylFpCImaUgoFq9W5fKF9m9jGEv+qqxxVWFIuIsRSKz
         OE6lBOEULod3ojPu9dyXEUkey8zQl8hsMuwvRCl+TLz+eHlaSmlkJH5GQ1NjuV1onv6J
         S29wwrY82s9c7fc7sozDmD5zNRlpOqEdlgKKt6jYydEqOtK3zsMqJxGDIIEGBWwt9NXR
         jKQiIKoDMorIBcx3hCi1YCYruehTXDI83BmDZICJRjTbjEmtzMzmyXrZOBC5r7qwHWj6
         6yTgapo/wh1eJvuudZidSTtdY1PL473Jse3L5WLYzrWzjxsiiN8v9TMJ3yaaZoih9ku0
         CBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531605; x=1759136405;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJqhgJyvnD5d6YT81nFGxO9YqrSRYT6f3jsmSzdijO4=;
        b=NpfUrhMAPNuGDR88oZBBKTtUFiSW7X9kNMYN46qvpYKIgzs4vxVhMMrwn0Eb53PaeI
         fnafa5FHDP7bxETxFPw4g3+XwPcrNJBWFQf10qnpoha9uMvfdqOjHyxvUFY1tD47PB/y
         1X45rZRnCBUeX+QYmjGK64s6UVK58kxEB6p/Uj0z4bsZxkE+OR698gm7hkjkcBezmLwF
         jThQJlfgmEGnNzdV8VWBCs+5/ISME8ss/nkdcmFzefYdfvXNlhOqV1gu+viZzgtneFIU
         rCNJ/Yg+1sDjgG4iA2R16uxxRL5ZGrhiMeYP3wm1oYM7YJMxin4K7SqrsGfUv4kcmj1s
         MQmQ==
X-Gm-Message-State: AOJu0YzdmGCUQBtwiAEa6HIifOkoux0TDTwiSG+EEP6wFpX6YNnIaypv
	z+BKLPMJGILWml2dn61Luo94QmW7UPPgjVja64p5E+92lHr+ZFFA9Us0qbIBvVG92MlMowBt9FX
	YEC9EJVxfr2DMVLv/OYBAz1yd9dk/RYh+EUj52/zGU/bTrn9zIBFBOF2w77dVBxPEq6c9DO6z6c
	oM2OG+trS+phGo56Uq3p3d7gYSSujT5vFQ7BTfeM5GC6aBCw==
X-Google-Smtp-Source: AGHT+IF+yNxN8u0Kn/bBdnRnggKLG4SBwNB4ClzRlBvae+pc7iApwAt2kx062VQ8LZ+b/9dnodHumoEI9ZZgHg==
X-Received: from edf16.prod.google.com ([2002:a05:6402:21d0:b0:633:2fbe:a0c9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:948c:b0:b14:53a0:5c61 with SMTP id a640c23a62f3a-b24eca014ccmr1430032766b.12.1758531605450;
 Mon, 22 Sep 2025 02:00:05 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:59:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922090003.686704-1-smostafa@google.com>
Subject: [PATCH v4 0/4] Move io-pgtable-arm selftest to KUnit
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


Main changes in v4:
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
 drivers/iommu/io-pgtable-arm-selftests.c | 222 +++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 204 ---------------------
 4 files changed, 229 insertions(+), 209 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c


base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
--=20
2.51.0.534.gc79095c0ca-goog

