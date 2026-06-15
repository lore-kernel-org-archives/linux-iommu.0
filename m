Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743681D89F4
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 03:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781494442; cv=none; b=g877nFHE6o0F+Md+5yS6sdrj+jYWJqKN2/Wqkh1cj6Fegz5gIyW+GGTll2k/RRNUNu2Wn427nHanhTrw3KAQAGgVveTc0p7fHoXEcgxm9WL/t7b64SC3ytFVgWorhnz5RMBD7SfD18+6EMfUfjpJRbAp4utBmE3dmeS1RWCYPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781494442; c=relaxed/simple;
	bh=7CYnTAuVR8rZg2/zzNHVJX1whHtFmlFtEUUksdZQ1Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXgEGmYEaP1/7QFHmphdu5Dtc/CFGOYJ7eil6D4EpWIB4xbW4Z/73AEUUJKp6ZnfDStkWyPseDanVfcz4ZxctetICbRP1Fio/mxMalcqM5nvT3dTlmUVU1+sTghxP13W9b+SWBU3cdpozAz/3/WHiztxx61ssSjlP2uIUkFTueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUxMefHb; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUxMefHb"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so790661a12.1
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781494437; x=1782099237; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4N4VN4U8dWKYBPdGLpmGB0dN8xMC6v/gON67oih3Zak=;
        b=EUxMefHb88YeHHJLQbFK/XWA2Zlr9+OZ80tCZ9VBX6bn/kymlBDVhbYNnoHd+pWtUD
         vBCa96GX3H0yH/LTRxJVPmLMtk5XhMtdQJGUzzr75x8V93qUBOalSlGyqVxcDwt2Q0Io
         blXJY6QVdV0hT1RaTyOBTiQSyMw9x6bATQeFH6YRW/hm6aXEFiZ8tQ5dToyun7uO3V9Z
         Gpg1pE2hjZ++HD65e8FoHlC0Z8PzUf45wyDP6qlU3Uoc33swrvEAVCe/DuuUWI8Upk23
         u07ETmhE+2a0pdL4XuB99c/8YZnyFGYyoRMIhIbEgM8GBnBRYSmxONojA8bvBa0QKOrh
         hbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781494437; x=1782099237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N4VN4U8dWKYBPdGLpmGB0dN8xMC6v/gON67oih3Zak=;
        b=PuDzaRl8iYkH3Mun2wjRgvq/rUb041AI0y1C3kb/9QSYE3XvB8W+rbYxYnPfTlRcSG
         zRIZqJ2OIBSGQOwiHmH3jPtjLd4QLfmO74+vyOLyQ8mkZ9zDyVG9n/Qvswev3uImmy1r
         9doTNgoj1+iXZ+Cw76Zy//vItDVGfYfBSn6PXiRrb7cS+0HceDwCHyarVMWRC1Ax5T5R
         PZCC7aqHix9r46LH/R/+lz3F1ZetoeVi4lhKyvhFCAXcck0Z41s+b/sgzprbIRp2c/Tf
         4e5IJXifpCvj+gFxFsZ5Wc9MCYRD3L0PqR/CRxMH+oNdeO3hvVF9WTzSHaOEkX1IA2je
         g02w==
X-Forwarded-Encrypted: i=1; AFNElJ864bJ+uvg7TXARP12cETxdtKjS0eysR8sKjvsRmss88TCV1UxBj7LukAnJB6HbdqtLnG09AA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGoiByYgB3fEBvnsXQddeL79Exk5qN+05VJHG8BUPJvotxLTkJ
	m83bNXfcSjQSf3Sd5Wl5Kkr5Fj6LAUgz6Q4TC1jnh2aLUxxASQwHvChO
X-Gm-Gg: Acq92OGjoK6dmmPhoP8CGAdAXDTSTJxn/fax0KtPq+2sV7t6JLGk2iBbj6lpR4SryXK
	v9BCo0uXZqUk+zgxedPbvDjFnq0XUUJhl8LZl4raTP3zI3LPQ8k8zFlQ/ItzzNZOvltJ2OSfQlJ
	+MuGhnZH0nik3aNAUZaU59QSiZYb7oHEVIitUbU0Hl8suuhxWK97JRxUGjTbzH8mW+z79EsQeZ7
	udVXEVzT5dh243Ay9MsH+pTra4PUDXM8W+UGadiI83YDTDBZRDC61FUnQiD2eJaQDhIKXuoA3DR
	PrV6/XAWvOoy172wN5tUpzziKwMzfZ1rSutc0e4965IpSEStveecDHliztlP4x4drfIO17fyI1z
	NWe2NeKB569qG4cqo6PBz03gqWB11Fc3zQecIn+HxzqiNdqQRPb+qLR5Xuw80+Ng5f9OZZRekaa
	tWz0wqdRsB/KneGTGZCb4thqWNOvuh9Gb2H3N6jaWn4w==
