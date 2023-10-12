Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413F358A7
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIrYD36Y"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57bce354d94so697440eaf.2
        for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 12:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697138321; x=1697743121; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lly61ot32j8FoDDoJ6cWEByOKtkJuuXw1V179YkQ+qQ=;
        b=JIrYD36YTwWY3k/2QDl0zD4Rn5Rawp4+CjNth+l7bqSdGnqVOiXM2/OILKGG1z3ueD
         1wOk6GS+RVYARwDj1oyt99I6fCex4j2OP7Ddj9TmXCJ5NDWOiX7bm9f2OAGTMN4FLqF9
         mzOBPgwgd+n9g90PAJfxhL0LhgZYREm7FtDVlrlQLN3MM6D6hrhpvgqSO1gUygg2nT3B
         HAibdlcXQqPh6vruRDdi7ydRYEKvGLHJ/PdiCppECyhN4h/3CWbUzPXTSgtsv01hoLwL
         SKq6eZnrt/c91/GrsIIvkS1KE0kc/V6VWpj37QXORMWsVPYiDj4ap3NeCtrDU6pUtVH2
         adCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697138321; x=1697743121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lly61ot32j8FoDDoJ6cWEByOKtkJuuXw1V179YkQ+qQ=;
        b=uWxHwgGr6I4icuIv34fwPo5thoNcDGb9ATn1g3UJdxbLdeB0prgj314U+gcTo1F46Y
         yRY7aZlBI/F2XTJ59IKinKeqV4J3GjMgOfHbs3Our6BufgvAyV20aVdwHPJ+yrceOS6P
         fm4nGh6jWHtdyNr9wcJXtwGnuzMVm3TM9EoEZpImR1ac41ykFZOc9IBQGj/5M625cRJX
         Isf6W3Q9cngTKj5xVaYU+ZBj4ppQAwbVFXIQ6wuvavfDVzvj1a00HLavyCuAOSbaYOwN
         F82yxHcXIZhtjKXTqoVGwMjxfibTCsY34gs6P/eXkMJYPlH0H2wr1FOe2MC+XOa5BQTL
         6gAA==
X-Gm-Message-State: AOJu0YwGeYllxHp+tER8VzLjBTdskoMS+uPqTTHwqJWo/6uU+8eBufb3
	mG0QhuzNDjYIyrC6Scf4WGU=
X-Google-Smtp-Source: AGHT+IFQ/8tRfh231wBImO6e9gycJ9gLPybhZL4tPQAP4HmrzWQeBUlcNv5nsoXTDJkx7CggGPiXrA==
X-Received: by 2002:a05:6358:998e:b0:13c:dd43:f741 with SMTP id j14-20020a056358998e00b0013cdd43f741mr17793249rwb.24.1697138320720;
        Thu, 12 Oct 2023 12:18:40 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:a953:6b0a:23f3:fb73? ([2001:df0:0:200c:a953:6b0a:23f3:fb73])
        by smtp.gmail.com with ESMTPSA id p6-20020aa78606000000b0068c006dd5c1sm12133698pfn.115.2023.10.12.12.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 12:18:40 -0700 (PDT)
Message-ID: <2627cc80-f431-b47c-68aa-fc818785808f@gmail.com>
Date: Fri, 13 Oct 2023 08:18:32 +1300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Content-Language: en-US
To: Greg Ungerer <gerg@linux-m68k.org>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
 netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
References: <20231009074121.219686-1-hch@lst.de>
 <20231009074121.219686-6-hch@lst.de>
 <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com>
 <0299895c-24a5-4bd4-b7a4-dc50cc21e3d8@linux-m68k.org>
 <20231011055213.GA1131@lst.de>
 <cff2d9f0-4719-4b88-8ed5-68c8093bcebf@linux-m68k.org>
 <12c7b0db-938c-9ca4-7861-dd703a83389a@gmail.com>
 <e16ac0a4-3e4a-4e8c-98ba-7b600a8c6768@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <e16ac0a4-3e4a-4e8c-98ba-7b600a8c6768@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

On 13/10/23 02:25, Greg Ungerer wrote:
> Hi Michael,
>
> On 12/10/23 04:21, Michael Schmitz wrote:
>> Hi Greg,
>>
>> On 12/10/23 02:09, Greg Ungerer wrote:
>>>
>>> I think this needs to be CONFIG_COLDFIRE is set and none of 
>>> CONFIG_HAVE_CACHE_CB or
>>> CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set.
>>>
>>>
>>>> in the fec driver do the alloc_noncoherent and global cache flush
>>>> hack if:
>>>>
>>>> COMFIG_COLDFIRE && (CONFIG_CACHE_D || CONFIG_CACHE_BOTH)
>>>
>>> And then this becomes:
>>>
>>> CONFIG_COLDFIRE && (CONFIG_HAVE_CACHE_CB || CONFIG_CACHE_D || 
>>> CONFIG_CACHE_BOTH)
>>
>> You appear to have dropped a '!' there ...
>
> Not sure I follow. This is the opposite of the case above. The 
> noncoherent alloc
> and cache flush should be performed if ColdFire and any of 
> CONFIG_HAVE_CACHE_CB,
> CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set - since that means there 
> is data
> caching involved.

Now I see - I had read that definition to correspond to the 'select 
coherent allocations on m68k' case, not the latter 'use non-coherent 
allocations in the fec driver'.

Your definitions are correct as written (and for all I can see, 
Christoph's implementation is correct, too).

Apologies for the noise - I blame jet leg for getting my wires crossed ...

Cheers,

     Michael

>
> Regards
> Greg
>
