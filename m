Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320559;
	b=x+JdNcTWL1xzct6EHXTGzyC3eR4ERxCvJjs6ab4OEkb6OUlnsANT3FYRp0yN+6xfUL7B
	 xJcQMjKCFyjxtLUSNgr+pICrg4ejDN6StUwLgp86dqN8TJ1KHPaENM9GHuCD775kOY/y8
	 w2hyKO2vf5ECh4nRc5xWWO0KVNPIZElVUJJkoz2QE+TTCDYZZFAL8gmm0W8UZ4NJ6Poz9
	 tOO+OofzV7Dt/M6VlkgL/4cYS1EVj+cvE6nzJ6Nv9r0BzgOkqnQu6T+EldfHP4Xz3mKP8
	 Gmo9o57uZYt4bgzfKbU1ITi1XGQWeJDOD3NRvOW5JpExlfUo1gSQcI5KzATLBi+APyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vW6Me650CnRCbqpTMm9ScZes8RV1bkmpcr+ZWjp/+oI=;
	b=LF26p781gZVWgz4Zw1GX8EB3jZmFxxjbWvKmrxScFXzZEsdXODmOahI3v+vHAcCNuGLC
	 yCQIoc2n6WlcJzITsOOtA3T6vg0+CdZZovqj9LjToql0MjkYgI5IFk4nYhWXhn/sSdtgn
	 AWa/VlJVW/7XjHXbWa7OFE/XYAmsiLKMiQXhxXZd4EI3qS2r4lXcFAu8/S2otrPJlk+xm
	 3pMPPadZklze01ENaR1k4ZgvgrDteRxHi62iJ6djLqSPyUsZlqEe+bbG/IfLX2X5Oi2Qt
	 TAbJWnrPjTmz0bSn5lhoqzBYHTDjZ/f9gB8FfUx0hJqN4WdvviQWHAx+FQif28ROH6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JwOa5Qx8;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402760A260F
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 14:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9402760A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JwOa5Qx8
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3b0d11b85f0so1250861a91.0
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 06:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320559; x=1794925359; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vW6Me650CnRCbqpTMm9ScZes8RV1bkmpcr+ZWjp/+oI=;
        b=JwOa5Qx8jNtY5CEUmL9GAu/Ww+rDLESSHy/DnAtNoTzkSQgQzCQBUsnPKRHxp42792
         0WgvFUlJEMRroY1D0ttuPJkiFc78h9yO3+6QvgbQKWGKXAvdEQ3hHiekc3p9Av+thGYs
         krhjcS9JtF9nFygPwGAwBq1j4iuRGfvbQCHFf05eQ2VsOIkx5lPAN5bEolcUSstgT58Z
         pUcokjJPDJoohXnnjfq6eUOlYxIGfKajrB5B58KMa5K3ejngB98TaffcT8KtxDO2uD1e
         fnjlzsjOuF0LpZI1gI7pib17FViHdpnNZ412heHJq7cWMOA4i3GrIIv6W9+e5cXsBPnB
         40ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320559; x=1794925359;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vW6Me650CnRCbqpTMm9ScZes8RV1bkmpcr+ZWjp/+oI=;
        b=KkYFmqOLUs5uQd1Il2HVOui9vzseUlwl5ZmQcMvVFYXAM9rWeu21W1KrXGdjaYpW1q
         tqq1htrfqhRwr5bAMBZR7oS3IrnuhdbIPO/Bigtli7/q7v+LGFXOap0Lzgt36sv4e8LE
         wASFv34vNtYTUjYRMPS1Rai9soqvQYAA4nQquQfQo2kDWfnzOwCnHrOJGjVoJLhpq06o
         1s+5eGW21qaWYmQbfqT1fws4eb0S8+Cb6zeyzpP0tXMWQp+v4oHO0tZ+VMTLC3NUYkcc
         jS9AVI55HjL7GfpB5NNrbyZ3TYX6RE9Jl2+jqgxCzdYacK0Z2/3iz59kceXkBGwUD3t6
         cnXw==
X-Forwarded-Encrypted: i=1; AL+hErHPMb76w6CfcgaoxMRDm9UtyHklabkt3kBuOyx629rxKpGt+FI5Wz39KznZmnB7zRaANPuJtg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/HkzxjTwoQKjTKI9M66LlMpfVhgrazgng5AjbNRFG9gVskMpTR
	SO8UnYayuyVtVk8Q5MXc08lq0RfpeoXlq+J4py8TeICIKkUH7DNDaJ2q
X-Gm-Gg: AYBFou2t26b6W5EsN4/V6fY1IWQY8nZYg5eu2XhXfcM8WYQ4tXMbbPpCqvcsFyFwvst
	DIwiMvVSLXQ6k3R2VWfzfwcy5CKI9mMH8P6b9uYORPEJR3e7P6plFlmP2k+nZUsRW5YrYwtnbOA
	U1gSlRqFHomT9JvEeeiNopxtpDePcNBMRmr5gmHf+LwU/Rw8WumG6ndl691GxYIz9+McRHej+/6
	6BH01XIQHOLLKbuSSSU1lmKyQ0lv8ECBoPPSG7jMlqzjYfGpgTqtFfJGTRR925FmPvGyLbxiiAx
	UPqIQyDeP934uP3ebMHRXxWVueFPzmyV37OSDwB+sUf+cWkINIszli4IFUCyn/WX5bD0MlEwgj2
	B13ONGEDvlElo7zkJmtCfvujlymDe2R1yrpQQXWaFppCDinnn3DgN3rNaFFGQEhPwMomKhA6opV
	G9QqyknIrQGTGk5Bbpqr4Sl+c5pAOGpdsoCZ+kGBWz1rPevA3daNGBD/pAoG8Hp86i7MgYz4IFe
	mLoWm9WKShsvBItdrrV8LHzdskfrG3xxuKkQon4c4Mgwrk6E896h4Ni82fX+s+gj5Up8MNeCNZ+
	0vrU8mO/3Kpjf62IIQmyakcOS+zn+q3L/sZdakchjxCkFFiI+9mgpZ3k5kiMs+bsDvVf
X-Received: by 2002:a17:90b:562d:b0:3b0:968f:fdef with SMTP id 98e67ed59e1d1-3b166cda37emr3135880a91.49.1794320558504;
        Tue, 10 Nov 2026 06:22:38 -0800 (PST)
Received: from [192.168.50.100] ([114.252.97.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db9d1fbsm70817a91.15.2026.11.10.06.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 06:22:38 -0800 (PST)
Message-ID: <ce2231cc-e554-44fd-b931-5627219b534c@gmail.com>
Date: Tue, 10 Nov 2026 22:22:33 +0800
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
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, gong.shuai@sanechips.com.cn
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20261110115137.184160-1-gong.shuai@sanechips.com.cn>
 <20261110135615.8073-1-tanchi25@mails.ucas.ac.cn>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20261110135615.8073-1-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tan Chi,

On 11/10/2026 9:56 PM, Tan Chi wrote:
> Hi Shuai,
> 
> On Tue, Nov 10, 2026 at 07:51:37PM +0800, Gong Shuai wrote:
>>   2. Use the guest PSCID directly, but allocate a separate host
>>      GSCID for each vIOMMU.
> 
> I agree with option 2 as well. My earlier suggestion did not account
> for independent PSCID namespaces across multiple vIOMMUs sharing the
> same S2 parent.
> 
> Allocating a separate GSCID for each vIOMMU seems simpler than
> maintaining an additional PSCID mapping table.

Agreed. I’ll work on the new version soon.

Thanks,
Shuai

> 
> Thanks,
> Tan Chi
> 

