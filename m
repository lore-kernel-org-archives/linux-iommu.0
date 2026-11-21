Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795264691;
	b=u+M99sBi84i1Oi/FubEZpHdSYS5hTX6s987goIC/nnj6cUo+BA+paE2DeM+Y8z+0WQ+X
	 gdwGRsrL2rwdm6acpX4plcLaNZ1LAIWI7BqGdLoyLG3Bma2MplJQTprwBCm+195ZzYpt2
	 PQidDmE1kmr+p1hYywd10gx1byZJJcDEJpbmFJ/T8VqV3qIlfJVuK26yVhLxUZXqhFzwX
	 2eaMoEtXoGAi4/OWSHanJ4Qx6sYydkaUhrpTz5u3lpFw1I9jEXF2VICky7Ql95t5N3twh
	 vPzBE0sMrxUiffZHgC/CJH/2vUFr3GIp4exw7Mp3o8zcBHHwH6mrF8Adrz26q1i/vvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264691;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m5G/QICZ24fNOzMfjvXjLK2A3CcIHloqOJ+RgXtyUT4=;
	b=OZ/VkL9ZH/VpYHDV0c/VnW8a7Fd5mP/HSeARqN3qqhdZP3VBctLYS+l2bH61KWw5aL3w
	 ipl4cPnmi74SF0uz3HRns3nuMwpLDZeevLPh5E2OLbz69f72iAIqrcmWasoGZaZfXt9k0
	 o2Ps8chcL+3i2JSP2hzJhkn9Gnd5a78srQlAkePthZyV13ujaBX9ujhnhVy5y3RhoZXu5
	 aBO4FXxcDLEYWhcwKGdUn/fcT3uCqbsTzVp0FWbG0YJktZvmFvFIE3r9bLTwjXgzku+ut
	 9aFN3gEc53FsUiLoKTjn2VbfWrFSMMEq2RCumR62GwjBEM+dQBacOu67sn76UyaT1pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BVd7DUyo;
	arc=none smtp.remote-ip=95.215.58.83
Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F4606A32A
	for <iommu@lists.linux.dev>; Sat, 21 Nov 2026 12:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 676F4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BVd7DUyo
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=rRoUO1ekAv/EnBw/LqUWxSkU357wwykHVnVwqfZsCKg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795264687; v=1; x=1795869487;
 b=BVd7DUyoNQtYHAc4AxDOU+64n2ZFVG7Y9IswXb9+GmiSj5osvIXrsMxxPTJYs7PUDcCsV5L7
 jJL3bm9/PTutt5R29GggzbveN3rBIOYTNJUAEIIIxDAzfmGYxgzDqf1DSZ6WuUVth46xQ5ngwMk
 nw83sHH+nTiiOQbBQDGuw4H0=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 51c69ba41e2b6b86;
	Sat, 21 Nov 2026 12:38:07 +0000
X-Mizu-Trace-ID: 51c69ba41e2b6b86
X-Migadu-Flow: FLOW_OUT
Date: Sat, 21 Nov 2026 13:37:29 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
	Tan Chi <tanchi25@mails.ucas.ac.cn>, Wu Fei <wu.fei9@sanechips.com.cn>, 
	Zhao Qingye <zhao.qingye@sanechips.com.cn>
Subject: Re: [RFC PATCH v3 05/10] iommu/riscv: Add nested domain allocation
Message-ID: <awGP5H2JdjxW8WXG@orel>
References: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
 <20261119132744.396426-6-gong.shuai@sanechips.com.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119132744.396426-6-gong.shuai@sanechips.com.cn>

On Thu, Nov 19, 2026 at 09:27:39PM +0800, Gong Shuai wrote:
> From: Wu Fei <wu.fei9@sanechips.com.cn>
> 
> A nested domain describes two-stage translation through guest and
> host page tables. Iommufd exposes this domain as a nested hwpt.
> 
> User space needs to provide the guest stage 1 configuration when
> allocating a nested hwpt. Validate the configuration before storing
> it for use in a physical device context.
> 
> Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
> Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
> Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
> ---
>  drivers/iommu/riscv/iommu.c | 153 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index f2305b953f71..4f8ce579ef08 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1698,8 +1698,161 @@ static void riscv_viommu_destroy(struct iommufd_viommu *viommu)
>  	ida_free(&riscv_iommu_gscids, rv_viommu->gscid);
>  }
>  
> +struct riscv_iommu_nested_domain {
> +	struct iommu_domain domain;
> +	struct riscv_viommu *viommu;
> +
> +	u64 tc;
> +	u64 ta;
> +	u64 iosatp;
> +};
> +
> +#define to_riscv_iommu_nested_domain(domain) \
> +	container_of(domain, struct riscv_iommu_nested_domain, domain)
> +

Please rename the macro parameter so it doesn't collide with the domain
member name, otherwise macro expansion replaces the member name too.

Thanks,
drew
