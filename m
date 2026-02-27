Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F8438FF3
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206944; cv=none; b=FSZkZB0uyhTaBbL01Qs3WDc6W7geHQgqQrdrhYVd7LgGSPVnLwOQSBXNWOofe0eerwIgenr4yLCq7nap6lqlM4wQy5uUaJReWchAajtN6TSnYg6g8Vq+oVzV1pz1D7Yu89uTSaKU5W4hrUlpFDcqNWygOkKNYPAdUZccQuvtsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206944; c=relaxed/simple;
	bh=xHYW3p+5GVfDn8x6oFMyWCK6CrLKRkNsDbg87Yl2z8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Olr1X7YZZgEz7cbDADy6eyPjwOkPQUs5hqbIATz4wYRV6UO/zddKVTGyWWegIgnU/FEpvDXrB5psNS9pMIAfHxy+CGog/NKuFhpDvZRQZaO56WmQaQ56ewtD73c3J/60eT4V8CwxB/CCn/Uji/yYACHg7R0sHzvtphsKGHHFC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ikO8IQvQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikO8IQvQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so25320965e9.1
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 07:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772206941; x=1772811741; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wzqme1k+Wy+/3yspGSINYIH3f7UH5wA3CsIMcq2UIg=;
        b=ikO8IQvQJXv5bg+qQELTK/EsczJOjD4OLWHNKaAqOh/fHDRcdt1XTrzJt2/QONAqcz
         D33LzWStoVIkdNgjnawjiob+xVzhy/CJTwDFqdGQNLculXUWMgmP4aPHYyqrqPqNRB3P
         kyD95Q22DzYNFGRQmRyoW9Jsh9Bfejg4wK55Rmoj9gdH9klwb0vww0nadbpdqxox1z0Y
         524YmODsw7NOd/ppmKHK3sytXkgLOtt5y+aVaYyGEnvakyldm83zsuuhG110lcm+Iu/y
         dxQFlU/1XI6UU957o+481CHNijHmNN2EkrxFNY+IKm1RHIWZwGzkG80DjZSgc7XuqksO
         IQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206941; x=1772811741;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wzqme1k+Wy+/3yspGSINYIH3f7UH5wA3CsIMcq2UIg=;
        b=dj3bqqlTpG/oUOG73lu8IlyNFzXQv0BvmRNuL+CrV0Cx0LMECoU01h3ptJ2/rThPOh
         fO/mju689TMZptQdk84AzDA7KMbfnFHtqugxwpWk2jeNN8+D7Yp5YpUFxaW+vZgfp7OO
         RzZIdsLp3Mhdhk1WcVRczyU3vvSX/JDm6HXYKtoO6T/tzvlWetAfkYkEzcOAJVYizkTO
         Xb3whItYi8S8djC9aSW3QB6w3IvUE1J2fuveKnNRWmsokmCVaoWwUxhH60IYb1kCHF/V
         hiLFk/OMFfWOtIKFsfOjL6USnpMuHduJKLhaXP5J+l8aWNMrhTM5hw/yxMtXDJtT/Jyr
         Nk5A==
X-Forwarded-Encrypted: i=1; AJvYcCWB9pjdrq6CsLgAxDrif/4f+AUxBzRDrRByGCAVxRKOGU11R0qfqf0UdEEAjcXdNjvZPTqC7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIksxuOHX/LuQVnYDkXnYdrXh966fY/fvmjHAUCrO7AZClEAu/
	YQQ97XloziMA672dPoUFaa8qjblE2Nxrs3xljW036fwXdMgAEXJ9A7XttMjiZEulDdc=
X-Gm-Gg: ATEYQzxEu/Eh1VjH1bn+bBGfe5ZH8DEFT5HBgzsk1gkSeVVsfJsPqj/PxDOEi7HBnsR
	W2JdICQfCDa6y7xDxavzyJh4rruU27UwDBZKq5lPF3gK75UZqwrSmb3akZL+qH4TJDgns0uFIbc
	edw/3lDaumeaOeG1+aQbG4004NFg5uOPypikxgslxF5bncJ+j7aqcHh7ujO/vJgaXmPyN1Bn8nL
	3/XPrWJber779mjZPrK74yOP7mVQVXeUlvC/E3463bVUsc3bQgaZf9uHrW6NCCQTMzWUqmruhs2
	18CLv1163ux/GmUsQRtTsxK2YsE+LS9GoF9D1hkYQUluDoG4TJzw3zJK28M8iaDmbJ/lmmyCI5H
	EW4gkIdNNTSwRg8PvmqgJxccfPLoWPHQreoJIB1UDHyidVGKvtxliMB1cdr7RqqDe7F7S4BHz2U
	zZNMiuKHBsv+ePXFjg1+Ju+j4niNEp3xbR29u3UM69sAz0FV1Mle0VJC/O+EAr91+k
X-Received: by 2002:a05:600c:c4a6:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-483c9bc0344mr52202975e9.12.1772206940611;
        Fri, 27 Feb 2026 07:42:20 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm83821705e9.5.2026.02.27.07.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 07:42:20 -0800 (PST)
Message-ID: <c84f0e40-50d9-4c99-92dd-00bcfc554d83@linaro.org>
Date: Fri, 27 Feb 2026 15:42:17 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] media: iris: add support for kaanapali platform
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2026 14:11, Vikash Garodia wrote:
> Qualcomm kaanapali platform have a newer generation of video IP iris4.
> The hardware have evolved mostly with respect to higher number of power
> domains as well as multiple clock sources.
> 
> Considering iris as a client driver, it adds the handling for multiple
> stream ids from VPU via iommu-map.
> 
> This series is depend on the below series:
> https://lore.kernel.org/all/20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com/
> 
> Following patches were dropped in v2, as per the comments, and would
> be posted separately. This series depends on these patches for
> functionality.
> - https://lore.kernel.org/all/20260126-kaanapali-iris-v1-2-e2646246bfc1@oss.qualcomm.com/
> - https://lore.kernel.org/all/20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com/
> 
> Patch #4 is also posted alongwith below series. If the other series is
> picked earlier, then this patch can be dropped from this series.
> https://lore.kernel.org/all/20260227-iris_sc7280_gen2_support-v2-1-7e5b13d26542@oss.qualcomm.com/

For the record this series is blocked on this:

https://lore.kernel.org/all/20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com/ 


---
bod
