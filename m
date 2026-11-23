Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437370;
	b=LQQSdebC685qUW2fQRifiMj4e7GY97Ktn8lsp8kWc6sHjSoFo2E2owPQoa2e5idJUN80
	 Rwi2At/qaCFLsfsG/yWTIIqPZ4soKm8Hlm9twVPG6azWvdsJZAv/xrpeE2Ru4j0Gk/au6
	 0bA7wMFYU9g7/JR7AboCfYkYOLm/1/zCxkfBK10CeIK6uk0Z2w7UrIff/Xq0Zxng953y4
	 3XnFiMzvGxo+Mtar326k3JMxA3hVUfyXRrlscObrxncI3QAle/NACYMLfR2CIj/MD574L
	 WejPfpbra2ZPK2/7vw9RNFPHRDrvwnsE9jUhtIfaHylbSN2Tf8mluFJRAsWoncoBE7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=U/uD1Gm/ThsK3UVlqQr4l1VJFGDwFXp2U6warxXaR1w=;
	b=NAW+23ac3rh4kaiaQb+EtVdb9uwHRWalSoWQSTSRcw1yaoq3RCg87Q5mmr75W7w69+NA
	 aNnms6fu+GgV0gJ6UgXr87asdWNWmthHh+VGP32BbwQrNczvTrMSYB85PCDJ/ja7vyV8d
	 svUy+XQtkcDr3n8RoHxsrTyDnCsW0V8KeFwOH3cqPXTG7WlbQqYqP1YXVK9XMIYtlrdpX
	 Nr6Zh9a5Qwjpe2tnjv3OObrM+4youIEJ28asxgTPRZL9L9A9lSKwgwk2td1tt5l/VT7Mu
	 2iiouks7nd14WnG2Ty+2yuVuJs7J9UQT6soQNX0bYhXkAgubmUM4AHfVZig3brpQ4uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wc8ykADn;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF41606A69A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 12:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF41606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wc8ykADn
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3b10718b387so1749240a91.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795437370; x=1796042170; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U/uD1Gm/ThsK3UVlqQr4l1VJFGDwFXp2U6warxXaR1w=;
        b=wc8ykADnasJhvmkXv51WIoMW/bbC4G4FkZ7HXFylY8J5YKG5xMwI4CdoZnf13UhjVq
         CbXqC7XJ21O13JSkfuihCl+l5MpUek3hrm8WnnRLiToeWNXp87Ds2JTczdkSlOduFAAL
         q2D8pYaIsLcH3XGwGaEVfVhJwwLzANPNRakuMfUJbljayEMQpK7saGu0xT5zuSfS7C+v
         Vgn2qDDIg3qYLHutxpBZgqNBtD/t2EFoZ0lR9sxDs6rc5MIpB2St0c69zVHo6h27okiW
         EuB/seyFz7jrXxlZLSLgZaSs2c9b7SEMr+7x8Ty+cLouD3Gz4YtnbEQtIFJi1nRusaZZ
         XPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795437370; x=1796042170;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/uD1Gm/ThsK3UVlqQr4l1VJFGDwFXp2U6warxXaR1w=;
        b=nb09N5GdvOqcVM2BWIcsYk6+oANlLy99FvToO22H5esCehtBwKLZNs92yoErPJ9wpz
         BnRyR0mumR/YZlKLWqyidl3xD0JUtppUPeHjEe2JlldRwHMMMSEtOyGSM8oa5SNwxHfN
         Rw3nNM/Ch+/HU+B30VtADeu4mrmZpIZjbn5qRMwtDzyNLB88teIxH1Xr+MTyeBo5xNw6
         2tbgSPx3NglJIYj9Spp+qqSJ74RplhVBHjgBAPIkmwlIcEQ8sG+4+y5nyt6tKT3PI+m9
         RVA/yNPVDP9blgyq3Vw6iwcREUZa+uPrwjZvqaBuxoeTmsJ1OobRFDWB4r7Yjs2RBUbF
         ePew==
