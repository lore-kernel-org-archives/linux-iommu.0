Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A89385D64
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020743; cv=none; b=gdvOTPtM/IJPAZFyks2aNw0KrvBOflxvUoMv9k5VRUoih/1CcmNLAmukr14dRUTpEWR/SJcSrFJxwdYkygeFlkq8vz/RMSwScY7BnQuMI60CmbbTge2/jrTbPfzlSEtei3GrWqgCv5vWGV412uXTyOZrD6ybW/HABTZpfUtc4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020743; c=relaxed/simple;
	bh=Y3myU6PC6Y/+0AUV070w4T/IlmTKT4MrSxy6LSocXzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoU9EUKurPy61wjjWRDBPTZ5QPcyHTe09XdTBjZfLv3CbQlgqXVwTxE7a3ZVF9XEL+y8fVpFWBtwt5Zen0sWoZa0D0Jd8q9xEIqzAzLPQXVh5r2gcv2m26m0UrfUm/UpR+z7yJOyS8Btup5o02l+BDVNNLccQw8kLwblGJf0FMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtYnmaAH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtYnmaAH"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-472055b0efaso1488023f8f.2
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783020739; x=1783625539; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7qgcEW/wpSAcIIpifYaO2mjjD/biPw57/pk0Dft8EAU=;
        b=QtYnmaAH5B3N1SW+gLrWR3hMIKJ0rzNZk76uX1pihp3ExtSDPNxyR8hMXubxGBJhzE
         vPouvqYbW2vPsbVIlcJoJwHfOqMDLEXwrbUHn494GQQiM0Dw3a5Vbq56/gGaW+jy3yB5
         NtkNHJIIfKjhIit6KRQR6+ReVwTnkFScCOxIUGd1faoYzfAT8xtzlrkJN6oTi0EAIsy2
         8JT2fhnGU79DrJDhJoxaZPQaOFa+5eC1kpdXzVIEXYSuSerLPpu/mb8YMX6TckVl4e8S
         OHaR3enGAe4C1CBO441aDQxEU0kmuaVBNAeBTzqc7FhqANE5T3S3JHh057hqKC1UN22F
         JN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783020739; x=1783625539;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7qgcEW/wpSAcIIpifYaO2mjjD/biPw57/pk0Dft8EAU=;
        b=kWbKbS/cdbZNWCyEl5u2C/05b6bwXmS2QNNTaLxCe3F78piW5F656zKnGZ5PRw3gHE
         mGEhQ1W87jeWWReDCEUamMscjM2GJhdlgp8A39IZXzLsKsqZW8WTjt8vTKthiM8LcxaF
         yp1KZhZgW+Gm99YOUYzHDF+BdWE03uK7CcMBTyJtxmZsl2+VuxbgnKenS1MXkEn7mE1q
         DcJocmYWom8opKyhiu87ZoZoq6ABae9TZmMXqxNN0P2PL3tZUReBqHV4S2JFnVCiA/WI
         eAZch/8EgOOG6XlLSTvVHDWbohicHgaG9nLgXa/IhalYnr2/J9J+kTAu3CxD4QTnXiuX
         ojag==
X-Forwarded-Encrypted: i=1; AHgh+RqN92QDljUnpOIgpReUt7hcJLIv8PrC9oMsnAm87q2fu4imCM369+xVbAV2cQz0x2YPzCAJ5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmCDmnLnOKPSa+BBwd3IAxS6EHXLdPwXtwn5TTKP2FnwdB9tDX
	N2lyXCi/6Lf2spR0qqVsaAFdsnhPIjD+b4KMMoU0MHihwKqs7p3k6W91
X-Gm-Gg: AfdE7clkIQs0x8L3oZL1Je+4/WfJ4xzfxTZHYJoV0+vRq52pFiSbZ8owlb9OjliNSVX
	OfrpVq+pXEnOqhhs5QXhIqLZlutASy3sV3OqET/8xp2joyRSDEuALCY4HDPuX7IPVEKuehy4tt7
	bU8ceChx48H95SZhgQJgIibNTsnL38/2sY+KWk9edWuAu5dIiOFituduJIeZR6LO4+T1rHuUZQy
	tnddyp4ST5lzCa8cNHtbDiEsEOHCb7WjMqrJNf1VcTBfdkZZp5YxE9rJv71ULjU0Dv6yQH9Wc6n
	KHWsOwilh7h2seQuh0Xf3z/plj8Zmaembn+rqBt0bnrdnrSEpqSWFlWiStw5V9fkb0a+NJ5mFSK
	KKIaBuAbqG0tvtelFiHXUhDQEW58pjuqvdY2PBHjnfq+dJoSutVunCB3gyE0bQGCm7pJ8YjjjvD
	kj1u5xROsv+RCzXzj9IxZyUL/WMz735IAnvF2SKKdl8diHKB/acxH0zEL9ay/Y4Acr4jKHRurq7
	sNBMCLR
X-Received: by 2002:adf:e00b:0:20b0:475:3a97:8e47 with SMTP id ffacd0b85a97d-4775918fa48mr8502412f8f.29.1783020738996;
        Thu, 02 Jul 2026 12:32:18 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94ce4csm12070471f8f.17.2026.07.02.12.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 12:32:17 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <a0cee001-7bca-438a-943b-da28528e7df7@gmail.com>
Date: Thu, 2 Jul 2026 20:32:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] HID: apple: Add DockChannel HID transport driver
To: michael.reeves077@gmail.com, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-input@vger.kernel.org
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Michael,

On 6/30/26 13:54, Michael Reeves via B4 Relay wrote:
> +source "drivers/hid/dockchannel/Kconfig"
> +
>  endif # HID
>  

> +++ b/drivers/hid/dockchannel/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR MIT
> +
> +config APPLE_DOCKCHANNEL_HID
> +	tristate "HID over Apple DockChannel"
> +	depends on APPLE_DOCKCHANNEL
> +	depends on APPLE_RTKIT
> +	depends on HID

APPLE_DOCKCHANNEL_HID has a duplicate dependency on HID,
since you put the import for this file inside of 'if HID..endif',
and then also gave it a 'depends on HID'.

- Julian Braha
