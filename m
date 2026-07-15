Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556403AA517
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784084102; cv=pass; b=SowL9mTMmRpc5T303jQrs3cZewNbk4y55l4VrtEjtCzWURy4kyPb8J6WjF6U+V2jWK2G/NeEl9R9P1altfjRzNCvNrVg1Sqhg28au/ZZhe/70DjinF9Me44OaHPksu/LTPBqNTlk3MR8EKDt7NiRb0uddyzCF1Q+I0ifYzHPXgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784084102; c=relaxed/simple;
	bh=6eBwj4et6Kll0SOF/dlQ0iXDfU2skh9D1bcyDgpLDWQ=;
	h=From:References:Mime-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPZFQulqI0jp7JiVkEuZ0H7XpVlNyckImWlh/2rC0q6vm5tbXeupLLwVIj5xlvQbgGSgmZN7/yA9ZfSiakG/Df1A3BLJ26yq/MPPUVmzjmmkGWD+kjbmpXtXrAXbKJ+MJ6ejdJADGB1rd+WchGHuCPVsXrBAYeSV8au5Myimzms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bR8COSmB; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bR8COSmB"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso4593807e87.3
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 19:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784084097; cv=none;
        d=google.com; s=arc-20260327;
        b=OEtO1vuVK/e/yA553F2Q1cqspobptKvylIXptDkh3VFNVvSGGNfvOFKhX51cAdUZIC
         Bf9l69nq2jOhf3eWIBiGPgFTg3puKfuIVXmCxBxj6rTy7cfRZD4sJXKtnI31qPvDiKbC
         4hXazU+767a1oZScMhiEyyGxTIMmwaeoztZhOt1nXDWXY/sMjz3Jxo3y85S6MYP5Ud6o
         IPWMDPELtIu2yUw30CjrF/vMaoM+fCJCM3a6r8lwR/zwgRZn5mf4u7n4HgIzoFjg9lw3
         C14yvaMBG/8VZWY3K5bZZqAdUNcE6HRNsPs3+JNUkXeTyqIuoUzk51n2aDk9ZJox0JP6
         FvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:user-agent:in-reply-to:mime-version
         :references:from:dkim-signature;
        bh=onc8LBGsosWpMb6oO+llEi3YzErTQezwilYi6725L7E=;
        fh=8m3h5EAwmf1ZW1CdT/SfXzwNZ0oEGdn1m18oKQYgL1Q=;
        b=KtBw0jdaVGkQcuT0odxiB18UCNP7nW7PtB99NESQALqblVnu/Qc87Rrx1rP48E6fN2
         r4Zm00FNMJxHWioOLndMZTXxsBxWzooBQbKjl/cW3CjVpipQyCCZ3S9ZPLSvdLcYlsMT
         cqHMi3jisrTu11kFAOHIxZ4NXefP4NkqvqTkONpiS43oLO5NKPt4qIaZcqgW41N81PRp
         hr/aOTUlEQWkU6G+CAC2zVWin59Bv283Ii53N7IO65jRNMUqIbXpPyHNZjw9Hu0KEOkC
         UqiAEhmdlivq9j84r6LNX4tZdAi9ph/ocOpbNv4zQwl5VfVY+eSENa5rkkPuv6oIGVEm
         QghQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784084097; x=1784688897; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:user-agent:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=onc8LBGsosWpMb6oO+llEi3YzErTQezwilYi6725L7E=;
        b=bR8COSmBOruMHvnU9PnmpKLQUjxiNPMWYXwvQWpPYbJFHZ+O2WQn/9kRSK8kYEshxJ
         RHpDNCraAVW3k0aNkb5Uf3LJV38/YnaIc27gM6F+UM4wIFqmMtEqZqeELaIqv5FtKPgx
         48UomxCQU29Nnxxc4R7KhB4yS6BjRzCBmmPoCN3c5J9i9fgcL279Cc8wcupTgcEeElXW
         1xf7+2Gi9abRjxeXeg7rAQYfU6rnAsKRwKLAZ4zHoCAYY3CAo0ZQU+a6iT29TXDYvC3o
         EganOf7EsnRo8wauVDJOAGxo1wWhGnmlmksBmzGv60o8gMMqjjrdZZjqI+Y7ckvnD4m/
         DyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784084097; x=1784688897;
        h=content-type:cc:to:subject:message-id:date:user-agent:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=onc8LBGsosWpMb6oO+llEi3YzErTQezwilYi6725L7E=;
        b=qBRP6sLdNecAyhCXePj9n2hMj8sSNsjOLTZgkIKqpLyO/mPxPfYK4Q9jC5Da3kd585
         ZiCTiPJZ5uBUt9d+CicKh50lf6fEGtpnQA3w9Ds558Hbc0Qr4uQR60MKf6cb+wclDFxo
         pzC7/cYvAnVLgDtj1GlEB7GmMrn4KK4fAl1vdAsQ23tShm87ZOQ5OfHR7W3kh5fl+XhL
         T5HvCRN7D++/MhS6JqDUDQVzt+PUE2dFCwhMzb4cNllo1hQYBegsOFKPS6biubSC5w9n
         mIRUgY0uyhTCSioIEa/eYwk0I9SmnzrihpIGGwtvU/pOSQ4lcnifxCPXPOBCGwUayaeh
         auCQ==
