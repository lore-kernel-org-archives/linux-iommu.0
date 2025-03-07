Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AC23E23C
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369996; cv=none; b=SioNUioxIJ+e8D0WKGGa04WImM1pzrSyxGZyE3sxkHVSA6/DA1eweL2ccyXi7RHfMnl9+ayGX8EN3aHdx8vnWCTuzPAboO5wyQ6/BSqv4YbTYLjuu6OEfCO0D55XcvXlopzUVYhZH7BNDBIpia8e99PJzr7OwWNkuvppNaPqqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369996; c=relaxed/simple;
	bh=rr19sBwsRVx6eT7qGK7eZbt1MWHgFKS3zq9OvUcxx5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHHSDo11yttyNdtauBuQ1tG2EUaMRGqlEZgakS2wOMCm152pkBG0bB1roXFWJ5tkOkONkk3BKEEe9lAxzwg9QoHfJoACKkf4Snn4dYFFcaigd605GD1lSx/1HbPX+VQPZkOqzGYrzScNqhneARG/XrXs6YbvWi+dyynWhDzXZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROIvDv7Z; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROIvDv7Z"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bae572157so20137011fa.3
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741369993; x=1741974793; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8awcwolQNhF4G4i2+3gjV99xCmgkzISBAp5ygv3cfg=;
        b=ROIvDv7ZI31LzsXa1pLIldPKo8Z8tPOZ04yHgtZDgOpjyqezyTrp1RyIuZnDBip6l5
         l1YUJUVnzBBEV6SSqFI6QsTMWu1CXOrD5nrScTx8E1APDN2edgTS4pcvoAL7XXZeDckF
         3bL9PUbWMSrD/tEFoUAya+X84TGqXAb+UkSf8iXg7H1Am8TIE2tpP3tHpYwCGPhql/dj
         c8r/6KHvNHqOhWY/zPkvKh5hcCJl6OT4tYjCo5EBni0apFpJqGUBXzf3xepI4A3I+uz7
         /QaQEsp6yJhVSjNItf30BV3vjYAf/ti7NC7Mv40/6ECREVg1gxOEyCt+6Rnica672ErM
         tzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369993; x=1741974793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8awcwolQNhF4G4i2+3gjV99xCmgkzISBAp5ygv3cfg=;
        b=iorREFJ568ZdpXbWHlD+hm8AOei49BK8vqKkHL70r4KRSvgIvq/0eJqSDoeNRBI5ye
         QOzxOMt6z2B4q+Qk1ZBEBted1H4aJY2ZRpC/59xLDgYSc9af0YTqsBYj3YsPQSmWJ8lZ
         yT4oSjRbPu1shl9h1lqSAupDwk9xAO/xesqyyCLC4qWlR9cK8OaifVXYxIcUMUNlvHB7
         h7w7Kky903Qow2oyEWTuG1QjsZ/VtwpPsGIvJPQ4KVhH1GAX3PWWYZwO37vy6jP5cKzh
         a4cMkHugzEwuQbI89Zcs2KrDW9UKE6HUZwg6L95r67kQWFpJqOEiNyIkeQ78mFvscoPs
         mARA==
X-Forwarded-Encrypted: i=1; AJvYcCVLsJ8f/t2h2EontK+R2xeThPeIe4r6LQs9MHYlAkqQrg6nzgT1E4JJRSIMzQz/virk6dU9gA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLWQFAj2t5rwbGbPPKtvV4LwIDhVNrRH7WOz8hipW4FdD3UY7N
	L/F30s/iQLsV0j3zAV0JNQjbdbVmCAUH6ZG9EtNACWn/gzBLIJ7/
X-Gm-Gg: ASbGncsmiusPvHMykxQgRG+qBxsaTMshDJklzDpd9/eii2lQO9OwCPQt33z8wJs1apA
	UXowynagXj90CSVKx7do+P1itXRWCNX09rZkimBYbpfBXrPGqCsVBgJL+BTqJb0+myjloXO3X0A
	6OT3cAWIunzbUpJDI5W27VnSAHqv2mZoJaZGE/Icg6QXWM7jsa96UQMutrZ3JgDJ7bTr4iUJ15b
	H+d1LgphE0XIzTuDaohoR8DH3L3AgHdOXLWguKg3iUSGJtfFY6GTt5NDjhM4S2n1V/jx2pQCF4B
	7DLbzPqRfbQpfsxRvyBcOSALd26m6q3yU886YXciCBLlPUf3i1VlzUqz7CPpo0uqxd9JrCXW0hg
	PghZ4y/gCsSJ1bnI3Hjy1Cw==
X-Google-Smtp-Source: AGHT+IGl09OB0dqYCWBH02itDKGKUCJJ7qvwBmuOJq8stuaveEuflIp46xdYOfUbEyjC7svNNa5IMQ==
X-Received: by 2002:a05:6512:238d:b0:549:8f10:ec25 with SMTP id 2adb3069b0e04-54990e6734amr1611796e87.31.1741369992223;
        Fri, 07 Mar 2025 09:53:12 -0800 (PST)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae591e1sm554933e87.102.2025.03.07.09.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 09:53:10 -0800 (PST)
Message-ID: <1b812436-5e9c-4fd9-9ec8-24ba106347b3@gmail.com>
Date: Fri, 7 Mar 2025 19:53:09 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/7] rust: pci: impl AsMut<Device> for pci::Device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <20250307110821.1703422-4-abdiel.janulgue@gmail.com>
 <2025030747-caramel-blade-4b8a@gregkh>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <2025030747-caramel-blade-4b8a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/03/2025 16:18, Greg KH wrote:
> On Fri, Mar 07, 2025 at 01:06:20PM +0200, Abdiel Janulgue wrote:
>> From: Danilo Krummrich <dakr@kernel.org>
>>
>> Some device methods require mutable references, since they change the
>> underlying struct device without lock protection.
>>
>> Hence, make it possible to retrieve a mutable reference to a Device from
>> a mutable pci::Device.
>>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
> 
> Note, you can't forward on a patch from someone else without also
> signing off on it.  Please read the DCO for what this means and why.
> 
Thanks for the reminder! Will do so in next revision.

Regards,
Abdiel
