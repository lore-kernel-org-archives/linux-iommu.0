Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652658;
	b=Um06J3rGIZfavAoMURWqeZcG99IuZtQ8YIbW4dlxAUGDvO9Pf/ZuLKulZXMi6DrEn3af
	 2FAwsc43aB8Uvev+aBQL8L3INwhwd4iLh2jnfSmBDT224aNOVclU6w2Un/B2s+cznPVd6
	 nAVhHNMD+P7DdEogXwvaYf51T8axOBnNSXm9EvuGh+M6uoUOsLBXl6OHaZ3Vw2Cs/BM9z
	 7NOOpGGTZg3yIdepOk3Yj0RfqBK4JMuHyhLBq2Ap0acpwptSnkfPrZY2VRdCd2fGUtP6O
	 m6OY46Zsu5DwAqbQ1ZC1chHD1mIc0KTzsX318PVCSrxkOVlrlIjHsGR4nMpJbXqy/Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+ByBpVD7FPTufElpNoOF6mqXMOL+Kv6Ik0YaJGkEPtg=;
	b=R9hl349IJzEHK1aYOLfiyyjsfhFesmHrAUh1aZDNOv9A4O3V5zYDrF26gUY+7NHSMcHl
	 adzgduQhWfuDnI/Zna1t49JpbJVyN2dpmKcyVCjNNmIGoEDqgKR1wXIoA79Zm1N7UqNdt
	 PpXRg3dR1c7KPBcwAWL8e0i5vc6kCMXJ8D9gE7hBKk/93I/Cduymb/dpeJiPWgx36y46o
	 MS8osgYhDN4qjTq3NE24YD1SHaa11ffUoeq3Q4Y+DnJ+21wR9/A+Y0IRZXSalsQ2SXxcm
	 hCh2mdHejjUUgyIp14/Nz2ZyQLEQk4qtj4JWG8StdsLfELCUrbLIcJ0EA//T/4pLVmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXvXvPnR;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13664606A320
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 07:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13664606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXvXvPnR
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e4a61a2ff9so5392065ad.0
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652657; x=1793257457; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ByBpVD7FPTufElpNoOF6mqXMOL+Kv6Ik0YaJGkEPtg=;
        b=FXvXvPnRT//Eez+eRJgLfA5dQOSUYhDdm0Eov737/emH3/jcCMM6Ox6g2eBMo+hEGQ
         x9W8Qb7yAKG61G+EA4QnMZL6G2lCffBfncaq3EJTz1Ps7b7QvkUil6eHC8uWa80FrZr3
         WEcRIIpCizY9WD3HEnsIfQjkLH+2VLuKQlgDA63AtdRsxGbcm3Y66NF8FNVCqRuIsR9K
         ALA02jDdNYg1C+mSppmcLEwhT9VdpUrxMrU4ZvlPNvoWk0W6SoWFlBg/nZzbejy/enGZ
         0yLmnURqkftY1kU5UN21HWzraUlnHpILMCv2gqHehdNDiEvwSJgpLMWn7V7fCIuIJbVn
         vmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652657; x=1793257457;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ByBpVD7FPTufElpNoOF6mqXMOL+Kv6Ik0YaJGkEPtg=;
        b=Xu/6Jsd2VyKrbJuvGQIumkXdWLtImfE5syGFM4O/kG5QQvNaZZuQ532OJvk22QDfjR
         g4yFLJkCLXyULSlyNJ12VZW9195w5MkOdT0oYZYYQefzH23ccFYKacrB+eRlZoNXAsrH
         bQuvP2inblrSnM+gXwSEIjXkg2OxhIrxYnmwCUs379jHjialQ7qmUYnS6ZzQqfgZon/s
         jGIzPvVDlo2p8Z/9lctPrsBBzW2lVJMBjiIvMxRO1NYNawRYJaZId4IXp6c6Tu3Uqyqt
         +098EXz3f3wsRe82mRF6zy1Ff+bC/mtaH2R6msQPzUFJgRWZnHkwwBdiS7Fy7pZ5bgaO
         ie+g==
X-Forwarded-Encrypted: i=1; AKwUvBwjvNH9D/Y8Cbnf9B6jSzw+1KrUIctdycoSKjHHNEZTV6+Tuw7D9grMmTSQ8ISObFfj6D+gsw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJjCyrO937st0qMiU/8oGZLFKX/It9i6Vb+QZJrDVOEHBM3utm7
	y87Liu3J5dz/8WRa2bcNXOYWVt2AhQZRP/KxwKTgASrwMUuTRMxWufRP
