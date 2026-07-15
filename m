Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA813EB81B
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108598; cv=none; b=AMxgz/vgD+mZZ+XcMq1k8Or5NJTbh2IQEglT8DNkPh+SxRg7l8cLoBhaE3v24vXtaBJGHDp+DSf4jTXzJvxW7g9FPIhyrml8ixyoZvrLXeY9Ds4Sl+NNz9aMhBMs5A+CJCuRuZwOhMirKHLaCoy0TvFA8aK/oAcAbMWJOeuDFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108598; c=relaxed/simple;
	bh=R2HmU9UJ2IBaGQSpvN6c/A3uULuxNh34EiIl7381Gmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeElvNnSE8wQgFZHaQTgAu9H49hHPcNFqg4WJsZXh4wuAK8n/ENzmjaXTur5Vkltp4milTpdMVbMHKsNzietIVWlzqjHcGmNoy8aSUY50SPeposxQHbtddmb0T0nKPjqwW49Y24Wmxs9p/3jch3R2HiPn6FjCIveB2U9cYNQotc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=blsm8iUx; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="blsm8iUx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784108588; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R2HmU9UJ2IBaGQSpvN6c/A3uULuxNh34EiIl7381Gmo=;
	b=blsm8iUxbUrUWPFekEikTYZv/lIrKQXKVbxOUlmTzV+nDK4MV+EEhPgdXBz0pFQik2jW2nvFudBhkpS1fVW8/5nGcJ/X5Ce0i0aY2o25fITgHR37RpHGtVVNsyX3KPbIT1bqp9hPVD8Mckc9/lbjO7Cblza1T7yhhePIuJMwPzU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X78miZk_1784108582;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X78miZk_1784108582 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 17:43:06 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Guo Ren <guoren@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	David Laight <david.laight.linux@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Zong Li <zong.li@sifive.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
Date: Wed, 15 Jul 2026 17:43:00 +0800
Message-ID: <20260715094305.2783-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTT7TPA+K+JgkvvUtb0x5BSzfox+s5rG8OtrP0QzPetHFw@mail.gmail.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com> <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com> <3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com> <CAJF2gTT7TPA+K+JgkvvUtb0x5BSzfox+s5rG8OtrP0QzPetHFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 09:55:19PM +0800, Guo Ren wrote:=0D
> The specification is deliberately precise. It uses "may", not "shall"=0D
> or "must". We should not introduce speculative implications that break=0D
> the spec's consistency on RV32. The safe and portable interpretation=0D
> is that software is explicitly allowed to use 32-bit accesses for=0D
> these registers on any system, which is exactly what this patch does.=0D
=0D
The RV32 argument is quite compelling. The RISC-V IOMMU is a=0D
platform-level IP that must serve both RV32 and RV64 software stacks.=0D
Mandating 64-bit MMIO accesses would directly conflict with RV32, where=0D
such accesses are impossible =E2=80=94 so any interpretation that turns "ma=
y be=0D
accessed using either a 32-bit or a 64-bit access" into an implicit=0D
hardware requirement for 64-bit accesses breaks the spec's own=0D
consistency on RV32.=0D
=0D
The RFC 2119 argument is equally strong. In RFC 2119 terms, "MAY" means=0D
an item is truly optional =E2=80=94 a specification should express obligati=
ons=0D
through these well-defined normative keywords, not leave them to be=0D
inferred from everyday-language intuition. If the spec authors had=0D
intended to require hardware to support 64-bit accesses, they would have=0D
said "must" or "shall".=0D
=0D
Given both points, treating 32-bit MMIO accesses as the default for the=0D
RISC-V IOMMU driver is the safe, portable, and more inclusive choice: it=0D
is explicitly permitted on every conformant implementation, whereas=0D
64-bit access atomicity is left unspecified.=0D
=0D
Acked-by: Chen Pei <cp0613@linux.alibaba.com>=0D
=0D
Thanks,=0D
Pei=0D
=0D
