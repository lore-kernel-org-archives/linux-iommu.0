Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096360;
	b=x8K4EbeFudoR/FYvRU9aPWZZ2uiJXG+oItwuI8NTcDrB0Mu3bSFYITAWrhOGhaIGRfRJ
	 zC4l/lVqHt/0NkA/XonCmb3N6tkjzWTy87Ht+rI+hevbwyQdts7DQ+KJ/45db1N5He4fO
	 8eTeJpUd7HjcyABfjtUsv0ELjN2vt1vgxvR3WL5Qk0srTS63xOoZg61LTuhxfME1TV65F
	 ekK4MFop/CdD43qsOKzNl46e3LJMLvGhAgK/jgX4B8UjbtZRwkRA+gDiHezXwp0rlDqPK
	 tTsbdg+Chy3+sAdxpgefOGucvMLqJTsU38wIp+Zm0Jk5t32P5iNUdOx5MUBVqpIdUog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096360;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=H3giZ1HYF1OcJ1XjNTKZ+B+MBp99vdaKlXFDCF5Fp3w=;
	b=vDer5mztr1SU9PwsLFmT8bsA0x4FaiEJI0eU8xidLL6u9d0DY9cdQvNofcYiqu+Yv3ty
	 DvKTVdA998ikHVArSt574o+AooJ39WBx6qwR3dxmKMGiolkhsyNNjKq/47ypRy7GW++PX
	 9qJFq1eClPbcbX0KklisqQw1fmfCeNddWMhnGyoBywOZQNItay5uGSdm2xqHz5eGd20ry
	 m3hsejyVpepXrudNc95z60b7Faai6m1zOaDzYRvyVfNHFqjFQIvE4cT2YhX2z6zlP00j9
	 /aezGicpjRoDEHryOz1YMG2sYUW2MGZdzdg3G7FIbnAIugnMRAC+KOCZAvjJ5B8+F8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AA2pLmcv;
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5860A260E
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62E5860A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AA2pLmcv
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795096351; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=H3giZ1HYF1OcJ1XjNTKZ+B+MBp99vdaKlXFDCF5Fp3w=;
	b=AA2pLmcvLUibOsUcL/FalonEJ5YlXIGuy4nEIiAai8KfmjFGPN1BYgwUQP85uYoSe5hrLpNmk+XOmfRBi+5SUR4PY9S2LMVKAwCguo/fHnmV+ehW54zZaZYgKFdpi10E7jNT7XzmZhE8G00iInyaevrMPbJNjWP4b+VMIzSi/Bs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XF3fKam_1795096347;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XF3fKam_1795096347 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 21:52:29 +0800
From: fangyu.yu@linux.alibaba.com
To: gong.shuai@sanechips.com.cn
Cc: alex@ghiti.fr,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joerg.roedel@amd.com,
	joro@8bytes.org,
	jroedel@suse.de,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tanchi25@mails.ucas.ac.cn,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [PATCH v7 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Thu, 19 Nov 2026 21:52:22 +0800
Message-Id: <20261119135222.55990-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261118061848.184844-1-gong.shuai@sanechips.com.cn>
References: <20261118061848.184844-1-gong.shuai@sanechips.com.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>Hi Fangyu,
>
>We should add "select IOMMUFD_DRIVER if IOMMUFD" in
>drivers/iommu/riscv/Kconfig to enable IOMMU_HWPT_GET_DIRTY_BITMAP,
>otherwise it always returns -EOPNOTSUPP. I guess it belongs in the dirty
>tracking patch.


Hi Shuai,

Thanks for the catch — good point. I'll fold this fix into
the next version.

Thanks,
Fangyu

>Thanks,
>Shuai
