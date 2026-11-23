Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437196;
	b=3dobiR8VizpnZh5XZsYJX3eJpFLTyLwkBNCdTeV2njPwoyHltFbpPy6kSWDaukThBnCe
	 a2HDYEqaG4z/jZpYgti5ru0cz3PVbpqcl/A0tPNSegl1z+T/Z/2BElzmUJCGJOI0KD/Ze
	 iUfN41gVep1SjOFEH+6BKgBlCxlaZMKvTdlJJBGRRHlRljJ0IXb/Mdcpg/lFJ3BUnGwvu
	 e3ZK8dPUxtkCUZaETSpqR8oBiKdXdicA18hYvBgWLOavyk9/gLkNh7GUoxFRZJvNFA9vX
	 o370CWBGAEpW3OkL+tFBdyE/CEkYOKQKw6gwBxif7aa4OpRWLHAcFaL2iXjyTwPyQDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Hn7QLnatls3YJLh9hvARkpylGvnCInTwrPxLQjvpHck=;
	b=gNreNe8uyvsVf7kDb6hBqR5Vh9Yd14tjlssNwp16aeq74TfLy0XpGfxAWuILdojE5LBM
	 +oHMDH1Ha8/xcI7rrEOZGWAuxWL+fz7aYk8M29BewzmPCC0YX2vwAFofS8+7unHMiLJ2f
	 cX2CVVe5WQ8ySjJVyhAmxdZxkHQ3/jaqSurqzXPxf8Fb6j0VM5s2E0RXFVzYO/52QzcdO
	 u6SrVbbZ3u1m3bE4zMqqefVhlIehAiXWF75pLTv1XMvlPCRC1l9pm73xcY1gvyaSHS5yS
	 CyRXf3AJmVXRQE+6xxXBZ2FYWZGMFePgyBWA/khGlDjFW1xKsal6Vry5FExVh2wnsiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aakaJBir;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E0606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 12:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 152E0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aakaJBir
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3b411059cd2so728580a91.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795437195; x=1796041995; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hn7QLnatls3YJLh9hvARkpylGvnCInTwrPxLQjvpHck=;
        b=aakaJBirpBopIg4aEhMidqvpIu+/gj6+60WIJipirMhpDVJKDToU6FtWf9zWQwMytq
         dBGcoNlAVb1nKUvQ1vLSZc8oRpLDDDYbI36tiMvzwr3y2pAvjjl1pP7fHlTNAwBZ8YTP
         qdWJptOARImn3erKT0vaD2AxwVZfh4pp8HLlRQzsmi+r/2Mbigqoqji2Hu7hRyl5mr3h
         zLvPWEfJqVfWhS+1Ys2Q4cwDlJEtoJu47Dc9b+cF9e2qk5kywC0p7pZoUbkIS+m/Hz6F
         Go+VnBzmTUQEB5+E3WLYDuZfhJb6MDiJFrdGu0amSG12vU9ymZ/NpPWGh7Uos3+ka1Kx
         KjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795437195; x=1796041995;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hn7QLnatls3YJLh9hvARkpylGvnCInTwrPxLQjvpHck=;
        b=am4ZEsy2Edjzc/DW/3DH3sO0BJRg6ljx1t6oaG9IjNdjRj+EmQYk7pcQxtEbgpVJ3t
         FiJpx+nAH3D2N2GI31j2mXCoe099rZgPXS2WKrGeFbDaYPk6hZsr2IYBMNw2oW2bTJrZ
         TBDfktOmBNydOeQ9Zd9gX05bLwbyVOLXPRtelFLJNZqFOCImsSOHFCtCqZ66o/P3EZGP
         Im7eXeStoOo4hZzGIbZ1Dp0nNYrLx/w8D9aQl3AiVazlTY/8L1LP1KOyt0jXIp3qzd49
         vSgh06AycUQcGjx6fifzPiqujDxm0oPJuTbDjB542X1VM+Rrfn8Opgzst8s4/LHTjm99
         xS8Q==
X-Forwarded-Encrypted: i=1; AL+hErHzQZr8rODkoMKxsr0uaZvJH1gII0dg1AkdqeGu29rFnG6mjl+EJvNxMNIle/l+fbNuQnGKdg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+RyN34pz+IL1b96Unuc1fNO02PXaQz/PXIytYuXsuAs6sdenN9
	HekGe4F1NORXbQ7WejVwMfjdp08iReEOz7sKbc8xmG+n8pwI+KtL/Wrp
