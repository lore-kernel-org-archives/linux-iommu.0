Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A2443E5E
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243511; cv=pass; b=dDxdnbSGr3CW640B2nMJpKieP4NQp29VvQnakhlLcAxGynr66RSZ0c5pqfNa1f2MXnXd3/iBI9mfeV3FtSKwaXhZCjDjkHBSVsdyJ+79H4PfeD4kfDegAbhUiM0WZJ4olsPQuMulMaXasFX+/MTmIk7dgzfnLfWbh/OPpHNYfpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243511; c=relaxed/simple;
	bh=iiELtgm1yAzuWo2qXQiNnvZmI2a28WotDb7qzo11MD8=;
	h=In-Reply-To:References:Mime-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bn0RU/JuGE9KE4o0UFIJavmwmkbudB5Zrkmom3im/WATWf4lbg51AcAULhfSzoQFWqQP1eWHs1Hw414hOOiHJYkqGHRsXSI6Q0JRLdhI6yZ85hOoRwBbYLkYSjTAZWGeIBmzHWQAy2QqZbhssjfXvxGqKRiaVlqhiED6fch39/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UF8ma5N0; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UF8ma5N0"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff17443dso19535901fa.1
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 02:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790243494; cv=none;
        d=google.com; s=arc-20260327;
        b=Y+SpHOeNj+OCzlgAMmtKkOR+P3E9xt40MunavWsHSKmi1RUsOly34SyCwQWe6oSE1t
         kxt4jI8pAPAqyq3FIzl4R//4Td1PhHuKmM4unkoc46NQgeOP/b6tua7wvkZlt09l6hhO
         FL49W0sVvL4JCt3Xr7YD3nNgb9DHuoMlv0Z0eT6qct/mtXfGUdxzawUIA+FYQJJGQ1he
         p+f313FeUUMvvFvXAPOwRf2OZG9oVriYxEC9n90XGL0FlEkGMu6G/8VCkn78Fl4tksbu
         Virfy38IY/k4uvnHI+ScheK9hOxFzDvxSbibJTmJ7RbuWwG3X1dG8wZI+vv713Njxct8
         7z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:user-agent:mime-version
         :references:in-reply-to:dkim-signature;
        bh=eisBXp/pRzcQ5EL8prBSUE7T1+X/ln778vZdJ9nZQMg=;
        fh=tnn1GfCwV71G/FSlzg6DWPsdva4hGp4ntRHuJ9tMJTo=;
        b=YiRQsVF1YX176yYf6b54QUd66J63o5wlvTKCvJHb2p3b4FTJVQMEIlzBp7twRiEKyH
         NXjrCrL5MVv/F0M770Xm8l4cCmFBDo6SW6bdUzvZjfeOuRD1G+rkfAndk0TEaXWsoBBd
         kRtQOA0XAeHRydDb6GfoR++SLJZn6PC2Hhl/D187go4MTKeobCL6bFs8qYG8+MdrqWgA
         uKdimCqBYtfhRfLy+J2cUEEsUEKRBPwk2ONEsCk4DIewCJRKYEnb/BjnP75NVfyJtqnX
         GokzF4jNrpMlSmbffqwHDZF4yu9kkRHarAYWWg3iJVhAnLWaVGKO/4YfTTmbMX+yPHrd
         j/PA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790243494; x=1790848294; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:user-agent
         :mime-version:references:in-reply-to:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eisBXp/pRzcQ5EL8prBSUE7T1+X/ln778vZdJ9nZQMg=;
        b=UF8ma5N09kMt7YEOU233CSlnLRT+DjP4KBhgEGxlMQS0LahI1SxaL57zVHb7pubOPf
         b4MOJqqSTSKGjzsAyoyzjJnZn9k3OqXOr6w3dQKQYuG6eZh0c8HWP/ACNDSrA2KG0cln
         0pXZ3niCPjLSixcdYbnX8Nza0f4K25zqCMyKAxbrMuq36KDAtWP4XTI10BA9qAyeoFHF
         o7Ti1mJ9B2/1x/VonYyNs44WvaikqyWpyRfzlQTFY4bnveXm1rVQZ9p2pkREZ+uGHAXK
         f2YL8Lw9un80n41C8n0LOrByXqX3YcBFnUNHaxBC1NWYSvq0yMgRU0LLhQ1kjZSUp9tb
         7pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243494; x=1790848294;
        h=content-type:cc:to:subject:message-id:date:from:user-agent
         :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eisBXp/pRzcQ5EL8prBSUE7T1+X/ln778vZdJ9nZQMg=;
        b=PrR7eDhaedJwtX6A7ZyPsc4LglcIkviQRw6cBwAtn+YQAYvLvLDJtZi5Ahr4xAJzKg
         DhdWXGOX4AVmP8woEAeEV3OY1MlRqH7EB/CRR6DloVtXdxmKeMQ4NvgqnIabsR4Enpqt
         okZ8Tz9c6nDbO5BUzoTxVhiyKzUMvR93IepCM6tLHv3IiRDWw/Z7KYzT3zE/vmBEhGr+
         IElW4fs0jnTN7TOF8hcBkv1zZ+ziG3l4FT9AQIRPLV4OtbN3QRGSEQ0iSPnPgP8A4JWP
         ZGcbuAisjuwquDFziFHNHkhC/SW9fnA9luAMUlhnVBMwd1qEiPUkiihJP/tshFSFoUvv
         VqcA==
