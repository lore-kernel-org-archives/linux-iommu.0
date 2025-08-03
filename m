Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C71B4F2C
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754218778; cv=none; b=YOkAaVfyxM8ZrJnF+HsJPfeDgvhl7rfZMijqDjtx1V+2/1BEWRGH4oYe/5dLKPOXuHZY3JOpLcFLBkM5bbx490YeTaD8UAW3O5tMnJXVxjj+Huw5g9py71A89Afh6EhhRjjS9bzF4JsgrW9czy3CpTosRk2lIasQ7sD6I7uiB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754218778; c=relaxed/simple;
	bh=8qGh5+VS2OHUxroiuOZuE0lXrzfIziOPyv+nXa3cCA8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F2/wTHDqxIlgGtfmPrMYiryxqlE0uwoNE5fFF7a763q1IFtD+EcA9+yi8NMbf0ynBFS2Z58OX1oeU06WDpAA04XiAdtN2c9oLA0o/rK85TEFwHDe9x4WJW5poggFU9rwQg1HzGsAvdW+2z7lpz5IRmnX+Sf9cDiA1QR0B+n3Sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=C8+qwyXm; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="C8+qwyXm"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-707453b0306so25077756d6.2
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754218775; x=1754823575; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5d1Ty/OC9652uUgpaiAgn5uJnzmBBRdn461onxQuzqM=;
        b=C8+qwyXmO1KiqqlioprhNJtqJcDMbTTsevMFpy8eSGQRLvyloAFLqKEsq5YH+RTdP2
         5VVhgTji2zjiNS5aWOzfXrUi7KYdpxN7+sV4iH8ydUJJLlLl9MvSof0RmqVwk9HQtAfo
         5rRwjW0uiSP5sB3OUEIUV7Fw1T38TCo2OYVt7+hFxzogxYVF6c9+AYaA3LY5iA0KEB6M
         FtyT7KJOFkeiPEfTSRf8jPxsYfCFN6QkWZZ7BS6K4nZ59sIxmy/rXS0TRkGH/EzpQwdW
         WepXqdGeFTEnXnrMSUPHp65On9ONG3YtqAHcfoBwHkqi8RZM1monfAg02SuluCDVhUR/
         EEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754218775; x=1754823575;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d1Ty/OC9652uUgpaiAgn5uJnzmBBRdn461onxQuzqM=;
        b=D7+gd//WVXiN7cgVAsTdxhd6ngAMbG/sZZ2b9JHEG/szfTWTpy9x7bi9RWnIVH30ci
         L0gWMHev2IEmjAKjU+dWBDraN5SiJbhC3YZwlWAMjpUSMJEt97CeiPCApoLaEgFZtaSL
         7uaJ3Gkgo0i6mPYw2itHT5eg9kOuX74KgMMi7xsKzWJFbQ0fU4H3MXZ/LsorzQ49wifY
         4xij5xehNTsROFMj5K1jLMGU2VFGTvT8A0MS3dn6gNSc8dsojy3cCJfiVQPxz7kAp3MR
         B5EErXe6ausROBbDsiei6XLBuAZYvRqeDTbmrPk3yz08SeonT8B+WkSgNFKAs/uFf7yQ
         Lb7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWK8055M6kfNwN/ltkoITzaKyWo7kiO/iz2VwLewfz+MKpHdKETpep1Ejp39k5gzxiU/7y6aA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl3KFEVRvHFj7O/1ZKaloXAtNIkK2cL5soNvxA0ZFdJc+asMw2
	/avD7CXbpZsEtWXD81/FAcO0A94yF48bMR5+U49Mk3vsmvdvx/Od8JfRqaOFpZxYg1NzM3ZOOws
	6HGWy42x8KgYfSdi7JFuznOaHDDlXVP2b0kuRRQCpVA==
X-Gm-Gg: ASbGncvgQWO6pd2vTzzslyvtASAfZdJ1uSI5oGfZ/GYG87JKloD4VHvMUfeKyTbYzjy
	KMzi8IXJxejbf1IOY8z/6B8LqXHuo7TkcoiyEzQKLDQBov5NHDUDkWNL2nm5CWxNP5A6emjoxPU
	H/zR6QObsKAP/8rrwvDweUpJNFi1eNmSKxhN0OQVBoYWNWjl6CKMmRIQj8NwWHOuya2PEpN4LnN
	di5beo+gg==
X-Google-Smtp-Source: AGHT+IGt6W1C3etzatTk+DvHHR29hoZFX+9vcXrQgy+SxsY4eo3JROncv3wBlR+V1hQ2RnTpJXWmFgE4U3qVLSQKcgs=
X-Received: by 2002:ad4:5b8d:0:b0:707:75cb:60b4 with SMTP id
 6a1803df08f44-7093631987dmr77957396d6.41.1754218774911; Sun, 03 Aug 2025
 03:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 13:59:24 +0300
X-Gm-Features: Ac12FXzclI2ppn0KBABkur-RWnTOIL3Ys4pDILyGyuz5uO41_4IKbSmQPo8juL0
Message-ID: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
Subject: Large DMA alloc
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I have been working on a set of kernel changes to facilitate IOMMU registrations
of large memory regions. The context of this work is working with PCIe devices
that have very large PCIe memory BARs (multi-terabyte sizes are possible) from
user-space. Large memory registrations happen in this context when the PCIe
memory BARs are registered for access by other devices (like DMA engines), and
when the application memory buffers are registered for access by the
PCIe devices.
Working from user-space typically involves a single registration of large areas
(application buffers and memory BARs) to avoid run-time performance penalty of
dynamic small registrations per IO.

The full list of patches is provided below:

[PATCH 0/8] Large DMA alloc/skip 32-bit alloc if size > 32-bit
[PATCH 1/8] Large DMA alloc/extend alloc APIs to use alignment
[PATCH 2/8] Large DMA alloc/do not align allocations to size
[PATCH 3/8] Large DMA alloc/add busy_regions sysfs attribute
[PATCH 4/8] Large DMA alloc/add APIs to query available range
[PATCH 5/8] Large DMA alloc/remove max32_alloc_size field
[PATCH 6/8] Large DMA alloc/alloc DMA addresses from the top
[PATCH 7/8] Large DMA alloc/low address limit in alloc funcs
[PATCH 8/8] Large DMA alloc/add min_dma_addr to device struct

Entire work is available at the master branch of the git repository
git@github.com:cgavrilov/linux.git, with the purpose of sharing the code for a
possible kernel merge.

The following messages will provide individual patches.


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------
