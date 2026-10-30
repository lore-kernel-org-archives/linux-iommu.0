Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367978;
	b=J2UsOz4GiOXW2fVO4rNpTMFHHwN4rD6Yb9eSZqAprghz9PT4gkrfoMO5NsqjF4Cw4vqd
	 8G2LCEkX3nTblX3n9nY6Kq9fTCAPferjObr70WXFdFiNOSxFdpWcflJfQATEIj1TT+b7T
	 i/G8dxz16CC6lgXx+cYuyVhFVVOQEM98YgahfRWkHIf8v207aoXwcw3mZT46FUjWI87SJ
	 7M3E58DvfG13bzRDcnlgvM8IgBw4az/y7mXjb1kLwonN5EYVBqbDMNct3fTkursUAIpAh
	 7+mFH/DA1AM9ibgogDvZkN0PxC+d7OZl9tgZkI+Hsp5MOFET/gCT3a+UOnvtnwJr6xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cel0vcm4G5w81qs6p/3zOaRkogZgkiMaq/fEg3zUQoI=;
	b=muXgiaWYWZ39YEqHqlO9Gq75bMP6nwqAjXob/c7IIP5R9ossL42k7a2Q/9sbp0hq/lPh
	 Zp0+0GXwWGL1qMDsrRRljfPReM4f8agEjcTktnXFCoznDl9krn/6wuCvWagx5+a5SpEH3
	 zhTIXIdKrXtGos0QaB3zXTn1YRFgplENxAOCS6CimuwHGJ6UOJj4rcMH60NAw4sgOJ9c4
	 omQXZ/FFSDjGnHs9WVwzAsubjgmowS//vl2xzoDxdJ/GoQoglhUkG6NpguvdkXtT6Adn5
	 t83ilhJKKOj5cYYrI0yxrSvfNrv7+i7rNmZb6BkLFCJt4sWKaznpdh6tjAObHl9JPyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=anzOZR+H;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5C606A320
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 13:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AA5C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=anzOZR+H
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4ed6d69bdfaso463139b6e.3
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1793367971; x=1793972771; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cel0vcm4G5w81qs6p/3zOaRkogZgkiMaq/fEg3zUQoI=;
        b=anzOZR+H+dK6ExDZEutUyPXQRiYAnmo7mWGvRaJRanil0/s1rT6oAu82jXDlQMTmY0
         SihZTqD8Xlzk/p0H4U1zHuR29KMhMR1vM8tn86I7sYKRmO0d2X072tivdKtllDCvMPa7
         ulmPmXYshDlvdv3WS9QGD/v/KGwid4H2TUP1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793367971; x=1793972771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cel0vcm4G5w81qs6p/3zOaRkogZgkiMaq/fEg3zUQoI=;
        b=OJGl8HDr9bY/yGKBdcvqT3RDi4xznxxkm4iwD4Zjq2AVRRRC2C7yf5XbQaob1JicVC
         40NNWOl6yeOr128/Se+2TYbts6iKcUVJEPoPjQmSqQsFy6n8Kfs2MITvcE05shTzgqoi
         IIEu2MXktbgn9kOYJ9SB5hhfidwgRbcqXacbcpbgsWVWrdTyEY6G5bjpj4yFgzcK3hfE
         WOzr+gR+I/62ZN0VL4Gs1K59i3TMjIKi1WdO9+kQ8ydz3ewgUihQenrB0y0gXTL0EhmS
         F527V7zQJgVAysfovCyonf8WnHJOHrvXFHtCBhbO/PdGHWO24lL1Ebrfqk9g5/5SLCST
         rExg==
X-Forwarded-Encrypted: i=1; AKwUvBzaJDVpGuvB88U5BadrGKZsqrf7GHxIBG5ENr6W1yUbT9GDqDEXiDlvoWX7pyxocVYiHOvbyg==@lists.linux.dev
X-Gm-Message-State: AFq9FYI//5zanAHM6VobmDniJftXtMyj91sQ4o3irxtAw84BC+HA/Afq
	1Iegh0GFWRt97ZbwSTMGVl1P4hx91WURtyU2Oj8UAFOLA+11NsvkNmMbrVo3ERZpuw==
