Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061D883F
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 05:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766466191; cv=none; b=q/gakyNtVwXgkG6wEwYZ744xxW/WoUZ+OtBDa1t2WXQ7Pyjl/Rq8EyHUai+1GwAJS4/F9nj69M4AI81O3e+BANDoDvuQ1/wENdAki+Pd+faWuJf/3lyg9dLfHFKMqF0+JJJLAqqFTZI5XfVWCknXCH7OuUxjyDCwGFx63sDOung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766466191; c=relaxed/simple;
	bh=3bGyVD9V4kdQ/2hmVX1tNTqF720SdxaMUiB5CbziAQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awJXrTEaTcRvhNj4a1ec6H4vnfGpDxfLo3M59GdYaAOrdRwBeReq0V2W4U0cTDRLi/ADf8+RNKg5ioa+K6TEYzUJQ4EGl4Tg/57GYaUfvn5YgcR7fiHX/Kj8kZJovbzaz/vBW2h0YOQgifBqBkmyPHFNsnMconoNQuP9xWAHJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from 172.38.31.119(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.fqufVW6_1766466176 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 13:02:57 +0800
Message-ID: <2ce9d8be-10b3-48dd-b99e-7358347fc171@bosc.ac.cn>
Date: Tue, 23 Dec 2025 13:02:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About RISC-V IOMMU PMU
Content-Language: en-US
To: Zong Li <zong.li@sifive.com>, Xu Lu <luxu.kernel@bytedance.com>
Cc: iommu@lists.linux.dev, Tomasz Jeznach <tjeznach@rivosinc.com>,
 joro@8bytes.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 anxu@bosc.ac.cn, wangran@bosc.ac.cn
References: <CAPYmKFt8bu48mi0awW7XWCiQvQqKf0VzcJbx5VR0VmcT0zYZ4Q@mail.gmail.com>
 <CANXhq0qeQmDP59J3_j4H1ei3CFqofx0m6vUcX1mL3Y+it6+FXQ@mail.gmail.com>
From: yaxing guo <guoyaxing@bosc.ac.cn>
In-Reply-To: <CANXhq0qeQmDP59J3_j4H1ei3CFqofx0m6vUcX1mL3Y+it6+FXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/12/10 15:12, Zong Li wrote:
> On Wed, Dec 10, 2025 at 11:23 AM Xu Lu <luxu.kernel@bytedance.com> wrote:
>>
>> Hi Yaxing and Zong Li,
>>
>> I noticed that Yaxing has sent a patch series about RISC-V IOMMU
>> PMU[1]. The same driver has an earlier patch series[2] from Zong Li. I
>> am wondering if Zong Li still plans to update his patch?
>>
>> [1] https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
>> [2] https://lore.kernel.org/all/20250115030306.29735-2-zong.li@sifive.com/
>>
>> Best regards,
>> Xu Lu
> 
> Hi Xu,
> Thanks for bringing us here. It seems to me that Yaxing’s
> implementation is similar to my previous version. I’m currently
> working on the next version to incorporate the feedback from my
> earlier series, and decouple the IOMMU perf driver from the IOMMU
> driver, and make it easier to add custom events. If Yaxing doesn’t
> mind, I’ll send it out later.
> 
> Hi Yaxing,
> Please let me know if it is ok for you. Thanks

Hi Zong Li,
Of course yes, absolutely — I wasn’t aware of your earlier submission.
Please go ahead with your version.

Best regards,
Yaxing Guo
