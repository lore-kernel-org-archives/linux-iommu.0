Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2013FCB3A
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728829; cv=none; b=ZV7JfuI4YsNSDltM+OoEfqmwVLeNnWl/FXqySf0wXa/JQ0vqpZxfm5GUOzAVQ3iwKVvEoakIlj5gzRLZmJ9iWOo7pUGNJYb/ECA3cvxQTBI5/e5SAtkybVofIQOVX/MiopNprNp4Hq2wOGNqoAsb6r7wXTrU/ACkbbY/V+aLDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728829; c=relaxed/simple;
	bh=ZUwGpl30HDIT8l2z/Osc/Y3a2vr84b85yvTBFDvsGtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJgVdo9lgfIwSPe2nnEYIbDBnIhpsDGViU3wv6UfBViLoexrhKIdrr4ZaPLUoxAGAigAoqDJt/YsKAGDLW1g7bZwHLVPeIZ0+EhYe9jIw4uqfai4YkWAoYtr20D2BYbcD9F89fBBNyaWA9CO41lq2i42Tl0tG1ZG6GN/geBNWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoSSnE/b; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoSSnE/b"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2caced6038eso4986835ad.0
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789728825; x=1790333625; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAR8zhCOEVqWXPt6vBsjOMeeQmFuBz9UsZFbgyML5lo=;
        b=GoSSnE/bQGOQZQkPu5rGRPLo6VEn83JoD6CiotL0+48UOkFJOUGdKxDMNh0RBly1Si
         jVCkx5z4eCDtLSpWBmKM5tDO1ku00WrJiXQhBQ+mzCXbFSvnr1cXeNWgm33Epx0gx6vk
         QPPfipsXyqf8wvEzD0lXkhhBsp4ZhDpScaOevQ12bwqHTs5PmikkhB0MUVlq1dQNNBXt
         l3Gu1P8XbdqMrKriW7CcmPx3ZuJK2jWbTUZgGTnaCIDtxBFK5UV/skljxIVkToM/pWmA
         efWlapsCNLiGwJWnXz8q1KKoxMSdZ0O2suBDIVZUd6ltRG+0aOfmv48q0jAg4gOlNnd7
         AhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789728825; x=1790333625;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAR8zhCOEVqWXPt6vBsjOMeeQmFuBz9UsZFbgyML5lo=;
        b=gwU9cNW9J3luATFIYvVr9X4kt4oQFAUOaqv8cnO8vst5/OX0eaK2PkCTGL/EsLS2Sf
         rFkszOaHCOzIl71fU0ZU9/gEBZIAUck4hrbEpihCvg2vPFZuyMJCRJ3REOStGFKoKEiI
         JKRd+k9X3f4hhX+0WUO+K5265SisZ2d8DcJ6Tu720zUkgwCwyingBgIhEUvT17hJQhhm
         U/2AgMJ2bTse49lS4ZgzU3rm3xUrZOlURqWKEvu2Qw5t9C1FIqDPgKBwTFb1pAjzoEsP
         lZolQiqevj1klbMn2Uyw/sdpbcKc5yYhxjy8mmH+bdfVorgZCr7eXs+OsMl+Q85py8O0
         QgLw==
X-Forwarded-Encrypted: i=1; AKwUvBwDFc7i3St6zJQZ42A1nbM3/EJ2iL2O5rtzsQXo5fZ0A2DU/nZd2OdK0UdmxCFZu/H6luTpHA==@lists.linux.dev
X-Gm-Message-State: AFuF++mlq+1JoMyV9OK/5nmS9KuMCdscb7XigSDPvMDJyD9Vy0NnWalz
	115IqJYMPldguuR07Um1F7YoRj8yqY9YaVvCCk/ONhPF0zlL9etw9ke3
