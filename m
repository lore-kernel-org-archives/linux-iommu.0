Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE633E374
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550303; cv=none; b=Kv6rx9fSsC0pwfKiefn18KJQp0EOF/nYxFYMi9jSAhf2lEVTUQSTmwFqknq3xSWokUhVjuTdOmcrz7zItif8t7XaQ/UhWnRfwuq9knrMzgKcGThhrrv8/cuW1KuM0XTdfFv3P9zqxynY5j1vV232WUAbU/YXSAT9Ltk9m6rlkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550303; c=relaxed/simple;
	bh=5zP8QkeIldQR8oeH0HhV4V/mXJJGJNin7wI2cdBzMBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQmb/3wHIPnMry/s5EC1mkeV0sNI0InwtXiikG2fqaLWGtqvcqac0Te8O0V2Edp06j6C0GsDHW35xplDlsrAbfR4SFq9u8oXJXCZwutaBT2zDqhvS1l+IU2qgNY8W/aFkCMSjm8Ool5AMleI5IQh+/YTJZ+1XH1vixv+zwfEQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGd6tsXw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGd6tsXw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so758097a91.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 22:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780550302; x=1781155102; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuBmEOIOOIyUhW5B0cAmum3h3GyphcqhgceqYCZrJ+8=;
        b=qGd6tsXw48JQWsE8OI3QzbP5jiJTZmvxWMMTQn2qK7cdQRFahMAxsEXecIaj7IyaBb
         TehCPFLLbX1yhXES3QuxrD1v7XZaD/2wDQeLL/OXI4wQyYhbSaFjvCzhe7yHJSoGKMjh
         v2wMmbdH3q+N/J6TtDON4X5ik7RrDkS4Rpgkub4LJwfeyxgikE1z9KqEXoY5jtLqfqvU
         xp66Vd2ddX3czITA3XwacOkgGsWFGWv9yRaZNqOEH4GaQ9/972lOXT9ZRx17nHRc8bgi
         UROFZH0h2jbqkpaDLiJdC+PFesBXEyf/cURXRjnvlO+erUH7kiwMW6LkE/+RFwv65wgi
         mFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550302; x=1781155102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuBmEOIOOIyUhW5B0cAmum3h3GyphcqhgceqYCZrJ+8=;
        b=hmJs06YGD4SDLo/982TwkLk1ub1hCGuRtDzRpIoya/KgyO8GAwyeQl/+4pGTfIe3J5
         KErenS6B6BVhHDXPzZKxc9BzvIcvUrKj7K19RPDQV0zNg/qA2bELofoV2WsksPG3Vph+
         1EXtR95Ph0twzuHICpbudVRZYCDiZFnNVwJaRqnlPTEDqAYmhh+vvef7H0QTzRNGwlxl
         THnIW4TvFBhcreRT6ZUeqazXXuAf4Ii91s8ZtqYj6iPja9yPR9xkQ7fxn+hRwQ1IvLVP
         2poJKpi/esojpT5m1Gh5el3777+qUXemMvBqIqCn+kZF4AVnyKnVNjR2M1T0BzkWW2vq
         0Oow==
X-Gm-Message-State: AOJu0Yyg+2WFg3EyFmO1TAvKb93rLOqGMFFyITea5dd719b2ZCkzHCGg
	SQPAEIRHLC5ZtXxTGcF3q4cgokrz+QhbBTtpaO+DCd3qpM7RP781GOOt
X-Gm-Gg: Acq92OEObSlA5+RrHv/sxnYYrEo6ApNM9h6wFYfQFsFH8aFakzv1uluEKckYzwzR4SG
	cUnB4S5mnU6RFRRvtFNTIwG39YIFBFBcYn4PzkjCmW4wSsTmVs0YnJDdZ/Cpw9Fe0ou5+6DdsCN
	14u48abAPJyjQN9E5NClzHVkYXKsRXBfDd0MZszkJpn4wAdMsJjkKqv++RXyGfHuIaim7bRvnor
	MABR6JJYUtcO2P2ntretPcOmDsLVJ+i3qyXlRTzpmzkr4VN4poiTrW28VUvON1DDqqtUV6tdSVp
	BGsrgdphQKgq8BkekO2LgR4S0zlVyaZKjSh6MhG8iVnjBZIFCMdAWVJtICQdWBExbC0Xf2cwXlK
	UVBOunuX3Ihat3oiXayfrepB8rHeKbDahw8CEWYowsOcNJ50ivZS4M9Uzp6RBDwc2t5Wbt6sBYk
	J1pYBCLTFSoxImyfl8aLNPg3qtBPA2du+rUrP5G6SK0IUum5P99fJ1/ZKZiuM=
X-Received: by 2002:a17:90b:1d82:b0:35f:c493:cac5 with SMTP id 98e67ed59e1d1-36f782b56b8mr1727051a91.16.1780550301842;
        Wed, 03 Jun 2026 22:18:21 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm2009262a91.1.2026.06.03.22.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:18:21 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jpb@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH 0/2] iommu: avoid using list iterators past the loop in resv region insertion
Date: Thu,  4 Jun 2026 13:18:14 +0800
Message-Id: <20260604051816.2976221-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows up the inquiry at [1], where Will and Robin agreed that the
two list iterator sites in drivers/iommu/ that run past the loop end are
worth fixing.

Both loops only walk a list to find a list_head to insert before, not to
operate on the entries. Per Robin's suggestion, rather than tracking an
explicit insert_before pointer, each loop now iterates with list_for_each()
and keeps the list_entry() dereference inside the loop body. There is no
functional change in either patch.

[1] https://lore.kernel.org/all/CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com/

Maoyi Xie (2):
  iommu: Avoid using the list iterator past the loop in
    iommu_insert_resv_region()
  iommu/virtio: Avoid using the list iterator past the loop in
    viommu_add_resv_mem()

 drivers/iommu/iommu.c        |  7 +++++--
 drivers/iommu/virtio-iommu.c | 10 +++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
--
2.34.1