X-Received: by 2002:a05:6a21:6813:b0:3a2:d629:16a2 with SMTP id adf61e73a8af0-3b783b757e9mr14493609637.10.1781494436758;
        Sun, 14 Jun 2026 20:33:56 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b035ce6sm8650381b3a.49.2026.06.14.20.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 20:33:56 -0700 (PDT)
Message-ID: <894d7c33-8e14-4ba5-b774-14062ece39f2@gmail.com>
Date: Mon, 15 Jun 2026 11:33:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] of: reserved_mem: split
 alloc_reserved_mem_array() from fdt_scan_reserved_mem_late()
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 iommu@lists.linux.dev, zhaomeijing@lixiang.com, catalin.marinas@arm.com,
 will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, m.szyprowski@samsung.com, robin.murphy@arm.com,
 quic_obabatun@quicinc.com
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-6-chenwandun1@gmail.com>
 <20260612144122.GA974326-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260612144122.GA974326-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/12/26 22:41, Rob Herring wrote:
> On Wed, May 27, 2026 at 11:29:11AM +0800, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> Prepare for storing /memreserve/ entries in the reserved_mem array.
>> alloc_reserved_mem_array is skipped if the device tree lacks a
>> /reserved-memory node, pointer 'reserved_mem' continues to reference
>> the reserved_mem_array which lives in __initdata, storing
>> /memreserve/ entries into reserved_mem_array would result in metadata
>> loss, and an out-of-bounds memory access will occur if the device
>> tree contains more than MAX_RESERVED_REGIONS /memreserve/ entries.
>>
>> So split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late(),
>> and call alloc_reserved_mem_array() whether or not there is a
>> /reserved-memory node.
>>
>> No functional change.
>> The actual /memreserve/ population is added in a follow-up patch.
>>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> ---
>>  drivers/of/fdt.c             | 7 +++++--
>>  drivers/of/of_private.h      | 1 +
>>  drivers/of/of_reserved_mem.c | 6 +-----
>>  3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 82f7327c59ea..83a2a474831e 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -1284,8 +1284,11 @@ void __init unflatten_device_tree(void)
>>  {
>>  	void *fdt = initial_boot_params;
>>  
>> -	/* Save the statically-placed regions in the reserved_mem array */
>> -	fdt_scan_reserved_mem_late();
>> +	/* Attempt dynamic allocation of a new reserved_mem array */
>> +	if (fdt && alloc_reserved_mem_array()) {
>> +		/* Save the statically-placed regions in the reserved_mem array */
>> +		fdt_scan_reserved_mem_late();
> 
> Can we make this just:
> 
> alloc_reserved_mem_array();
> fdt_scan_reserved_mem_late();
> 
> We already check !fdt in fdt_scan_reserved_mem_late().

Thanks for you review, Rob.

The reason I kept the fdt check is that total_reserved_mem_cnt is wrong
when fdt is NULL, early_init_fdt_scan_reserved_mem() returns early in
that case, so fdt_scan_reserved_mem() never runs, and
total_reserved_mem_cnt stays at MAX_RESERVED_REGIONS. Calling
alloc_reserved_mem_array() unconditionally would allocate unnecessarily
memory.

A better fix might be to make total_reserved_mem_cnt always correct, add
a !fdt check at the top of fdt_scan_reserved_mem() that sets
total_reserved_mem_cnt to 0, and let early_init_fdt_scan_reserved_mem()
call it even when initial_boot_params is NULL. Then
alloc_reserved_mem_array() could naturally skip allcation when that
count is 0, and we can drop the outer fdt guard.


There is still separate UAF issue (fixed in patch3) if we don't check
the return value of alloc_reserved_mem_array().


With the fdt_scan_reserved_mem() fix for total_reserved_mem_cnt, the
call site in unflatten_device_tree() becomes:

if (alloc_reserved_mem_array()) {
        fdt_scan_reserved_mem_late();
}

How does that sound?


Best regards,
Wandun

> 
> Rob

