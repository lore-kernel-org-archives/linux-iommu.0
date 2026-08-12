Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5437FF75
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 02:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502553; cv=pass; b=idAoh0f1qPGjCcI6xRK8R/28yanXuW1iPmmSlM8QyvV+PmOurjMY+aWWbhyOVti4a3jFqE2Nh4K0nhkE2nj3rwb4chujmkrXgQtwYijVwg40QJOh5WeEQ6gD7W3ZGL7F2LWWJDVWJN5+r5P7nPuIMNG6xn7MdvSg88g/MwJshJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502553; c=relaxed/simple;
	bh=g/2afXd1QhsDNXpLtYrqK3LVQpstqIRtF29BH045doo=;
	h=References:Mime-Version:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INkPObWI5BFBDd2UUCC3RH68zPT7+SRyPzEnoeSO1bS9c2//sqKyKuyH20aSGl/wZsXNXskBldCCKbPo32aKwRBBOL40FfFT5fNSh1Drh/CHo49CR2f7+k/RWtKeRDQs79d1fKVDaCpXMbFF/XKj+1kET/swmi1KIJR3FV5O8ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G1ZVTmxK; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G1ZVTmxK"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b01146b205so385578e87.2
        for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 19:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786502550; cv=none;
        d=google.com; s=arc-20260327;
        b=YIvjKs50CxuYUDX7EAri6E3xVPQ4Eau8a1q4hFRVUrEAPenjpZhfntbeGaE4OcnglV
         leqYFdkP7Mv+lcTDUegxRtWYnY9ysyEECW69jCHi1Q+hxWf15RRxBS/AaciN89QIGV7M
         Ql7TsDpDU+rMvUmROsQLPSv1whVdNs9n0gfkmS53SIbib4eukOLV+Ds9LINy25sy9+NS
         QJQ9ayB/69NMXQxXxXroeRm8mLsRqF0vhp8kQOnWw0cAV1t2et6JhCDxrp3E7PMqYvv5
         WbGvSpe2VxAsYdmAr68NC4AfcpZiEeT/k/JnCuvTjn2qpjlzqahMhR3BkYhJMkj6QUGt
         xGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:user-agent
         :mime-version:references:dkim-signature;
        bh=MA8pf91t4FXFQxQ756OvBfWNusYinHNGZmr60DLI1ig=;
        fh=jeKTyn2EZIoleCYf4OBj7x6alYNVlWTg5S66LMkdRh8=;
        b=lCqeVp+2Vm/OaURcJqUARqsocpGeArouVfdpt0qwTtMZnVEPYAA29pSYZTC/u2uihz
         GpV+gtupWJ3ad9QSbdOMXjS+HhGvm9vpx+jSWSk+rgHsVW+N9SvW7szVGIEeAQcCEofP
         rQqxInU8mtRsTtG1mUYklsKVGmXXKWo6/f+SB2NQinNc5oM4UrJaGlukLkyMfoObFwKd
         rv91iNNpgilfL3I3D1GYPHScvCGAAgmt2gevkSmb5kFAQV1VDLdwoxzop0VHTxMls72I
         0BnLB30yY3bPP7Njn2x28jIoz50P9pqtGkvERQQ++jT5eJeymP9BuRUUDoAgCw30zQC8
         +jaA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786502550; x=1787107350; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :user-agent:mime-version:references:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MA8pf91t4FXFQxQ756OvBfWNusYinHNGZmr60DLI1ig=;
        b=G1ZVTmxKuMShqbJ4Z2RSbvoMOYRTc2QRLIl9JhmxeqnG2m8C2JU6qJGumjcZocDfSt
         /MpsRuEepg0JhU/GQ5bl8kji7PhmpW0EcC0t3aJmaYQJGXuEJBTaC9QuzYUTeXk5QLv7
         y4iAcdrZT3sHerQVsXbjqXMo0g4ha0K8E1dym4UHRVrqzyG3ZuEgtLjzEVHY9LERoAoN
         g6xlVifKaEio/D9aU+jmnKhepvgZKqzaWbtDu3km2xJfApf4IGh8gIui9IfsarC71r9k
         FfxqAHur59kB7kKXcJ97JyXhuOkzjcrbMgxPzyj9F4L7ULUZztTg4wx7SMO71KtVC1bz
         5K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786502550; x=1787107350;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :user-agent:mime-version:references:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MA8pf91t4FXFQxQ756OvBfWNusYinHNGZmr60DLI1ig=;
        b=pb6NvhoyiGGg6jNoapVu3VjNXHDGvSZTZfziQulQig8i2MyWJw9RvYA/T0F0iimVVU
         dmgY6awB1OH8aY8EbPmQnu8nBsgXYSkTmLrPI8u/mjkt+VUSAwCD/gqH1IYYvYWbcq9s
         +Md4vGh8gxOlQwpx0Af40eXG2wL36BegpUhhYHAEWpkkSqngDZCdO8jgEHclWVoNl+W+
         cZ1bdcmT96fU/ikfoBdJ361LkACeI9eRcvgzaI8aOl63pRsZX2GFGM+uXGZFp3uMWZA2
         RyCjMNhSz1UJIKRzxP5xoall+BczMztCD1KUXNVmcX6KyponST399rMm9i+JGAxci1Gm
         hVVg==