X-Gm-Gg: AYBFou1ILR9U+VFKctw+XR9nuAD2ZFwYeZs9+o3CyMLlqrycVK6nvWubI3WaZytx9Pq
	bF/YHp2OjyFkmDSwTm6RHsfZjNxY0DcrH5PwsxerOfD1C5IT6r3/XKFz43/XxoH9StnSkJ58ZfK
	zx5oNlkXAO8EQqhZ5IXz3ksS0G3swot3fHomF7K3DeeqiOUAMoXXK3VOpByiymkm50n5spd8gqH
	wC3+O7Kl9pCQTkBQV+jL/JnH1X+vYE3ESwB328wo6DjWU7/PL5UtBGrRCB1zSXStKWyp3HtELiS
	NLfG2C6LXZwX3RSmOzCru0jsXeOiEmXQ90EstVTCitTHoRs8YWaJcvnMrQd90p66OmnEGXmeaXW
	JV96+9u12046ryraWqOy19GMW+6p3CrglfzGGT2uGyYXLGnCqwYUFmWEeUMMmAgzq2seisgElrL
	kKDjULMOO1lqRkOrzt8Ar9qaL6lRXeBRs+PuYyEFjAKcWmfgSjw2b7G9oi9iHmfhREUQkRUSHEa
	kqJIQ==
X-Received: by 2002:a17:902:cecc:b0:2d8:d4d2:d139 with SMTP id d9443c01a7336-2dd9ca3f088mr93269015ad.21.1789728825328;
        Fri, 18 Sep 2026 03:53:45 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb7525b2asm5835555ad.19.2026.09.18.03.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 03:53:44 -0700 (PDT)
Message-ID: <1a47d5de-fb68-4c10-a199-f0d274689cdc@gmail.com>
Date: Fri, 18 Sep 2026 18:53:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
To: Baoquan He <baoquan.he@linux.dev>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
 alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <aqzznOgILX2pZg7b@fedora>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <aqzznOgILX2pZg7b@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/18/26 16:17, Baoquan He wrote:
> On 09/02/26 at 03:31pm, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
> ...snip... 
>> ACPI systems already filter reserved memory out of the vmcore through
>> their existing path; only DT-based systems currently fail to filter these
>> regions, which is what this series addresses. The flag lives in memblock
>> itself rather than in a DT-only structure, so the mechanism is generic and
>                                                                  ~~~
> The patchset itself looks goot to me, while I am concerned if it's
> really generic. I raised that in sub-thread talking with Wandun. Imagine
> I tried to exclude many driver regions and split memblock regions into
> hundreds, cma could yell out: cma_declare_contiguous_multi()?

Are you concerned that setting the MEMBLOCK_NODUMP flag could split a memblock
region into many smaller regions, which might then prevent
cma_declare_contiguous_multi() from satisfying a multi-range allocation?
If so, IICU I don’t think that applies here.

MEMBLOCK_NODUMP is currently only set on memory that has already been reserved.
These regions are excluded when iterating over free memory, so marking them NODUMP
does not increase the number of free regions seen by CMA.


Before marking NODUMP:

  memblock.memory:    [ free ] [ reserved ] [ free ]
  memblock.reserved:           [ reserved ]

Now, for memblock.memory, it is one region that contains free and reserved memory.


After marking the reserved region NODUMP:

  memblock.memory:    [ free ] [  NODUMP  ] [ free ]
  memblock.reserved:           [ reserved ]

for memblock.memory, it splits into 3 regions, 2 free regions, 1 nodump region.

Although the memblock.memory array may be split internally, it does not create additional
free ranges for cma_declare_contiguous_multi() to process.


> 
> IMHO, withdrawing the claim can fix the nit concern. If I am wrong,
> please help point it out to let me learn more.

I will revise this description to avoid any misunderstanding.

Best regards,
Wandun


> 
> Thanks
> Baoquan
> 
>> both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
>>
>> Since the reserved memory regions are filtered out, the vmcore is
>> smaller in size and faster to produce. 
>>
> ...snip...

