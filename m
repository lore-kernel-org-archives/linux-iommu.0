Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318437;
	b=zRCc/Niy5kPKxIDByuRlYKscbDDxpSyDJD9XO3+KrNcTmcBze1auw910MW+Sx8SNfMnl
	 NcrOzXLFIwiX9zMcqndrOEKuXCSm8nyUHUO2HKHlU7HpPjo5Wv6320pGzjqAXKE0A95mX
	 Qh1LCiVzGx3aHiG/pHEp8Aufs/E1eeB8QLeKQwKIx84qYi9ScKFPJJ3obLnGgrXzPsS4E
	 zldWmLkO29wYTNrgCc3nvkpWF3YvSoPn/o/ZUyoQTz33Z0qSMCZHuZrQ61a4okuvsONn3
	 8anm1zmqGs99W2qjOEdFxtH7w48wnhZb1k07/hwHWaOQZ/CK3oMfm/lqAyQlxOO13LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GnZf5t7UPSoR7hVFC72+KtUOhGomuwzXct79OPnbGl4=;
	b=EUwCQ+Ue/6igweEwuv+7VwUNSdcHpUySh3cg71t1uOjui3UPhTUqIXxDg9Ks0fngr6LN
	 1hRuKaFWcl+UCc+5d4TUiJ5ELkHPbcu1fI62KECF7pxg4vtpmCnIpxIKV5KInyZCtEByb
	 oxJWRbINooLELDWkJszO1v65WM8/PDTWa5Sl84r+vHGCGgNI8wfXcuJfyw1thtY2LSlCO
	 9+9lxfs5KIbMcGhF7Od6fv9zDTliSWk7LZcZdOJW9OmFqwWDccMtT+1fZpTHsYEIV0F07
	 AFepFq2jCl3vTiKjjxmp7wJSV/qfH1WIGetLm60ykMKPMkdPD49ubJzgFlVOeAREFEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGIl7l5q;
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0D60A380C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 13:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15F0D60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGIl7l5q
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdb91898fbfso1213167a12.0
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 05:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318436; x=1794923236; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GnZf5t7UPSoR7hVFC72+KtUOhGomuwzXct79OPnbGl4=;
        b=LGIl7l5qeXfSV3NH9/1Ng6kouIf5w3rO5vMz0qrJoVGnVhMCU69oQVHNLJqEEUfnA5
         Q1JPs0GB/HbauXQz5C/9X5L9/l74uGxWpm8Elon49EiZpDK6IaPWXNLoxjeYWTPLwZiP
         xy/MuiNw3euquGSqbISOYWCIOtrqGulgr2U0Zyr4koNj7tqcwlwJH5g48y272eTDl1e8
         yvhOVW6saQLR/JlSBTBC7mwwtHRY0Ldx//GuoAUOFepTbCgDSP/YdawtVSHG2cBo+Yog
         C/gSiw0Q0WvADm0SwJEuqoz95Fz2UYMAx4HdfUeCQDIjtXlUQzzEkbEPdXTIYdCKwopE
         sgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318436; x=1794923236;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnZf5t7UPSoR7hVFC72+KtUOhGomuwzXct79OPnbGl4=;
        b=Wtj4uZhLxKhpMU44p/MD1EcefXfEEm021CkiwOimKnk8/cPUDXH6RV7xgcwExPk9nN
         /jeaUYyVEXyaHMhAD4aGEifGPpBZb4smlLR0jRUqOI0UxeW25pcSLGBYeutTRJK2Id/v
         ArfSNvdqzCuAd5UWhrFOomUOQ3G4UV99aLueFmBSaqgwDhrtg0gJkk6DD0BB0jEmjHfx
         RSTrsntzgJQy/CKsEJFo0G2nBuKj+i/RkAZnpvqGr4nTnP3HbIvLwg82ddwhWocLz2vG
         YjKmlxPITmCqXKndvIvnQnpgUvLCD8V8I2RGYLkBx24NgCqUj9ER7QtZLDLHi2CCdguD
         tqpw==
