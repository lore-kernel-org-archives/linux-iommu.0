Received: from mta0.migadu.com (out-151.mta0.migadu.com [91.218.175.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF63B9DB3
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630633; cv=none; b=sXAsFa6pbWcQijRY0JekBeg6euQ2OSwADx4a8oJCffJmyBOSz7lXoWfSftrBxPXCCZdFJKaQdUKJbFGmUGqNzlSuO3+Hc03x/w8KQAERW0Ks1j44ZETU+szLw7FdrcclScSIfhh1aQ08vVmvQhtjMEtPnhp2FD9U29Sk+b0owbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630633; c=relaxed/simple;
	bh=dkPUvENe6pwuHKh8NOpN8zeRylP+POd1HPtFXW+q2Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qo0idI+32THjMTWZlvML0TL8ix7T5hvjz7pB57gwmHpV8z12udwu9ckzSKlmcVNTNXPf3vILJRtbbhzydKVwxQiNPs0HROXs/c+gLovUCHFhCvHflAMIS3kflX5iJHBhZK6mpE6umwH+YOF4S/5dMT4NJjkY9uNO+QsyxMjHj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H2+XEqyR; arc=none smtp.client-ip=91.218.175.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H2+XEqyR"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dkPUvENe6pwuHKh8NOpN8zeRylP+POd1HPtFXW+q2Yg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786630628; v=1; x=1787235428;
 b=H2+XEqyRCJGh6lBZL1tYRDI6VbU4tMWsOBH/MJlYUqWLZEqt3nf0P08N+uTzxdupsbUsE00X
 ES06uj3WgwAIL0EzrlY1+Xyy0gBe9mXu/I6eiEUcDW+VuY1yecpmg2O64LRXXLYiC1kDxlDAv1o
 4TnVyycaFHw2nwx1jJdLtI14=
X-Envelope-To: iommu@lists.linux.dev
Received: from [IPV6:2a03:83e0:1126:4:9d:a05e:5bd8:c200] (2620:10d:c092:500::6:def8)
	by smtp.migadu.com with ESMTPS id eb43e0fae73920e0;
	Thu, 13 Aug 2026 14:17:08 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <76fc44c8-5924-4b9a-8897-320c9db91307@linux.dev>
Date: Thu, 13 Aug 2026 15:17:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on
 Family 0x19
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, bp@alien8.de,
 Joerg Roedel <joerg.roedel@amd.com>, samuelcrossley@gmail.com,
 "Srivastava, Dheeraj Kumar" <DheerajKumar.Srivastava@amd.com>
References: <20260813131833.2808948-1-usama.arif@linux.dev>
 <697be383-2de0-4c6b-91c1-9887d23ddc9b@amd.com>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <697be383-2de0-4c6b-91c1-9887d23ddc9b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/08/2026 14:58, Vasant Hegde wrote:
> Usama,
> 
> On 8/13/2026 6:48 PM, Usama Arif wrote:
>> [You don't often get email from usama.arif@linux.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On Mon, 20 Apr 2026 08:42:02 +0000 Vasant Hegde <vasant.hegde@amd.com> wrote:
>>
>>> This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
>>> Event log and PPR log buffer sizes to the maximum supported value (512K)
>>> on affected CPU families when SNP is enabled.
>>>
>>> Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
>>>   - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
>>>   - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
>>>
>>
>> Hi,
>>
>> This series seems to break kexec in our production on Milan hosts with SEV enabled.
>> This is on the 6.18.43 stable kernel backport.
> 
> Do you have dmesg?
> 


We don't get any logs after kexec. So the last logs are:

[  OK  ] Reached target shutdown.target - System Shutdown.                                                                                                                                                                                                                                                    
[  OK  ] Reached target final.target - Late Shutdown Services.                                                                                                                                                                                                                                                
[  OK  ] Finished systemd-kexec.service - Reboot via kexec.                                                                                                                                                                                                                                                   
[  OK  ] Reached target kexec.target - Reboot via kexec. 

And then nothing after.

>>
>> If on top of 6.18.43 release, we revert the 2 commits, i.e.
>> Revert "iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19"
>> Revert "iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19"
>>
>> kexec starts working again.
>>> Could you help in fixing this issue?
> 
> Sure. We will try to reproduce it internally and get back to you.
> 

Thanks!

> -Vasant
> 

