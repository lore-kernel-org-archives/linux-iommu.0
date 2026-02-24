Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC136605D
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921931; cv=none; b=L9ykYCkEnpuE69eo4cSKmWky8WGiWpvANS72Eo/J1pE6eh94HjRtc7WnQHgg7f0l3mleuadEQDH75V3RDVNP1sMLKQsu73lqqJC4PmQRF/E4qaYgC+CR54XtgRR/NAvZlyzAslGQ2hTykYYfSepJ1LaJ3WtIsCiwl6/ImNQ9kjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921931; c=relaxed/simple;
	bh=avykNOyv/u+V3QY9hr2O0Q36L/u7PrqaV597fmOI+CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsXWJsrT1cz76tXHLBSBRTeoy28Pg14aKhFW75bNMljX833CXJU/2lbkL4RivCxrpBmoUW5qjXQqjz7QSPungIALL2cDdBNOcaQM/QsC8rm2kxx2iTMuJm8Sz+80rwc0lTzSW5NNO+3cRSWkfyQ3NZUFet2IPXkL0PJuh3sOpT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iAylcrkX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iAylcrkX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4833115090dso49956515e9.3
        for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 00:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771921926; x=1772526726; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/EquV0ZhBp1KMAQWMVyF7t2k8W3NQOG5g8XyiQs2v3s=;
        b=iAylcrkXPxA7YgwbCsKeZI6kmf65+SVKlX2+yWBto41Qqrw0Pz9ofz4irIaHQhaqEk
         1gYNsOcunQij6eGOrcSAesP2GcxPj1UP3sbEZneAKC5rAYt2v6n3kkYORbmY0sHds6C4
         wOHXHcpWdZS6bOLP0iiYIJLnjPdv5NzaNrZ4kVqO/G52x8kkiVwkGI9Ukwm4S0ibcrvC
         tXFTbQbBushaGGPqMTinSZPCtpLCbjt4PoMkDE0DKgGeXdlIpWm6ylZQQeRQz+AZDMa7
         ials1t00sf9xTfBJgUAq+hKVq1A3QIVR+vl3Z1tdiOHaBHIgSvxbZKrk+eogTdUUsgki
         Y8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771921926; x=1772526726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EquV0ZhBp1KMAQWMVyF7t2k8W3NQOG5g8XyiQs2v3s=;
        b=RDOk11l55ZQIMhkxyeOXkQregUS+nThVC9O1E2fNSssbJZZLshv1KPIIhds4Esyiib
         y84qP4/XJKYxbjDMzbWgI6r/JN9Q5v8gXcvry71LnQmFyO2PYscWZvl1SC5AZ4L99dkG
         +Jf21oskvGuWDgp0XUBTDmkU9bxtzf4ttgCHEKAJbnx0yBb2AbEcIljY2VOEX77bk5sO
         LsdoZzpr5x3S4cnh5gNPRmiMo77vbT7swPdL7n4xhPXNETNp82p8vJIz8xymHgB2/mwK
         9paWVSUB7iZWRpAB3EQbTJ6gCue0u33t3M4tMfN3lsyJjLhR3jID+VbpjLhMD1QMBMjb
         L0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyCl50b//0ABdqULlCZ6nE3t49egBjOOtu0WNjJv/ir5MyrNdsd1xXRAHs3avwhh7dfNVC0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRtrZ5OWvJUwoGiK+Qpy/jdk2TNXBTmGd6m/lIxIPLSt3mjFMx
	kj69RSP2Vl2B0GYRNkXHpkmyTtwbY/zbvEa8sEx8YDGkZLaW7MktaRocV4OVTxQTVcA=
X-Gm-Gg: AZuq6aLL/X1+ToX+EoEQgMG7wmSGu0brkZfIu2NY/tcUlldfFTO9aakqb73RfXlQBPq
	OzBU+UXQZyTH6xjmabUYpDoOMx8YfRGw/h5DKrWSSpZNzZ4ttq1UknN2zkqtHiVT5gdyRaARE3I
	OQvMeZW+u+PkupJZiU+LVFubbsu4gTu1wzFKviSGe9BvxCgsErTKPoA8VrdocLE8UjD0tIAqJoE
	gWD08iIeX0bfeDGIicdLl7C5rpOAv1C45/0cEfuvpnr+J1t+iBG6j+MXBhnFXdqMFO92WTf+iHS
	eA3fdWRdLd5cUsLS/XoYv7QhSXjqFeq8nPpfIGdY+joBbbAvvdo20WlXGjF07W6n74/QChRvCFW
	XyVO04/uopfS0xfaRq9wEMUvsgZLWebFJL5hK0UurUzWlW+U8MrUcXRleigl3TxHKjGdn0dmrbW
	PvsYDfSEhUqZI9xX31BSRY+PEXxBeU414=
X-Received: by 2002:a05:600c:1386:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-483a960c879mr236583495e9.35.1771921925134;
        Tue, 24 Feb 2026 00:32:05 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b820f718sm14689075e9.5.2026.02.24.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 00:32:04 -0800 (PST)
