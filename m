Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0B522F
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703887; cv=none; b=AykeQ7PrEBNjqRu4nUouqQUJYtmdqeqxYZ3nQ8cVpUxFVfnr0Mr89CPUoX5gmxuoDyZGXNfc4t+AB98u1d8F4jcj6y5wK7LdmYPOEzASUUwIHCvWgmU4A1cBbGSD3K3mHxqaAfLtJKofNlIIEAsHlrxubylanaXCTRVhkmNc8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703887; c=relaxed/simple;
	bh=mbWvNzOAlIydbE1Inz7ynKIk+hgmCs4Yk1OknKRyGN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvTNn2RJj2jL9Bvc6EkIloMtYByJZqCOF6Qlg+pyUpQfo9WBS4NiWoFPtsqqr147wgQZ48fBSwBAwsrD+M/Ey6HygP8jungqHwmZrl6O4Evt3p095Q0JMMjjyhVCFCbUrtHQxqi69EfCTW2+/QHWccpLq9YezWfVYDJWrfViolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFyfNFKT; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFyfNFKT"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso10975935e9.1
        for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740703884; x=1741308684; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYYhVBJMV/KkTWkQqY+F3s+lGTl4si7QLi3D5XzPjGg=;
        b=PFyfNFKTrGy/9Rm3hNAlDDc8z3dHJYiRjhvnZmqEYOGT4KAooXFxQ8wdrHnV6o5zTF
         79YfpuoRfg1lksF2p3PrFESHZ0fLk/w+lWNgPPh4Rsdgjge/0xeYfQjVF6IOpbLzsd3S
         URc4ExmGLNBGW1zB7tr6JJ7vUmPPMundd+7iKAuJaQJiFzjCoIx/UGFfNCxPrMGh7AcK
         L6/MNLN4+BUdgb65e1ofOoAd530FxL2gz6D/jLxR+ACfFJLivO+ZmoTkAEzpvBLLSEzU
         sLQ96xgSObUc6jhjlCDKW0nG5bJMVY+ioO19hXNF65OT7fmJgxlgEMRkNo3k8KsdiTUh
         nO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740703884; x=1741308684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYYhVBJMV/KkTWkQqY+F3s+lGTl4si7QLi3D5XzPjGg=;
        b=WFL6LbskSLdRMiWLB77Q68E85HPrSEMV43DuVhOlTpU/qkOsXedwhSiQjJpoDmvE3S
         94wsWO4E8AUTPo5plvCll896pGGxYPEClbSinhWRiL8vmKuuKQa1sbubP1bNpeJsvmpe
         MvK4GmNSUA+h/iyZyhz2lTY7fbXd3kAUP7/qzSJnD9i1w/KDwPgANHsHTKcTdEdDDQ9V
         EkO4E9Yjl+DcGU+vpnrmfmupMy3Igsj4DQ0Ohc5m3LaDm4cn4tXeBdIcjjA7zNqKa8RA
         7t/RSLuxWI0jiQW/bR4aQdbgEyZkB/mAEHJvigcU4jz5pvZymlf1/Vb+eEciAp/BTO53
         J0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVW4kB3RAdpgEbdVOZ4MZIOpYAVrXTMrPmOLbxDqhgyHiWxsn6OI42Hca7CIFLQtHf26W80HA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAvvbT56K6+s0yRPOad4H1D+CThJLDuAJTeX59BbTGVgUVOuFv
	BzinPKJ6O3yDBXT7OkrSfakgXXMvlKCB3LOCm++wGd8uL4C0quZe
X-Gm-Gg: ASbGncvh+uYsYQrFlsBhx1Q38cto48h1Tg4EknIoy6zhB+aPMQXTBJDH+kk/jH/XuLq
	LqWwJaYIMONDLRQXak8kM1QucbZ7UUScbrPjSCtPjFlXWHLwBTR56TZgILaw1zKuOx8MDSzJJG6
	EMlXFE4H6u1CBU68ULGRmerP37JGXleOos0pNS1vty0rwRtTXA0JNdM+Z0q1HfWLucNH6x9KgIW
	t4MWvrDx0ysZB3Bf0VPQppJEdJjG1JTnHxr3oFhTUPaf5g3oXotSAPx9lnJep77LfN0i61unKgw
	kNMslv0osgDmpvUIZXp8v6VwOVJAqG3riaiLpMY2yzD/LS4Ek6zX5asTCpK0CRYbdOm61rHgp3F
	31WvbC/C9h1TcdXOQYlIGwK7epFt2V9IzcLvmf+q6Ww==
X-Google-Smtp-Source: AGHT+IGEwAvaRf/47+Awx+9/XO+1Ue4pwdfkjzEFVpRwXK5AT2/emQX0Zv8uZLBVyVlvheJHe51FBA==
X-Received: by 2002:a05:600c:4ecf:b0:439:9a40:aa03 with SMTP id 5b1f17b1804b1-43ba66da2b9mr8992775e9.2.1740703884240;
        Thu, 27 Feb 2025 16:51:24 -0800 (PST)
Received: from [26.26.26.1] (ec2-63-176-201-248.eu-central-1.compute.amazonaws.com. [63.176.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm38100555e9.18.2025.02.27.16.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 16:51:23 -0800 (PST)
Message-ID: <7bafd132-6a82-4313-b25f-92fc16faf917@gmail.com>
Date: Fri, 28 Feb 2025 08:51:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 dwmw2@infradead.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
 <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
 <20250226130423.GF5011@ziepe.ca>
 <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>
 <20250227203855.GI5011@ziepe.ca>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250227203855.GI5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/28/2025 4:38 AM, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 08:40:31AM +0800, Ethan Zhao wrote:
>> On 2/26/2025 9:04 PM, Jason Gunthorpe wrote:
>>> On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
>>>>> Provided the system does not respond to those events when this function
>>>>> is called, it's fine to remove the lock.
>>>> I agree.
>>> I think it is running the destruction of the iommu far too late in the
>>> process. IMHO it should be done after all the drivers have been
>>> shutdown, before the CPUs go single threaded.
>> Hmm... so far it is fine, the iommu_shutdown only has a little work to
>> do, disable the translation, the PMR disabling is just backward compatible,
>> was deprecated already. if we move it to one position where all CPUs are
>> cycling, we don't know what kind of user-land tasks left there (i.e. reboot -f
>> case), it would be hard to full-fill the requirement of Intel VT-d, no ongoing
>> transaction there on hardware when issue the translation disabling command.
> There is no guarentee device dma is halted anyhow at this point either.

The -f option to reboot command, suggests data corruption possibility.although

the IOMMU strives not to cross the transaction boundaries of its address 
translation.

over all, we should make the reboot -f function works. not to hang 
there. meanwhile

it doesn't break anything else so far.

Thanks,

Ethan

>
> Jason
