Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6403CD8AE
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070798; cv=pass; b=eyt762gPMtDOssoqgs97eaGRnox6Oz2cmwmB74DCNrjpk//+BAfjpnI4wqPXukALTJG++Vhw/q9GkSMaROsTMU8j80074kflzcgZjQtMJYCKAWHboZ3ul7z+hZiph9vM6WFMqUm274J5IB7tuJoUW0AyMfMi9cHwoPvaDdqymTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070798; c=relaxed/simple;
	bh=fUiMYtNMvHNYULJIwkoZwWkLFEOGGVApxwthvUYiwWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQG1Sz53o0PhXkjFD8JwOiYiuYbjl9IXsU5HDMmj1kpucwU3txXnismoN3C80zfU4xGEaLd8t+26ToJD57SKw0xTSebm3z5gSE2TU+0elc6peN83U8r+eoLvaf+/iEoMEXMyhgpdrovXmxf+BovEjDEUxJ4iWb6kXTQ9b/79M50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJRjhJ5Y; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJRjhJ5Y"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64937edbc9eso10752587d50.2
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 08:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070796; cv=none;
        d=google.com; s=arc-20240605;
        b=BoMbeY7mG1/YBSBz4L382Dyb+6I2xMWLeh2LU0ddg0M1nd4AYAnVX1HYuhGySZCxeT
         PlbCZNG7a6R4gk5aKAySz+pRO/JTZOoywca6uUEJUWk21aaF748CbO+bVZeWtJvKHeOD
         XlrqPzM0uOoJ0GZhNM8ZElF9TjsvBGbeOz7D2SGFEh0nERer/MSykV1fOf+l8rbDRFzq
         z2VEImh5bY+HhKudMO9nVp7uikoda3X09sPt9MhoC/vR7wK+Gr8N7Mo/1t/Se1ZfiEoc
         vIFQ3JOyERO4ds91ezDXiZLfTLJjhUx7YjlwggL0iQr/ifoI2nTYF6lKoBOHKGe+OdbJ
         f5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MvLYcYLZmHSPzURtRpTfKGpAse3rZ5uBdKhXxFZ9chA=;
        fh=6UMeHXnbeMuo9Zc1TnyGIDdmXk4J+xjMiBAc1uG/liA=;
        b=JRduk9ejZpvvYeIea1z3KJcEVa+KBv2K9Gzq2PrGRfCDCurHeBpQlJixTZV2wjH6Dv
         UDFAIjcHcK2+PK8hxr8ZgSp4ZHuGQoLnHBfy1rLPbPzXil9Aj7HmEBfU8xLHR24MMuDT
         ZT8xlfPvJC2xh359So5B66jc7Iay+BWUhtGFQCcmk7i6S1zpAa5mxvOUO/kpO1vlTS2h
         4TcUZKtvLUSHKiED2E1TWmgHIFu6TFQArknceMGhdUNrL8h+R0uaioqfXmeFmlLRUGVQ
         W0zGxN36o8urb34Dm+8SJeSV+M+Wc/bAXtFzsVU7/4U7o8B/OzbweCuYqpA+PGhJVZBK
         JvMQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773070796; x=1773675596; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvLYcYLZmHSPzURtRpTfKGpAse3rZ5uBdKhXxFZ9chA=;
        b=kJRjhJ5Y3bDhtQO0zfrZWT6BXzLPrV8i3Swq+0RMpfb/7+qJvC3Rxyp6CYU5Zk4Wqw
         K6/qxcYrqGRE7AYHj8hGvJ7F53C63lDTokW+lY1HDO3gLNuX1VK9PeyEii4lPItkhFKp
         37KsDI51oyNURR/aYeTW9I/vMoKpQ4sGaDFkFqlJ1AWpgo6VqEx2fNTS84A5r7CbXIqw
         4y1gSbu8q57U7sYbqHOW18jzHHRtErupJxydRCIxVx+h+TpNgmge9MNhU2GTPXU0P76S
         86dHbzTtjFV4bIfIG7HD/caL9LeE/1T9kgQz5d0FfVUPed5Yxw9ujRkZ1CjY2vocY7ul
         cAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070796; x=1773675596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvLYcYLZmHSPzURtRpTfKGpAse3rZ5uBdKhXxFZ9chA=;
        b=qOJNnMTCoLD5JUFv0UMc6F/AC3cqA5hmr9qbmUYKxo9/5H1znIXzq7pNl5oag3Yc/y
         ipvcG8I04UeipMp2jbR55d7Ago5xHfylSfs3dicAnrrx0nrgLuB+TkonbeZ1CodRx1FE
         2oQ7EJdJNghBa7RcPJz52VxjOn4n2YwNcq/+da0cW3sYaWEKV4JGnPQh/wqvij6OgvON
         hHEneCGeNdr2lYcCJnr38k0/cKSIWUPZJ2cquhoByqmd13XBKbkbWIPCj+pZuAxVMKjc
         EkBl6UoIwzzNlypqIqj+CIt2u9G0behhsImEy/9eJzarzc7D8ZSNNqdLNxtyeytJ267S
         ymLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOrLPZlqPiHI/f3gQQh1nosAJWCNYs7wjUHZJLovtYu7ig8R+BaTMj6zyUnMorwMyIh5rUjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLpk8lrm58jMKeRKomUu4Or+lrwCcBzWNweeoG09Z2ENSFw3+x
	k6NxB5AdTCVwNR0jTBqVbxrAOS3Attt0Spo0bKh7ujcUGj/Ft5ilogpxjP5sgd+BHEHhiOtR4Z3
	O0fcMXcZxOzA0iDH5CHj2YFhcQBisYkP7HKm8JaUf