X-Gm-Gg: AZFdTZdWEAc0F7SKaJnxKpkB4I4GCz91VZKkCyWiL4WYpSRa6u6C88e52rU4qGRRBZ4
	BPc5CL0cVfSiMzZ7WdSPYesrR2DXIUlVyasknCSr5eQ8yxI5oi+XKqQNhoeoQ/FJTlGcQSyt8wr
	WKXnzQliZo7c4aX9kc640s2bTKpqeu7OpfsqucIyUDK1AocsI/AL5GqbSNYFm5XnUjN8v7DDhlt
	kEEOp2O7qxvmbv4Ju+bvA7QwQdb8oaL0+PPy5pL/Sm29k8JyaGb7nW6jcDjotSDM2H43ewySamL
	AXPfp5UQRR2B8heW3lrGspTWMGJtV16EHVVMNzH+XlKXOWLQqcxfxHTtMOlChjdFOFSVB+JlD6l
	vR8FfDpOadMT3RiCz1RtKJYwee7XgSfUlzoQGjXFigjAJDxpWKg5wEt8L/FFrHR/o+A2kcZewD4
	O6mR+ZIdnLB+aOYK/gdaEGRApKLgd/L0uWNh13Y0r+q8bpIuBrpnEgGSDiCJgSVKJsikCQryEWG
	I3pzzu3o2bNfLz9UcZ8ju2DYim/U704NHOBJg5jhS65JvslN43KiET1yUlwmGIiWYMdMPpNPNks
	qb4foHmwhfMe2+ePUFDZF+dUUcIVQd8z8bm4y1si2AgcDV0H
X-Received: by 2002:a17:90b:268f:b0:3b3:afdc:2e5 with SMTP id 98e67ed59e1d1-3b41c9cf56bmr7964160a91.30.1795437195128;
        Mon, 23 Nov 2026 04:33:15 -0800 (PST)
Received: from [192.168.50.100] ([114.252.97.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm7472471a91.0.2026.11.23.04.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:33:14 -0800 (PST)
Message-ID: <4ac66d3b-7343-4ff8-8ebe-d3bf9ab25da4@gmail.com>
Date: Mon, 23 Nov 2026 20:33:04 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/10] iommu/riscv: Add nested domain allocation
To: Andrew Jones <andrew.jones@linux.dev>,
 Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Tomasz Jeznach <tomasz.jeznach@linux.dev>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Fangyu Yu <fangyu.yu@linux.alibaba.com>, Tan Chi
 <tanchi25@mails.ucas.ac.cn>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Zhao Qingye <zhao.qingye@sanechips.com.cn>
References: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
 <20261119132744.396426-6-gong.shuai@sanechips.com.cn> <awGP5H2JdjxW8WXG@orel>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <awGP5H2JdjxW8WXG@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 11/21/2026 8:37 PM, Andrew Jones wrote:
> On Thu, Nov 19, 2026 at 09:27:39PM +0800, Gong Shuai wrote:
>> From: Wu Fei <wu.fei9@sanechips.com.cn>
>> 
>> A nested domain describes two-stage translation through guest and
>> host page tables. Iommufd exposes this domain as a nested hwpt.
>> 
>> User space needs to provide the guest stage 1 configuration when
>> allocating a nested hwpt. Validate the configuration before storing
>> it for use in a physical device context.
>> 
>> Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
>> Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
>> Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
>> ---
>>  drivers/iommu/riscv/iommu.c | 153 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 153 insertions(+)
>> 
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index f2305b953f71..4f8ce579ef08 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -1698,8 +1698,161 @@ static void riscv_viommu_destroy(struct iommufd_viommu *viommu)
>>  	ida_free(&riscv_iommu_gscids, rv_viommu->gscid);
>>  }
>>  
>> +struct riscv_iommu_nested_domain {
>> +	struct iommu_domain domain;
>> +	struct riscv_viommu *viommu;
>> +
>> +	u64 tc;
>> +	u64 ta;
>> +	u64 iosatp;
>> +};
>> +
>> +#define to_riscv_iommu_nested_domain(domain) \
>> +	container_of(domain, struct riscv_iommu_nested_domain, domain)
>> +
> 
> Please rename the macro parameter so it doesn't collide with the domain
> member name, otherwise macro expansion replaces the member name too.

Thanks for catching this, silly mistake on my part:)
I'll rename it in the next version.

Best regards,
Shuai

> 
> Thanks,
> drew
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

