Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26002FB97B;
	Sun, 17 Aug 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755448626; cv=none; b=XdBPZRYtRPl2ZeCRcjNYxPtEzbYi5M0nP8aOi8oPY85aioIBgUoOEB7MfJaUAsYVJT2uFCWTqlKpx6LiDwMYP5mFWR361VUVdx9UQxxlq0Z5O0wse1IGQhcizDo4SCeR4udbJT5UefQPTcH9A/HI4lZv+X2EFakI4ABEx8/3hgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755448626; c=relaxed/simple;
	bh=+/Vmnj42oQV6Fm+uetYEn6odxvV0wTKF17MONO6nAQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDEEKyXukha8WhrChcU9V80qgTiw53q6sjz3MeQat10Ot+hUeZ1PGeccahiR9E6S7jVEB6XIglLACVXmCXeFBeIanXVmXgpfPMzln4o2Cy13av4jl+XbSZmQgjQJCyryWa9XQAcOvSWOb0lMk7AFy0FW+G7jJbmVvenM0dhCXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiG/f38B; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiG/f38B"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso2888466b3a.2;
        Sun, 17 Aug 2025 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755448624; x=1756053424; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vu8NtR3SA6w/CY24HT9I4ClMud60N/2LWQULRPh/3no=;
        b=BiG/f38BwW8kOTxi3/W0jdXzRynpBEvk3y/IncVWdA+BAQ5J8XGIPwEznHQn+tUddU
         oPfA9VWg5M11W9ZhMxxE2FIASaj5hrrBDJzQKmuBu7+OVfQvtitHP8ilnIBhoTxUuWpc
         77Uj7Gv+t/lqDEVMAhZwaMtblBKv8zEAr6/DIv8TyZzQhvMD9JfClItvy0RouibovRru
         eir16ChMysCgxkXalog1UISOfhWfBhpT8XmsCkYxwbif42z3j2T1JReZVWX1bbKtNjoG
         hHtLWEs2ZSYMbbUXi9hsNbqMdm/v5b2iwQpfhsTwwm/j+NZWkwH4NVUWfQvga2xEC1Yr
         kA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755448624; x=1756053424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu8NtR3SA6w/CY24HT9I4ClMud60N/2LWQULRPh/3no=;
        b=sOnI5RbJOnbVzWrvjSE3Bt+6sXAJFuQI/taQuY/LFrvFILd9WuXMmVRtP1Oz+99JO1
         A4elmfVBbAejNkxtvYnufuFEKaVl77zWw23wKNSQi/up4qjAXx9QhjgZ4/vFbSz1Fot5
         jNosMzna/bwYXvg0N7oyYbrk3CskTS5uOJNB/SbXViCT0ZucAYp6w+zUjxM9vFa5NWy8
         EqwHYwlP+VYTbwaPxBYS4hs5f1PHOM3+zJC4MMToamDJxTUCKJSbfZPVIxF0zqejTk5Q
         m421sjkddFdHVCeCnt/g4rDMhPe4/x16FndKt+/1n1Rgqm30Vhu1w2JOjNUNDIi4YOEa
         pGCg==
X-Forwarded-Encrypted: i=1; AJvYcCXeZ3hNRGGBvA7JU9lgWwpqKIs9tOcfV0Ba/6KQuBm6GLEF5DEIK1o4yDQISTMhDi+JUvp9yQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywts+JX1y/iwYL/w/f3E1M05duxJv0V6hKx/fK+yGJxKP7RDfN9
	WEPmny6+RrlBciblKeui6ArNLiMxn2kvKOGp9jJUcPm5aJrbSpHkdOvtMbzwHg==
