Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B93D9029
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054456; cv=none; b=sTKzOcZMX60myvZKrzdwJ30uL/7OPrVkiqrm6RoCyfZxT4n8Y6oePXpr8Cs5Zq+iOuquPf/n3YWGtg8T0IqoRU0OynSC/Ui1g4o5V9Pe40mNmGGp6WWDY9iS2jKM0j2pwrd+YkPngeGztuS6vvPSO+nmvBhh1SYqNWGnMsBM0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054456; c=relaxed/simple;
	bh=gTslTYml5UTyW3FJ1z6mktqPCrhht3BNmW/1rPIZPJc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TRXN7qqc+Fe4D9KMmR5zUYglI4L8wb1Rd+2HdAkW/72WJgZQvXhnDOBO3IrcfOPzVj/u8OikyWbk3QvbHKegEkWULfBReGc0L/ecoi9r/+zE+dDV6iEW0Iqo3WiwfczI4hljzNGLIMtOhoYhbqFjBkw2+x2eYJ0tbolqCnp0upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBmN7gTP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBmN7gTP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso2729808a91.1
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780054453; x=1780659253; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=InN/OGCUMvXTCX+obkWeolv325a7pUPRJkHQ9ppGD9Q=;
        b=cBmN7gTPQAfJ/6JxtzAOCRVYDzgVr1aAhNr5rjLDKTIS5psLL9NiCqhmlpdnXvUUGP
         nqMStVeDA3OPSsIqkh6E5rObYMmy4byhufOeDkLULY3sQL6mqCeVAwjtAYat2Q6OikaD
         58ubJCfG1+6RzU2wIse/WL3fwXsFMBWvBT0ctCWWXrvv3FkgYiE2/RypuZwCKk0zCPu9
         wtaMj77+IkszkrfGVw/6Vy+WMbIDBScPoRmXgrVEedlUt7Hzq8bNwA+kLgYhncnJnLcM
         8YjZxzyWHpMDBEAWGcBJ7+Kg2BmWnXVWXrO9EllJWXBNEkdgfwqorpY+EzPckprt3aWl
         TdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780054453; x=1780659253;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InN/OGCUMvXTCX+obkWeolv325a7pUPRJkHQ9ppGD9Q=;
        b=mRKkSHA8ssqOE+HBInWX1eHey1imBnzpCmPdzdER5LxbQiZ5T9gKu8M2j+ShLGcuF7
         khGi+7JR47fcYRdpC3qnzvWjbxANM15A/4ApgFbYsP39kgJp4YdrD/aDZ7B08EN5czEU
         O0PYMXM/Gpm6DktSMUWIKx6BcgRzxzf/9Jj6XAijsFSTcHlrwI5t93Rco6TLoJ3+e1vu
         SqU0CDv7HpNVFf++C25rQ7es6p1HnWtJvrbB8UDrRD15yemVGvkIwUR6j4w1dIIDk5CS
         GJD1suRgR2sp0voRvUKot60PfDHP2y3xWMEmIhsEw32v1IPURLGNPoA+t0mVc6qcvfIb
         fswA==
X-Gm-Message-State: AOJu0YyuD12l/JzWyECVyOHsgtIdQZ8Yy7Xccm9L58ds9+YtYOlemwlT
	ONxUJkP3YOD+ro5Nb0K3xNaRblQkKM9Xg9KqKrbbPN4fNp79EkqEzw4SsPZSin68wi4ueoTgNaU
	i9FK1k6x6W+zJiR3iNN1HNU7n7mGuC/TGe2AMQ74H5TJucoxf2AlTv8zEJsSAJpFEQ9eY2kEIiX
	dIlorpD7uMQ6vfa3XvsKz6B6NXKeKFfg==
X-Received: from pjsc7.prod.google.com ([2002:a17:90a:bf07:b0:36b:8d13:c936])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50cb:b0:36a:d51d:42ef
 with SMTP id 98e67ed59e1d1-36bbcd86035mr3204141a91.13.1780054452415; Fri, 29
 May 2026 04:34:12 -0700 (PDT)
Date: Fri, 29 May 2026 11:34:08 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529113410.491538-1-praan@google.com>
Subject: [PATCH 0/2] iommu/vt-d: Fix issues on probe error path
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses two pre-existing issues in the Intel VT-d driver's
probe error path. These issues were identified by Sashiko during the
review of the ATS series [1].

The first patch fixes an RB-tree corruption that occurs when probing
non-ATS devices. The second patch fixes a UAF by ensuring the per-device
private data pointer is cleared before freeing memory on failure.

[1] https://sashiko.dev/#/patchset/20260525184347.4059549-1-praan@google.com?part=4

Thanks,
Praan

Pranjal Shrivastava (2):
  iommu/vt-d: Fix RB-tree corruption in probe error path
  iommu/vt-d: Fix Use-After-Free in probe error path

 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.54.0.823.g6e5bcc1fc9-goog