X-Forwarded-Encrypted: i=1; AL+hErEzqqGesMBumfgHpMQA4K8LvVyIE+M8+1UF34fLqCIqWd+5Ib85/5RrcljwD8KbP+VpRU2vuQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9elQvMDvlHCYYUQISXL97Zx0aM6TuTkRQ/vPQ8wCrzCXvAK+oi
	qP1obwmnptRRXRuADjZgnJVX8k0AzfDcT6UAXM/kc5QzhUZqL63bqael
X-Gm-Gg: AYBFou3VztVG4qDEXV3PPVBAFz5zrquoVWOyaXVQdVKeYV97T+TDPVCrOCQ7OaXlhke
	boTp3ivtASvqgSA32bRD8R6Dn+dbFK/PoAzc9Mkj9n8BzLZmdvBNNP4TKxOX+qjm3FP1Jp6U0Uq
	4NHNSLwHoRqJmza3z76NevnGj1OFyrBvzPpBpqVP35+h/wjIoVPJeFtgrRYtmDSuX+MzWN9IbVq
	nKvS7CG2KfkAxkl/mWKcuCSMbJ6vyj+B+At1kyNaIA1DA5YUKFjwoi/k+VKQ8d3sViPH+x/AtwJ
	KXPYIP1MxP9vMtKJe5NkgGliSbO0ag0XHIlF9Co1o01mL711BzHO43Nqoo2KMlVt5imIwRVmDy0
	hiWKhhH7yd+xrOXX9HZzaTy8UGTAQWEo46xCFae6SAso2CL1p0gaPLJHOpzf9Pwe3GcyJqxyCBI
	GsJ81EJ9r7VtUMLd/8kBmVvjzWmz5FbHoLSU7ZaUggSsMVlDOjDEyDuT3X58VRHmmfFE676PUTt
	pl828AXRQ0sXAMsG69zWJpKxi6w3jIRa2KMSQxuLE4ckd81vmgHaiN7yZ8vdqkYm72l2q+mRm10
	aHWJ+hTLKfLhRpYfCQB7nXX4nz67OBpgfF0e11l1+6AHH60=
X-Received: by 2002:a05:6300:210f:b0:3de:48e4:c37d with SMTP id adf61e73a8af0-3f18f0b86e1mr2622791637.26.1794318435879;
        Tue, 10 Nov 2026 05:47:15 -0800 (PST)
Received: from [192.168.50.100] ([114.252.97.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e110sm867486b3a.36.2026.11.10.05.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:47:15 -0800 (PST)
Message-ID: <42ce73bc-0fb5-46d9-bc45-34a5bef25cb2@gmail.com>
Date: Tue, 10 Nov 2026 21:47:05 +0800
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
To: Jason Gunthorpe <jgg@ziepe.ca>, Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: tanchi25@mails.ucas.ac.cn, alex@ghiti.fr, andrew.jones@oss.qualcomm.com,
 anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev,
 fangyu.yu@linux.alibaba.com, iommu@lists.linux.dev, joro@8bytes.org,
 kevin.tian@intel.com, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org,
 robin.murphy@arm.com, seanjc@google.com, tomasz.jeznach@linux.dev,
 will@kernel.org, wu.fei9@sanechips.com.cn, zhao.qingye@sanechips.com.cn
References: <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>
 <20261110115137.184160-1-gong.shuai@sanechips.com.cn>
 <20261110131658.GW663069@ziepe.ca>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20261110131658.GW663069@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/10/2026 9:16 PM, Jason Gunthorpe wrote:
> On Tue, Nov 10, 2026 at 07:51:37PM +0800, Gong Shuai wrote:
> 
>>   2. Use the guest PSCID directly, but allocate a separate host GSCID for
>>      each vIOMMU.
> 
> This is the right model. The viommu should allocate the GSCID directly
> and keep it for the lifetime of the VM.

Thanks for the confirmation. The new version will use this scheme.

> 
>>   3. Share the GSCID and maintain a per-vIOMMU mapping from each guest
>>      PSCID to a host-allocated PSCID.
> 
> AMD is doing this because they don't have something like a GSCID.

Understood. This approach makes sense.

Thanks,
Shuai

> 
> Jason