X-Forwarded-Encrypted: i=1; AKwUvByaGidfH7N/HVl87R96mvTENbqQ4QiYfhoiEelPgUtCmIDHBLEmFSYYgdsAdgqbcsRPErD2OA==@lists.linux.dev
X-Gm-Message-State: AFuF++mEgtBKnFUeYHKo1/NBmGN/XLUT5+Wsh2Q7Ln3vvY/eAepMoYD2
	Veb5jHG4Wkg+wP771Q++nA3yJ3H0WnyyyWgh61XBNk2SVZgMPLm08UNb2V0JvXZQzANRX0bkjnA
	IfzeEOp2fWZIr0I7GyH2NtEy6z0Jj5yoIOTceWsHBMw==
X-Gm-Gg: AYBFou1B1T79tnYvP2Rw2lkSodSmBez9GX3URZy6aIarPWCUnRQhSSe4WP6dIUt68Qt
	bKBhfxMHWaGT+gUtotYBkfFSLNqA9zBzq1yk6aFyedoOBswZCixiLH43ND9UL4DCBgddm6SINfO
	LDFOXcNGcgVqkFrXEqkpxb6tKSVttJ/R6xdXLHWxk9xetQWRWKWPwfUCd0Vnre5lDWedED9DHV6
	F/9hk8zrRPeBc2AM6ah6vqY25IWgA5A7Wlapt/Uw4O6qf779+5zrjUt/vy8mi+O3g4dIUG7VfMp
	5mRi84E9DBO81Y3y4aTwTbQPidYBrHH5FI9tV85d2iW7nxAbQnnSrbQ=
X-Received: by 2002:a05:651c:b1e:b0:3a5:f041:d7c9 with SMTP id
 38308e7fff4ca-3a63c2fbe45mr4361511fa.22.1790243494487; Thu, 24 Sep 2026
 02:51:34 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 02:51:33 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 02:51:33 -0700
In-Reply-To: <arKx__kOPe4B5gDW@agluck-desk3>
References: <arKx__kOPe4B5gDW@agluck-desk3>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Date: Thu, 24 Sep 2026 02:51:33 -0700
X-Gm-Features: AclHuK8hLnUXrqZJavVwd1RFJSGYNAQLudfmbLvNFp-j_eu9SV3bDABt6ZKV-Fg
Message-ID: <CACnXVne=bK9sESdsFS6kbtYJuirqFoqTckuSjJuk0NYyByLM7Q@mail.gmail.com>
Subject: Re: Resctrl and I/O
To: "Luck, Tony" <tony.luck@intel.com>, alex@ghiti.fr, fustini@kernel.org, 
	aou@eecs.berkeley.edu, babu.moger@amd.com, baolin.wang@linux.alibaba.com, 
	ben.horgan@arm.com, corbet@lwn.net, cuiyunhui@bytedance.com, 
	Dave.Martin@arm.com, james.morse@arm.com, jgg@ziepe.ca, joro@8bytes.org, 
	kevin.tian@intel.com, palmer@dabbelt.com, pjw@kernel.org, 
	reinette.chatre@intel.com, robin.murphy@arm.com, shuah@kernel.org, 
	tomasz.jeznach@linux.dev, wangzhou1@hisilicon.com, will@kernel.org, 
	xiaqinxin@huawei.com, yuanzhu@bytedance.com, zengheng4@huawei.com
