Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0740756C
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044206; cv=none; b=fj4RKGPPE8ke9HoplbxCtMEqZTwGn+Edf9vJVgHp42JN7pFmp3zZSwTGieyXfeUjkHI6peN986BOXzLQLRGduWUbUtJTu02bdOO8/q8iRK46skhF+ZpvF9gjOegYd4OXGFdB9KNIXkWQwcaGEgD7BlBTxAIaZ6MoR1t4l3Bp20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044206; c=relaxed/simple;
	bh=N1+Ri8tyl8Kwm5BhyBgbC2qh62bga6Mp83akJRvVsJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4GHvH1TnB5dY2CxYZ8EcOGYD7eJXKyLI2M8/QUwlDenYxRXRzoCCKSghaA8HlQDR0Ge+RtIaQxok13vBWGwwvYDr/pv9eWF6/f7HbD+vI6/+pC6QNURUVeEMkNFLX11MpPdc3LbJ2aM01gBvOpraoKD+yAAnYq0U39wHlVsAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NX9bMY3z; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NX9bMY3z"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd80f56b27so627071785a.1
        for <iommu@lists.linux.dev>; Wed, 01 Apr 2026 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775044204; x=1775649004; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCRyd9qleOZMVIjgK7RhQpHFpKKn7hN1W8j3Towy8nQ=;
        b=NX9bMY3znk8AH0otuM+JYN/8tAUQEWYM4z6pWlbZ/JbKp7/jofQyzkZVDLP+ypYW7z
         TwKaJuYGLLoiExUFdNLJFwNo8iWTOqThmWOLrnpcZCIjimdIRZWmljtmqSt5s1Jh0Iz1
         tRhq6BZ5ENJ0uKaH5IW02YIpsDepaKAx34l8woVgVlCmefF0oW9Z6NAQGl+AolHRDu09
         sP9ZbD5fXrPE+mxgp8nsjBMLdHsILK6P6ENHvIOAP9RjLn5BYVA+xiJEGnq4ACQmEr34
         B+C2gNoZh8Cz/spmA33EcVtHFiJz9jXnNSfQXu6MZsbEUdCKOWFSsl1c1Zq2B6xK1vMf
         FmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775044204; x=1775649004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCRyd9qleOZMVIjgK7RhQpHFpKKn7hN1W8j3Towy8nQ=;
        b=S21E+mX+ipP4gHUj1kp1ewzxE+R/FN/3YETAiMO5pgQbCXWO7kjhNFWgYDPWBH+lGQ
         njO5BFZbnPolZWtjuIH4XOZhigKHGDRiFnU0qb8u0/vThf6bPtzloWKtGO37Zy25nsBf
         pWnvpIuWldRSYCkv1VW4caeuBE7ycede3n/tkjSR8zpqIBUSHomIIbmdBKN5cIDBnPyz
         +e2jbgTanlI/SDTzfQ88DpPdLGjZIZ8WAHD++OBtH/u1tGbNVH6FSX/vNq8RNvyW1KsN
         7oE3unJZfoCvXSGc11skXETl47bnvvc8SCan/x/PJLR93f1Z6gTqNqLk/dDQYPO+NpdJ
         jF5w==
X-Forwarded-Encrypted: i=1; AJvYcCX8fbPsTIqRWoy+X4x83Ax2U09dddcFeotT6baAGwaSs5xYkHU+1bXMU3tFHQ7y0nZfeT9W1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq3K2Uf321NgSbw9SoAwTH8WVbiDOaNppqSgzCpl/N3gDvqc8T
	WorimZlLJIwMmv3ZnQ7ZxFXpbx8XDSf3z1CeKqZf+QZiDXbjXzssgV5HaI3+K+kC5/0=
X-Gm-Gg: ATEYQzzAxO88qjFJ8Gau7VTL3dww+p+exmUKlrYfaYbqh8XTkBK8KE2MuIUiHua0wzr
	OpqmWrmYNgfZXCXGhKAYXXq+ASllHDwss0tE3Q5qQVpFUlB3sumbVEmSEsSvTsve2KGa6nF/ZdQ
	xs7WkLlGGNyIGUVZ5WD5dqvtf9J7TGJ7gKDvKKfyMDxsfkCFPSYGG776ZbYu5TD1EhY9y2pQUzr
	A+fa+7JvBsXKZNRG3CJilZDbvOMqGedy9jzk5makLfTpYTwhDftkb/44hiYIpl8mq2QMDO9aaFo
	cCEKnc4FGVRAgi7ZmkmbsvpZBhcP+dAYJprSTSXtfmnTKJteFcKyyMHe5dt+hX4RO0wh3nPw7tg
	wJIFVyBmVPbQVGvhv7l4fR9ScTlgPTEmwuQ9Ti4DqWIv54ZUzJSj3wHHmYmizu6kNSbLMcLbbSk
	sQzAFpoP1oM8VKTbrY/uWK+IiwEPlaaSo=
X-Received: by 2002:a05:620a:6910:b0:8cd:b90f:fc16 with SMTP id af79cd13be357-8d1b5c6bf23mr447046685a.68.1775044203818;
        Wed, 01 Apr 2026 04:50:03 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027db4770sm1309221285a.0.2026.04.01.04.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 04:50:03 -0700 (PDT)
