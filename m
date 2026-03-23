Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C73BED2A
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284406; cv=none; b=uLk7vdiPlT/Y3G1pFYykMDTyJpnFLtPMsOZIwg45fS+NAl55mcWyl7QOQ1oY2uk6jVr4SxOQ9JwadAEKjxgbRcF4KZUPeyh0yHBL+n9ec5Cuc65TImnOCIMFRoKoiw9BGJzzGDIJAqxhxu3ofWiX6Z9Jo62I4QGGiiOb8pByAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284406; c=relaxed/simple;
	bh=uT6u28q8xN+HvfAicCvlLrLPXdRQ7Bx/s17nGsTFrHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bappkS+Eu5rsQI+xDgDa3hkQjzTBGRW+VyBDn+q8NDkgJx7PjZmwS2duMeZ65mtuLFrcdVT3oUErJeNQmO7CoMdpVieXKaxM9rMn33FbKrp1OQt7wyU6K0eGtgiKhGwhxVjQBV06ZW7Dn6Ee8lBZ65ahTEUBLVD+b/Ba02B0U7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aQ1ufSgV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQ1ufSgV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso36812195e9.3
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774284403; x=1774889203; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMPSjiU3n/bDrZwK2WBMoUe3M4rFzhZbrCZl3W9hGNA=;
        b=aQ1ufSgVyGLwo8GYcoKz4w5NZMqRcQiXN0ibHaP71/O/TtYZqMiWVVrjCJ8LPCjn61
         fSX8ym98zijGRbqwzJRLJyAhiG3KFTetOWyD50PhRGabIZMW7ue9fX8/b3CGOIbNdrnY
         PDP443sX80WxCvPdr9A26P0LrGXpIURQavzCXjyQEEQg2xgZcL6Ud6b/52w8+ANCcWfl
         RkWXjS2zjBcdJukqRkcMwY159C08pHJeEuDm1S+N2Yxyyphdc/otTxrMX4MOXLyZ4Lsg
         feN58oiLX0bBfOrsSUVK1kQSY9jBQC6FOlknDO9xWZNd7+vnrAl2jkCr7lGeIPhyb3k1
         W3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284403; x=1774889203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMPSjiU3n/bDrZwK2WBMoUe3M4rFzhZbrCZl3W9hGNA=;
        b=qVUaIcUXx25yYJC4wY0vqojyQhMNngv6wWEO0xga18BxNmV2jbO19G/i5zk09F6h8n
         2G+Vo1cuU3IrkjieJFWQLfv96QKRE8wM8/gv9nnM5r63+udLQwfzWRx+yElUA74op4PZ
         Vz3yDIwZNk8u2HrbEhCoMA5edtXpirM8RNavk+E7lsdLVxog7xy2zBJlgRFpjfBTWLza
         mdLMcYZcvJJ7o9muO5UOzVddt1IWavQsHKk+K1gd4VrFFrT8XFdDfFlf5aSX3s/yEfRd
         T8brrqPVn7xlybkPUJibqXmgu0Oz7/Sctqo3JKs6rPUDvOlP7RwJJkedHnFHofvikQL9
         M0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDFYbi3qsWmnHXs+hEjkpQp+99LKFPVo1lGMJfiQgwqIkld75Zo4huPAzPsPBeKnL4wzCJFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxggqfzK8zEIp/M6RxYjWfW+1sVbcTESi4ew08c/kmheQCN1PcI
	ClFM4Z/PqyC9jICD5jxJ029P08rtaPmw2EPMLzNL2I5ob2+a1vfYMB0aqYrRUV9yyy0=
