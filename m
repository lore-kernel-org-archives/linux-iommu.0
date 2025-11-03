Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E230CD81
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173244; cv=none; b=h7OWU6QE3+/TzXmvsUbPDn7uQwWHEOv9ZlszbdtKQORG9wSkZGMlhNKacyqAw/mJOi6Rw9SwFG7qTxu4kBfAPhYQafcfC3wXXvTN7WXQ1Ysr98fYhvzj8haU5nxpWwP+9Ni4isMQWE5PmBhkA0uBHI6r42+nRQwjm/+2Am68fas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173244; c=relaxed/simple;
	bh=w36KW/wPb3cVagvybLftrF4CjYrWqxSZqwj4SEHtr88=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kwZZRUIVV5V1N6ZIhzp0nA5ENFRKL+4hj6E+fTV1H+cuGmErLVlsZ+md8cosl8GHj9vMEvpx6tr/KoGIk6UQKddDMAIIVRJi0qGxfjCeSaK6jrGvkBO0DqSEofG559yskYjlHFY7S0e6+A8KUCz1MQBsdeIEXgTXijkJ29v4crE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsHbOgXa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsHbOgXa"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47113dfdd20so19092425e9.1
        for <iommu@lists.linux.dev>; Mon, 03 Nov 2025 04:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762173241; x=1762778041; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSAYutkZ7+a569qs6E4HPdsGwXOmRZ2wAq/f2x6mExQ=;
        b=NsHbOgXaiQQQcd8ZsgN4BL7G8ceNwf0Z5uq0sz4OATRTZwhUulOkna7rTQ63TGSTqY
         UDMdh065/eMNUhPIuJH+0PMloacOwG3vrzaWcFD/yL3M24klQKIWh+OhWWNhaNn4janM
         RPOEoRojY17KNgLcBtojUy8B9maKv3gDHnQkFRuzrJ3WXKl2LLuai0BtB+We4CBCeI5a
         Nf0BUua1/920xFWVppSf9AJzMgDixReY2Hc39F6pQYNkCsYY2i+twiQJwf3xMFSu8GJz
         8asNRs1aJUvWWSqz3Vaf4byC5ObOYbUB2sidu12AaPiyK3F2yWdITjBNyVdtlaKZU6Qu
         SSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173241; x=1762778041;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSAYutkZ7+a569qs6E4HPdsGwXOmRZ2wAq/f2x6mExQ=;
        b=gUYixNdmQEbUkO+dJo/aScv3yxcRQKLWB+MxEz0S1TWrydAB8SH6YtIi0pl48CNZFO
         NpVdQ4iu+zaka6P7OE7r8tv0nL4bBIAcHOuUNTwmo6/IgygXZ7yLfEtRXdjGHUD6gsXS
         Q6W/FCNheXrsWPa0JcifV7vuf5bnSwXwOQ4D7PxIe8/CczkObAihIT5M2a8SqcMgrzm1
         vocXn6tnmljxva1wrKwm7IB9lYKuyjqDGVe+M4jkI2hGiBpvejrv33kjQXbfiaeGFCoZ
         j9cmG4koUfmG8iWGItonF6GPacl7CPiXrs+p4QqaR2/HutRCvNs/2qm/Z6BT9OtMKEze
         tMTA==
X-Gm-Message-State: AOJu0Yxz0td1lS2l7PcwLjzBSYCQtah4J9fOkXTo2OG9Y3hbcifCm0wC
	3Jn0tArFyi4+B7qfoh+D+oGgpP4JaO/EXHev53phrhcLSyG3qAMmrEe37HcWmd+qOQ6nRgAkBoi
	zLzUI60Rf5aUlRgRdvXvf+5ZX5e9K8usmGvAQ80iOtnIHzjnLcwyVyUgewNdMjOeonzZ4S90L/m
	GjVgyVQnUPEU7gIFZMNOrkpqI/Zo5J6qJ/aUqiR4UNK1Ie0w==
X-Google-Smtp-Source: AGHT+IE3BVSRA1xaeeR33gXX0nVF0a1SF+382+YyhshPRNKnmANoXw9zOSGPxjdhjzWLcN6ym2yRotwlAcsWrA==
X-Received: from wmbgz3.prod.google.com ([2002:a05:600c:8883:b0:477:df7:b01a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e08:b0:471:3b6:f2d with SMTP id 5b1f17b1804b1-477308aeaeamr104092065e9.38.1762173241601;
 Mon, 03 Nov 2025 04:34:01 -0800 (PST)
Date: Mon,  3 Nov 2025 12:33:48 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103123355.1769093-1-smostafa@google.com>
Subject: [PATCH v6 0/4] Move io-pgtable-arm selftest to KUnit
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
[   55.631877]     # arm_lpae_do_selftests: pgsize_bitmap 0x20010000, IAS 4=
4 OAS 48
[   55.632135]     # arm_lpae_do_selftests: EXPECTATION FAILED at drivers/i=
ommu/io-pgtable-arm-selftests.c:144
[   55.632135] test failed for fmt idx 0

Changes in v6:
--------------
- Remove arm_lpae_dump_ops()
- Simplify __FAIL()

v5: https://lore.kernel.org/linux-iommu/20250929155001.3287719-1-smostafa@g=
oogle.com/

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
  iommu/io-pgtable-arm: Remove arm_lpae_dump_ops()
  iommu/io-pgtable-arm: Move selftests to a separate file
  iommu/io-pgtable-arm-selftests: Modularize the test
  iommu/io-pgtable-arm-selftests: Use KUnit

 drivers/iommu/Kconfig                    |  11 +-
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 214 +++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 203 ---------------------
 4 files changed, 221 insertions(+), 208 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c


base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
--=20
2.51.1.930.gacf6e81ea2-goog

