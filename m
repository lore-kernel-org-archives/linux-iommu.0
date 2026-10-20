Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459452;
	b=HzZAEec7yR5A0fkXAIi2KtN0H+5Dw4+/kzBVBsw0Q9OqdQW+rvCmfG+AAtHWd4GPyF0l
	 Ci9E+cUNIjbK8UyYwRceN5PIA2nGtcU7OmR/MxYMBzJzgpRO4eCESR5k/fVutS4ell+Dg
	 mKfQ9a0s5q74Vf9Iolk5VHB+XCn13yyBVm/O2IibQIY9vLJaQiWeM5KcCYQs8AjhhcSAI
	 3dNFP6u8p309zx/S0/2jDXZeQr1V/dB3ec+4zxstarId0nJGIl8I3qe2quUlGlQl8f6li
	 9Ad03BX1j5SgJZ6OXCPPZkqyH5ZmHREMGQbPmOCmbp3uid8YTJqopFcpGe1RK9hmJbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459452;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q3EOLIaJ2qdXdEiMGxALnePEn7hmKAP9M8QU5KMiV3E=;
	b=tTsEdKwcLomq71EUKHrHKScY/VZP9+3D1fj9iFZTYCYH0PjSZBEMFtEix7eznnYhHcc7
	 GRqRTQm/0RxtfZo9g0z38MzzKXrZrTjcjF5nWwQ88xE2frwtbW73MooVyhnBIlEx+ACcp
	 b1/tr7OYupNrmhJZ6dDJfOo4WtFdE16ixmPm0ygfI/ZyTZrAbB1sH2xlm6+QS2EMIdrza
	 2PEAphi+CLeAm8ZoLMG80HZiS1TAaE2CAX7aWhiPOYiYL2i+mfOghuHfXXwT6rLDf1BRp
	 xHYqfGUy7LZkvR/2nM0k7xS5VW1U7oIwW7eLkzc+J34KkE12Fv8SVghtxQxFHpBN4VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mjeZVoE+;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22605606A319
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 01:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22605606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mjeZVoE+
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792459448; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=q3EOLIaJ2qdXdEiMGxALnePEn7hmKAP9M8QU5KMiV3E=;
	b=mjeZVoE+15fONT/jj1qHIOZzMEkbmDKw5rJBuPWkIfzNrWYnnxpXcgSBda3g5JD+KXBfN1zJEQnKWysM06+Z57T9BF8d1oHRZOu+wT6nSFLQyHACzecFWt5fe1BkpWir18OGe5cmffoEeM4Cop6qbTLnp43Ubk6CkDxSAcWK974=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XDB1Dh._1792459444;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDB1Dh._1792459444 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 09:24:06 +0800
From: fangyu.yu@linux.alibaba.com
To: tanchi25@mails.ucas.ac.cn
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	gsh517025@gmail.com,
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
Subject: Re: [RFC PATCH v4 10/10] iommu/riscv: Add IOTINVAL.GVMA after updating DDT/PDT entries 
Date: Tue, 20 Oct 2026 09:24:03 +0800
Message-Id: <20261020012403.22247-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261019133536.1610-1-tanchi25@mails.ucas.ac.cn>
References: <20261019133536.1610-1-tanchi25@mails.ucas.ac.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Hi Fangyu,
>
>I wonder if riscv_iommu_iodir_set_mode() also needs a global
>IOTINVAL.GVMA now that second-stage translations are supported.
>
>It currently issues IODIR.INVAL_DDT and IOTINVAL.VMA after updating
>DDTP, but cached G-stage translations may still remain, for example
>when the IOMMU is reinitialized after a previous kernel used
>second-stage domains.
>
>Would a global IOTINVAL.GVMA (GV=0) be needed here as well?
>

Good catch.

Per the spec, adding an IOTINVAL.GVMA here is more accurate when
second-stage translation is enabled.

I'll add an IOTINVAL.GVMA in set_mode() in the next version.

Thanks,
Fangyu

>Thanks,
>Tan Chi
>
