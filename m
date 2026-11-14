Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794648885;
	b=MWhKgEgJkLxfkpdIALZazALYjz6X2WUMagw121qU1ewJtfuQ69rnWr5Lg/ttLorXtwc7
	 KqXS04m2xkcupfh6s+e1xT7eTXgflfjcCxNIiGrG7qzAU0e17ipe9pWDxLY6M6k0RBjoS
	 zkK3XVOcL55kPii4rHATrmJYye4NBcN0h8oTHRahavgqo767iZzcCBLSGC3cA/E2mDyOa
	 krLS+dOEvvjQQOndwa6qJZDxvbR/AaUcv3+napG9TygXQphNp7CifsDWdkjXT7Y+P3MGf
	 YK4GSLBli59Fh/XbFukW9ZpfobiGvIbnv7m62d2KBg+lG0jUdmWf2VYMV0QAFJ6FHwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794648885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=cYfB8ZYjzkbZTu8PkWr5VdyVYonCx+ZsO65KHqfQojE=;
	b=HdIsu/mZ7AajqTNXWnAZhjATexF2gja+YwqtFnsxqYbPezBBEfNPm5z7hZF7c0hKm8DW
	 7A1QcDv4Dl+Y+T52swlqg+/xeTZDcYl5SSfh5fs4zWzvKCLFYWW5PV4b/gfRDNwV4bcSr
	 CVkh4i13eXfNsZ67SpauhPa+6AnUoqqwmcbnsAmTYWZWPbh1hzS3TKNpiUVkKoAHMElrE
	 LKHhiy68+JiKB7BlntIeKjw9K3jzBUU9KCQ7GQMwK6lP3TYXaimFojaeLWuLlolomgqC+
	 YHpsJfDb4oFnpZW+dTECUz3El7r+QxnbrTnbdxArFeBUnNd/n7K+UH8r5Xt9NCUKDjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZ0Bdc7a;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D8606A334
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 09:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C3D8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZ0Bdc7a
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c50a8e37286so120786966b.3
        for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 01:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794648884; x=1795253684; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYfB8ZYjzkbZTu8PkWr5VdyVYonCx+ZsO65KHqfQojE=;
        b=ZZ0Bdc7aNfX61/F0ANr5xkvk9K62pFsAenBTG8ZxCOmDIF6nKad0BHMIpSijUz9oLl
         l/0D6Qw/tBkhh4ZlCaqOVrbG1X8YXvdBz6i8qICymbqYgJg/nyoD7ZkzBqQn+KrgB1yr
         Ear77WzRrekOPxSlhJlnRz7LzWs6Hcupa4jP1GdBRsE1yf0ovgGCB4sl4ra7CDg4Nyu9
         TD1J1Ugr7LowtxTYYjX4SDL1Yo37RBuSpZGWCFcAPxVvEQIAduZ/2ez2+Y0vXWkIHKhu
         +ELr11L1AMQvsYyHswyqxrg3oP/eULC1TQVfGwV95VVEGc9k/sXDkaOcqdvHgYVBxG7k
         ktUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794648884; x=1795253684;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYfB8ZYjzkbZTu8PkWr5VdyVYonCx+ZsO65KHqfQojE=;
        b=m9UbBIGrjYWCDkV3+urvKIU3AcezsnTnV2k0mGNJuEUqPKrXF3WfysnB4Gcvfgeztv
         nylPS+/HkewgZ9OG5KRVqgjqJjg3NJA7Y6tGD+vEIc5NavoDQ3T/bIOKNorvN/rSOysg
         +PFSN3jk6IWqE8i05/K5GBWdBNDcm5odcGYhzmY0yHcsaj4haIjq88NO8UrE3YBkO5VG
         A1iOCq3IH4wNQFFS1PEsjdZTCUYwom0tX+OETBHzAgSnRCGMKsNWR2JItLjh0ZpDphST
         iun63RbIVRDShFLoTq324Ot5wcV7tt1rFX7bZJPKONb6R2c6JfY/fONNQ1Wg8Kc6yVgZ
         nkVA==
X-Forwarded-Encrypted: i=1; AL+hErGyxBrPly6D1QItRiCoA3dSENNbzpBAqcc66EJjfUCoo7T/BCaYB00an+y2EqMTmrg0cpr44A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/uFja+XHO07o/eMvMuhUKU0CGY/R6Ufxw57nwW8xEJoLkIlCKY
	L0DfYpC6kzs2y7lK/qC2cdw56vor0rVCGzQ1xw5c0GPOQqRelsseMYWGeMKCfi0bDBUekvRcOTk
	mZRTQHA6uP0TjOMnz0Q==
X-Received: from ejbgl17.prod.google.com ([2002:a17:906:e0d1:b0:c50:537a:6835])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b83:b0:c41:b4e4:7958 with SMTP id a640c23a62f3a-c5095dd7931mr418395066b.0.1794648883281;
 Sat, 14 Nov 2026 01:34:43 -0800 (PST)
Date: Sat, 14 Nov 2026 09:34:41 +0000
In-Reply-To: <DMRP21FATCC0.ARAURXWV85JP@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-9-tarunsahu@google.com>
 <DMRP21FATCC0.ARAURXWV85JP@google.com>
Message-ID: <9huzse13pxhq.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 08/19] kho: block: Add the feature header to blocks
From: tarunsahu@google.com
To: David Matlack <dmatlack@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"David Matlack" <dmatlack@google.com> writes:

> On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
>> Precede struct kho_block_header_ser with struct kho_ser_hdr using
>> DECLARE_KHO_SER. Each block in a block set starts with struct
>> kho_ser_hdr followed by struct kho_block_header_ser. Serialized entries
>> start immediately after the header payload at offset fhdr->size.
>
> This adds a feature header to every block in the set, but the layout it
> describes is a property of the whole set: all blocks are written by the
> same kernel with the same header.
>
> Blocks are only ever added and removed at the tail, so the head block
> is stable for the lifetime of the set. I'd put a single set-wide
> header in the first block only, e.g. a struct kho_block_set_ser with
> its own feature header, and keep the per-block header to next and
> count.
>
> entry_size (added in patch 2) is another set-wide property that belongs
> there. All blocks in a set have the same entry size, so recording it in
> every block is redundant, and restore has to check that the copies
> agree.
>

Yes, adding a ser_hdr to each block_header is unnecessary and also cause
8 bytes to get added to every block. This can be solved like you said by
adding it only to the first block. But this will make number of entries
in block[0] to be less than blocks 1..N. I am not sure if that is
acceptable but if it can be then we can avoid adding ser_hdr to each
block. Same for entry_size which can be moved to the first block only
like you suggested part of struct kho_block_set_ser.

> [...]
>
>>  		entry_size = ser->entry_size;
>>  		bs->entry_size = entry_size;
>> -		capacity = (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
>> +		capacity = (KHO_BLOCK_SIZE - fhdr->size) / bs->entry_size;
>>  		bs->count_per_block = capacity;
>
> Nothing checks that the blocks agree. Each block's entries start at its
> own fhdr->size, and count_per_block ends up being whatever the last
> block implies. With a single set-wide header this can't happen.

yes.

~Tarun
