Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327484;
	b=eGc3aCkwS/BTB67ssR1m9mFOTwpRiFR8sV+SaxBNCkObY+OkUrv+Pig3I7MfIoIsB7aT
	 GGmYfHg0cgsjCYw+lLzSoMch9uS9HBo4/LcvM5Q39CrekcEdQ92vbiHBY8aBezWZHgYym
	 tnypnWHFtG0URxbg9o4JREYrCB9tZJgyJGcaaLl6SdDVvU//F2c5ufKxWD+zGqERPCmDe
	 yqiouBNfINeJR0YMcsQu446U1FkdRJFnv2xOjeqv6JGIx56MnDi8GbKIrofM69xECtFXo
	 E3FaGiFEbxl1BcIPZ66jSomC7rp16AD197veMSccS3aivpi/nQoIz9rEF0xvbwLX4Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327484;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=F0TSJYgAt9wrDoqXicJayvqpbTvTCb9uspY/q/ePjKU=;
	b=RXAzNqOlm9/IlHQWeH5pCo2JodyIkKfkFHCyM82S9qjC5JPsi+lDOZ17cr5PLwpo/Gij
	 yvjUeQzHAfdyjBy063rgjqtCKQC1KpksWOgdt3po12WrOLOKtsDwLOo79oOGGQ1Zjg42i
	 NbD3hC+SUstIybSSnoGEYdDWVqpAQy6TFKUEBcDmYwlMXyAh91ABYsPSHbxDbyZzm2ul3
	 cJkhrZRR/UZeRnPYDa8OTMRGGafhwptSimfRmGIXn9GA7n1nJIk7Kio/o/0dbq6VhMaBm
	 tIYuBgD4C7j2T1UJQYyvHgBdRHQ73XOxG/X9TfwkHuO1QKZJAbuTj6biYDGdcaVeZJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834F606A31E
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 02:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2834F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jG4ps6VlHz5B1C7;
	Fri, 30 Oct 2026 10:31:17 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl1.zte.com.cn with SMTP id 69U2V9Yu030476;
	Fri, 30 Oct 2026 10:31:09 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Fri, 30 Oct 2026 10:31:10 +0800
X-Zmail-TransId: 3e816ae40168028-1fbe9
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: fangyu.yu@linux.alibaba.com
Cc: gong.shuai@sanechips.com.cn, iommu@lists.linux.dev,
        kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v5 03/10] iommu/riscv: report iommu capabilities
Date: Fri, 30 Oct 2026 10:31:04 +0800
Message-ID: <20261030023104.51259-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020094106.92722-4-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-4-fangyu.yu@linux.alibaba.com>
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
X-MAIL:mse-fl1.zte.com.cn 69U2V9Yu030476
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 30 Oct 2026 10:31:17 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE40175.001/4jG4ps6VlHz5B1C7

Hi Fangyu,

> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Report RISC-V IOMMU capabilities required by VFIO subsystem
> to enable PCIe device assignment.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

This patch has already been merged
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3069e8f3e1e9bdf007316eadae4d1777065e7b78

Thanks,
Shuai

> ---
>  drivers/iommu/riscv/iommu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index fe8e6d0f8a23..40beccedd39f 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1444,6 +1444,16 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
>  	return generic_device_group(dev);
>  }
> 
> +static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
>  {
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
> @@ -1505,6 +1515,7 @@ static void riscv_iommu_release_device(struct device *dev)
> 
>  static const struct iommu_ops riscv_iommu_ops = {
>  	.of_xlate = riscv_iommu_of_xlate,
> +	.capable = riscv_iommu_capable,
>  	.identity_domain = &riscv_iommu_identity_domain,
>  	.blocked_domain = &riscv_iommu_blocking_domain,
>  	.release_domain = &riscv_iommu_blocking_domain,
> -- 
> 2.50.1
