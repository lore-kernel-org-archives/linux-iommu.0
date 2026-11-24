Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513996;
	b=c7IjO5h6Kp59tT2Zzmk8NNhvHLOm3BZX/sSPPpoFyv3JL1kQNK52eLGRw7VRP9CyAz9E
	 5f0Pvm1XBfS5TwCBiLpWjq4J7JNgmrCxqeaC0FbF2p0l70nL50U5Pkdpv9XJ5smuW63Vi
	 oGV/vUOR7NVdicwPLl92Cs6C9RsPJ1GMTCh4jfaiJMF7huxkPIN4dk8UY3Ujm3G+MWecf
	 hCXkcpt4WPAKcQndL5fRbv3tCRx73XK5nXZDRjRKsnwOmB+xYQjLd+rum8HCx9VFhIzBd
	 DJSJgpv1bOrksaA82iuGAPcod2Sygdjybii1R5V2OLZHaFGVuA5rxNzE70ajDMNLt8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=s3HEy2luFzOKtpXEMJaCVU6qsnBsmUBR+KRo1CZ+Kxc=;
	b=xUC42dDjcRZg9aqJ3ub1x0ZbsEbU0s95Sj6ljJZZ4a4KJ9muCPVtW2B0eZsNtFQZRnGy
	 i8ZMXg93+Ca4mKeQW7Ct8o9tZWTUtWDT0+0Pu9brOnuoe3AyaU1IgSbtj0HqEAax7jJ+l
	 Nd0kB1hvoaa+h1jbbzR0FmIyfPav+nhZLyAkYB3ijU7hygGHBfWgDCpEdjSIFWKQCPfCm
	 Fzr+XsVqioQ97JvY1iZ2qvyDAp4NFGQ/WyKp0qC8hUNFDE8Bv25cZ9uuNVyY16Z5cRWwp
	 SLj29FAbiSYsbUfR9Pv2YmhE1Ffbn27W+nVeetys+kzduCePh88d+43D0fB99vipDjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IRYGbHDH;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA2606A682
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 09:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96DA2606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IRYGbHDH
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso2458153f8f.1
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795513991; x=1796118791; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3HEy2luFzOKtpXEMJaCVU6qsnBsmUBR+KRo1CZ+Kxc=;
        b=IRYGbHDHaFZOgqCsR3LK3Hytp8FmAyESMBlzoZ2w+EicKyINYByE3vRSZiagOPSaOc
         uZYbAiXKXPa+QuD5E4F6O85ZUD57lhYTY5bJQ+91CaA1TzvO3mXohs410DB8JrcLLieK
         vA8XxpwfVy11WN/h1fsAykX3Zhmzn4tPS0Od26WjoUC/Yer4iLe0sGRHOipC/ovOeag5
         LFLSO7W10gcbbexyZwZNLwx1KT/me5aHf6MYpEOzYvrCAcqllaBdOG2U9VWEe7PiM3db
         tpART4MK1WbwMUUavhBu2uA/R5FFEgoSkqh1uN0el3yX12xzZELSrcampkjFx+zJgfyo
         UZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513991; x=1796118791;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s3HEy2luFzOKtpXEMJaCVU6qsnBsmUBR+KRo1CZ+Kxc=;
        b=w0eyP/l+g/DcbdLXMOPKjE9Ml1IjCornfAnKJEWgw9ClmNC7/v19Ow2F5Bf0Frz8OF
         xoDEwFfPUNAUR2P1IOZz0bK+Qci5ZOPIjSp6AICInjaHlH90f9vw4kkGg5Wf7fMpGX/p
         UfgMu2qlxbqKze3thrRrq/+G/j56KrTIXVzYEmGgH8wiv6gPt3NezvYfqumfWj3P3Day
         RmSdZaZ0HuGQ/+Oltg/sJug1J0rTQop+ApMWJxqJsRwCp5rTybWgUftiVLHmpRKTblXT
         oI7uz6JgF6GUi7KpSJZgQ1N6eYP19oAYqS1U4DmJkPE7bs60zh+bGFmqnPLDOqQCLQ7D
         AN6A==
