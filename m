Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9E2D836D
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157893; cv=none; b=kAPLqZfIs4ILpCG+FaTrtG8ip/htjnurQvv8GH6ANgfEptbbEqEiipb1g89QdDNGc72KAjewj7GIN1zK2PS69lITQsmIDv83nA+EB5IauWQD+R2TNdMDN+ww3UVoiRFbUA18xZEruw/hhWXpJIE9VoTdLOm+6OaKHWutG69S4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157893; c=relaxed/simple;
	bh=9uUYz9kYCeGdE6spxQMBcRlbUnTIpA59Ik3mlReGOcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUDWjoYttpMb7japZJy0+HKkcGOuetHsP2sidR+bmN1LA5nly7CyVEL/X8BIkwwJx97USEDm9ZgfjKwQ3EOFOBSQsMOujsGUgAo3No+CqHTCpTdrfqbeJmN/gIqWUl6ryF3ryUWkukOt4FWyLyhOyKjRYv54d6LFvDeCcJnhowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3m7gE1Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3m7gE1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761157890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XEn3yyxjXvmC/ldsq8Um3xpfGQ3D0pETvFOoyjoouw8=;
	b=N3m7gE1ZlAJsHNccyr3qKtSwye/pyyihVmN2QGjeE5AzzHex5RUx8jrBHnR5ZteC2nnlU/
	+d98O3f3X8GrGMPd2H8FsqU3+dGhY75Z+H3a6Nr5k4BL7o9FImktQQvUBZPzHpm9uwePWP
	4d53Czv20uqVWKGvSJDB7GVzPZHmsew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-fvFd8P_SMc-xhuKxTUDSEw-1; Wed, 22 Oct 2025 14:31:29 -0400
X-MC-Unique: fvFd8P_SMc-xhuKxTUDSEw-1
X-Mimecast-MFC-AGG-ID: fvFd8P_SMc-xhuKxTUDSEw_1761157888
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-470fd49f185so55852445e9.2
        for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 11:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761157888; x=1761762688;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEn3yyxjXvmC/ldsq8Um3xpfGQ3D0pETvFOoyjoouw8=;
        b=a+QD17/U3+JUNj4YTPVJ/wrSPyxJ+OSjPzdFBHVCFWDO4EE2vgsO7Kw4OeLKazqYqt
         Dzb0L3q4FdaDLCRU/4x7FszTJbetZZOPBmzj8jQpqx+VALtnYabGrCUpQ4BfN2MvYZ6g
         PY3mArf7J4/8nSb4qQq6KM5JiXipClw+etL2zfhau7qCaLPrTy2CgpcUtbwhwE/DmDy4
         PQG8/iB5h6ESoR7T15FvvAkv2StgrI++OQNa5iqUui4BrGqs7wWI64kLa+m3OEwsi2nK
         W1nzc/9Pn8gfa7rKzfmYdEgOh1tBEIxnClt/bNaZyC60tSyTVR+n1BaR23npXOUzPemL
         ygsw==
X-Gm-Message-State: AOJu0YzjBHtrTFbmkwURJ5XiU9napaMsUnW8vBMtKrBprEeDVPyE1qoZ
	tXBiOVLNKV5LfPOJY5wOmeKPrcVt6spyeIRbXRSCyjU8heCVbNOiH2oTElMcQUPtMbjbOC7uu6Q
	4dX8KzvbGZYHDH0+14CqtazJDveAw3Dkgy542aQ+VwsfXoJqoRX2NAsP1
X-Gm-Gg: ASbGncsVSIs5u3BPEn+jTX1aqZ5CLeBE3NxmYuTSSFAjHOFM4XfH1sHaX3CuhiEjb3E
	PGwWTZPSsFLEPYqGyEQIWTMOiPxEmTjAllju6W1Tk32xhriBS+J6gow6PL6nqz/9Day2KqYfSqH
	vkH3By7bH5BMP7FFFhd869RwPHfVVS5Pusbw/B5xVljfK7cr1yA26s1unljQP0fIPHPi5yAgdMG
	gaPC7UgPCtuqyjK9tuQ5L20mKuZwhMLbhaI1lQx0IgpyhMlPAbZBEpa+Eglf/0lsBPRy7CCmii2
	6L2q43I/2Gq2CuyKwG0/IUvMgYnvd3HSgvjh4W1HtGeXsBJKpmpUH4Ab9nFGS/AQAaPiUnic5Wz
	hkaO81s370nnMI1GJwVbE6l66duraJhbfar7qX3TA1WJ++UaNpa/BiIDKPW/UsVy2AXwx4CWKCs
	z2ZuPeZS6dfeYES4g4OxVRpKdX1k4=
X-Received: by 2002:a05:6000:2287:b0:3eb:c276:a347 with SMTP id ffacd0b85a97d-42704c6eb76mr14414164f8f.0.1761157887997;
        Wed, 22 Oct 2025 11:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2H5mvZbqYjozV89c9xsAvxToHx6BgY2R0vbE6XnaDbrAdEv3Inh8U+0w9UndOHIQ8v68DEw==
X-Received: by 2002:a05:6000:2287:b0:3eb:c276:a347 with SMTP id ffacd0b85a97d-42704c6eb76mr14414145f8f.0.1761157887568;
        Wed, 22 Oct 2025 11:31:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c56sm26481057f8f.18.2025.10.22.11.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:31:27 -0700 (PDT)
Message-ID: <d02f6d5f-27fe-459c-a727-3dabcd07ca30@redhat.com>
Date: Wed, 22 Oct 2025 20:31:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/8] mm: Add a ptdesc flag to mark kernel page tables
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
 <20251022082635.2462433-3-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251022082635.2462433-3-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zzZVBoaNHmKyRHIQE7mhzjRmfHeRjo5jM9tXU267RWU_1761157888
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 10:26, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The page tables used to map the kernel and userspace often have very
> different handling rules. There are frequently *_kernel() variants of
> functions just for kernel page tables. That's not great and has lead
> to code duplication.
> 
> Instead of having completely separate call paths, allow a 'ptdesc' to
> be marked as being for kernel mappings. Introduce helpers to set and
> clear this status.
> 
> Note: this uses the PG_referenced bit. Page flags are a great fit for
> this since it is truly a single bit of information.  Use PG_referenced
> itself because it's a fairly benign flag (as opposed to things like
> PG_lock). It's also (according to Willy) unlikely to go away any time
> soon.
> 
> PG_referenced is not in PAGE_FLAGS_CHECK_AT_FREE. It does not need to
> be cleared before freeing the page, and pages coming out of the
> allocator should have it cleared. Regardless, introduce an API to
> clear it anyway. Having symmetry in the API makes it easier to change
> the underlying implementation later, like if there was a need to move
> to a PAGE_FLAGS_CHECK_AT_FREE bit.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Just a process thing: if you modified patches such that you are 
considered a co-author, there should probably be a

	Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>

above your SOB.

See "When to use Acked-by:, Cc:, and Co-developed-by:" in 
Documentation/process/submitting-patches.rst

-- 
Cheers

David / dhildenb

