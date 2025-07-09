Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAC285050
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062348; cv=none; b=B/M1HSkDtopBS0Uf9NwWdX8HSh5jMcPElQCrIevtEGxi29Do+S3MVytxlNoLeC2rZOl7R7vVcLUj4a0cv3S1xfuMTHrzyFBlI9ckz6mkxCBu3Dh6C+d6bMiXnemPaB8qf5Js3Ha7fOlGThy4TJRy5ysy4+saJXenEVOx7ekikLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062348; c=relaxed/simple;
	bh=bgR5awQX0vKasE3O7EHtXSFXPFtLWKVOsswzgDdWlbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cX+pa9m1LstwaWXgX9JZfh1uC13EVvmkaDrzKgqLg6Cz/WWqgef0+0kX7HaY8ptvKR7oxRdz41/I8Oym/KdmUED+Uee/Y3Ij0WlxRYbrximKbvfQQ/9GAUlRT8LNPRHZO673TAqY9dG5uFLU9oy0tdf9c6xmKYDKBvbqynrNib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUEpCT1Z; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUEpCT1Z"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553dceb342aso4822270e87.1
        for <iommu@lists.linux.dev>; Wed, 09 Jul 2025 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752062345; x=1752667145; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cok7uU2jUvW7fnecoEr7WpQIhsCNVnn9HvuxNqMoKcs=;
        b=AUEpCT1Z+o2MqLNUuV6+9v4fJpbtIPcrUZgeroZhaA+Egh/1fnxPHynnciPh82nIsS
         fyZ3YaiVnHIqK4amlfVel4DBA/YUSMye6k61+pR/S2Ouh0hftKwO9AIyqPD2iVzZ/VUZ
         xQ+bMN1+iiHdSRngtpZXlGCYsgYGr1n66t1yTfQ+Kx8f4zLxcbR6iGKhXk+xN+IKlEAh
         K9cZhqlLiDNdEfCCz2tY+vOmIAhF8MeH4zZ8EwbN6n5NZI7F8t75FTifr1Rxsflsw0S4
         OBpj2PYqkNV9XlbBDuJuserTI2yEy68LeczjYL6LmRXPhfQnqH8WwSBKyU9ljq4I429V
         Q7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752062345; x=1752667145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cok7uU2jUvW7fnecoEr7WpQIhsCNVnn9HvuxNqMoKcs=;
        b=Pl5d2h+mQDXKrjxdRdfmwPOJxrSG6YtFP5YqXivgC0MStE/izmDdMsBEe9JY1Rduva
         nwzcNiYAIlI3Jxl/wQWnmuIuZRDgjX+qfokqBwJA2vb7+2oq1Gl02cIFzuIE6RLIMcYu
         WeYMZYY8fKttvK037dBDttqHz1AVUtnv7My/eZAvKxIzSUK8ggoiBlqYjP7botirNTzv
         XUPI7+VkMUfpXSPWq4cCfmb/ISSSCMlcONOigaPF2Xi6doL5WJvqDGybaI0Gm9/4KVoE
         NwRXNDDPsuZpOw8wIjOYzbA7pWSba635a9ENQ2ambAP9lOkhVUG1Vr7pOlBuK4Tm/mQ6
         Jb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6jpKKY431TVtUXmE/LnimXrZZitWC4CO8fQx4ulgQ48urep3o/uSjtJMRrNBHYZDkEu4c1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz84VQhp+ri8puxWBB5ge8Br76yqKBy317Wu89x5QfO8uzpmkQk
	QqjVVP+p75SEhPOLcb1rAYKJ8xrPHvNbl5SAqkXC5x2C86fJZYwBlQx+
