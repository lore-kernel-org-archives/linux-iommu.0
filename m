Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E95194A73
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222462; cv=none; b=WT/8n4NSY/d4AQbrZQButXpN7kCvpjDlQGDIdsDPDecy6XOxLwf2jTlHOeXM1LMpM17anWeBqcBQMdTAO99lZ/x+kAUI0BPmZWqOXKgvBkzPjjv6bZmRSJ7PjB6K/ay49+gMLXbnMqNlS1uXj55w56thN/2vonw5b1k87cDr8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222462; c=relaxed/simple;
	bh=0jm1lKJFUeA9vENnTCBhNGR/47vAUHujEZ7UpvOnRRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjheEHw55NVBaRJzE6X6aMFFcONSQH1VpNpl+I23YBc5/EqRpEdaZD8nxV3WLrOwU8Xt07olulul+uwgvh2Tke+NrEDRkcXxBJpZFNvnwQcdQKjeFZu+Cqbbu/WbIq0vZ1k9KCK49lWxbTlgLSasU21HWz4oXjqXTYCNW2eLljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhFWOj20; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhFWOj20"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f6ca9a81so41715ad.1
        for <iommu@lists.linux.dev>; Mon, 06 Jan 2025 20:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736222458; x=1736827258; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hhIXJCyMVX58WglyiPpWD5cVYxcyBS4mpo3e43nW7IA=;
        b=RhFWOj20inUehpe/hDVxMsf1eWVUrvedENdByOQvweM4jFu4JhQD+hVCZxHJX8lScU
         OlaUSbOS35Eh5RQJaxmQTetE33CI20Y5OuAjqvOTW3vWenPjes7+5PDIg0Nat3c6XAf5
         xv97sejOdxyM0HunH8Q+5OxLwJen6d91tnWDVqJ964BBldEBQzC4fsKO+/z9XQMeJ/F2
         LRot4lQlOwJ5BlbhB4Y79lqNxzJ81xZoYRzBx+sV9OUVmZsxtwnNrP07llixJ3hoGXJs
         WKyM00zgZ/ZeZu20ZPbKzdp3/uL2tPau5MeExaDz51vTb29gMPjBpRvd4q0rNP+7XHVg
         DFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736222458; x=1736827258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhIXJCyMVX58WglyiPpWD5cVYxcyBS4mpo3e43nW7IA=;
        b=q5luig4/PXwbRPG+eJxycgc8uzLzc43KOfpMG75gZw5JWzQIPOLv+UFok/ZDAg7yFY
         P08eVPkNd7nSlEV/X/xw4lTpsVMgesG2DLybneiVMgFxo15LLkFah7/4Ul6BAvBYSDpt
         ehm0j2fahqwIi/KQhvj23HGq2Iv4l+M3/HACKvIHfQTVZXmXunBiXb21hZFi9QUVNbH2
         F5doxSleZs7ySQ/r0mO83l96WD4lbrtqHAZFmJpEguL5adWCR97WahjYa2qMToTa+QeW
         kplaADBHqb1G7TXGj3OpUMYKhYR+WKl8s2hetwIU2594hIFgQKc0dFdnobfrWTgsrXoP
         2SDA==
X-Forwarded-Encrypted: i=1; AJvYcCVpuqd36WB3EjCTWf9yRGP+cryk2NwhIjkuGWMXOa3cqyMMPgYx3dCllA7tVx32LFljRo7XGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCjovb9KXggtcZqV8R2/Dju37s7Jhdd/OwJFvBpEa9GAoxz81C
	7DzTC+T2UC1a5AMS3pc8AQTe+YBIbNow44l0xhSyP3K4I9f3Vy87DTrniBIMCw==
X-Gm-Gg: ASbGnctIt92fe6LHNEA2nwkm2xGnvzYdP60vWrbTBDwQ5kYN4qRwtME7c9hTLZuVIlq
	9CU70tSSyEbil/pO7XgHlDuMBAjF53sMrjJjJ2kdQIotkZoG+1YXJ/JHJUiHvOUKqc6qBso/7Os
	Cjl98nBKtpGkD+rcfNRNKp8ksWYi6krc2hMBv6EMKjDeGuoumwJOaFXKLYhzwFTeIw2Ano8o+8e
	fYFnFEfsQkbmhiVNCn1YLetIGOgHYk0d6eSzH+iyJERHXqrgJVwD9aGJ3HFM6DuSlKepTOgYTQV
	OlW3cq+fdYcl
X-Google-Smtp-Source: AGHT+IGkQzEvWPAnDokdOSkh1JxO/oaA2p5mte+akBY/CpN5NRWSK0KwftVJ+HLT5ny5vZzG3Ffduw==
X-Received: by 2002:a17:903:1c7:b0:20c:f3cf:50e9 with SMTP id d9443c01a7336-21a7aca07bamr1245975ad.4.1736222458059;
        Mon, 06 Jan 2025 20:00:58 -0800 (PST)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c1a6sm33435241b3a.181.2025.01.06.20.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:00:57 -0800 (PST)
Date: Tue, 7 Jan 2025 04:00:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, baolu.lu@linux.intel.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH][v2] iommu: move the adding group info to proper place
Message-ID: <Z3ym8Z73RcT_f8OZ@google.com>
References: <20250107033558.41135-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107033558.41135-1-lirongqing@baidu.com>

On Tue, Jan 07, 2025 at 11:35:58AM +0800, Li RongQing wrote:
> After commit fa0828036488 ("iommu: Split iommu_group_add_device()"), the
> adding group information is left in iommu_group_alloc_device, but which
> only allocate group device, not attach the device to iommu group;
> 
> so move the print to iommu probing and adding functions
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

LGTM, followed through since [1].
Acked-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1]
 https://lore.kernel.org/all/c30af43b93f04125bf9befe631922653@baidu.com/