X-Gm-Gg: ATEYQzx4LBSZLdTD6l54sqplooINn0NNVd9lz3ub+D8MYEOw0atkxtOXWIZy97l0KX8
	DhN4GaiP/iaJuvxH0mzkG4+MCvI0eOlpEiiVOxsV3YNmnh7MyyYJLBisTjNrEvcFpi/6p8HMgyD
	uVC1DkddcDrvMVz9mlDacMiMbNAzs/NfmQdqUtV6wlTv65OUFwKVPdX827OYjwJOp1b4ay8R3sn
	KUiLFFZaKh5XU/LCKav74XunlqY321e9d46MIZlmENjTnjsBVGxFdkNa59DSe0ZuBq70ETfXPaJ
	hcGVaCoCZydUdj4xQV3L0LwPkw6a3IUq28XetYHyFRQZuagD1E/UHgmMIy/OWALy3aP/HbU4EvS
	WKQ/Y3QltFtaUwfdU6MgJ6j6ZMk4DS2C1C7iPaT4WNbJu5a+1vV2jPacPvX0jZa0r3tiASXnb2G
	DmWCxto8vV/0vGe9p4zq7ksYqLGdbQCbE=
X-Received: by 2002:a05:600c:3b1e:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-486fee1ab10mr180454805e9.24.1774284403113;
        Mon, 23 Mar 2026 09:46:43 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm600421655e9.9.2026.03.23.09.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 09:46:42 -0700 (PDT)
Message-ID: <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
Date: Mon, 23 Mar 2026 18:46:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, jyescas@google.com,
 kernel-team@android.com, stable@vger.kernel.org
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
 <20260323135414.GA8437@ziepe.ca>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260323135414.GA8437@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jason,

On 3/23/26 3:54 PM, Jason Gunthorpe wrote:
> On Mon, Mar 23, 2026 at 01:09:27PM +0000, Tudor Ambarus wrote:
>> Commit da33e87bd2bf ("iommu: Handle yet another race around
>> registration") introduced a readiness check in `iommu_fwspec_init()` to
>> prevent client drivers from configuring their IOMMUs before
>> `bus_iommu_probe()` has completed.
>>
>> To optimize the replay path, the readiness check was conditionally
>> gated behind `!dev->iommu`:
>>     if (!dev->iommu && !READ_ONCE(iommu->ready))
>>         return -EPROBE_DEFER;
>>
>> However, this assumption breaks down for devices that map to multiple
>> IOMMU instances.
> 
> ?? We don't directly support "multiple IOMMU instances". There is only
> one dev->iommu.
> 
> AFAIK if some drivers need to support multiple different instances of
> the same IOMMU driver they must deal with this fully internally and
> present to the core a "single instance" view.

Thanks for the quick answer. I may miss a few things, I should have
marked this as an RFC. Would you please help me understand a little bit
more on this topic?

Downstream we have a display controller that's using:
	iommus = <&sysmmu_19840000>, <&sysmmu_19c40000>;

These are 2 distinct platform devices, they probe independently, they
each call iommu_device_register() independently.

If I understood you correctly, the downstream driver shall model its
architecture and call iommu_device_register() only once after both
devices are configured.

My downstream reality is different. Here's what I'm encountering:
1/ sysmmu_19840000: dev->iommu is NULL. iommu_fwspec_init() correctly
   evaluates !READ_ONCE(sysmmu_19840000->ready). Assuming it is ready,
   it allocates dev->iommu.

2/ dev->iommu is now NOT NULL. iommu_fwspec_init() is called for the
   second physical instance.

3/ Because of the !dev->iommu gate, the evaluation of
   !READ_ONCE(sysmmu_19c40000->ready) is short-circuited and skipped
   entirely.

But sysmmu_19c40000 is not ready, its specific bus_iommu_probe() is
executing asynchronously on another CPU.

If the core's intent is to strictly enforce a single IOMMU instance,
shouldn't iommu_fwspec_init() be checking
	fwspec->iommu_fwnode == iommu_fwnode
instead of matching the ops? Because the core currently matches on
ops, it permits aggregating multiple physical instances with the
same ops into one fwspec.

Thanks a ton!
ta

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2940,7 +2940,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 		return -EPROBE_DEFER;
 
 	if (fwspec)
-		return iommu->ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
+		return fwspec->iommu_fwnode == iommu_fwnode ? 0 : -EINVAL;
 
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
