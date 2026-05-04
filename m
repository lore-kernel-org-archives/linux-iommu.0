Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B83E5ED1
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919594; cv=none; b=XRnlGKWJbrJAi76TDr03Krqi1Y0t1FtLdEeLzd4OqPepdWmsYXA8X50DNTtsIjcoYrY81S/HhaP1blNZqL7v8zHDtfSNABZ4OdhJishAGsQehORDBOb4z+2V3qEc2RvW5M4DlgfMFq6Um9dp/5W/qLVAoL3Kv7vn+i26pydhZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919594; c=relaxed/simple;
	bh=9S6I1BVV9U+hakYrzMNgB+o+EjrvcNV62AWmq1dpHmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFsyOG99B+eNv9978NYQ1KowI7xhBg9+aVJiaGSYNA2rfYe7Geu0dtY7VOThsB+BFTPlNzi+WRRPOn7EdnbflsHgjsgk9rCgagmdkwPsRMkg6f+latIoD3n5/ILuzjqSVTZnSFXmUBmCAKHTIElsaQPrBiYdAhkXxf9PPxmPWQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jniCOBh/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jniCOBh/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso22625ad.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777919592; x=1778524392; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJD8nC3hNpz1bkOtzLotRv5riDST1DKSmHvRTvkrIKA=;
        b=jniCOBh/IX87EwAtG6GMgIFKw+RLfgv0TisfadJyW1l2/phm/MNl3MxrT7SIm8Ez6a
         QQsxatRpS13jkM+yVr+VZiPsvDYQDU1C6qwdf8S09nTBbh+LLvR9k585o6M1OXtzP+bI
         iitYFoM9hDX/rn1LKmNnADSptlYoArdrrVlZn4PoFp3/tBodH4KFsRRoTGNPBSXxyk7t
         IFH1Wl9tCS3/vnv/rHgSKk+s5jSIfEu8WEZ4fOa2DpFb4jcqJxCzCC/RelrJLwXzI6C/
         vU2m/up0O/mLjceuEQjpycckRNDwxKGbilUxrXEm7JU0J37QLVU+cxkpPIWM2DtvK/8w
         kA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919592; x=1778524392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJD8nC3hNpz1bkOtzLotRv5riDST1DKSmHvRTvkrIKA=;
        b=lxYwgKIS0f/i18nsCqJSWo5iSTtoPhhCM9ZHM5jRvjYDb7emrsaj0SYYakX9NeYrzP
         Gi0mdbDPA658IVGemBu5zskczg95QbyaPETiwN28CJXo+Vw4a3jY0wzMIfNE2somRxkd
         oLnhOm21yOqSbOZlFSrUylpR9t5QyPHYlmXGvefhqp/kYZpzqUIH90xfk+CkiieUU0uJ
         Os0aXViwp1++MdoRpQfRdPxs+UtGtsJ0xxYzeQV4eb1M+71ivmWMwAmD4fMoJ6f9+YY4
         tO/tZ8QXq4jq4xE/aKEvAUPzMb8rS0BGbAO0H2TTMkjr43cjeJLOzoQpbIoLfKTK7+p9
         hHyg==
X-Forwarded-Encrypted: i=1; AFNElJ9h384XB8NMzlL/Wib+z8OltHAxecr741zGo/XQuqjwVEOvOIjUl0KyV/+4DDk0xIgoY2MBpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2Ho9a2dcQCqqVqLGa4/oHcNUtCqwuMRWJoQz8Prca0Ljh4q13
	QKF1p98SvXmXMDy5H/+1yZu5bMLbZX40HR/kduF4Ca337aTyDiLliMBmnmqo8p5tQA==
X-Gm-Gg: AeBDietY7fwTO86k1f2jibG9AXeDjVx407q7SCS1dpjEwgL6PYa2eYg/O3rRAOggMtd
	nJKhqXp3WYzxEXjgW2S/vlVAFzaE494ZLGQ+u0qBzlTKtMGrrhaQNKys9ernMPIoo0PMnuyElvm
	DRIUta7QMiJw4N0yTKkHlpWIxEn6k3kSO565gWxXo1uy9bDV13lWpOy7NPsAH/Gy3N2ReGgAY7y
	rx2gOaavDTddLMk8VJiGMTvPu8T+w+8w+xBCPQSGHUZ6/K2YS7hCTjw5kqokMe3XQKRggmZsJuz
	0GXQgQHCkqhJ2ED3eCbtnI49ntcK5iP49tHKgpWvFWOWSum/0pFuk8JjxpQTduu2ZK+Kwgv9Js4
	NOusAqBkBkTEp51lzAc0LOIMod2U638d9F71wr+huiWAGiUjPUYFE/Vodym9vsKJ9+k8yDZhcB7
	WNjuYOVvE9RQRct9N10CSRhE+qYYeG5MCxm5MlVeC0qA713BVy0uXcwpFCrD6jnJQ1zQnDp83wS
	65gBcqzUUI=
X-Received: by 2002:a17:903:1c7:b0:2ba:f71:57a8 with SMTP id d9443c01a7336-2ba4f7af343mr587695ad.10.1777919591414;
        Mon, 04 May 2026 11:33:11 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm113335475ad.63.2026.05.04.11.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:33:10 -0700 (PDT)
Date: Mon, 4 May 2026 18:33:06 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
Message-ID: <afjlRNfYA37ePRm0@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-4-skhawaja@google.com>
 <afUkbz0IQh98siYn@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afUkbz0IQh98siYn@google.com>

On Fri, May 01, 2026 at 10:08:47PM +0000, David Matlack wrote:
>On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
>> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
>> they support IOMMU domain preservation across liveupdate. The new IOMMU
>> domain preserve, unpreserve and restore APIs call these ops to perform
>> respective live update operations.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>> +static int alloc_object_ser(struct iommu_array_hdr_ser **curr_array_ptr, u64 max_objs)
>> +{
>> +	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
>> +	struct iommu_array_hdr_ser *next_array;
>> +
>
>There's a trade-off being made in this function to leak deleted array
>elements instead of trying to reuse them that warrants a comment.

Are you referring to the "deleted" flag in the HDR of each object? Yes
we don't look for deleted objects in linked-list of arrays and reuse
them for simplicity. I will add a comment that says this.
>
>> +	if (curr_array->nr_objects >= max_objs) {
>> +		next_array = kho_alloc_preserve(PAGE_SIZE);
>> +		if (IS_ERR(next_array))
>> +			return PTR_ERR(next_array);
>> +
>> +		curr_array->next_array_phys = virt_to_phys(next_array);
>> +		*curr_array_ptr = next_array;
>> +		curr_array = next_array;
>> +	}
>> +
>> +	return curr_array->nr_objects++;
>> +}