X-Forwarded-Encrypted: i=1; AL+hErEV6+h45WmM09yvPwutQtit2bzd/DInG/o2AOzkFkGiZSQIJ/3v+MgC2LTWqL0ItV4rugMnjA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+uSXjyZPOKoEUjzLjokFzUiOPhq7OxsTQT8Z4/5L5eepYnPyXX
	pqyZ95vdCDDPL/RHPw8edXltgcqXqnqnbFXLWevXAAYfSV5uQ7XZWIQzY+IzJb48Crs=
X-Gm-Gg: AZFdTZeJHqu7EyhvwQbQRw7dlt3v/g4MGB5yCBrL1azRXRIxCrb+jOArCHykstyUpRg
	zpZYC1SpOfekusStDzlvFDNBaCDr2k9zFGO9BTmDK4HVajknS/xanDRVQGBU4dNhxwebDUf3KWl
	k0GjjZXBrxwpKKXk1bCr2Kmv3iL6OUhCaoIqQqQusCJDSSL9ktSDigJShEk0R1HrTpJVySHPS1+
	k0TtfvR0AYkw/CaQr1uzbGoBrFbs/9csoahPtWmHsRMUY8PzVHojc+coMDcTMFWdgdqYa0BZ7ID
	kBIR/xEDpYF4ryAJBqUfuN97ke2QOGJxinr0Aba7ZHRjrwZcwJeelJUS2/3IxgG3fv3tX6uuzS3
	QmkmGXh5ZSuqkZ2mCE+WnKk508x22Lgi4meXXJrYZRNU9CEOirjToLL+DGBmvTpUqt/Rrjtn/f3
	D0W2f7jIsNFZnznMaM+wM2y53nJNEbR7rauAQwao7J8teRFt4NMOuR1EYmRO2haB/+CErUWcaSX
	WyrZs5npC25wUXM3kGLJlnktfyWWgcv+/WmJjT7EO+VwX0siLIi7+MOQ548FfkjhkIkmwhGLL+8
	oPY4Qttf3zGi5qbLI6Zx0fTbe4RiYdP7Uf8WjySoWuJ4tcY2XMqbyGDw8eeN/AASAb+c4q8AZ+D
	coA==
X-Received: by 2002:a05:600c:4e0b:b0:4bb:6f45:2a79 with SMTP id 5b1f17b1804b1-4bb88817920mr309330195e9.22.1795513991045;
        Tue, 24 Nov 2026 01:53:11 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm435581505e9.2.2026.11.24.01.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 01:53:10 -0800 (PST)
Message-ID: <2fd706ef-8205-4564-bed7-527b6bae8790@baylibre.com>
Date: Tue, 24 Nov 2026 09:53:08 +0000
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
Subject: Re: [PATCH v18 5/8] accel/rocket: add a GET_PARAM ioctl for the
 hardware version
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, sidong.yang@furiosa.ai,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1795478392.git.gahing@gahingwoo.com>
 <cbb77a43deedadb6667a84bd1c57030cf1c9ce74.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <cbb77a43deedadb6667a84bd1c57030cf1c9ce74.1795478392.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2026 00:01, Jiaxing Hu wrote:
> Add DRM_IOCTL_ROCKET_GET_PARAM so that userspace can tell which NPU it
> runs on. DRM_ROCKET_PARAM_HW_VERSION returns an enum
> drm_rocket_hw_version value, taken from the compatible's match data when
> the first core probes. The PC_VERSION registers cannot be used: the
> RK3568 reads 0 from them.

I also spotted that the vendor driver uses compatible-based matching for
this kind of thing.

> @@ -197,6 +224,9 @@ static int rocket_probe(struct platform_device *pdev)
>  		devres_close_group(&drm_dev->dev, rdev_group);
>  	}
>  
> +	if (hw_version != rdev->hw_version)
> +		return -EINVAL;
> +

This check can be dropped, we can assume that a DT that gives cores with
a mix of hw versions is invalid and broken.

With that change feel free  to add my Reviewed-By