Cc: x86@kernel.org, iommu@lists.linux.dev, linuxarm@huawei.com, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

On 9/23/26 12:51 AM, Luck, Tony wrote:
> Patches for ARM[1] and RISC-V[2] are both at RFC status.
>
> They appear to be based on similar h/w capabilities where architecture
> specific tags can be added to transactions from I/O devices by the IOMMU
> servicing the device. Device enumeration is handled outside of the resctrl
> file system.
>
> ARM docs say "the device name is the one listed under /sys/kernel/iommu_groups/<id>/devices/"
>
> RISC-V says architecture specific device tokens are "devices or device groups"
>
> In both cases assignments are made with:
>
> 	# echo {device} > {group}/devices
>
> So now I'm looking at the capabilities of Intel RDT hardware. I'm ignoring
> the implementation on the Granite Rapids CPU, and looking at what is described
> in the RDT Architecture Specification[3]. Here are the highlights:
>
> 1) Enumeration is split between two ACPI tables. IRDT enumerates device groups
> and provides MMIO addresses to assign CLOSID/RMID to each group. ERDT provides
> MMIO addresses to read event counts for RMIDs and to configure cache allocation
> bit masks and memory bandwidth limits.
>
> 2) All I/O monitoring and control is with respect to I/O caches, not to the L3
> caches that legacy RDT features operate on.
>
> 3) The number of RMIDs supported for I/O is lower (maybe considearbly lower)
> than the number supported for CPU monitoring.
>
> 4) Monitoring events are I/O cache occupancy, total i/o bandwidth, and i/o miss
> bandwidth.
>
> 5) Current revision (1.4) of the specification doesn't include details of
> I/O memory bandwidth control (The "IBAD" subtable of ERDT is reserved for this).
>
>
> Fitting this into resctrl
> -------------------------
>
> RISC-V description of "architecture specific device tokens" sounds great.
> I'll have to find some ares of /sys to provide the mapping of tokens to
> "device groups". There's no association with IOMMUs, so this will be some
> other path in /sys. Perhaps under /sys/firmware/acpi since the data comes
> from ACPI IRDT table.
>
> Need an info file to tell users the format and source for device tokens.
>
> I'd like to avoid limiting resctrl monitoring of CPU activity due to the small
> number of I/O RMIDs. Perhaps don't include a "devices" file or mon_data/{i/o
> events} files in resctrl group directories when rdtgroup::mon::rmid >=
> num_io_rmids? But that feels clumsy.
>
> Domains are based on I/O L3 cache instances. So a new rdt_resource with
> new line in the schemata file for IOL3 cache masks per domain. In the
> future when there are I/O MBA controls, new line(s) for those too.

Thanks for the feedback and the detailed discussion.

I have been occupied with some other work recently and have not had
enough time to follow all the replies closely. I will catch up on the
discussion and take the feedback into account before posting the next
version of the RISC-V patchset.

Thanks again for all the comments and suggestions.

>
> -Tony
>
>
> [1] https://lore.kernel.org/linux-iommu/20260901140802.1215508-1-xiaqinxin@huawei.com/
> [2] https://lore.kernel.org/lkml/20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com/
> [3] Linked from the bottom of https://www.intel.com/sdm under "Related Specifications", or
> direct link: https://cdrdv2.intel.com/v1/dl/getContent/789566?erpm_id=1158389_ts1790091453223


Best regards,
Zhanpeng