X-Forwarded-Encrypted: i=1; AHgh+RohlXXy9RsNfQ9Qxu68LvaUtdVey6w5MKhLg1TXehVeUkAyLZsvULC3hgSM1qL8u9ArIjOnRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBLmJOleen81qiFAW1Ejk/5TN4jnvxLlX9jpU5vqvFB8I7PmSc
	9aXPQpLD6fxfzBk6c8NwRhk9camhdt/6rdGmdnhfB8urNuZ/Mq54eYe9JceCXdeGLMQZzD4/vtY
	wyMGsYaT4czthr/PBBMD5BZIUaIZml92sBYPoH8UKkA==
X-Gm-Gg: AfdE7cmYGkvvEfxukErxPTEqMhsW/oWPoAjlUnw/0MfeiCTbpXgymL18fSad9neTeBS
	/YXJzkOAfnQ6U2pNdPETO2Tvue36zkXCIxHRccqt9zaqfswC3PSXiHDxoTruJFbQio1adCX+iPu
	K3GNptD1oi6Wq6xi37RdKXd9fTW5aoMxd0mw6HpPaKTIPq5V/mqsKoH0OG2RLUX1yrAujjTYNr2
	gCcvYpazuBjCpZeA/5VoW+4aRLd/I56LJqQby3g2HCTZ+40vquxOj6iTlyncT5CPBL3dMTf4yfb
	LuGm4Til
X-Received: by 2002:a05:6512:3f12:b0:5ae:b7d4:7ddb with SMTP id
 2adb3069b0e04-5b159b6fda3mr1064835e87.26.1784084097163; Tue, 14 Jul 2026
 19:54:57 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 15 Jul 2026 02:54:54 +0000
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 15 Jul 2026 02:54:54 +0000
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-2-zhangzhanpeng.jasper@bytedance.com> <20260714140336.GA3716926@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <20260714140336.GA3716926@ziepe.ca>
User-Agent: Mozilla Thunderbird
Date: Wed, 15 Jul 2026 02:54:54 +0000
X-Gm-Features: AUfX_mzaekcsCjyK9vwKSYgr-sn1iFmjDQZenkFE6MLRADlmaaPOOGhkJ3gRioM
Message-ID: <CACnXVncfth5=ctoS6YqY8n1u_8JvZb-BpVgdniRqqjzxgNzdXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] iommu: Add group lookup by ID
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com, 
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev, will@kernel.org, 
	robin.murphy@arm.com, fustini@kernel.org, pjw@kernel.org, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com, 
	james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net, shuah@kernel.org, 
	kevin.tian@intel.com, cuiyunhui@bytedance.com, yuanzhu@bytedance.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

On 7/14/26 10:03 PM, Jason Gunthorpe wrote:
> On Tue, Jul 14, 2026 at 09:06:51PM +0800, Zhanpeng Zhang wrote:
>> Add iommu_group_get_by_id() so callers can resolve an IOMMU group from
>> the numeric ID used in /sys/kernel/iommu_groups.
>>
>> An ID lookup must keep the group object alive without also keeping an
>> otherwise empty group active. Embed the devices kobject in struct
>> iommu_group so its address remains valid until the parent group is
>> released, and return a reference on the parent kobject to ID lookup
>> callers. Add iommu_group_put_by_id() to release that reference and
>> iommu_group_is_active() to detect when the devices kobject has become
>> inactive.
>>
>> Serialize lookup against group teardown with iommu_group_kset_mutex and
>> only return groups whose devices kobject still has a live reference.
>> This prevents a concurrent lookup from dereferencing a stale child
>> kobject while allowing external users to discard bindings to empty
>> groups.
>>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>>   drivers/iommu/iommu.c | 107 +++++++++++++++++++++++++++++++++++++-----
>>   include/linux/iommu.h |  17 +++++++
>>   2 files changed, 113 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index e8f13dcebbde..da269d10f6bf 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -40,6 +40,7 @@
>>   #include "iommu-priv.h"
>>
>>   static struct kset *iommu_group_kset;
>> +static DEFINE_MUTEX(iommu_group_kset_mutex);
>>   static DEFINE_IDA(iommu_group_ida);
>
> I think it would be better to change the ida to an xarray than to use
> a string search on a kset..
>
> Jason

Agreed. Using an XArray as both the ID allocator and the group lookup
table avoids the string-based kset lookup and the additional mutex.

I will refactor it in the next revision.

Thanks,
Zhanpeng
