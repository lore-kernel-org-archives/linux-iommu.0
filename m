Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20927B32B
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191863; cv=none; b=gN6IwVe14kegvafvzwyyVatm20X8+Z4gpgFa0xyBOHfkgL3SlWkZHW4p2e3vJhtYsEvP8KdNp1qM8vFn1axrw1VrZZCurt6Q8qdLqOmFVWfh5A2MdQ7HGNMcBLBRmEEf7iz+zR5Q0KtFALYAvJxjdOtSJCIXHN+gC46vR1Kn+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191863; c=relaxed/simple;
	bh=z6+4XFmAM+9E9nMdkW7Ivutg05qfOcI/VIcnBRViQZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9sy8UaspGyJga5SSF4yMwk6gkQbYpuXUtNJwfezpmXqf7dszOlmnOTXMYVMwFTaDhA2dqSXzaIkn1aZWjsbSVNDMcSxsgL/2W3VMo3I3XmZlLSQmiuXgISdepJgYW2CCWVb+CiDiKteQj1cIZCBnnVQmR7L73mFIYzkyFNd/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kkhf1wnE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkhf1wnE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305914so2192263f8f.0
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 10:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769191860; x=1769796660; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0KMpHNofunhigiSe2e7em+jTqmhfyGJoueS1EQ8l48=;
        b=Kkhf1wnEIVKwGvZDJY0qtlsw+QwzwnBkBnkbKM7RyLwVw6v0hFmtdWMe5Oc162sEEv
         jD7RxeaeYKctbO/d2QoA9ZK8E6Qz/dRrqg5lRFJ6z/547vnFWecmLW4jBGCI6sEF56ie
         cn6J528RNEHtF1nB6nMl/I8MjHkGtBdAFqlMP+VYC60EGuMEADqkh8RtCb8JULHyKc2h
         ECVxvDr9UG6Zp+Z1YsuIz1hqlVUmyksNl9bIYWGT7B0y5ELdLNCfQ18HfLOts/bGXboJ
         1bASwYVn91oLuZ3KYBG1OVLmbuF7gxQoPtrJPUPjyXv19GuxP2iRsnaTRzYoD3vvg/93
         cX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769191860; x=1769796660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0KMpHNofunhigiSe2e7em+jTqmhfyGJoueS1EQ8l48=;
        b=eo1CHBSrrMDJZt+XbIyoEerPaeEMuuCkJdtGBRNOcf4z8gVCtUhvOzDx4m9zbwgXZj
         gQhKZJjXPdhiAR8WKih6JW2mWsxP8DXxeFqxQcozmp47lwqcQMLSfcXTIO99I8TYIlRo
         Lc7UcTz+SwYSaH8Wp3xBhp061n+EjCGi4OyTETTYGnSIR0Xj3MFMRtCwsUIkpw74MlCE
         F959Kulb3GbEV7bKXcQLpCxenXcdU2X6Q7N/+I7bw5hCsiWoiENmirYiJj27zv5oUTl8
         rQ0GIcTYib087hNsCTqglRwDQpR7kK0CBtTSwv+HTtlNzcdPmS0YHnOUyNdBft5gqVdK
         v+7w==
X-Forwarded-Encrypted: i=1; AJvYcCXnWgu+3ffeRlxmNLoqWWC0ysdBpjKLqX0kaYlpt1z7ufpk0Wgux31rAlZxjCoFDeLg4/VNRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX92xH1qOa91ZF81B7CyHK5TPLSKSGYqzUQ3d2DuzhwYE3sdOU
	Eqrt240rqbyvQ53wWh0uVfm3h3xWesaTrR9vtGz3/JvfFy3SVlPQubZj
X-Gm-Gg: AZuq6aL1g/V0xJAFQAL+pVfX5nuKVTBYzsAV/mvU8NKtNQ93zr7ufcCYeJsgLPKKKTS
	p75D/+gDCSDRvv5Bl5G4D2xR2KHVePPCZnrnyk4cJoCbHAFW8JujtTM3c0W2tVflnsSYDD8Zhgq
	yloL2k++0smW1Y8X5YnSA9txXpg6VktLg9xa+kdASEGJahXslaAUhl2v6Abo98uwCvxsl97fO6e
	g4r1zHy3j+vrFoJ4vq+XvgBadrHq5tNfKQVru2dBt3Zs/oEQTLEQ5IirRqaV6kd2NxkvFAtyNdo
	CNZnAEqZWzn5In3zAP+6F9fklxowad9Sq+hNhmW+Cl7uhfIVlLSeMUPWN0IZc1kIWGiV+pFlTly
	Y8ZZXDnKoikeXbbAoVE2m6+XAfP2qIiLz5PVtEPKJCLMrGyB+eKnsGque3/4G35qlAuxsTCb6KZ
	ROX94BuS3ZidfCvBT3d+cbGNWe3A==
X-Received: by 2002:a05:6000:200f:b0:435:ae10:cf84 with SMTP id ffacd0b85a97d-435b15887fcmr7722618f8f.5.1769191860167;
        Fri, 23 Jan 2026 10:11:00 -0800 (PST)
Received: from ?IPV6:2001:871:22a:cfb5::18a2? ([2001:871:22a:cfb5::18a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm8059422f8f.38.2026.01.23.10.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 10:10:59 -0800 (PST)
Message-ID: <ab9103dd-c1c6-473b-9dd7-87a3d5e203c9@gmail.com>
Date: Fri, 23 Jan 2026 19:10:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] qcom: iommu: nullpointer dereference on boot on
 apq8064
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
References: <569d7de2-cfcd-4d28-8bbf-14a0179f665e@gmail.com>
 <20260105180213.GG125261@ziepe.ca>
 <9a86120e-c0be-4ed5-a3de-cc7f164da154@arm.com>
 <5cab0953-c2a3-4baa-af91-e9519afef092@gmail.com>
 <da3fcb7f-4ac4-41c0-b3ad-055c6766fd5c@arm.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <da3fcb7f-4ac4-41c0-b3ad-055c6766fd5c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Robin

On 1/23/26 7:02 PM, Robin Murphy wrote:
> On 2026-01-15 7:02 pm, Christian Schrefl wrote:
>> Hi Robin,
>>
>> Sorry for taking so long until I got to trying it out.
>> The patch fixes the crash!
> 
> Bah, in the process of writing this up properly I've realised that although it fixes the crash, I think it breaks the multi-IOMMU functionality, as .add_device will only be called for the first IOMMU instance, whereas the current code is cheekily abusing .of_xlate to link the device to both instances. And in fact that implies the existing code is yet more buggy, as it seems it will leak and reallocate dev_iommu_priv the first time it looks up the second instance (whose ctx_list will be empty), thus it's only working at all because in all cases the DT happens to list all the IDs for one instance before all for the other, and both use an identical set of ID values. Oh dear...

Thanks for looking into this! I'm not familiar with the IOMMU subsystem so it would probably take me a long
time to figure out anything useful about this.

> Are you using the GPU and/or display device(s) enough to be able to tell whether their IOMMUs are working as expected?
No I currently only have a serial console, though at least the display used to work on earlier versions,
but maybe that's just a configuration issue. Its on my list to investigate when I've got the time for it.

Cheers,
Christian

