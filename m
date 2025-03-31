Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757AF173
	for <iommu@lists.linux.dev>; Mon, 31 Mar 2025 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743393833; cv=none; b=e9ysGZbLnbFqk84yVPKd70Ezd9toAFMDSeYTW8+FL9qTnEInl3DP1drFmEGcY6kUqVpMWawdgaOMjvlkOXI5lgtExgAbzw/sUnUHZ4+4At4/Vniunl8tVqw+I+RYpya+TAbSO+qcpNBfXp4J+VNh3sBD4G1jqjNH7/JDK5RNCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743393833; c=relaxed/simple;
	bh=Ovriw1fRv9VQH8DhEJ92/4OemBiWmNygkfONdXwMWo8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=B9KjpRCvpwpLrnuHP9afBRPU2G1KAISAO5LvEN6GVxjX2YNxVwlwwxqqL9uu/WS5EpYEGQq1bWO0Xsj2gz6JVOG+4z4mLynWtVGrHh7KOnYhEvHZBWLEoBaAogs7W1jB80ZzDHJMBVsBJ9oyWMH6OuhvW6H1n77xSXXWQB7sTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bosEQDJD; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bosEQDJD"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86dde90e7a3so1731008241.1
        for <iommu@lists.linux.dev>; Sun, 30 Mar 2025 21:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743393829; x=1743998629; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Eoi5ctOlZBCBuG5n3/dJiXOfEGeAUQNLilO/2EXgbE=;
        b=bosEQDJDK7Jey20xaAawjcrAD2Qv5M12Yf5THNzHF/nz2sGKbnyZhF9S7TqBAULtGM
         gfH/KFM9onqCDqr1otruALYXM/WfZlNI5sCzXlMrdBTlGl0wK2eoXWyW/LFn+hPyUQpy
         1dUlHKfXzPDuHQMiJjB0+eFLv9MJL7ed7zsK9kkJM8/2vLY/3dDaeCFWPUuoCksrIGVy
         MOOlHAqrkHI+gROVkDQbTsKISDPyphD1Y4GmyFQMMk0ylbM8WpCU0KZ21sMbAoNvcqFk
         7tMNtrreLa9IeLNeAmKAOxMsfY+/+Kwk9HlycqcgM8N0Md6dfgZedB1IjfId8eSdJH7w
         D/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743393829; x=1743998629;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Eoi5ctOlZBCBuG5n3/dJiXOfEGeAUQNLilO/2EXgbE=;
        b=quRDCqtPvtlpPLnJgZBpo8s9mysiRI6g0mcbZfIFHlfSRI5sxZLYO0P5WzsIDK73Hj
         tK283auCSlSQaGaj2XBxiaPy2VAffiD8qDrLdXsZB315gPavLpCK8my60elC5+QhaTWH
         2+n2Vtf7/tMoU82O7GLnetx1UKs4I4pkywvmhFu1WuBG0ORY4bG+vH48HwkEkJJrULGj
         UBNZvH3Mnfj5oHf2TRrPS/nLJ9i3Yx1FXxpJvgNz86LrT3zMUzrscQeWyWa7C6Y6T0CJ
         L9/giq/JisNn+0mWJ+jqXIY41NFXjOSCQIaOJtVBPtX/I9ZTEgXXn+eOFG0fCq0uy6gu
         fUmA==
X-Forwarded-Encrypted: i=1; AJvYcCXoJ1Lf8Sg28OYp7iSGR/RrkFaDap7fmnDgH6uwTW1OVY9gobBIW2HILVE4GIX5uuUiNNFOZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyrr2+G2GIv1dQnCTr3CP1KUUPJtM0lJDnyRt3iEhpqwfTPqQyh
	X9JVw3FKdz22xZc0wdXi9EBDGvupxUi/8m0tBuy2BcIn/G/Yv1Hq1WM0x5Co7YTvL6iVTLWdVbN
	RRTE092KXnYsbpYq/cg8Gev0CJcXEjAkWuQUi9A==
X-Gm-Gg: ASbGncvHmSJ9LijUUlzGaSSqCQ11dBwgpFj6xO2FOwChRVJxmJApgVpwrZkJxIIrxnb
	jGQXOKW5XXYzVlE5ot/uP5yNPPPIYu5BHOgQ2+r1tfj2tOwTYja2yXhxavnwhfWAZPmyFyfiYDk
	YVv5VMfy33+teB7GBsnkX6fvoNcrq4SbdpTM6uKOYaA5g7VxSO0GZ7/VYHMA==
X-Google-Smtp-Source: AGHT+IE+omrjH7GYgvhNd+blM0ysANeUmxf3FkJnco8pyeAxxM7AfoCsUeEAKslkGCMtq8noDXdfL+o2qkrwgip+9BE=
X-Received: by 2002:a05:6102:3e8a:b0:4c1:90ee:ab2 with SMTP id
 ada2fe7eead31-4c6d38cb31emr4067233137.14.1743393829232; Sun, 30 Mar 2025
 21:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 31 Mar 2025 09:33:37 +0530
X-Gm-Features: AQ5f1Jry1FfmI-B89oqlgm9LhT3dGEDfFcdu18qH63QTqu9-bEzvTnC6C9KspFU
Message-ID: <CA+G9fYt0F_vR-zOV4P8m4HTv6AecT-eEnrL+t5wgAaKPodi0mQ@mail.gmail.com>
Subject: arm64: juno-r2: SSD detect failed on mainline and next
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux.dev, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions on arm64 Juno-r2 devices detect SSD tests failed on the
Linux next and Linux mainline.

First seen on the v6.14-7245-g5c2a430e8599
 Good: v6.14
 Bad: v6.14-7422-gacb4f33713b9

* Juno-r2,
 - detect-ssd
 - mkfs.ext4-ssd

Regression Analysis:
 - New regression? yes
 - Reproducibility? Yes

Test regression: arm64 Juno-r2 SSD detect failed
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this to,
# first bad commit:
  [bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c]
  iommu: Get DT/ACPI parsing into the proper probe path

## Test log
  mkfs.ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_223004A01292
  mke2fs 1.47.2 (1-Jan-2025)
  The file /dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_223004A01292
does not exist and no size was specified.

## Source
* Kernel version: 6.14.0
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
* Git sha: acb4f33713b9f6cadb6143f211714c343465411c
* Git describe: v6.14-7422-gacb4f33713b9
* Project details:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.14-7422-gacb4f33713b9/

## Test
* Test log: https://lkft.validation.linaro.org/scheduler/job/8188382#L1538
* Test history:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.14/testrun/27742015/suite/ltp-cve/test/cve-2017-2671/history/
* Test details:
https://lkft.validation.linaro.org/scheduler/job/8188382/definition
* Test link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uwduIsT14Pz3XEoUQQIS6ndlQK/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uwduIsT14Pz3XEoUQQIS6ndlQK/config


--
Linaro LKFT
https://lkft.linaro.org
