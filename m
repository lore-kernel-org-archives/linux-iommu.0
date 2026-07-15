Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F763ABD83
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784084121; cv=pass; b=YQ+ZUCrRrm+vaPibTnYFKYVY//BhCqED0fYE3PLVZ+mG9f8IbhT8NCBMBxmj54ZPNa9OulsohNedejKyCM9zvc3MsFKgAsWb7Xri8rj0Yz7tmVvQd0laAj38hJ2nJts4gx9Jek9KbaTA10rtXUwsbVS6IlmnFsYFKQlP1CyuY4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784084121; c=relaxed/simple;
	bh=6eBwj4et6Kll0SOF/dlQ0iXDfU2skh9D1bcyDgpLDWQ=;
	h=Mime-Version:References:From:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPT11PTXRFe/hqosmz/Jt40/7k8lkgcGmpycbgGVjgBTZWz0ZtD1nDwB/Lb2dOlGVEYxgxk3fiA+LEcmZ85gCjbjF16kajBys1dM6XGJVA9LYD9y6JRw/AlGdOSEGsjX/fL+ts6wAMg4tQ4D6rmAnFJtmAdwMzR7XRic//6eSWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UU0vJ4yt; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UU0vJ4yt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so59633485ad.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 19:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784084119; cv=none;
        d=google.com; s=arc-20260327;
        b=M8MWc2gPMxX+1S3AEp9xCi5HFHWhXX0TvBJ61p89MXxbagXs4C2IFRFS26GRePnhNI
         bnwpKuo7rOYey84Cb+KpVsDv/pmVed27BplXTHCQZxBAsYc+f8rlmqqXZCVtrdpdPbij
         5pCK62jKVIHSO5ZhqDs8SvfYwLA6DyCiA1FGK8vdYUjrJb8wujttNKiQXB/yRtkd1dQY
         uBOaLFcOPkckcS7iQghk2SuKVZK57k9/x4ODCnXizAgKHwqIebSmxwipGwZa61JfAEi/
         Lip9elwEJlGfE+vdL8NbMKTpn1klMdljPX869ZTe1W7exEc8V8yF7NJJ9gFF90xqtRxN
         kidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:in-reply-to:from:references
         :user-agent:mime-version:dkim-signature;
        bh=onc8LBGsosWpMb6oO+llEi3YzErTQezwilYi6725L7E=;
        fh=WD/i7nBMI5MeYvxEeETRhmSRB3OVj7PXJHOlfCRhIuk=;
        b=Fcuj17CL5qZehsRfOjnODKBxWQD1hoVDpnSsqb68Mreks89pyck/qR7BBuucPQE4rp
         Nn2Wuo8pKUQDkjp8NMYbxCV8ZELSNcumphrrkyf3n/uxxFJC4WaARgiKARgIOPLRVkPW
         DPDa/cXHMWyx1TcIFisODWecI9B8fl5XV2ahlNY5d0hhLBXBwUH5tYjOtC9NciO8OwuG
         Uq3o+kcx27DC6LaihIqTkS3elZK1AI/ITP06+bUdMd/E5AiVlUN+s4EGLRth1xqLhe56
         mko5X7dxnz+u1yD+EknGYYZI5c6SQ5SwxQvjxoSxxlWwPKeHVkQOwLZ2bgvkP1yDfjye
         RucQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784084119; x=1784688919; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:from
         :references:user-agent:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onc8LBGsosWpMb6oO+llEi3YzErTQezwilYi6725L7E=;
        b=UU0vJ4ytSQV74RBuxJNdu/cYyZRKhjl76wtRe3cQVW+Z8gwZ51K5ynKrtFQsXGifUP
         3nKzQXh9VIzIpkDqp/+eYmJiGm+ZG4dOHPRzTy6S7m941yJi5DWQeSzNkRlM/Ycm84EH
         i8kUt/YGhVANcsb2UkKtDh7nyxQF4a6WyMF1ovQ3Yqb2ZdW6utq1F/GrUFhHWbekehtJ
         E3ZPXdwUB4upS5d5V1azBcN/AjaSsaa2ajXvfiCy2UEmwKVr3Nx2Ic8dBXhj+XHudpEW
         3PkYnpnlz81gwKGBRE7etGJ9oewXJA+39U7bG4/fBlvlnADyHtHBEn4Efll9r9kpXcaZ
         CZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784084119; x=1784688919;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:from
         :references:user-agent:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=onc8LBGsosWpMb6oO+llEi3YzErTQezwilYi6725L7E=;
        b=XTZIdGumbI2uw/AbS0X+DmCeT703MrLJUmI23X5S9f2cUh5SxO2SRNLoBXqZ4gv3Gp
         LGDywG9IYnPFb1H2hJuXavxTSROIqHTiVkUu4VJCtCM5KzzvTFxS78w6TzS9WmHQG33x
         pFk6yPG7r/Pupf+0/gV3/R42IBALh52cbwebGOjzon9Kx5F7fhKLlupgl88O7+txS7Tb
         pnNkaQjcwWi6fG5g9A72Tls9YwKWnWs9Qbe3dApXOYpK7ZAEfkn5DIee/DgVOXMtgW/R
         N8SEWD3fYmohDbIOYKUZKHsJ9wJ+yTA6spmi+slsCfGvIacYS8cDA4USixcsai3CC6eY
         FSOw==
X-Forwarded-Encrypted: i=1; AHgh+Rou2vXaVjEpz8BZVzJ/8nlqDkDED/KDq9tmIADezbBFO564VUIt6cG7iM5H3pKxuCtOEIumsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJDv6/MK8kqXCp2vbsYosV0WVHOJ0DnD9+9agfytUHlnK//DDJ
	Yi0+mgOMoOuZPB6W5owmqeqz5VTQF9dIUM4h3iuCuqIp55jkxciI8mzPGTonb+GgDIhfKh7Jf+6
	0UTiQTBzMkYHRX/jVbRkg/Yi8UMWlTxoAJXn9tYl7Og==
X-Gm-Gg: AfdE7cnHMuLOQImJx5MWysOS4PpOhu8nWKN6q6HHJx6rCE6lx/RoUoA+HkFWcpUuNvz
	eHtvGtjZ5L5Hoz7OSY+ATEyz5mSHLx48H1z103TPHDK0BpRLKg0Xsz+GdMCzQC5VRT7APEKaJge
	gS4zpptEvmdAojs7ue4f0KmASfMWtIS9VnIuj36KwtM2foq1hwSM2rFdk3re2TiYAzrcaQIKf7x
	LiE9bJ3l+i/t8QhXnPPIodEQHNYrVWl0d+dfiiOIviI2NSLrws0MjbeNbnhrUTXN9Xpdy4=
X-Received: by 2002:a17:902:f64d:b0:2ca:5d24:720b with SMTP id
 d9443c01a7336-2cee9b82e93mr60194075ad.39.1784084119427; Tue, 14 Jul 2026
 19:55:19 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 14 Jul 2026 21:55:16 -0500
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 14 Jul 2026 21:55:16 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-2-zhangzhanpeng.jasper@bytedance.com> <20260714140336.GA3716926@ziepe.ca>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <20260714140336.GA3716926@ziepe.ca>
Date: Tue, 14 Jul 2026 21:55:16 -0500
X-Gm-Features: AUfX_mwCsBOf_hgb5yUzS2yT7xbSqsn1sQG_-ZF1ldFSOzP_jx_ehBg3xh3TSj4
Message-ID: <CACnXVnc4T40uUJKViZH0dzp8=RBjgC08KG6Pjz8btjPJ+aiG8Q@mail.gmail.com>
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