X-Forwarded-Encrypted: i=1; AL+hErHe7gEHCgRijgMAYhgDfecbcgwxvuQzNRytIC/Q9uNS0Rtnwulzya8gLOeh0X8QaUX/SvQQ6w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/O9CnA6YTybu5f/yB6wrkkFISB0i8k0xA0UmroV92u1SybWF1M
	OJdQZQWBWObcDNyPASHyugFcE6f8ES9uKvqUXPCP5K22vLDiMWuKgwWn
X-Gm-Gg: AZFdTZejTEh7O/kQheV+NzJ3xZ6fERvJ63lA1oZ6De1AdXUqNGTOxqOArSscFT+Ne4n
	Ij10MK8gFFFLlS9ylibm79twijE4sl08jQTXBC8kft+76UsKfyARfiKWTfHAz5dva3cpzyruGJR
	gQn5Z60UYhSgk8fLJLmNde22H9XfGpsPNGbaW06nOiqLGUMfZM3F5L/4jE20NpFYqDkiO5PeKl+
	0SHJ1A7FX/5R/QsWIvYaZRCwjJPUY07cBQUpL+DY077eEMZm9uVs00pZ6BPa+64GqIv1nwvUmRa
	x5Jok0nZ2jobryeOa2l1Zc8FBub3xHq8+06X+R5K/U9e2mx7HfP96ZP3Tzq/8xdEdfoSqNWGobV
	MVOCF9yi/Jpt9fZSxn7MWPTGr485/PAnf132hSCNJqkq9OaC3iMudTccHruHcKzJUW+Tm8obCMo
	Dwc9Ss0klOftHmYCdzf/WsAJBz5u83Bp/CCvU5ZpsFbRmA4zaoQP8A4L7ZorER+ffG05RlMQ93M
	mvNf6EO+wCyurbE6zbrGJBEB5n2Yn/GNwuWUDzlNy5mx6fx5S4GWnAOZdeYS6fu9cGZUVm7KZGT
	MGWn8Iv0X4f9Aa9ASAmLrBENWUtQPqve8DPqiGXvoaPM6T0=
X-Received: by 2002:a17:90b:3c07:b0:3ac:3588:b548 with SMTP id 98e67ed59e1d1-3b41c9b2529mr10221008a91.13.1795437369821;
        Mon, 23 Nov 2026 04:36:09 -0800 (PST)
Received: from [192.168.50.100] ([114.252.97.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8733e6sm6119715a91.3.2026.11.23.04.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:36:09 -0800 (PST)
Message-ID: <7225496f-222b-46f6-a609-89921d6572d7@gmail.com>
Date: Mon, 23 Nov 2026 20:35:57 +0800
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
Subject: Re: [RFC PATCH v3 09/10] iommu/riscv: Add
 riscv_iommu_attach_dev_nested
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
 <20261119132744.396426-10-gong.shuai@sanechips.com.cn>
 <awG5Q7pmntSme1A2@orel>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <awG5Q7pmntSme1A2@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 11/21/2026 11:48 PM, Andrew Jones wrote:
> On Thu, Nov 19, 2026 at 09:27:43PM +0800, Gong Shuai wrote:
> ...
>> +	if (riscv_iommu_bond_link(s2_parent, dev, nested_domain->viommu->gscid))
>> +		return -ENOMEM;
>> +
>> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>> +	riscv_iommu_bond_unlink(info->domain, dev);
>> +	info->domain = s2_parent;
>> +
> 
> When moving between the S2 parent and a nested domain on it, the parent
> briefly has two bonds for dev. bond_link() puts the new bond after the
> first bond with the same GSCID, which may come before dev's old bond,
> and since it's then dev's first bond, bond_unlink() removes it. dev is
> left bonded with its old GSCID, so its new GSCID misses invalidations
> once no other device's bond has it.

Thanks, you are right.

> 
> Passing the old domain to bond_unlink(), like I do in [1] for a
> different reason, would let it remove the bond matching both dev and
> old's GSCID.
> 
> [1] https://lore.kernel.org/all/20260928143113.49838-12-andrew.jones@oss.qualcomm.com/

I'll use the old domain to resolve the old bond domain and its GSCID,
pass the latter to bond_unlink() as old_gscid, and match both

     bond->dev == dev && bond->gscid == old_gscid

so that the old bond is removed rather than the newly added one.

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