X-Forwarded-Encrypted: i=1; AHgh+RqG3mMqTIXO03Bl0kxqHkXjdalpl89bbJc6N6WxdKX1IU5botfar8cdi9mCo92Ly2/39sAa/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6rNRxi/IB8nzjSoYad2WEoBFg+43jnfL2r+y4YT3q1kXzG27V
	jK4y5g0pjl74s/BWO651bHJ356C8onh6uDlgLOKsBBDE1hEnPOAhJ7NejNAJl75TzEXd8oCZNBv
	xUmrgUYWVOLcK02Ke0gEXmNR5yQLb5C7GytC3MgBKow==
X-Gm-Gg: AR+sD10q78QHDsiVFajFLKk2mhAwAs58Nctk4IPbCg4ZpEigHRSrk3B4gvBRTh+6yDT
	n5iJFikVM1ORxcpR8POk+js0XxKHyh8DgwE5V3UZLrhyTFAOb1pwSapQW15oeeC3vM9y/zoN9g2
	f5lVBGez1bbNNeS8jpJHIIZzo/6hbiWOfqICHOFm2Hfp2aQYs2wB/KtCzWIbc3hKUwKOMljvx3r
	R+p4esUlh3TclsbVaL0TDWjr9UWG62Q0GIPsvQ3ChPA6EvfrAv9hgogxFR89nfr1aO0WaEtrNQp
	mJ69Z05APVZtTQunG2gFEPThPxi2R2Ue94saqUBvOgz4aA==
X-Received: by 2002:ac2:4c52:0:b0:5ae:b88f:311e with SMTP id
 2adb3069b0e04-5b44e2d9076mr214876e87.15.1786502549982; Tue, 11 Aug 2026
 19:42:29 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 19:42:29 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 19:42:29 -0700
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-6-zhangzhanpeng.jasper@bytedance.com> <anuSdFS4Enajdqff@x1>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <anuSdFS4Enajdqff@x1>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Date: Tue, 11 Aug 2026 19:42:29 -0700
X-Gm-Features: AUfX_mxVuesSQBbvklGRHcVkXo5XtC5KWv0jTTFlxpw_NNWMsenVNQ5v5yGezCg
Message-ID: <CACnXVncPrZms8PMJYbK58PEqR_mFzNxG=6CsziQCi8QCyr4eHg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] iommu/riscv: Expose global QoS IDs in sysfs
To: Drew Fustini <fustini@kernel.org>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com, 
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net, 
	shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com, cuiyunhui@bytedance.com, 
	yuanzhu@bytedance.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Drew,

On 8/12/26 5:21 AM, Drew Fustini wrote:
> On Tue, Jul 14, 2026 at 09:06:55PM +0800, Zhanpeng Zhang wrote:
>> The RISC-V IOMMU QoS extension provides iommu_qosid as a per-IOMMU
>> global default tag. It is used for IOMMU-originated DDT, CQ, FQ, PQ, and
>> MSI accesses, and for device-originated requests when DDTP is in BARE
>> mode.
>>
>> Initialize iommu_qosid to RCID 0 and MCID 0 when the hardware advertises
>> QOSID support. Preserve reserved and WPRI bits with read-modify-write,
>> and use register readback to reject values which the WARL fields do not
>> retain.
>>
>> Add a qosid attribute to the RISC-V IOMMU class device. Reading returns
>> the current RCID and MCID values. Writing the documented
>> 'rcid=<rcid> mcid=<mcid>' form updates both fields while preserving the
>> other register bits.
>>
>> Keep this interface separate from resctrl group QoS. The sysfs attribute
>> controls the IOMMU-wide default, while resctrl device assignment programs
>> per-device DC.ta in translated modes.
>>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>>   .../ABI/testing/sysfs-class-iommu-riscv-iommu |  27 +++
>>   MAINTAINERS                                   |  10 ++
>>   drivers/iommu/riscv/iommu.c                   | 159 +++++++++++++++++-
>>   drivers/iommu/riscv/iommu.h                   |   9 +-
>>   4 files changed, 202 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
> [..]
>> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
>> index 2c57625637bf..13ea67b7e42d 100644
>> --- a/drivers/iommu/riscv/iommu.h
>> +++ b/drivers/iommu/riscv/iommu.h
>> @@ -12,8 +12,12 @@
>>   #define _RISCV_IOMMU_H_
>>
>>   #include <linux/iommu.h>
>> -#include <linux/types.h>
>>   #include <linux/iopoll.h>
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>> +#ifdef CONFIG_RISCV_IOMMU_32BIT
>> +#include <linux/spinlock.h>
>> +#endif
>
> RISCV_IOMMU_32BIT does not seem to exist upstream and these lines
> to just be deleted later in patch 6.
>
>
> Drew

Oops. These lines are leftovers from downstream code. I'll fix that.

Thanks,
Zhanpeng
