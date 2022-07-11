Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078B1FB7
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 07:26:15 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id d13-20020a05600c34cd00b003a2dc1cf0b4so2488043wmq.4
        for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t/PqRBXDv8XnbGqXCKFv3DtaQWbjJ/k2C/kwgKRLS8c=;
        b=SCFXq1nfYobOAwlRKYd50zeNz2wJyny1c0M+7nes2JxU4njk6mzBs9jEeFDN4PuYet
         Ave52lUzwL0R4iw+kc066bJkVLCtBFI1toXwXn7f6Un+YuX3ZsAuy+4LgRmdIqOxz2tS
         jkVznlF7REbbg7PR+xCkNW0HVzeEe03KeNo2vyiqndvITucQgxRrPZjzGii724sx8R1y
         kSVmIJ2mbKQqbLKcAvQom3qhm7ljLUQaCB9ikKPJ6Eip5iUc3oAS8orX/LdLLlKWL5sW
         /f5Rp3DJPSbxuRGjkYjSQ5fSl1oKbaEjkxO7rXB2dWT8v2ScYmTNV5ssj5qa7Ehb8tBV
         kwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t/PqRBXDv8XnbGqXCKFv3DtaQWbjJ/k2C/kwgKRLS8c=;
        b=D3QHnTrjZNmi+t9bQbHUaHIfnEtCNkUZ410SNMHQrU55Jx1L38KnCQH5sCPUF1Yntb
         XmxvaYySgQ+6nIFRQ5UbUsG+sUOJyzfMvBeurqKn1TYf7GmC68Z9Nx7BD8c9ySLpuyfn
         fdVymGsLSzd7J72YqAFxr6J1G0eUEg4D0clN4caPGMTW3UcZs+uRuhh907nU1gS3jYic
         zHy6wed6VGyN1mdSxcz9qWMy+nyUAgdDqhGid8QQ2l5xRWSFiKUJ5muUTqQALxFwKoFi
         uOwg/dZE7WGY0Dq03nmAqeWen4hU0umR+LYfsdU13yJ8Na67Sbb8knXhE+b6VSbX+PKu
         sX+A==
X-Gm-Message-State: AJIora9GtXDjb5Rg218wpSn+4QnHDGd+pzEl0oDe8CMtYouHAm4hx+NG
	4XR6758oE3O1O/A46KoNb8YVmw==
X-Google-Smtp-Source: AGRyM1uNu4zxhtyxybrkVox/XEc9FSkT3LpZkh5+naANwfdc/8jbNfqrSS/S31sCE69W6rNsJP1ySw==
X-Received: by 2002:a7b:cbcb:0:b0:3a2:e899:7dc9 with SMTP id n11-20020a7bcbcb000000b003a2e8997dc9mr3200161wmi.82.1657524373754;
        Mon, 11 Jul 2022 00:26:13 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003a02de5de80sm9103140wms.4.2022.07.11.00.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 00:26:13 -0700 (PDT)
Message-ID: <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
Date: Mon, 11 Jul 2022 08:26:12 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Content-Language: en-GB
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, iommu@lists.linux-foundation.org
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>,
 Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
From: Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/07/2022 21:32, Robin Murphy wrote:
> On 2022-07-08 18:08, Ben Dooks wrote:
>> If the io_tlb_default_mem is used by a device that then gets used
>> by the swiotlb code, the spinlock warning is triggered causing a
>> lot of stack-trace.
> 
> Hang on, how have we got as far as trying to allocate out of an 
> uninitialised SWIOTLB at all? That seems like either something's gone 
> more fundamentally wrong or we're missing a proper check somewhere. I 
> don't think papering over it like this is right.
> 
> Thanks,
> Robin
We have a system where we have no DMA capable memory in the 32bit
window, which means even if we initialise swiotlb we don't have
any dma capable memory. The code says go use an IOMMU but we don't
have one of those either (and all peripherals are capable of DMA
from any of the memory, so there shouldn't be the need for one)

Is there any other way of fixing this DMA allocation issue?

I added this fix as swiotlb prints an error but also causes
an annoying stack backtrace.

> 
>> Fix this by making the structure's lock initialised at build time.
>>
>> Avoids the following BUG trigger:
>>
>> [    3.046401] BUG: spinlock bad magic on CPU#3, kworker/u8:0/7
>> [    3.046689]  lock: io_tlb_default_mem+0x30/0x60, .magic: 00000000, 
>> .owner: <none>/-1, .owner_cpu: 0
>> [    3.047217] CPU: 3 PID: 7 Comm: kworker/u8:0 Not tainted 
>> 5.17.0-00056-g1e9bac738084-dirty #310
>> [    3.048363] Workqueue: events_unbound deferred_probe_work_func
>> [    3.048892] Call Trace:
>> [    3.049224] [<ffffffff800048aa>] dump_backtrace+0x1c/0x24
>> [    3.049576] [<ffffffff805c5f74>] show_stack+0x2c/0x38
>> [    3.049898] [<ffffffff805cade2>] dump_stack_lvl+0x40/0x58
>> [    3.050216] [<ffffffff805cae0e>] dump_stack+0x14/0x1c
>> [    3.050460] [<ffffffff805c69f6>] spin_dump+0x62/0x6e
>> [    3.050681] [<ffffffff8004e000>] do_raw_spin_lock+0xb0/0xd0
>> [    3.050934] [<ffffffff805d5b58>] _raw_spin_lock_irqsave+0x20/0x2c
>> [    3.051157] [<ffffffff80067e38>] swiotlb_tbl_map_single+0xce/0x3da
>> [    3.051372] [<ffffffff80068320>] swiotlb_map+0x3a/0x15c
>> [    3.051668] [<ffffffff80065a56>] dma_map_page_attrs+0x76/0x162
>> [    3.051975] [<ffffffff8031d542>] dw_pcie_host_init+0x326/0x3f2
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   kernel/dma/swiotlb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index cb50f8d38360..a707a944c39a 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -65,7 +65,7 @@
>>   static bool swiotlb_force_bounce;
>>   static bool swiotlb_force_disable;
>> -struct io_tlb_mem io_tlb_default_mem;
>> +struct io_tlb_mem io_tlb_default_mem = { .lock = 
>> __SPIN_LOCK_UNLOCKED(io_tlb_default_mem.lock) } ;
>>   phys_addr_t swiotlb_unencrypted_base;