X-Gm-Gg: ASbGncuXMWzzQhYiTsi/lL8ZkegJF/Zny2TDsCgFODD2S8nJXjIChr6VLGr6WAvxv0N
	KsyyqqKMDtzjzRdFUsij5WO1j8TDj0keJi//RRSjBumAc358h/d5zqSp0yEF4kIYkhjvwBEed8g
	5HrHRE+AiZb9Szd0NyoY321BSWX9jOWx3DhmlrxSCWOsR3gSqv+rIEdFZAH8X85GSFgP7OlTCZP
	SZ6srfBrNwr8/sfIHiK2AyhqIaXPe7eS6A5lL6pAK7LqnGSVYGyT1plcsRy3P9QWcMAa44nljpD
	N0PYrreuwCii0Y+qFJ8TZFPAbyzgY9tpChSoS0I0cnAyfSSmt0hKuRp8sdsy6eb3NT/oD5FehCe
	VAh2+aMiP+22J+97fcNuxXh7w7gy65C7pj07ruBsvHvRvcF8AQ4i2
X-Google-Smtp-Source: AGHT+IFolnCZsYxa8DXtlqeL7svE1Vm9qN7zDI4nNsqND3PhWkhOt0P90tLwWgS8I5+brb7rz1uJHw==
X-Received: by 2002:a17:902:fc4e:b0:23f:f074:415e with SMTP id d9443c01a7336-24478e3f823mr71496235ad.14.1755448623914;
        Sun, 17 Aug 2025 09:37:03 -0700 (PDT)
Received: from [192.168.0.124] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323632812b3sm1612946a91.13.2025.08.17.09.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 09:37:03 -0700 (PDT)
Message-ID: <e67860f1-bec4-4a55-91e8-61ade069f0a5@gmail.com>
Date: Mon, 18 Aug 2025 00:36:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme: apple: Add Apple A11 support
To: Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Neal Gompa <neal@gompa.dev>, Janne Grunau <j@jannau.net>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, Jens Axboe <axboe@kernel.dk>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-7-ef9c200e74a7@gmail.com>
 <56be1cd1-73cc-4733-b364-31b74f588e9b@kernel.org>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <56be1cd1-73cc-4733-b364-31b74f588e9b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/8/2025 18:47, Sven Peter wrote:
> On 11.08.25 15:50, Nick Chan wrote:
>> Add support for ANS2 NVMe on Apple A11 SoC.
>>
>> This version of ANS2 is less quirky than the one in M1, and does not have
>> NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
>> SQE.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>   drivers/nvme/host/apple.c | 228 +++++++++++++++++++++++++++++++---------------
> 
> [...]
> 
>>   }
>>   
>>   static void apple_nvme_rtkit_crashed(void *cookie, const void *crashlog, size_t crashlog_size)
>> @@ -284,21 +294,8 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
>>   				  struct nvme_command *cmd)
>>   {
> 
> Please just create a separate submit function here.
> There's just not much code that's shared between the two variants.
Will do in v2.

> 
> [...]
> 
>>   }
>>   
>> @@ -587,10 +618,17 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
>>   {
>>   	struct apple_nvme *anv = queue_to_apple_nvme(q);
>>   	struct nvme_completion *cqe = &q->cqes[idx];
>> -	__u16 command_id = READ_ONCE(cqe->command_id);
>>   	struct request *req;
>>   
>> -	apple_nvmmu_inval(q, command_id);
>> +	if (!anv->hw->has_lsq_nvmmu)
>> +		cqe->command_id--;
>> +
>> +	__u16 command_id = READ_ONCE(cqe->command_id);
>> +
>> +	if (anv->hw->has_lsq_nvmmu)
>> +		apple_nvmmu_inval(q, command_id);
>> +	else
>> +		command_id++;
> 
> This entire block here looks weird. First you decrease the command_id
> directly inside the shared memory structure, then you read it with
> READ_ONCE to a local variable only to increase it again. Why?
Thanks for spotting! Looks like this is merely an artifact of how the code
is hacked to work that slipped under my radar, so I will remove the useless
codes in v2.

> 
> 
> 
> Sven

Nick Chan

