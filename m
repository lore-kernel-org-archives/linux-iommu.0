Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE843CB8EF
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476589; cv=none; b=dw54ruDQf4+n4uPvaP07Dn8rYPHvQgJ96y/+PiSSsujZiwA6uxXEGIRcQvMiO6MoxnhAs5qZ6zCwsddhPEyHv4FVCqfdIHWwD3HJrZ570AkesE/7egpPusVGG+1oBL/GhkCinMitr1ppcqQ9G6V/CQpl05BYezCHpbqzTvCHaGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476589; c=relaxed/simple;
	bh=ui4ICGb/kqsSx5sis20c9sxB7gn9IT8brWRsdIH3KRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBY+VJzFnyyu43psQUSLME8R8fZGjlmoNdSwsVNLOzzI7hffYdeJiaKOrnh1727iiVyB/2bo1GZaqJrQVSlKRLzfGw0YX0yAecBA2mkWSQFHg0+97DSFrUMPtzQIwuTetuaHq/Oapr/Bosvwm/Q2PUdjP0YorSn1ugQ2OmTevLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyFM3y+m; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyFM3y+m"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2dae660f31bso31695215ad.1
        for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476587; x=1790081387; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mP8qopDle1Sc4k8F6w5GND/XUp1RUEWcrZG95tdjUPs=;
        b=VyFM3y+m5eNWMXZwTy15+YeTbFtPZ8Xfb25JdtENMO8I1OhunwXOUn/JCQzSrMCpCy
         bdDUE6DM6fuJPDTUWEaNEerr0tgJXUFfypGwPVKscpb9+PWIhFv+nbHI7ubBFmk+MCJ7
         bkqnPdgUWXU/McG3UdMiWgwEcM6m6aZzRssZh6To+Xc6YVHPbvK2rKqn5vLn1aTyzoxf
         JlS7h33tQC70Tp5TLGhoE2SzTXvREEl2psz87ppViiTrxLXcaBGU6Zx/KwC8zESqREOa
         YW/c4cn1QzzD8HdMOtdHvK9O0mHXn4sRH6VWVOGoAIZxz9hkFrv9P1GtayUnaLQN8dpU
         TxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476587; x=1790081387;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mP8qopDle1Sc4k8F6w5GND/XUp1RUEWcrZG95tdjUPs=;
        b=JLx0VjdeJJ7jRATSZTzsbxOzhx6QK2x9jUSXtbt0iVab4H9cp+RCczjnaTykVSpH6z
         PoNrpfCSGDdhiOiSfWhJHHw+QfskI/qiAIZN0qlXuoWWDAKnkKTPRaAUwLanozLLpsyx
         rjEOlVFk/MgMNUbbECXqKps5bVCItfaMf7NYf0ubUEMi3LWfLDXlKilFhT+SY50FTZkl
         eTfSs2vP1ma8957stjrw7bgFYtTCFe0vhEF9TffVYsMV4jXF46TokFwNMGTzDKENtzfv
         UiEgav2EvKOTAuPaJlcjv37+z3KrHmX6KI4OOtnFzMN24IztUyKtAODdsa4mt4LfiKuR
         q6vQ==
X-Forwarded-Encrypted: i=1; AKwUvByhpWKBgAMVcZXAsd6UNE07b3b7/8IxtbPL/UXsoMECyzZoYjLdl5ITyQsm99JO6zJpQaQARQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lWpturhOsxhBu+oIpKV8kMWObqgc3VO8VbByYtkPPs0Gn++fqw
	vpBD7L2OL+Q5HKl22vFpkfMvSQtE4TXxrzkOp6ruff8PWHH44MVKGH7J
X-Gm-Gg: AYBFou2CLkHr4LadnjJO40iw/o3ctWgsPTj2ZFeDelR6tJrO9Elr2W5kAxpBg4BygRh
	sInADMUswINYgZu0bFZ8XFoyBnRdNYm2fcNXA9JaZ9I8f7bptRIT+WwCARqTaYUsuBF93uq53eL
	ALVtWGTMwqwmLHFssVqklyJfwE0LARmnK6jOXTCobSlK73+Gj1nHctPqKq4hN58x0fauR49yFGg
	TxzS+/Ifvl8m4oqKEmGuLBPZSjZlIKGIxl6STdFofuQ+BeugClhCnUqWu1hLWj7k7mtDMALCM6v
	TMmn42Ipx3PSnLwL2Vkq1CK4UDyLX/FOhTLhemm2XOxQkg4Qhrnie9OgSVM16UFl0bflfbbCbKl
	Ed16c8nEV0syBm7zHmEElNyQoNpUc+VUNAy/FaYOekCcVmFX4PM+ECdTRuIHTUrBJQY1M8AMlFX
	0MS45y7nI4kNerw6zd3/EnwMsmxKasiSoQ5nuTHjsZhRMj4syAl47+A4NOY+rbkTns5XAN6BUU7
	uonx1A=
X-Received: by 2002:a17:903:1a0b:b0:2d8:d4cc:be64 with SMTP id d9443c01a7336-2dd6c7134b4mr167097285ad.17.1789476587316;
        Tue, 15 Sep 2026 05:49:47 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd6f8ebbdfsm26424855ad.38.2026.09.15.05.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 05:49:46 -0700 (PDT)
Message-ID: <86a09d26-2de8-4590-b135-31564e2c7049@gmail.com>
Date: Tue, 15 Sep 2026 20:49:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/10] mm: memblock: add missing HugeTLB flag name
To: Mike Rapoport <rppt@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 baoquan.he@linux.dev, pasha.tatashin@soleen.com, pratyush@kernel.org,
 m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
 alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-2-chenwandun1@gmail.com>
 <178936321614.3691424.10386784926753862087.b4-review@b4>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <178936321614.3691424.10386784926753862087.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/14/26 13:20, Mike Rapoport wrote:
> Hi,
> 
>> Commit 7d163a75f821 ("memblock: make HugeTLB bootmem allocation work
>> with KHO") added MEMBLOCK_RSRV_HUGETLB but did not add the corresponding
>> entry to flagname[]. As a result, memblock debugfs cannot report the
>> flag by name.
>>
>> Add the missing RSV_HUGETLB entry.
>>
>> Fixes: 7d163a75f821 ("memblock: make HugeTLB bootmem allocation work with KHO")
>> Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Link: https://lore.kernel.org/lkml/20260821020910.3428585-2-zhaomeijing100@gmail.com/
> 
> Can you please send this as a separate patch, I'll pick it to the
> memblock tree.

A separate patch has been sent.
https://lore.kernel.org/lkml/20260915124641.2498280-1-chenwandun1@gmail.com/

Best regards,
Wandun
> 

