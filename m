Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA813DDDD
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350336; cv=none; b=QeQvCt4Vb70m/+3ldKdU4AVgHI5d5hfyf01GOSXnTe7FAFL/cjhnGddmj6lI2eqOkSW0dRIvTK4Csxv/YRcu8OUba9zCiE+MERKaqsBmjkHf9a0C4APboTKirHHDJTCte/3cweiE3SPbzEGj/TddCj1mBG13+OvCdz6zsXj+UJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350336; c=relaxed/simple;
	bh=j2SDaSspcZQzjzwtMqeqijKNspTwsIjVjlU06GM8cIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvmGZbFQVrVZH5DRyqhaYk0VNlm/Q25I1a7Sz+LMK4OlsP/pqRH6OiaWSpsl6dyfEWraJ0G6JqROJcgQy1c8NGWx9Cw9DDIPVjDn8UkcggkhTJN32CROF0wzFbqQGPxt7DRRcTpG9/3Lv6CYwRy1Y2LEcPxOMieuc+q3Crujsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4WZjjAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4WZjjAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727350334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NUvdT/6VzD/N9xFL0vvfDArd4hGIXfIrgp9USblyYP8=;
	b=K4WZjjAKBKWiBD1xTaz0QxaMiqiVbAs1aK2in1i8fYhELOf/eGst2sWQgewqN5gTDonCIa
	YW7EferywTzbpFwKj4Lb5DNZpemWm5ruUhEhKnfI7fqPOV5E6kfLBKY7PMO4lDTjN2aMHu
	gFUDh4R6yIkg3DmrLBMcNEUg1BlRKz8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-UXeoBxgEN1G7hI-iJwsCJw-1; Thu, 26 Sep 2024 07:32:12 -0400
X-MC-Unique: UXeoBxgEN1G7hI-iJwsCJw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-378ab5b74e1so335383f8f.3
        for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 04:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727350331; x=1727955131;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NUvdT/6VzD/N9xFL0vvfDArd4hGIXfIrgp9USblyYP8=;
        b=l8N1G61HdR6etYKnpin0l/itWqMLwNAXvGBAOh1ryUFZM+2/fq3FrrgTKxNObMA8n2
         HFXbrwBgo0a/+OBfb2ma4Gu/a/AWPSSnwjDXbZxYQ5iZkJQTwYCjHp502SSNaZud35kv
         gGPOWNigSR06LlENmxD06LEGrHK1ODydN2/OzZzJwAho/4jHg/58vDTS++F7TY5W+V9L
         9DaRAE0/dCfZsG3Yd58DE+54l48QmIbeSc+BFZC6T23HOtPDXonGmRp7aFjVDj1ZcmVP
         Gr6kpPIEl2fo31rgzrqmL0ZLY7RctXnRrF7bNdY/fzWaYDN+19kqzUunKgD0wAcA017T
         NEdA==
X-Forwarded-Encrypted: i=1; AJvYcCUet5MEUssXN6vXu7ySiCEmVbOr78ptIEFTXF3SEIXAiqw00moal1ZysUbcHS2xUh9deOn9SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwToOXg7GmYCyh4frNubMBj20LXAZVmkoy3Md3KblrPNoLOBsxc
	5TKnYl8T52sl/bZ36Hr6VpyGQNZwp59u6WkYcYL9FjUJDPhpYhpGPYejShNt4rfMz7J7ZG8zMq0
	hlLJYX5q9+Wlm919RPGLni6B2GME0ka9fWYehE6Td9MPf8oK5yvJk
X-Received: by 2002:a05:6000:1089:b0:37c:cfe4:6997 with SMTP id ffacd0b85a97d-37ccfe46a46mr810357f8f.47.1727350331492;
        Thu, 26 Sep 2024 04:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENY0Txg/mu9eaMVHHwBbA2+jP6JUxvEjpA7+Ipv3S4Ads9SUd5G0UGbnSt7/reA44BsBZMJA==
X-Received: by 2002:a05:6000:1089:b0:37c:cfe4:6997 with SMTP id ffacd0b85a97d-37ccfe46a46mr810342f8f.47.1727350331107;
        Thu, 26 Sep 2024 04:32:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a? (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de. [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f9c27sm6265292f8f.70.2024.09.26.04.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 04:32:10 -0700 (PDT)
Message-ID: <27f8ff84-76cf-40ee-b391-e226218e5600@redhat.com>
Date: Thu, 26 Sep 2024 13:32:09 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, linux-mm@kvack.org,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
 <d25fc25f-34aa-458b-973a-f7de2438b837@oracle.com>
 <6aea6530-9f9c-4a9c-9c9c-2c29e8ae9e9d@redhat.com>
 <98004c8e-f941-480e-b1be-8f6fd925871a@oracle.com>
 <dd50a217-d492-471c-b708-a400c04e8444@redhat.com>
 <Zu14fVDpw1RWYevL@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zu14fVDpw1RWYevL@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.09.24 15:28, Jason Gunthorpe wrote:
> On Thu, Sep 19, 2024 at 10:11:38AM +0200, David Hildenbrand wrote:
> 
>>>> And repin is really misleading. We are simply adding more pins to an already pinned one ...
>>>
>>> Jason suggests a better name in the other thread.
>>
>> I would prefer something that simply adds more pins to an already pinned
>> folio. Much easier to get.
> 
> Yes, but also nobody should ever want to do that operation, it should
> always be part of some kind of "splitting" sort of behavior..

I remember patches from Dave Howells that needed that for O_DIRECT 
handling. Never say never ;)

Adding is much more intuitive than splitting ... just like we add 
references when splitting a THP, using folio_ref_add().

-- 
Cheers,

David / dhildenb

