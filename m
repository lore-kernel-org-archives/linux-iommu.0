Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D3635A393
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 04:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786248795; cv=pass; b=rbrZSZr+PU5WeCNFtB9dv3IJn1ND5j14SHL5p4AEg0nIg6T5N4Sc4W67q2/prefnmPXUPjpuJ6N30tD8eSQGH/P5sNsF3FKlrmNkuOxaTba+YMh3nIAvQdyEo0lTvVr4wtjPQmbPydnR/81mCktCcNuZUB57j9et9+Ne4HSW17A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786248795; c=relaxed/simple;
	bh=HiIJYw6XAIdly7FznRJmSLwu3aQgjqn3SOYU1/J2UwM=;
	h=References:In-Reply-To:From:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz2wpB509ULOkPx3Jgl9ACbBnVhUXKd40NORqP8zv75pPmP6dgRQE/JqhIyQf+yEwiixiqoM9ezl+C9bN8V+Rgbnt+F4GDtqawisQqwlgCQLEcfZL7unmAQVtpK2MdlThvAvrl1bZS0ZpfCagvsoI5hhP35+PYpUQNWaJ/eq2l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j9n3zcNA; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j9n3zcNA"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b015b2d792so748348e87.3
        for <iommu@lists.linux.dev>; Sat, 08 Aug 2026 21:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786248791; cv=none;
        d=google.com; s=arc-20260327;
        b=Ow/0+FDmttxMNF/Up809o+w+dRJ/Nd8CYX7uVr3+7MllVYTxR+ME9ztfWdnlYyU2ad
         xtWxwHGc6ZyDl0goFezsDWPs4+ly7UK/3U4TIbTwY/5SvfsoxywHW1reVIOaHmmWwNFb
         7o0iVCfI1+rY6ADYSU5kCzVhAIz8JKeFzKoH+6QMsgoSQQ1XZFzGATzu2N81fPp9BM8o
         a0FykB+omiJVcWjiJRPJiQhQR1z5jcSwq1pEIP1kT6t+1EWtx+S/JH/JistXR1ggxWP7
         Vl148C0vEJDr+ALslPWGGo8y8JlW3Idq1by49yknWBbahRVzmtjz44kRw/PhRUqQSrqQ
         HBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:user-agent:from
         :in-reply-to:references:dkim-signature;
        bh=nj/GrLZHfLimxl3JVKkCgz72NOChgU4G7DTMfU1gKqQ=;
        fh=ksu0bnwKZxYT0Lb6Rijqy/4I8WBkRMV3k8MI/IaC4ss=;
        b=YxOWIxHxRUF36O7pJDuPda92iN+gUqVeuCD1GTDa11bA2f5A/Zotr9XUS9MtN/DqxT
         Qb9fZ3pIsq43RLZytywCEye2L8ru5fWKQ3uGYvbyNKhlSYKVAWzDhl5pyTr9Y+8owm25
         WXV5V7Ll/lHqN7nO/zj6nFh8N4/wekuBrDux7fX9WhRsPjrgumQUPHme82Sdt3joiVW6
         7B4ZRTJ62oQzfmQuAvfCBFZPpqi54kBFVxx6uRC981BMe0rI75VxkgDM893zRMp+sLKs
         BiT6f5RoPInXZb165z3FhSXizz/lXh8084c4Boh3Njz1zH1SwHInVVa+BLBZy+0x4SjZ
         mldA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786248791; x=1786853591; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:user-agent
         :from:in-reply-to:references:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nj/GrLZHfLimxl3JVKkCgz72NOChgU4G7DTMfU1gKqQ=;
        b=j9n3zcNAzbEvJryh1Dl2SRI8EZjiFTAMHzEizVbcCnjaeBSTAfU7lZWnrAxirP35fU
         Usm6DkOO0D4MjmipyLTsJUJtfhQCGQwK8aaxKaInvbcs961K9zoXguYXU3hZGJBhSN1X
         sVleXb+AVd66Bgl7OGVm1jEcC40J3ewxcE6uALnMhnJQh3gNHHGQtSvWJ5W0cijldArU
         VYKSKhVk5yv+l27VYsLvj5ljNME04pmZjQvI/05W4bWqiqg+NT4grOxXoW3jLSKHmTG/
         aY1yXJgoDtZLV6Bb5lyn5c+7r1qLOxVTKgtmPaJ+lleam3ULKyoCe/IX7H4g3IslpEzS
         oXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786248791; x=1786853591;
        h=content-type:cc:to:subject:message-id:date:mime-version:user-agent
         :from:in-reply-to:references:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nj/GrLZHfLimxl3JVKkCgz72NOChgU4G7DTMfU1gKqQ=;
        b=MRafWB5S63KKDyKKYDApGU6Vo6kdHAnBybtiZ9XrW68sAfJJS0/ZLQ8c7Rc84N7fND
         86QUDqnPN/k49Cj5GZjhn8Bp+miXg4BPBCsr3uT+aj7swQwGfTfh4LPJlJyBG5/wgML8
         +s6pkPri+uXy8B+/Hpow9ahr5zhvo9LUBZIr0T923RkeJ+0G+41b6z9UxWhBN3dMjhfx
         oZb11k2WIbqAyML/PGqCHqVg9MMVmt+ucfb3y4bBhJk1aSg09Z+xJM18rP4U5iE0r8/j
         HPJXiOg2nboeBc19iEb1KBlXeSMg3Ozqxtv4ondT9b61+QwbsbNZJq3xCBhtiyiol8Tr
         FhGw==
