Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34922422E
	for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961434; cv=none; b=TNDRGIi0tY9EvYnhtbKmay3iA0jAvw+/f8Z/F566aNyxQgQHe5M+AclkJjyrzZZn+7w6KifWjl/VOptjq1kyITJvdH2omQADlesTHp9BIqin/5XH4ne2jQkAJtIT25yJ/A8aE/KtFZWQbZgNKWc39ra0vvpTTs3rw0C/A+Exxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961434; c=relaxed/simple;
	bh=gBCHP64kXB1dQICiP2hErVP2nwgWWbnltU6gcp20yvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1DCOwc0c+keHpPiTPdYNC35nV4p6tL9CHK6MJ1oNDi+Oi8hJRv1jngch79d1f81kjHBZOXh5uN9gkydZwX4ReH8XRdHABcyAdLzAc55b3OMz2qPZsucAmxPB3BNEqm90FarXt6/AYfHLjujTsPdy68u80wFbSKOod2nmsaeDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwfxNm4A; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwfxNm4A"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6180ce2197cso4963567a12.2
        for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 18:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754961431; x=1755566231; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kx6NdeUOK2ZAavwzyn07ncyKXSjBQKSfiC64En8ptK0=;
        b=YwfxNm4AkW6m+Fh15yyC5yPXE0J6fUjz/bLY8LgFtck+lX7majEqG4uLi3pSTLt9Kz
         /55MdE0iy+iOs7u8ee9FHvSCdWjPmfH3HbdRYGU40rhkrpmWW/Lpw3DZhMgBU5RgyBZg
         KeOGi1JKw/8n6iWXojSd2gNgSkN9qy/AWvB/PhtNhI466v3k8L+r55eR4ghwap7cqWu7
         q83TmLG1PXWl3trsHM0HVY9PyxP1aZoIOo6Yw/jTSmnLnH+vMlwzWBWKTaWo8UtmrKpI
         JIg64zEs89H033z7eCaLlsxjBHKH98kVgrYOeujetIIQSuNqdLDxTlc2W/kggWxKMXtU
         B11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754961431; x=1755566231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx6NdeUOK2ZAavwzyn07ncyKXSjBQKSfiC64En8ptK0=;
        b=PqA6h4n4KJjNTllJD36zyWLwfnVyrugsimpcqkCKq9mpHIAH4e04xqbGHjRfRqLWTX
         o02oDarjBnt8ObfKIIOSLbC4toCK5CGWkuHcLRdjbMMv1C6cc0QDY39g5YD9GUbl3KUK
         IqN8gU+ui6XgPohk7mJYf/KyKjRchxcY+see3Xvf9KL1mfsLeHu6+M8QcAxn5ABN2hV1
         PUq4X0ZyvSWByg+kmdejwMc6NQ+7O7dw0tt+Z4EKrTWeQOO1d82wzOPI0CL1HL+QiSRY
         oTDLXo3HysZeX0vo6GnPnqKXYfqOj7SJcPYNMzJ88awQm4GSmUUcH4WhB9nxBmzLAGHW
         5Kew==
X-Forwarded-Encrypted: i=1; AJvYcCUsXAUmJMoVmFqQOb/TDFOf83jNyr6bcm0wBLZDt/mn+UWTfOxgizxql9BjxSWcIIBpZqCWQw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+x/JVIEsHj/UGpFhiBlLrJKQtkdqBKAUCXGdphgLVxK1EGjTP
	JKBfn6zd4pOXZeuefJTeXv7AT6cOEu8acBX7cPLnrIWU/vr52zqGsOfS
X-Gm-Gg: ASbGncvOGigGhrK8sVQ9tJOzy8htfG7hUGS+19x89EqzX+vePU6r8yGOrTnxHxCKGop
	hutgHxNeGKTjyapFl4wNmjEJJxMCmHHSox1hdKCgmO0AWT4wS3QvzMtHo3FMrzMjK/oRG8HbSEu
	DqBYCCZV14HRs1CB+HF5fpDsDWsNiKVP6lUQCTswTv9YCxsrlcZ1cS8B2OkWiB7EqUm09tlvTbc
	dQ+/2jeZLARRW5D21YHR1W5a615S0cdA80Y7ytoW8g/n1fjFcKgejv5dJ8oUuim7i6tOYHdG4yR
	6DHPU1lKYn5AYOKinEgy98EX4a2Znibp1Jtqg6LjUEC61QraG6d1bJbPk0ZK6LkxrjHEVopMhSc
	Z9zxEO5d0eHJckT0cxq7wClsmHhRBCqmRA3BNXtbM0KhSq97NeYFSWExOLj58xJBoRmueaF5J9k
	FZ78XzhGWOANTALlqBcQW9
X-Google-Smtp-Source: AGHT+IEEgh2ZE7NXrGwzl02oI8iVdXUPjVYyGKwYEOxmUW1rZ67qA/e691Ikur9GysNftuEPTgJSWw==
X-Received: by 2002:a17:907:7206:b0:ad8:9a86:cf52 with SMTP id a640c23a62f3a-afa1dfa336dmr126169266b.11.1754961430541;
        Mon, 11 Aug 2025 18:17:10 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3e80sm2125702966b.47.2025.08.11.18.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 18:17:10 -0700 (PDT)
Message-ID: <563bd363-d806-4ee5-bcfe-05725055598d@gmail.com>
Date: Tue, 12 Aug 2025 09:17:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, Uladzislau Rezki <urezki@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
 <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com> <aJm0znaAqBRWqOCT@pc636>
 <83c47939-7366-4b97-9368-02d432ddc24a@intel.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <83c47939-7366-4b97-9368-02d432ddc24a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/11/2025 9:55 PM, Dave Hansen wrote:
> On 8/11/25 02:15, Uladzislau Rezki wrote:
>>> kernel_pte_work.list is global shared var, it would make the producer
>>> pte_free_kernel() and the consumer kernel_pte_work_func() to operate in
>>> serialized timing. In a large system, I don't think you design this
>>> deliberately 🙂
>>>
>> Sorry for jumping.
>>
>> Agree, unless it is never considered as a hot path or something that can
>> be really contented. It looks like you can use just a per-cpu llist to drain
>> thinks.
> 
> Remember, the code that has to run just before all this sent an IPI to
> every single CPU on the system to have them do a (on x86 at least)
> pretty expensive TLB flush.
> 
It can be easily identified as a bottleneck by multi-CPU stress testing 
programs involving frequent process creation and destruction, similar to 
the operation of a heavily loaded multi-process Apache web server. 
Hot/cold path ?

> If this is a hot path, we have bigger problems on our hands: the full
> TLB flush on every CPU.
Perhaps not "WE", IPI driven TLB flush seems not the shared mechanism of
all CPUs, at least not for ARM as far as I know.

> 
> So, sure, there are a million ways to make this deferred freeing more
> scalable. But the code that's here is dirt simple and self contained. If
> someone has some ideas for something that's simpler and more scalable,
> then I'm totally open to it.
> 
> But this is _not_ the place to add complexity to get scalability.
At least, please dont add bottleneck, how complex to do that ?

Thanks,
Ethan


