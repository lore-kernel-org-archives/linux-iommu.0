Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1001C3F36
	for <iommu@lists.linux.dev>; Wed, 13 Aug 2025 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055090; cv=none; b=dcE7/gpdYB/jylJ5AYF2/PTHvtDOrydJVuyY6pDxdzA/Ne0YRwobczCeLx5j4yJg0dImFNxA47eTrgtb/q1v1qT0VaSvFYMYXTgRyoLtxhDpW/a23dotMojJI37LdGvhV3kQbDd4TjExBcLsyTh7aNRYUo2yNOsHU9Z7OtCvALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055090; c=relaxed/simple;
	bh=ep7lK0F99GEgxWEt/eIh0MesHhIBI5SzHWocRe7DRX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDEXtq0aKSSMDPqVYiL0pQlILACbVzy/RZv/m1BYuKBKnlORL9TJ0GfCeqb9inzFEdZUxCb3/yon2pJgpIrzrhhFKi6giIaXGkpolcB3xn11DYu/jceMeriiD9xm45DXB+mgks1ydC5Vzs0C0K8Y7xyEIpGt+8/M7p5gWMrjTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5r5x1WC; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5r5x1WC"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3b8de6f7556so3383380f8f.1
        for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 20:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755055087; x=1755659887; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XCYFs1Ir8nk3KK4TBgEVy6vlzhXtWwOkAnDASfP0Oo=;
        b=M5r5x1WChq6SZmsjGsLF5ZEbsuOcZuY1J4Bo1ZkaucGO94uo5bm0SafznwJIItd/gX
         FIoKhpTMwPS39/xOaxLdPh+Jjhh3yRSbRa3wMFM/x920oDvhrVLCwKCdS864GcJ1sLGp
         RfYWGLM79emdJ8SWTxg0/YZQEzbN6yk2yhU1e8OItMN2wNEgbWRnYORHB6GllgbqsRzH
         mfYTlnOWsjMEhAPdm6TyEYbhEypO/jini0fKZK3sH1i4SiUZSZnvSRr3RrCw5vTa/RrK
         o8rvjx9x0rORnATVBhwQ491fHU1bH9vYze6TcGQ93c+/lUoijB/v6zPCVhBAHSbz/EU7
         CJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755055087; x=1755659887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XCYFs1Ir8nk3KK4TBgEVy6vlzhXtWwOkAnDASfP0Oo=;
        b=NH9QkWNdUb7rgmpi5w1gRV7C4s9yOzjcJQT8ocQDNst0IGu/3G9UHg0EhDhcQIs6LN
         uvmRtcGq4+EoePj2BQXuM7muYLThoK+xcH/MLAkI+RmLCGdOZulKZjwNFznCWicoWnYa
         1lkhk+sPd4s7296WVRxTFugyopt58gt3IHwFXBs/ERaH7W1gZkYP5FOdBjfKDH+p1pf+
         pfS5f4BSKotnZVusSDrprqKQmkgLyZ469eCfPbkWgeWIIdJwMRXLQuW0mEzJPCidezWN
         3KWqbOtdcxdz9Fqg1qZTDN2kNFvllcGEDQWKM6cRt/Vl7RubDAtRrJir8lEdR+AF1RIW
         lu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWE2LKkJ3Av2/uvMmS7sozz3mXAs/zq2JjTMPJRB+9evBwbv+dBtl0EE4lfWiuYlLeGP+ynGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeLF4cVO9yGBixqfdcvfuyKyO8bZMCVjg32V0Dk3MkjwfYMR+b
	XEZqrFVQ8EUGtTPP/8kw22yP2b4KRJIbeYqbUUexv2m5KmskwGahG18F
X-Gm-Gg: ASbGncsx/aZONod+U4kbCdzOf/J5WW2Z2KkQfwdQMmTOYuMy76kl4Xh7/8RrpKIab/G
	4oEX92Cxamu1OG8RSz9rOMTrEq39BIH0rIKM421yZI6O35pyGNv6Dd5NyXTgMquylsbiZ9+oXWk
	MsXjamH19aPJUSn3SG1MrapX86RSUb+hwJe9tgmpqus3y9wvYcESbfmoegCqAnTchv8A28cK4FI
	L6Q5TxEwl5a8X5Gj8v0u0eEUuQmR535YNMEDw1xe/BaUCvM6/pQjjl3epkcVxR8jlN7kwSRBpwv
	E+JCkxhwfPxAZx6Big0sVpSZk5ci7gZNNo8cLtM4aca87dMmUDRVfLubEanD7NlL3K4GE23xitA
	0kXu++HRpN2XXXyxBF+5C2uP8oly27FFM4onzqIH47oNJLUuxYdzrroLLj65QeOhALIUdRuMITm
	0g39RX+JixlvyH6AYGeuyn
X-Google-Smtp-Source: AGHT+IFK1DMyzcLy23ebyF7+rQb4+XbWoa8waTcmvm2yM0sRpo4qdIIwHXD6dXoIgYNTEroCcmTFnw==
X-Received: by 2002:a05:6000:2311:b0:3b7:8268:8335 with SMTP id ffacd0b85a97d-3b917eb8171mr822011f8f.42.1755055087110;
        Tue, 12 Aug 2025 20:18:07 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e04c7407sm36750215f8f.13.2025.08.12.20.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 20:18:05 -0700 (PDT)
Message-ID: <33b39588-5a39-4474-ac17-bde923803600@gmail.com>
Date: Wed, 13 Aug 2025 11:17:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
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
 <20250811125753.GT184255@nvidia.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250811125753.GT184255@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/11/2025 8:57 PM, Jason Gunthorpe wrote:
> On Fri, Aug 08, 2025 at 01:15:12PM +0800, Baolu Lu wrote:
>> +static void kernel_pte_work_func(struct work_struct *work)
>> +{
>> +	struct ptdesc *ptdesc, *next;
>> +
>> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
>> +
>> +	guard(spinlock)(&kernel_pte_work.lock);
>> +	list_for_each_entry_safe(ptdesc, next, &kernel_pte_work.list, pt_list) {
>> +		list_del_init(&ptdesc->pt_list);
>> +		pagetable_dtor_free(ptdesc);
>> +	}
> 
> Do a list_move from kernel_pte_work.list to an on-stack list head and
> then immediately release the lock. No reason to hold the spinock while
> doing frees, also no reason to do list_del_init, that memory probably
> gets zerod in pagetable_dtor_free() 
Yep，using guard(spinlock)() for scope-bound lock management sacrifices
fine-grained control over the protected area. If offers convenience at
the cost of precision.

Out of my bias, calling it sluggard(spinlock)() might be proper.

Thanks，
Ethan
> 
> Jason
> 

