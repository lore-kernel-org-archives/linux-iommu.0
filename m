Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449703;
	b=kUhF63IFwIJW87K6F+kvsB9GX+TtFp086JOaXsgIE7OETzE9bPFXXH1pdPqrXVIznTX3
	 Fihc5AoBpySDpIFExqWNij+IGx8VSxQloQnZPvy1uVB+i1m/KDaN8CWuPiBJ2h7+/yEPL
	 PSHQdR8YOTYieiJ62WNFpqUrtjeyXStANxfd3/uRKom3DP6057d3wPDV92gIM0Fsw/BuJ
	 9VIeCQR1QRtB7dUMcMug0KCiLVLWQirBgg7ftE+QdV4FZNwEb1HTpKGceKObIw8sWMSWJ
	 PRIpy+FiKvVMgbl2hp+Bq5cuw3oIMrPEIknea1javOj0tyPf07ga4yitAbq3PVuEqnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449703;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1xCaH4HUY4jE9shdiHIoND7z6gJxF6tiu/0JOdXHPA4=;
	b=AExbzneC+AbcGKm2UYbE9SobUQhLlSTt7WCa8Ek3EkuSLRg69hfC2lGJMMzsMCN3+CDS
	 14XxlZWrD7ehDMN9SYzkJOWxjjdvbw/e2w5wZxyRyG9zjGeNiFNDm0j+WVsVVxjgbDX50
	 L9nfTygJfj6QQ0fD1yal18QSEzdBfJhGK9fMkbd/dPfvzFy/JQV5tUgViy6v6OvxUlE8H
	 +01h20UNIgGeq3HNh9GcKMfE7iPhMadm3HwYAFKvzS4CMRg8TtI/eonxoB93SOVtpE+Jl
	 8bMQmO3BZqwsNjDw8nyHGFEh3yLMZnVvdTJTNzJALzHQtlkiQsvT8WBi14GV8ykop/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HmTDAKB7;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D789606A321
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 02:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D789606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HmTDAKB7
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794449693; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=1xCaH4HUY4jE9shdiHIoND7z6gJxF6tiu/0JOdXHPA4=;
	b=HmTDAKB7AVJdzLzZqx5FUfbAhyHX3gEGhOK81gH1j/ruh091urRedD8/dickzMvQ1dDZsOutEtY9kLDmp1rRY20IfkAosLwRlPZinrqa2gqa4qv7LxR6Y7vsmRS4Hu2U0wlUxSu1LH/V5vlBKMgtAgxIXNMC+7DCxht4dm12IKA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XEaSUOK_1794449689;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XEaSUOK_1794449689 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 10:14:51 +0800
From: fangyu.yu@linux.alibaba.com
To: tanchi25@mails.ucas.ac.cn
Cc: alex@ghiti.fr,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn,
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
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [PATCH v7 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Thu, 12 Nov 2026 10:14:48 +0800
Message-Id: <20261112021448.48441-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261111150249.13262-1-tanchi25@mails.ucas.ac.cn>
References: <20261111150249.13262-1-tanchi25@mails.ucas.ac.cn>
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
>The following QEMU patch series adds support for automatic PTE A/D updates through AMO_HWAD:
>
>https://lore.kernel.org/qemu-devel/20261108143934.129923-1-tanchi25@mails.ucas.ac.cn/
>
>It may be useful for the end-to-end dirty tracking tests mentioned in your follow-up work,
>particularly for testing G-stage dirty-bit updates triggered by DMA writes.
>
>If you notice any issues with the implementation, feedback would be very welcome.
>

Hi Tan Chi,

Thanks for your work on adding HWAD support in QEMU. In the next
version, I’ll include your patch in my test setup and run the
related tests there.

Thanks,
Fangyu

>Thanks,
>Tan Chi
