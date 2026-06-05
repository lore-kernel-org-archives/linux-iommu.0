Received: from mail-m3286.qiye.163.com (mail-m3286.qiye.163.com [220.197.32.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E03377017
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780626909; cv=none; b=iC3GMLMz+bdZn73BTid8Ev3eZh2SKfgTY8v/wdLCvfoLsQWD9rWf1hEK9CkKb+U/c8sEpRQVhTVUh5IHCOHZX4r1kUkJmbCmUj05Zw7QE8wUddvdMliYBzZy1v9SgIuxL3BOYG4Gy/d8iTjqZmd+YtnHu1C53OHZo/FkdKDjvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780626909; c=relaxed/simple;
	bh=KlSOQOMOtb8TK9P6Ea3DGVv/R2NSDERpT5EWmqMpOdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbFEglUgxAyk8if6sOye5Z9hw4Ssxs7mWt/E321LCShUyfxQ0mjnTKmvqlTg523BvS4EKyTPMEsRHdshnD0tTyDm4idYcaIt9X9LLKFRqwjJcE+ICfY2P1oWZ5K5BhangDbVrOAvLbHPCNsya5pb8sB1Z+L+3b70JPcKL4PjtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Y3Bvc45C; arc=none smtp.client-ip=220.197.32.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y3Bvc45C"
Received: from [172.16.12.90] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 412827f77;
	Fri, 5 Jun 2026 09:59:26 +0800 (GMT+08:00)
Message-ID: <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com>
Date: Fri, 5 Jun 2026 09:59:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Midgy BALON <midgy971@gmail.com>
Cc: Simon Xue <xxm@rock-chips.com>, tomeu@tomeuvizoso.net,
 ogabbay@kernel.org, heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260604135255.62682-1-midgy971@gmail.com>
 <20260604135255.62682-7-midgy971@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260604135255.62682-7-midgy971@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e9581b64203a7kunm811ff8bb36f5c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUtDVk1PTUMZSk1LSElDTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Y3Bvc45CIW1NaueqHEUkrrc13tHP57PqG6D2cUlho677APrf8hPJYnVsf6QyD0Zk7yVvbfA0ZPSedpeaoQA52ct4LgKHetxAmjcdQmZWwmJ+EqDR7sdzv54ClZGO6nzhL/GGcQNa0SaMChUshrzbZtTRabCXibPw3II/YdwRamU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=JhwLEVlbuMyJ2TM379GNJ3NbYdaquaVpgzGyK/FsXPQ=;
	h=date:mime-version:subject:message-id:from;

Hello Midgy,

On 6/4/2026 9:52 PM, Midgy BALON wrote:
> On the RK356x v1 IOMMU, RK_MMU_AUTO_GATING resets to 0x3. Bit 1 enables
> auto clock-gating of the page-table walker, so the walker's AXI master
> loses its clock between transactions; a TLB-miss page walk then never
> completes and the IOMMU is left stuck (PAGING_ENABLED, never IDLE).
> 
> Clear bit 1 (keeping bit 0, the slave-port gate) once paging is enabled
> so the walker keeps its clock. This is required for the RK3568 NPU MMU.
> 
> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 4da80136933c4..e3d8b6e9ca12b 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -953,6 +953,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>  
>  	ret = rk_iommu_enable_paging(iommu);
>  
> +	if (!ret) {
> +		/*
> +		 * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page-walker
> +		 * auto clock-gating; the walker's AXI master then loses its clock
> +		 * between transactions and a TLB-miss page walk never completes,
> +		 * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE).  Clear
> +		 * bit 1 (keep bit 0, the slave-port gate) once paging is enabled.
> +		 */
> +		for (i = 0; i < iommu->num_mmu; i++)
> +			rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, 0x2);
> +	}
> +
>  out_disable_stall:
>  	rk_iommu_disable_stall(iommu);
>  out_disable_clocks:

As I said, it is v2. Could you please try using the code below
instead and see if it works? Thank you.

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0013cf196c57..89e3a83a0251 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -930,6 +930,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
        struct iommu_domain *domain = iommu->domain;
        struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
        int ret, i;
+       u32 auto_gate;
 
        ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
        if (ret)
@@ -948,6 +949,10 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
                               rk_ops->mk_dtentries(rk_domain->dt_dma));
                rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
                rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
+
+               auto_gate = rk_iommu_read(iommu->bases[i], RK_MMU_AUTO_GATING);
+               auto_gate |= BIT(31);
+               rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, auto_gate);
        }
 
        ret = rk_iommu_enable_paging(iommu);

-- 
Best, 
Chaoyi