X-Forwarded-Encrypted: i=1; AHgh+RqE55c/Yu8Vf/69whARZpMxacnzMfCBtBbNgzyNTKY65MnEuwxWnCoB71YFr06ov9+G0d2sDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh3va3wyrTI9xdC/5xMyCGQmFO9Ja4x+nyS6BUXhC6Dml+Ur17
	EoV92BUgW7kcw0daAhTDi6fIYoy18pz5DW7H4he2kvA3JsrldF0U2ZEmccgno4eGQN+J3jddTEH
	wEp7tB8xtPUqD2gnF3Wp/Sdw8OlpZnu36vS6075RIqQ==
X-Gm-Gg: AR+sD11S13ZLtRPeHE8QhEHsfTudBQMIaIatNnF3yejQSI9m+6+k/OwDT6ktQ6YJW/M
	LAXRow/aAcD8NROngQOa8LAuxB5Gu+ENO9dFAjLS000ob4V9/9c4VXRKLgRM0Tu0VYmnGeNmfz7
	ia8MhRZvg4F51X9JPK35djmuFedsVXJI5KY9PWOJhXPRNkIfP/dvy2kYxonDmqx3D9z1ZT5Jn/0
	8E9mNDMQw0reOO7r5Usae9rkOagAcNL0TsFusCv7L9PYwNSdXMX+kaGAXXE/BszewgKlvs01zHu
	W3sXw0w/x0z6+iGRbWHD5vTxybnA0i/6p71LmAwrmg==
X-Received: by 2002:a05:6512:6d1:b0:5b3:e02:b3a3 with SMTP id
 2adb3069b0e04-5b30e02b519mr1049490e87.13.1786248790804; Sat, 08 Aug 2026
 21:13:10 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 8 Aug 2026 21:13:09 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 8 Aug 2026 21:13:09 -0700
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <anQaaQvpEXFTRYvS@x1> <7cf591e8-e182-447f-9808-d8e328d28f79@arm.com>
In-Reply-To: <7cf591e8-e182-447f-9808-d8e328d28f79@arm.com>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
User-Agent: Mozilla Thunderbird
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Date: Sat, 8 Aug 2026 21:13:09 -0700
X-Gm-Features: AUfX_mzzYgAHotFJmRr_abQhtL3f8Je1q-ux1TqnkbEk2HMTY_2mQymojNl5UmU
Message-ID: <CACnXVneKuebieFi4wNF7V2QmMXy-N379C--H0jtCg8Fzy-PMSg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/7] riscv: iommu: Add QoS ID support
 for resctrl device assignment
To: Ben Horgan <ben.horgan@arm.com>, Drew Fustini <fustini@kernel.org>
Cc: xiaqinxin@huawei.com, zengheng4@huawei.com, palmer@dabbelt.com, 
	tony.luck@intel.com, reinette.chatre@intel.com, tomasz.jeznach@linux.dev, 
	will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, 
	corbet@lwn.net, shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com, 
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Drew, Ben, and Qinxin,

On 8/6/26 4:42 PM, Ben Horgan wrote:
> Hi Drew,
>
> On 06/08/2026 06:23, Drew Fustini wrote:
>> On Tue, Jul 14, 2026 at 09:06:50PM +0800, Zhanpeng Zhang wrote:
>>> This RFC extends RISC-V CBQRI/resctrl support to external requesters
>>> behind a RISC-V IOMMU.
>> [..]
>>> Open questions for this RFC:
>>>
>>>    * whether a common resctrl "devices" file is the right ABI for
>>>      associating external requesters with a resource group;
>>
>> I think a separate file is the right approach to avoid confusing iommu
>> groups with pids.
>>
>> I should note that James Morse had an ARM MPAM "extras" tree [1] which
>> carried an iommu_group assignment interface, using the same
>> iommu_group:<id> format, but writing it to the tasks file. However, Ben
>> Horgan clarified back in March [2] in a reply to Qinxin Xia that it is
>> no longer maintained. Ben also wrote that the interface would likely
>> change upstream. I've added Ben Horgan and Qinxin Xia to the CC list so
>> hopefully they can chime in.
>
> I haven't thought about the interface much but Reinette let me know here [1], with good reasons,
> that we should consider the format of the tasks file fixed.
>
> Thanks,
>
> Ben
>
> [1] https://lore.kernel.org/all/f9b08563-4958-4f3c-ad6c-1e7fa3047896@intel.com/
>

Thanks for the useful links and context. I referred to the earlier Arm
MPAM IOMMU group assignment work in my test version as well.

Given that the tasks ABI should remain PID-only, a separate file for
IOMMU group assignment seems to be the reasonable direction.

>>
>> I plan to review the patches in this series further but I didn't want to
>> delay any further in pointing out the above.
>>
>> Thanks,
>> Drew
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot%2Bextras/v6.18-rc1
>> [2] https://lore.kernel.org/lkml/d13fdc75-b647-44f3-9657-d592353e8a1a@huawei.com/
>

Thanks,
Zhanpeng