X-Gm-Gg: AYBFou39qv40OAhtgcOo90UqsiwHqZEmdweGkL99LsX3SfLjSP+kPI+kg5BJYQv6VT+
	D61vEBt5P9dOVujPcLiIM/9PyRYP8xb7X6D9i5d5h1lcIXegwsG92UVPojixo5FZcbhqhqPVvPJ
	4H0dnlxdfOMejuRLd07cuIA+EsEbpp1iu6t+rR1Z9HkpVZ9pOcyQnPJ5/7QI5f/EdjJwZmV3QEF
	Hnhj7T1ArLWHVv7n/PmfDzwK/dhFwBq/c6+uVbm7UhzRMH3vJwuc/l3b0WDxtkbA6eujOW8rqJw
	3dWTerVbmDKeVWiW2B9q3HQ5rJWTDhe9vDDHZwgV3FgvGaynVmRGT8lQ3lEn8HQbw4MiRYZrCMV
	LCT9PEpLAHhN62KGmP87srCa+SpVqVrEDHGrHDl3gQZkU9P23Z0TpdtEdsEPUskp/TeVCaF9vEV
	8Lzb4g67olVwfJ38oEAkdb89pp6M0MFp7ysGe/pU9GcGAIFxHU1SGUa/504O7GRU0rtR2n4Sj6g
	XGQKTFQG7RDyZNTHQ2kVvYkG8N4CsDiakVLG7SWBi/UFs3un//mdjrWQf4fIYJ1JRQ9842SENVx
	tsjQO7gtcczVRfBlsnG9iioH
X-Received: by 2002:a05:6808:151f:b0:4c3:6d56:77c2 with SMTP id 5614622812f47-5640de7e3a9mr1613306b6e.41.1793367971178;
        Fri, 30 Oct 2026 06:46:11 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-5640fdcef5asm1492922b6e.9.2026.10.30.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 06:46:10 -0700 (PDT)
Message-ID: <9207a52e-2d42-4e10-b777-2988e84d7dbe@ieee.org>
Date: Fri, 30 Oct 2026 08:46:07 -0500
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Matthew Brost <matthew.brost@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Guan-Yu Lin <guanyulin@google.com>,
 Mathias Nyman <mathias.nyman@linux.intel.com>, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 netdev@vger.kernel.org, imx@lists.linux.dev, Rob Herring <robh@kernel.org>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
 <auRb_r8ZSSU-eHZA@kekkonen.localdomain>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <auRb_r8ZSSU-eHZA@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 3:57 AM, Sakari Ailus wrote:
> Hi Frank,
> 
> Thanks for the patch.
> 
> On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:
>> From: Frank Li <Frank.Li@nxp.com>
>>
>> When CONFIG_PM is not enabled, all devices runtime PM state should be
>> treated as active.
>>
>> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
>> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
>> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
>> should return the same value as the stub pm_runtime_get(), which is 1.
> 
> Shouldn't the same change be done to pm_runtime_get_if_in_use()? It's
> otherwise the same, except that it requires also the use count to be
> non-zero.
I think "yes."

I think the logic for !CONFIG_PM should basically pretend runtime
PM is enabled for all devices, and they're all ACTIVE and effectively
in use.

That implies:
- disable_depth == 0, so usage accounting would (if enabled) be done
- runtime_status == RPM_ACTIVE (power is on, no delay)
- usage_count > 0
- runtime_error == 0
- Maybe ignore_children is false?

This might not be complete (and could be wrong!).

Some of the other dev_pm_info flags could probably be assumed false,
because they represent states in transition between ACTIVE and other
states.

					-Alex