Message-ID: <e011f298-cec4-4c6e-94e8-ce533642a3f8@linaro.org>
Date: Wed, 1 Apr 2026 14:49:54 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Juan Yescas <jyescas@google.com>, kernel-team@android.com
References: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <67b32e90-1f60-4bf5-b534-b4a901d5a796@linaro.org>
 <6c3b506e-8cc4-45ad-a801-326886c694c4@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <6c3b506e-8cc4-45ad-a801-326886c694c4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Robin,

Thanks a lot for the educative answers!
And sorry for the late reply, I got sidetracked.

On 3/23/26 10:49 PM, Robin Murphy wrote:
> On 23/03/2026 5:18 pm, Tudor Ambarus wrote:
>> Hi, Robin,
>>
>> On 2/28/25 5:46 PM, Robin Murphy wrote:
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index a3b45b84f42b..1cec7074367a 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -414,9 +414,21 @@ static int iommu_init_device(struct device *dev)
>>>       if (!dev_iommu_get(dev))
>>>           return -ENOMEM;
>>>       /*
>>> -     * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
>>> -     * instances with non-NULL fwnodes, and client devices should have been
>>> -     * identified with a fwspec by this point. Otherwise, we can currently
>>> +     * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
>>> +     * is buried in the bus dma_configure path. Properly unpicking that is
>>> +     * still a big job, so for now just invoke the whole thing. The device
>>> +     * already having a driver bound means dma_configure has already run and
>>> +     * either found no IOMMU to wait for, or we're in its replay call right
>>> +     * now, so either way there's no point calling it again.
>>> +     */
>>> +    if (!dev->driver && dev->bus->dma_configure) {
>>> +        mutex_unlock(&iommu_probe_device_lock);
>>> +        dev->bus->dma_configure(dev);
>>> +        mutex_lock(&iommu_probe_device_lock);
>>> +    }
>>
>> I was chasing the "something fishy" dev_WARN on a 6.19+ downstream
>> android kernel and while looking at the IOMMU code I couldn't help
>> myself and ask whether we shall prevent concurrent execution of
>> dma_configure().
>>
>> It seems to me that while the IOMMU subsystem is executing
>> dma_configure(), the deferred probe workqueue can concurrently pick up
>> the same device, enter really_probe(), set dev->driver, and execute
>> dma_configure(). Is it worth protecting against this?
> 
> Yes, it's certainly still possible to hit a false-positive if thread A in iommu_device_register()->bus_iommu_probe() races against thread B attempting to bind, simply because thread B can set dev->driver long before it gets to any point where ends up serialising on iommu_probe_device_lock again, so thread A can observe that even while it is doing the IOMMU probe in the "correct" context. Other than the warning though, it's still functionally OK even if the "wrong" thread does end up finishing the probe, at least after 0c8e9c148e29 ("iommu: Avoid introducing more races").

I confirm I have 0c8e9c148e29 ("iommu: Avoid introducing more races") in
my tree.

If the concurrent execution is functionally safe and the dev->driver
check is a known source of false positives during async probing, do you
think it would worth switching the dev_WARN to dev_info? I'm thinking
dev_WARN is a bit harsh, as it can disrupt CI pipelines that halt on
warnings.

>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index e61927b4d41f..5f0c1a8064b5 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -461,9 +461,19 @@ static int iommu_init_device(struct device *dev)
>>           * already having a driver bound means dma_configure has already run and
>>           * found no IOMMU to wait for, so there's no point calling it again.
>>           */
>> -       if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
>> +       if (!dev->iommu->fwspec && !READ_ONCE(dev->driver) &&
>> +           dev->bus->dma_configure) {
>>                  mutex_unlock(&iommu_probe_device_lock);
>> -               dev->bus->dma_configure(dev);
>> +
>> +               /*
>> +                * Serialize with really_probe(). Recheck dev->driver in case a
>> +                * driver bound while we were waiting for the lock.
>> +                */
>> +               device_lock(dev);
>> +               if (!dev->driver)
>> +                       dev->bus->dma_configure(dev);
>> +               device_unlock(dev);
> 
> Much as I can't wait to get rid of iommu_probe_device_lock, the main reason we still can't rely on device_lock() at the moment is not actually the remaining sketchy replay-dependers per the comment in __iommu_probe_device(), but more fundamentally that for most IOMMU drivers this will deadlock in that same iommu_device_register()->bus_iommu_probe() path, when the bus walk happens to stumble across the IOMMU device itself, which of course is already locked as it's still in the middle of its own driver bind. I couldn't see an easy, clean and reliable way to get around that, so that can got kicked down the road in order to get the "call of_xlate in the right order and make iommu_device_register() actually work" basics landed (and start shaking out all these other problems...)
> 

Thank you for the detailed explanation. Between the self-deadlock on
the IOMMU device itself, and the fact that a non-blocking
device_trylock() would be unsafe (as it could fail due to a simple sysfs
read, permanently orphaning the device from the bus walk), it's clear
there is no clean locking fix for this TOCTOU window right now.

Thanks,
ta
