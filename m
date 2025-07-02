Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664634CF5
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433483; cv=none; b=hnYu8Wi5ljOotf6VoPcS2WkcwzwPjX0Da/c1aTSzVU70sVwLIGW/TRvsZDEn3JH7m3kqlt3wZfF/B2vvi7JoSHrCF+63wP9q5IuUc4/g00hgz9gw85HIFDZmJ8hppJL1uJEmaT8w0iheYXrredRGcCShSClO30bGc2ADi+KTIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433483; c=relaxed/simple;
	bh=um54tsybIQGov1so14z99eeBcqw/L/Ty7QQVOkcxLcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taLWP1GETZ0jcSxjZ4ZGxy11Nnc1ehlMsirvT53hf1mA6jQ5btWHeWaQGMjDAHHZi5zqPDFJlEAs2dudJCb7RwQGXGu4lPrFAMaPgRXeZmam/vSBAMe4wNHMn6Xs345m4jdGgBghM29z1/fyWoYxpPp5o3VOwFJyiq41H4Hxzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xghk0Vu/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xghk0Vu/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso6715179a12.1
        for <iommu@lists.linux.dev>; Tue, 01 Jul 2025 22:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751433480; x=1752038280; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=um54tsybIQGov1so14z99eeBcqw/L/Ty7QQVOkcxLcU=;
        b=Xghk0Vu/REw/RlwsAvQKjepAQA/LHDdbhocbnkctFAMAKeRvGLLeLdVUOg1pWkYpI0
         koPRUAEGzxoBCuLcY4nQogeERRvtEbOVd/xFB78RA2s8Q5iLOLQS4kpLTXGTpGKRlu+1
         jLmpNBpxrOLVDY3ZFPXP0apje7tLb4pP1Arr+wMtivQWwuebP/4I6mu8IS0z0y3SJXFK
         3G8szJERKxh65z9cRDEttZ5OGF/Gh5GH/u23OuVTwOcGyTbshejR2NjI2+bEQ+7er8YE
         CNSbpUiW5p6IK438cE+bOjQ9DxP30vlt82j+2WnCJ4DUW7kGyyZdEThNSqn3nx5bWyJB
         gFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433480; x=1752038280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um54tsybIQGov1so14z99eeBcqw/L/Ty7QQVOkcxLcU=;
        b=u7mgkOOi7kDxOPFw6IEdge+Qs3x10T6ZFgx3D4RDnxKoiQvx4RKmy6Ljngmr/rd0g5
         5ZaD9zG6iQr+K2vOthOE6P41POOMq+9XECRqxvBLsqrpu6Jc7MxSxoskv/qKCiHOfRFI
         6a6PuhscFlZqfUoLZhlrBkpNR8U5Dsg9cyx82Y8BpcxiRuKTzBlwZDQ0wt5o71CqA2kH
         PBRyJPyr0+Sf+eSs1sXVC2R0AGqzdKbzTYH9i4sso2GM6hHWDnAjLoPqf+UPh7HVYfN4
         ui6F8siQ2AmS7ZJVBI6dBiMxeEQdap2fiLULvf7UOHFHszARvF48iu3rkSl9uwJD3nmt
         emcA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Dwj+WW3beRtU+Hm63aYglQBZpvv/OuhTsyJkJGixGKckv6q64+h7zJcrG+6JCFnPdw0t6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWvEyJHUmldUXrL8+5ulhnYDN8YWmBdI9ksW1JXEngI6gFbZD5
	QbehIPYXAa3BkpwC86Nui8bt4hOqwX+9sl4DKDiSh7uwR2kXb1WZoxCtZXsX+r7Y/j/JTRYG0Vd
	v7DFe2xpnUSYxkSTDHWYrF8H5Sl6RtOA=
X-Gm-Gg: ASbGnctUMqre/dw2p2t0rr7YFz+gENgE7KMBMQWEdtbdhdwnWfMXba1iQYYC+ydDZvi
	HIyJXGrg6+ZJae9LwQTTLqhQ/4tQYVp+2xSqhhdm8edaIbn3Gel24a7Q0zadnH/4iZrI2m9sv7y
	UixlQul+coCcjPNIKSZ3BvZv7GT6g6lKMRGeLqsQNxN7MZWozZNrPk9apqjoG3Sads5YD3HDlof
	Q==
X-Google-Smtp-Source: AGHT+IEMkmdwzlSGJeAQ8PPaXllLIAjtkJJZeH3b5OICmbQtX7VsVL5Q9yjPcEMmQTvGVa8fRMj8QxumFogFy9cFkSg=
X-Received: by 2002:a17:907:1ca3:b0:ad8:8529:4f8f with SMTP id
 a640c23a62f3a-ae3c2da9cdfmr117080666b.45.1751433479523; Tue, 01 Jul 2025
 22:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com> <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com>
In-Reply-To: <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com>
From: Matt Mower <mowerm@gmail.com>
Date: Tue, 1 Jul 2025 22:17:48 -0700
X-Gm-Features: Ac12FXwNkOaqmG2BtbfIHH58QXlArNNvzinDBRJOE7pKkFaCFWQUgB-Rk0U9dvU
Message-ID: <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	1107521@bugs.debian.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> A couple more things I'd try on the ath12k side: firstly, boot with
> "iommu.strict=1" and see if that makes the faults any more
> frequent/reproducible;

The issue is easy enough to reproduce in 6.12.27 onward and I may be
mistaken about the rarity in 6.12.22; I reproduced it relatively
quickly in .22 today, so if this was the primary purpose for setting
iommu.strict=1, then testing with or without strict works. FWIW, I did
test iommu.strict=1 with 6.15.3 and still have not reproduced this
issue there.

> if a fault is fairly easily reproducible, then
> use the DMA API and/or IOMMU API tracepoints to compare the fault
> address to prior DMA mapping activity - that can usually reveal the
> nature of the bug enough to then know what to go looking for.

This is unfamiliar territory for me, so I hope the following is at
least close to what you requested. If not, happy to provide more test
results based on a set of instructions. Here's what I did:

1. Set CONFIG_DMA_API_DEBUG=y
2. Set kernel command line to: iommu.strict=1 log_buf_len=100M
dma_debug_driver=ath12k_pci trace_event=dma:*,iommu:*
3. Booted and waited for page fault, then cat'd
/sys/kernel/tracing/trace to a file.

Additionally, though I'm pretty sure this is irrelevant now, I added
logging after each dma_map_single() in the ath12k driver to print the
function name and resultant address to the kernel log.

Comparing the addresses of several io_page_fault lines in the trace
and in the kernel log, they line up. So, I'm hopeful this is on the
right track.

DMA/IOMMU trace: https://cmphys.com/ath12k/iommu_dma_trace-20250701.log
Kernel log with additional logging:
https://cmphys.com/ath12k/dmesg-6.12.35-20250701.log
Diff showing extra logging added to v6.12.35:
https://cmphys.com/ath12k/ath12k-extra-logging-6.12.35-20250701.diff

Thanks,
Matt
