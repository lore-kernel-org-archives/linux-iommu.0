Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774757;
	b=ZnqTLkWL+n8C9MecRdY3HaWKZHCbLXNBUA9eQj/JaIkHP5d5ZOKz2zl2Ob140xaVUq/j
	 rqcG+M6MKBBvDLfWdYVrVvMHAMU89q0/w9LLhfTcizcdCHOZdD6AcfZis/V9mB2qJYvC8
	 jlRHy1VL2FyaI6Cx3JleELFNnMXzk9Buf/oTwsDtxBhtqTXD8Y2KMc7mDcaogM1Cq/OYu
	 R6hHUD0318pUnP3qLmggX1crj9/1i+on78Bx8FfxHG3qoDDWiNTa0OirvWHLZJtBxhmso
	 l+hqXijDiEj/V2mwT2zX481Q/Y9KtfK8Ps+WCeVIiK29LrLApYqZ7Y10KlHNl+LxbyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774757;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=clIQptAzz0QSjPQqw4pdzoEdWRP3GM/T5ORBpQ5q5qQ=;
	b=IAUQXN9hMVNGTVaX/yDUPgm17NEEFo2bvijFit9jMd+XMf5atX8s+qX7cIj21wbyn5qg
	 xyY3OS/+w3JlECu4XLqkRCn6fyqtV2O06C0jQq6vCoIDUcoBs8PzQnhMrdrq2B+MQWMvj
	 vlFBbFYr0ZnVk6ZnGN8MucIkWpW7TtO/XIJbU9C/whUSXN8wb7Ui7/t9K15/AzkgXMTnr
	 Md5Vkl5yS+Iw2tR1fWokHj7NZBquh4KtdMVQujJjtbHfdeK8QfjTPlgQW1aokq5zEUxnT
	 zOV+MXMFbOGm8FMsS7qOGmJtIL39LADU+uOLody2Y6ZyjtVTx7aqM4bcDHdFhfOg5Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C533606A333
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 06:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C533606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jKGDJ0s8Cz8Xrrf;
	Wed, 04 Nov 2026 14:45:52 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl2.zte.com.cn with SMTP id 6A46jiZE066518;
	Wed, 4 Nov 2026 14:45:44 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Wed, 4 Nov 2026 14:45:46 +0800
X-Zmail-TransId: 3e816aead493029-bd580
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: fangyu.yu@linux.alibaba.com
Cc: ajones@ventanamicro.com, alex@ghiti.fr, andrew.jones@linux.dev,
        anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev,
        baolu.lu@linux.intel.com, gong.shuai@sanechips.com.cn,
        guoren@kernel.org, iommu@lists.linux.dev, jgg@nvidia.com, jgg@ziepe.ca,
        joerg.roedel@amd.com, joro@8bytes.org, jroedel@suse.de,
        kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
        skhawaja@google.com, tanchi25@mails.ucas.ac.cn, tjeznach@rivosinc.com,
        tomasz.jeznach@linux.dev, vasant.hegde@amd.com, will@kernel.org,
        zong.li@sifive.com
Subject: Re: [PATCH v7 06/10] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Wed,  4 Nov 2026 14:45:40 +0800
Message-ID: <20261104064540.115560-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103120236.53474-7-fangyu.yu@linux.alibaba.com>
References: <20261103120236.53474-7-fangyu.yu@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 6A46jiZE066518
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 14:45:52 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEAD4A0.000/4jKGDJ0s8Cz8Xrrf

Hi Fangyu,

> From: Tomasz Jeznach <tjeznach@rivosinc.com>
> 
> Enable KVM/VFIO support on RISC-V architecture.
> 
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  arch/riscv/kvm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index f7e4d0f9b156..13552cfc2cd3 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -28,8 +28,10 @@ config KVM
>  	select KVM_GENERIC_HARDWARE_ENABLING
>  	select KVM_GENERIC_PRE_FAULT_MEMORY
>  	select VIRT_XFER_TO_GUEST_WORK
> +	select KVM_VFIO
>  	select SCHED_INFO
>  	select GUEST_PERF_EVENTS if PERF_EVENTS
> +	select SRCU

This option is now meaningless, please remove it.
See:
https://lore.kernel.org/linux-riscv/20230105003813.1770367-5-paulmck@kernel.org/

Thanks,
Shuai

>  	help
>  	  Support hosting virtualized guest machines.
>  
> -- 
> 2.50.1

