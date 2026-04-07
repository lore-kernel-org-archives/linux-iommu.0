Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8952ED141
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553924; cv=none; b=NKKOjIS5MRbDIuZ1cSGrMvQB5oVrPUhV8MTAm1icMIm37mtSKRa+2lyQPVhzDHdOlGeJWNjFxJc+6ApQXSS12j00SAk2LgYwx5G/miKmFDHbDamDUKEp76Ryf8K5Hkw7ijvSMIDfhlhlfBm9O+BoznHUFaxHzCoJcmDzAxWh3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553924; c=relaxed/simple;
	bh=EL1uS51GqLRXczIb69xOmfNqtX6Z7UkZCrcbE2W7W8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRQArHJU/eKGOBhT3td0HE6RF/3CnYrfu7rhkSdrXj0DywbzWTvAwyF7YqpOFItC0m3Pq0jp9FoG02xnv/jlp2rwGn7k4aTEnodpV57Nvd4oy9+aofa/IXG6KpylHpDD7hfimBlp9FFj7ANBavLCDp9wnFzsrQifPlB96/39ulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=L+7DH+2G; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="L+7DH+2G"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so4221171f8f.0
        for <iommu@lists.linux.dev>; Tue, 07 Apr 2026 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775553918; x=1776158718; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ChD0onF1gDOUOLYFpD7x1c0kz7T4QILlyJ39777mmvM=;
        b=L+7DH+2GOqf9BABK5stnc9ZS1cCmT9bWN1BUtkaAPrgV6Fkghm6LvFGacj+DbwAuBI
         zjfrzmJOywwdsy79BqoAsRj8MjlDQfWPcOURPpuDQ13YcJtFVGR8IX/aA2lcIGIOGoT7
         abv6qlbjGzZ+NKYq6Jlh7DHpdGJsXR19g4EeUV2HhyEujXpEo+ARmMwwjh6XVapyfNyF
         nLy+AGy1hcmQpthvTKAQYbaUOLXBVVkbJu4h5LtM33vie30hfDOa7zmWoqOREcgLlty0
         h91yCZ5QaauxDnh+FsqdwKAZdxP2e/mNs6UWMoKEqpXw2DDm02los6MqX9X+o9LA5I3c
         drFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553918; x=1776158718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChD0onF1gDOUOLYFpD7x1c0kz7T4QILlyJ39777mmvM=;
        b=sXP0YBvkUDEqGeB8uXz1kUp7BfhhtdZg6ZmK3Lr4sojtl+fCGufHSPUqY/NSOG2+TO
         a9FzkFSsP5xJ0mYVRhMiLBCx9Yu/g2zCmHvTBYrq4T/2mHTa7GgZl9DjTeE5Bje37rrr
         aADDY44qW4u/ebDcyz47TkAScrAFC46RJCyxRAQcTVNk8V3l18jIKCH1QktlZNdpjoGJ
         iqxEJ2ySSoYK8fDXbnxDf7rovv+YHXduw7hv112ZkCzGnUbPZXfQ4NVz7tFJR0DgXsD5
         PgAO4A16fUMmr4LgRjPJHhwU3WiZJwHUFflY1tlXcuFZiXEJ1S3uEAbRMBqrkOxpaejR
         WBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4EVf/eJMgEbUpq1Bwap7s5872DhXdbZvV24dJRf7vZUQanSFedbcdr5Jr9vlUnLomggPszQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCiCPwtYDxsQ+NzzWzVDE5mJ4DxMfxJoAj5+39Xu659+HhiPvQ
	ol0Y8WmDKWPPSgDSTPd9bbdmgi/Tg4B/uYjcKmsPY1RBJOuK9Z/S7NMOcZGIKpAfOeg=
X-Gm-Gg: AeBDiesbPMbnRr9hbf+bq7lBy46mcunsoyTtkq9wJApu0TjxFTINn1jYRmFVKteWr9K
	QD+5GthtNpihwvyU646D6mKWXcKuuOtjaG/FbHWJQSMInkQhacuyOdKaIqVamAagn5gYz6XnQ+u
	pK0x7AISs9lKcTkZkxqVmNu29gm7aRWwyyaFzwIu0a0S5XdTxyqaRwRMuvUpilYHI3CpiGCtNIx
	jPeJv4UkkWjO6467l4WPtAnv/suXzi2kOdKpnjaCvyFaYsc6CbfK1XFGg+H09y85+5L4xNnLSKj
	pfZjKZmOMckAw9T1xU/dQ83g0pOW31GRhWt/DkmNyRc5YRS0fpVweM46cKyCHmjbHaUVCyfRiv0
	Ypx+gtSbyBMySvTvefFfiicMlEHZXMs0s1/tzh3fZGUxAWmG16p7dMdg+vrqw/y6xpPXCddnY0r
	aboS1l6Ui08g3iZflKaCMdgIfIG79mnGU=
X-Received: by 2002:a05:6000:4201:b0:43c:f95c:3e66 with SMTP id ffacd0b85a97d-43d29294b62mr24203622f8f.21.1775553918478;
        Tue, 07 Apr 2026 02:25:18 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5016sm52091538f8f.33.2026.04.07.02.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:25:17 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:25:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca, 
	leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH] dma-buf: heaps: system: document system_cc_shared heap
Message-ID: <5l5ack3pgpajrkbcactkiyvfi5pir3jn5eg6tmohcrdgiuqtn5@odbwbvsn4vrj>
References: <20260402141103.598495-1-jiri@resnulli.us>
 <CABdmKX3N70j8ZZs5DNhx6fhRi=Aa_+2xY1JHcW+uDoaV2+Sngw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX3N70j8ZZs5DNhx6fhRi=Aa_+2xY1JHcW+uDoaV2+Sngw@mail.gmail.com>

Mon, Apr 06, 2026 at 10:20:33PM +0200, tjmercier@google.com wrote:
>On Thu, Apr 2, 2026 at 7:11 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Document the system_cc_shared dma-buf heap that was introduced
>> recently. Describe its purpose, availability conditions and
>> relation to confidential computing VMs.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  Documentation/userspace-api/dma-buf-heaps.rst | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
>> index 05445c83b79a..591732393e7d 100644
>> --- a/Documentation/userspace-api/dma-buf-heaps.rst
>> +++ b/Documentation/userspace-api/dma-buf-heaps.rst
>> @@ -16,6 +16,14 @@ following heaps:
>>
>>   - The ``system`` heap allocates virtually contiguous, cacheable, buffers.
>>
>> + - The ``system_cc_shared`` heap allocates virtually contiguous, cacheable,
>> +   buffers using shared (decrypted) memory. It is only present on
>> +   confidential computing (CoCo) VMs where memory encryption is active
>> +   (e.g., AMD SEV, Intel TDX). The allocated pages have the encryption
>> +   bit cleared, making them accessible for device DMA without TDISP
>> +   support. On non-CoCo VMs configurations, this heap is
>
>"non-CoCo VM configurations"
>
>> +   not registered.
>
>Doesn't seem like you need to wrap this line.
>
>with that: Reviewed-by: T.J.Mercier <tjmercier@google.com>

Okay. Thanks!


>
>> +
>>   - The ``default_cma_region`` heap allocates physically contiguous,
>>     cacheable, buffers. Only present if a CMA region is present. Such a
>>     region is usually created either through the kernel commandline
>
>Each paragraph starting with '-' confused me for a second there. Those
>aren't part of the diff. :)
