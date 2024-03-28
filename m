Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DAF18D
	for <iommu@lists.linux.dev>; Thu, 28 Mar 2024 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711584350; cv=none; b=P7VLiEudS9hexan+pA+1p9eMvZF9NSk/3bDGVjuN6HpspaIkEu6N2YVSLmpzWRSTEi8tTJ9aNbO+3FJDxQMMRhKe7RzIFJ63SX/Yl/BPRwqepbVRS8DQouje0ZHpTv19KiOyOYQAD5b9zHCx5UGVeZEbIpVtCv0EwZBw7VntdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711584350; c=relaxed/simple;
	bh=UTFyWoS2y5wH6iR9AcEHg/ju7M8hZpmsWIUw0geaDIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtoCDSVu84L9Z3hdPH+ure0q9hWTRRiOMl+knbTy0vP4EDFHD6w02y+WxGOXRD4OH70lqjyRfGev4UftkCp0r8UqCc697/qVk9fhWRfmUNMtvD1m8JgBrJ7aVmG69gHCrVnCgMmDUikpdgZb4zS9IXV+vSZ+7aO/sNfuzL2NUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BwNjx51I; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BwNjx51I"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3688f1b7848so612645ab.0
        for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 17:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711584348; x=1712189148; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCTMIq8WtfXbFIqQEZh1qfZYEzZdHCH9y3zHSAgcufU=;
        b=BwNjx51I4ZzBeuQiK6TIrBzagdzmEdWySJqA2a2vvVkp/8pgpClpRPspUnIkEH2p8e
         iqGKIYqS9pNa8W3vZG6T6MiHLR/aQW15Rha8TNPcONFZ3sx5Tp2Ard2sbkEtP6H9SOIs
         CgvGcLXflhIiAktBf+PCHp3DfR8xF3hy771IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711584348; x=1712189148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCTMIq8WtfXbFIqQEZh1qfZYEzZdHCH9y3zHSAgcufU=;
        b=C3gCuDFPc7qiorzVmcsG4zB6vFDuf5OCI7DVStF/ldh1tFcLebmBWqsuL0h40NQI++
         bkwSI3az7Dm9fz5RMs0I4G55PRBzQJsBevT1nj8PQH7PR3OVGTaNaHhiG5/R9EjBZSR1
         HL1rnvvYpFP/q4pTSVjPl6Tr+42Er325WxJ1hCVeqgFGG631kFOfVfsx2cu9edw2fiXp
         mRpqCH3I9RVoGyALk+oI3vhrvutCF5WDxd4AxccfpPo+xIDHMCR3Ig0VpDmttBST9KPf
         c0BEBAtFh90dfUBgG8Eh9xnZhIMg/pWK06lKwh4ihm4jWjMmJBl574eHre+uDTCoVUIC
         E6LA==
X-Forwarded-Encrypted: i=1; AJvYcCX4IuLFUBz4jVdfK7OByeZWqka6iOxw1dnoGeIcnu0fhZ0Cux636jgJtiRn4/kXdmZb0HRVmSdMZq1FqXZwzNqs73GcgtE=
X-Gm-Message-State: AOJu0YzbVjRcO122R8H0iiiigeca4Bbf6fhcknUQCumhvR58z1+zCU/N
	kh/oepl0JarHVm4HPxyjBUe4lUFTJFfyJ42s2U0uZoGvxXtnmQjG3oJHjlJra+M=
X-Google-Smtp-Source: AGHT+IFDM3R/PlIPv7Hx0hHfbsCS5Kf6sx6RMyDmHA0pdbH7D4okpLEyaqSJhoa1zGqNlJk0CdVgmA==
X-Received: by 2002:a92:c645:0:b0:368:80b8:36fa with SMTP id 5-20020a92c645000000b0036880b836famr1540423ill.2.1711584348147;
        Wed, 27 Mar 2024 17:05:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u17-20020a92da91000000b00368706996b8sm69730iln.38.2024.03.27.17.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 17:05:47 -0700 (PDT)
Message-ID: <24c54707-421f-4c5b-8a34-245328cad347@linuxfoundation.org>
Date: Wed, 27 Mar 2024 18:05:46 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after a
 failed assert()
To: Jason Gunthorpe <jgg@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Cc: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
 <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
 <20240325135207.GC6245@nvidia.com>
 <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
 <20240327114029.GC946323@nvidia.com>
 <ab5d2b61-2dd2-46d6-a106-a9aea69b0a1a@oracle.com>
 <20240327163832.GJ946323@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240327163832.GJ946323@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/24 10:38, Jason Gunthorpe wrote:
> On Wed, Mar 27, 2024 at 03:04:09PM +0000, Joao Martins wrote:
>> On 27/03/2024 11:40, Jason Gunthorpe wrote:
>>> On Wed, Mar 27, 2024 at 10:41:52AM +0000, Joao Martins wrote:
>>>> On 25/03/2024 13:52, Jason Gunthorpe wrote:
>>>>> On Mon, Mar 25, 2024 at 12:17:28PM +0000, Joao Martins wrote:
>>>>>>> However, I am not smart enough to figure out why ...
>>>>>>>
>>>>>>> Apparently, from the source, mmap() fails to allocate pages on the desired address:
>>>>>>>
>>>>>>>    1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>>>>    1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
>>>>>>> PROT_WRITE,
>>>>>>>    1748                    mmap_flags, -1, 0);
>>>>>>> → 1749         assert(vrc == self->buffer);
>>>>>>>    1750
>>>>>>>
>>>>>>> But I am not that deep into the source to figure our what was intended and what
>>>>>>> went
>>>>>>> wrong :-/
>>>>>>
>>>>>> I can SKIP() the test rather assert() in here if it helps. Though there are
>>>>>> other tests that fail if no hugetlb pages are reserved.
>>>>>>
>>>>>> But I am not sure if this is problem here as the initial bug email had an
>>>>>> enterily different set of failures? Maybe all you need is an assert() and it
>>>>>> gets into this state?
>>>>>
>>>>> I feel like there is something wrong with the kselftest framework,
>>>>> there should be some way to fail the setup/teardown operations without
>>>>> triggering an infinite loop :(
>>>>
>>>> I am now wondering if the problem is the fact that we have an assert() in the
>>>> middle of FIXTURE_{TEST,SETUP} whereby we should be having ASSERT_TRUE() (or any
>>>> other kselftest macro that). The expect/assert macros from kselftest() don't do
>>>> asserts and it looks like we are failing mid tests in the assert().
>>>
>>> Those ASSERT_TRUE cause infinite loops when used within the setup
>>> context, I removed them and switched to assert because of this - which
>>> did work OK in my testing at least.
>>
>> Strange because we make use of ASSERT* widely in our selftests fixture-setup.
>>
>> setup_sizes() is run before the tests so it can't use ASSERT macros for sure;
>> maybe that's what you refer?
> 
> No, it was definately ASSERT/etc if you hit those in the wrong spot
> the thing infinite loops. Maybe that was teardown only.
> 

By adding assert(), you are mixing frameworks and the overall
test behavior will not be consistent.

ASSERT_*() is supposed to exit the test right away. If this
isn't happening it needs to be debugged. There are several
tests that use this framework. Maybe you can refer to another
test for examples of how to use the framework.

thanks,
-- Shuah


