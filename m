Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C51112
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 05:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03933C433D2;
	Tue, 20 Dec 2022 05:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671514916;
	bh=aobfGfEvD4AGl4vRZJIYk0SEFsUj+YmTUfc3k7PaaFE=;
	h=From:To:Cc:Subject:Date:From;
	b=dyv9hCR8Y5cKQ80uJ7AOscEh/kDAsDsF/psMVIGEwc0LkdOg5NUaH5C0HkfiCuFW8
	 APy2e/R0Sv2c/yUAuAtJCbtRZ2YpFw+9nNcCAAIhNvWkiCmFo9Ni48HLJ8f6owdZz9
	 bvaGPQwFQJy8ILpQHBlW733ozfua0bPZIqY1z8QoB67C+m86a2FImqFuVLu8uNHKmM
	 zdPiDDH9x/QnQYik3ctlDWzw+wmZQEc1cHg9bs3J66Nb5NHUxPLb/IsfXd98KFi1Ou
	 7LJMOzENRw1+SpzJX8XSSYpYhuu4B2HkJHZUDT6gZsEnrpvnLuzKE9H0GScTlzcIAS
	 1DDhFajrzTg3w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	corbet@lwn.net,
	will@kernel.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	dennis@kernel.org,
	tj@kernel.org,
	cl@linux.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	davem@davemloft.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	Andrew Morton <akpm@linux-foundation.org>,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [PATCH 0/3] crypto: x86/ghash cleanups
Date: Mon, 19 Dec 2022 21:40:39 -0800
Message-Id: <20221220054042.188537-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are a replacement for Peter Zijlstra's patch
"[RFC][PATCH 02/12] crypto/ghash-clmulni: Use (struct) be128"
(https://lore.kernel.org/r/20221219154118.955831880@infradead.org).

Eric Biggers (3):
  crypto: x86/ghash - fix unaligned access in ghash_setkey()
  crypto: x86/ghash - use le128 instead of u128
  crypto: x86/ghash - add comment and fix broken link

 arch/x86/crypto/ghash-clmulni-intel_asm.S  |  6 +--
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 45 +++++++++++++++-------
 2 files changed, 35 insertions(+), 16 deletions(-)


base-commit: 6feb57c2fd7c787aecf2846a535248899e7b70fa
-- 
2.39.0