Date: Tue, 24 Feb 2026 09:32:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: John Stultz <jstultz@google.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca, 
	leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v2 2/2] dma-buf: heaps: system: add system_cc_decrypted
 heap for explicitly decrypted memory
Message-ID: <5z6d2etfr24oscoxhk3samf2bbhtcz6hymf65cow76omagsplf@6gdaev2perkk>
References: <20260223095136.225277-1-jiri@resnulli.us>
 <20260223095136.225277-3-jiri@resnulli.us>
 <CANDhNCp94KG06P_7ivMTNA27qEM9g8ox-h3b_tZ=v6e-25xJ3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCp94KG06P_7ivMTNA27qEM9g8ox-h3b_tZ=v6e-25xJ3g@mail.gmail.com>

Mon, Feb 23, 2026 at 07:33:07PM +0100, jstultz@google.com wrote:
>On Mon, Feb 23, 2026 at 1:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Add a new "system_cc_decrypted" dma-buf heap to allow userspace to
>> allocate decrypted (shared) memory for confidential computing (CoCo)
>> VMs.
>>
>> On CoCo VMs, guest memory is encrypted by default. The hardware uses an
>> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
>> Intel TDX) to control whether a given memory access is encrypted or
>> decrypted. The kernel's direct map is set up with encryption enabled,
>> so pages returned by alloc_pages() are encrypted in the direct map
>> by default. To make this memory usable for devices that do not support
>> DMA to encrypted memory (no TDISP support), it has to be explicitly
>> decrypted. A couple of things are needed to properly handle
>> decrypted memory for the dma-buf use case:
>>
>> - set_memory_decrypted() on the direct map after allocation:
>>   Besides clearing the encryption bit in the direct map PTEs, this
>>   also notifies the hypervisor about the page state change. On free,
>>   the inverse set_memory_encrypted() must be called before returning
>>   pages to the allocator. If re-encryption fails, pages
>>   are intentionally leaked to prevent decrypted memory from being
>>   reused as private.
>>
>> - pgprot_decrypted() for userspace and kernel virtual mappings:
>>   Any new mapping of the decrypted pages, be it to userspace via
>>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>>   of the direct map. These must also have the encryption bit cleared,
>>   otherwise accesses through them would see encrypted (garbage) data.
>>
>> - DMA_ATTR_CC_DECRYPTED for DMA mapping:
>>   Since the pages are already decrypted, the DMA API needs to be
>>   informed via DMA_ATTR_CC_DECRYPTED so it can map them correctly
>>   as unencrypted for device access.
>>
>> On non-CoCo VMs, the system_cc_decrypted heap is not registered
>> to prevent misuse by userspace that does not understand
>> the security implications of explicitly decrypted memory.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>Thanks for reworking this! I've not reviewed it super closely, but I
>believe it resolves my objection on your first version.
>
>Few nits/questions below.
>
>> @@ -296,6 +345,14 @@ static void system_heap_dma_buf_release(struct dma_buf *dmabuf)
>>         for_each_sgtable_sg(table, sg, i) {
>>                 struct page *page = sg_page(sg);
>>
>> +               /*
>> +                * Intentionally leak pages that cannot be re-encrypted
>> +                * to prevent decrypted memory from being reused.
>> +                */
>> +               if (buffer->decrypted &&
>> +                   system_heap_set_page_encrypted(page))
>> +                       continue;
>> +
>
>What are the conditions where this would fail? How much of an edge
>case is this? I fret this opens a DoS vector if one is able to
>allocate from this heap and then stress the system when doing the
>free.

From what I can see, the failure of set_memory_encrypted() is quite
rare. Don't see any real DoS scenario for this. All the failures seems
to be either theoretical (sanity checks, malicious VMM) or concurrent
kexec execution in case of x86/pat.


>
>Should there be some global list of leaked decrypted pages such that
>the mm subsystem could try again later to recover these?

swiotlb does the same non-recovery leakage. I belive is it not worth
implementing this at this time,


>
>> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
>> index 648328a64b27..d97b668413c1 100644
>> --- a/include/linux/dma-heap.h
>> +++ b/include/linux/dma-heap.h
>> @@ -10,6 +10,7 @@
>>  #define _DMA_HEAPS_H
>>
>>  #include <linux/types.h>
>> +#include <uapi/linux/dma-heap.h>
>>
>>  struct dma_heap;
>>
>> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
>> index a4cf716a49fa..ab95bb355ed5 100644
>> --- a/include/uapi/linux/dma-heap.h
>> +++ b/include/uapi/linux/dma-heap.h
>> @@ -18,8 +18,7 @@
>>  /* Valid FD_FLAGS are O_CLOEXEC, O_RDONLY, O_WRONLY, O_RDWR */
>>  #define DMA_HEAP_VALID_FD_FLAGS (O_CLOEXEC | O_ACCMODE)
>>
>> -/* Currently no heap flags */
>> -#define DMA_HEAP_VALID_HEAP_FLAGS (0ULL)
>> +#define DMA_HEAP_VALID_HEAP_FLAGS (0)
>>
>>  /**
>>   * struct dma_heap_allocation_data - metadata passed from userspace for
>
>Are these header changes still necessary?

Oops, leftovers. Will remove.

Thanks!

>
>thanks
>-john