X-Gm-Gg: ATEYQzyd6h0TikII+ssIhB/EuM/O5vop1rZVNzRGH0oTsrvAx3EZJ9tTFaz6fZ0O0JT
	TgClk/tfCMNaHwwTQ+2dIvFuu722Cvnpxntg1ZDZn1h+mvU6Aw2bGnCkwk9fRwQohZpC/8v2VXy
	Moc8QdnkPZrcF5KjSdw/TnI2XCUcNNoTBXdb/Xj4ryzXeWgZL4fq3F1onhD/5XDP1yU+1ZtFycF
	pDaauh9gX3r8usrlz7adBeusEWH86eqJjf5t8ECp7P4/HSYyzLG8X7EhGf1E3AikVKEWbIoVI2u
	xZV5OXGmiqCmHf1cjRF5/eFWfCFviD0T1vRnVDJH5V/Nkh4+
X-Received: by 2002:a05:690e:16cc:b0:64d:29c6:7974 with SMTP id
 956f58d0204a3-64d29c67a27mr3174372d50.11.1773070795335; Mon, 09 Mar 2026
 08:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260305123641.164164-1-jiri@resnulli.us> <20260305123641.164164-3-jiri@resnulli.us>
In-Reply-To: <20260305123641.164164-3-jiri@resnulli.us>
From: Peter Gonda <pgonda@google.com>
Date: Mon, 9 Mar 2026 09:39:44 -0600
X-Gm-Features: AaiRm51h3c_DzKOKsC7CokIZvNyOKydjIyhi9bVIzEGXBlmxcqpV-AFuGedzucs
Message-ID: <CAMkAt6o_yZ5T-3TRwymjYQZEq-Q_z=DAA3vc61h81X9sQr_CXA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] dma-buf: heaps: system: add
 system_cc_decrypted heap for explicitly decrypted memory
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, 
	ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org, 
	suzuki.poulose@arm.com, steven.price@arm.com, thomas.lendacky@amd.com, 
	john.allen@amd.com, ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Great feature to have thanks Jiri! A couple naive questions.

On Thu, Mar 5, 2026 at 5:38=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add a new "system_cc_decrypted" dma-buf heap to allow userspace to
> allocate decrypted (shared) memory for confidential computing (CoCo)
> VMs.
>
> On CoCo VMs, guest memory is encrypted by default. The hardware uses an
> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
> Intel TDX) to control whether a given memory access is encrypted or
> decrypted. The kernel's direct map is set up with encryption enabled,
> so pages returned by alloc_pages() are encrypted in the direct map
> by default. To make this memory usable for devices that do not support
> DMA to encrypted memory (no TDISP support), it has to be explicitly
> decrypted. A couple of things are needed to properly handle
> decrypted memory for the dma-buf use case:
>
> - set_memory_decrypted() on the direct map after allocation:
>   Besides clearing the encryption bit in the direct map PTEs, this
>   also notifies the hypervisor about the page state change. On free,
>   the inverse set_memory_encrypted() must be called before returning
>   pages to the allocator. If re-encryption fails, pages
>   are intentionally leaked to prevent decrypted memory from being
>   reused as private.
>
> - pgprot_decrypted() for userspace and kernel virtual mappings:
>   Any new mapping of the decrypted pages, be it to userspace via
>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>   of the direct map. These must also have the encryption bit cleared,
>   otherwise accesses through them would see encrypted (garbage) data.

So this only works on new mappings? What if there are existing
mappings to the memory that will be converted to shared?

It's also slightly worse than just reading ciphertext. If another
process writes to the memory with the incorrect mapping it could cause
corruption on AMD SEV, or an RMP violation on AMD SEV-SNP. Can we
update the existing mappings?