X-Gm-Gg: AYBFou3YZx/vZFgppC/GjbS9DZ2IdUucH0bQR4QQHvo4V4Wzfwx9FYOnf9i3u4VVGEt
	ODkYocSKnstgMZ4l/sdLYVefsuT1EKH172XKMkccdB4gzjRUENEntHH6UHByN9/SAMkI3nhVLwr
	ngj3SgHRav6FwaVJU9L89ANj9gQy2QXluZagpnOsi+0bQBT0GwXg+RMOY/TS6ID5EeAmIwo8cT7
	YJGLxUue13zokt4/er8VLZrv8NnVBoAxmJ77v5VgYPiVsMSIKGs4rnZZ22wu096LiRhJv8Y5doi
	80cuQ/+bJqfycmQq526mpwwNhYjl+XL9MxfbzQz886iEGfV3aAGzB/3NYckcYov2BuApx/hrbYS
	bxG9hWPAb98lvA3OaaC7rc08foFADRStL+H5PBTdo5j2rwk2RBo99PQj2/1CuLZsIpnozY5MvOy
	+6fA1R2TWRVIYzZvXA1hrlbS+KP26TOXbxUtGkZSSNDTFIQzEsm2SkgrPH0rwO/2kpXZ8PUJEhI
	U2R6cNgvXPlrJ0cTQsJzcCkKdEm1NTtL9zG6cda0sZRgD55VG9Mf30SBtIlvBg=
X-Received: by 2002:a17:902:e947:b0:2e9:9bac:2e84 with SMTP id d9443c01a7336-2ea43d3a8e5mr34417885ad.66.1792652657298;
        Thu, 22 Oct 2026 00:04:17 -0700 (PDT)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b43478csm19901295ad.28.2026.10.22.00.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 00:04:16 -0700 (PDT)
Message-ID: <95f18ef2-8fda-447e-bc64-1732febea363@gmail.com>
Date: Thu, 22 Oct 2026 15:04:02 +0800
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
Subject: Re: [PATCH v9 0/8] kdump: reduce vmcore size and capture time
To: Rob Herring <robh@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>
Cc: baoquan.he@linux.dev, m.szyprowski@samsung.com, catalin.marinas@arm.com,
 will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org,
 kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com,
 pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021132308.GB3667411-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20261021132308.GB3667411-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/26 21:23, Rob Herring wrote:
> On Wed, Oct 21, 2026 at 04:30:03PM +0800, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> On SoCs that carve out large firmware-owned reserved memory (GPU,
>> camera ISP, ...), kdump currently dumps those carveouts as part of
>> system RAM even though their contents are firmware state that is not
>> useful for kernel crash analysis.
>>
>> ACPI systems already filter reserved memory out of the vmcore through
>> their existing path: firmware reports those carveouts as unusable in
>> the EFI memory map, they get MEMBLOCK_NOMAP set in memblock.memory
>> (is_usable_memory(), efi-init.c), and the ELF header builder has
>> always skipped nomap regions; only DT-based systems currently fail
>> to filter these regions, which is what this series addresses.
>>
>> This series introduces a MEMBLOCK_NODUMP flag (suggested by Rob) in
>> memblock to filter reserved memory on DT-based architectures. A new
>> flag is needed because MEMBLOCK_NOMAP can only express regions without
>> a linear mapping, while MEMBLOCK_NODUMP can filter regions that are
>> linearly mapped. Reserved regions are marked MEMBLOCK_NODUMP by default
>> so kdump omits them; reusable CMA regions are different because their
>> pages are handed back to the buddy allocator and may carry crash-relevant
>> data.
> 
> There is little point in continuing to send new versions until Mike 
> agrees with MEMBLOCK_NODUMP being added. You didn't answer him on v7.

Hi Rob,

Thanks for the reminder. On v7 your reply to Mike stated exactly what
I wanted to say, after a week without further objections, so I assumed
the question was settled and went ahead with next version. That was a
mistake on my part: I should have gotten Mike's agreement on the flag
before sending a new version. I'll hold off further versions until then.



Hi Mike,

Sorry for not following up on your v7 question. The reason a new flag
is needed is described in the v9 cover letter:

    A new flag is needed because MEMBLOCK_NOMAP can only express
    regions without a linear mapping, while MEMBLOCK_NODUMP can
    filter regions that are linearly mapped.

Put differently: today, whether a region ends up in the vmcore is a
side effect of how it is mapped, mapped regions are always dumped,
nomap regions never are. Nothing can express "mapped, but not useful
in a crash dump". MEMBLOCK_NODUMP decouples the two, and DT is simply
the first user.



> 
> Also, I intend to apply this[1] before any further reserved memory 
> changes which will greatly simplify the code.

Understood, and it makes sense. It removes the two-pass reserved_mem
initialization and indeed simplify the code, I'll rebase on top of
it once it lands;


Best regards,
Wandun




> 
> Rob
> 
> [1] https://lore.kernel.org/all/20261015082315.56876-1-m.szyprowski@samsung.com/