X-Gm-Gg: ASbGncuu5IH8eyQY3ho661l3Dg8zayNTyTmJJr5u7aE1KmAtJd5ZASfpTsuHn2efF6O
	oY32jZ6cXeHGnU0IPLKU56Lm3Nu8+VpKP7vI904LvcAA8iPrDaK0wvjynZj2pJ11VnKxXoZVCYT
	aRKjxqxJ4+ZjXABMNyInXkh2gj2vEw6OFTufTZmFd2ssYSC0dFbEL0wCkwh6txW3CvRWXzUZOjZ
	gwPJtZiwSSvBATrL350KWtckmFbDBxv+E1rXSgVLEvyjMY5ZATkOhS1UlubbQFWX6h7hQTmElgZ
	vChOD2HjKPu6Z3fO1dvJ/qIKe2syZoQL9dgNezA2pkxxob2hNh3NvbMAAJq3D9vY1h/ZH8zLa3G
	adU+9y3+j4kzh/6XSIls17KLz+MKDY60PRNR90YgIUSwoYi+WVg==
X-Google-Smtp-Source: AGHT+IFC8/vApe5HFeNaNKqi+jWCcD3kQruu4TovfGc8AxarPCJVnGOQYHuNec4peOG7S/XWGGoTrA==
X-Received: by 2002:a05:6512:3f0b:b0:553:2e27:6769 with SMTP id 2adb3069b0e04-558fa86e7cfmr643645e87.7.1752062344958;
        Wed, 09 Jul 2025 04:59:04 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384c8c42sm1981269e87.237.2025.07.09.04.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 04:59:04 -0700 (PDT)
Message-ID: <0206a7fa-ce7f-46af-8f1d-f9dedbb0a3d8@gmail.com>
Date: Wed, 9 Jul 2025 14:59:03 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: add initial scatterlist bindings
To: Alexandre Courbot <acourbot@nvidia.com>, jgg@ziepe.ca, lyude@redhat.com,
 dakr@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Petr Tesarik <petr@tesarici.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sui Jingfeng <sui.jingfeng@linux.dev>, Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
 <20250626203247.816273-2-abdiel.janulgue@gmail.com>
 <DAZQ9OGC1648.2WWABTO7A7UU6@nvidia.com>
 <DAZVUN9N4GBT.38B6BX4CN516F@nvidia.com>
 <DB17XMDHU5M7.2M2KN9A8TJQOB@nvidia.com>
 <DB288AEQSBTC.63WK79TB77TW@nvidia.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <DB288AEQSBTC.63WK79TB77TW@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 03/07/2025 10:03, Alexandre Courbot wrote:
> On Wed Jul 2, 2025 at 11:37 AM JST, Alexandre Courbot wrote:
>> Thoughts? If Abdiel is comfortable with this I can submit a v3 with this design
>> for review (putting myself as co-developer), on which Abdiel could then keep
>> iterating, as I suspect this would be easier to understand than this long email
>> :).
> 
> Figured I could just as well share the code with you and save both of us
> some time. ^_^;
> 
> The top commit of this branch contains the proposal discussed:
> 
> https://github.com/Gnurou/linux/tree/scatterlists
> 
> The sample code has been updated to add dummy examples for the 3
> use-cases discussed (reference to an existing `sg_table`, refcounted
> reference, and owned data).
> 
> There are still things missing, including the typestate on `SGEntry`, as
> it wasn't necessary to demonstrate the basic idea.
> 
> Note also that if we decide to only support DMA-mapped SG-entries, we
> can remove a bunch of code, including the one that maps a `SGTable` if
> the backing type implements `BorrowMut`.
> 
> For your consideration. :) Please feel free to take and use anything you
> find useful.

Sorry for the delay, just came back from a week vacation.

Regarding your question regarding why I dropped type-state, I thought 
the general consensus here is to drop this approach:

https://lore.kernel.org/lkml/DAC20AXGABW2.X147X4JPMRBS@nvidia.com/

I think I might have misunderstood after re-reading it now. What you 
probably meant was to have no intermediate state from initialized to 
mapped to create the sg_table?

Anyways, thanks for the code above I'll look into this in detail and 
pick bits to integrate into v3 :)

/Abdiel

