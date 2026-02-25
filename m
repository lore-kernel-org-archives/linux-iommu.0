Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8F39B48A
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026945; cv=none; b=rpvwuldC4otuAc8lkYH2Nr4lMGxobxB9VwW6Rlz6OuzAnHa7PFj8JwHSZZaFcWlq/BVkqE6z/d1Ko8nHqYm5/UlhtnLBf/dd2BiQrpSqbJ7DoBCiDbVvz2xuj5j1OApr9x0H6INWaTBtZ/TdeC2VLduoHOCJZnvaVU4s1kE0Jdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026945; c=relaxed/simple;
	bh=tYdjEGnz1EsZUC8A6iACOKdkEfqIBfxVguRN3pG2Qcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUdtVY7KzUfW13kLAD7/4BHuepxr8TFENiYkJ3Ltx4xgm7PFk+Lx4K++Qrhxdg6/kI/6rOPzc5OIjbj/NNW2nOC+BgBBDOOtgsC6hbcFQnXnrW8o6V4L595QLLupzZe6gFTjtHyuauoCLqjtIprpO71c4qWGkfqvT2HsdpWvTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wrhiO5/2; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrhiO5/2"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-65b94e0a875so9762812a12.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 05:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772026943; x=1772631743; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJfmcZ4qFbylZDu+uvn8Ui6nkXp001OEAlMyyRd9wXQ=;
        b=wrhiO5/2PPf7jVpdLc4377/Jq8aDyY2M/51fDBVQZDTjHRQmqrPtSosF2/eN0AAHBE
         QVUbPjPUd2mFX7FHILCxzvWuX74vpYYjSTIhwYChMScdMPfOfstsR7v/A+pBZRLepgTf
         FU+q/dETOSKjCkCawAefU5CDx1Lm0qK3FMetFBmWobpYQXW5eb7nIAA1VRCQ8Zr197dv
         klLlBKtN9OTdT06/yrMyinYgQDScMYqKf8joycmgO1oQzXOwJhqVQb7ozVS2jRjjLj/t
         hsR1jlFy6wOGw+nLlXq7PvZSFu37CCC97/44WqPoBO2iQgZGYHArPt4aaHwv6gt1WOx3
         Gawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026943; x=1772631743;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJfmcZ4qFbylZDu+uvn8Ui6nkXp001OEAlMyyRd9wXQ=;
        b=OZkpCux8h4EtRg2jpGakXxekAqxNVHzIaUUi2JOZMwmlCOYklOWWih4/NNs4ZYp6bm
         TMycis+lxaT+cCganT78pBYyqucDLkF68ffI3FMMK2IfoQGs5gCPmtCEjE5JOh4qlx+E
         aUiuE26BG6mfkY7TyjINhcC+dYAPPMTULLUyXRXMWQ2B/SLNfcPlUbOxOSPIfAxlvJgJ
         hivY0Fh1gvKYaN5mimc/TV9cMNQbQqxHzk0CzLd8/K/u6iEhc+98hLWBhCNyKqbkCeiI
         JG2HXBGirx7xEfBG5C44GBSijh16RCZpBzxzvLNVWOL8m+PAgNuCQ6jiAF3LqyDQ5V4l
         Ov8w==
X-Forwarded-Encrypted: i=1; AJvYcCULVyQw3vg285lz+Hce7Yq8iOjL1IDvnmeuG7V9H4IG+iT+FpRnbO79LRG0W2zLnGmui5fVEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3KEdJc84XUN6GZXp5GMRhf5fp+hiZCzak99vTr9zQLa8mCN2P
	DuQL5CXOsY1606gEjBE+gypgt2ia1GcgBew+lf13xYP43yfj8KPMXntVISHP57H4+Oo=
X-Gm-Gg: ATEYQzxLvgADeuXHGK7+c2nwYF8ugOcu1iUGory9FzLhJAvT0V0ne+xYMBcRpgV8SHt
	Z4IysdY0zwevBRRm91PpnR8mragiTLNMGfHVcvyhc8y8poBo7pYKNCzEmMgzfpLJ51lVvpLSU3f
	H47AeG2pXW8krxKkMA+bhdDsfrZp0KX0SwliZNFn+E7+KRofWO2zd+at/VXgRPxlxL7vTvxdpku
	GtWyKGPbD1yicWeWJEsQaG9Or4wX3klyFopM+rq8zL1tHz8jRtAGXdF5lcEkyfVTo/H9PLge3Yi
	/kyIqi6OkM3eKGtXdyM7hAMpFQf7j57tY3cV3KHyrSgp4oWE+SXDwhr50/2ymf07Br8RVIDqkhE
	KFI7TRC8KGBi3WiYEdzdaqMR7QK/M3eFQozY3K4Q3nFBzyFlIWaYjHniYiOlNnen1OF5TJjpidO
	B+Mve9Pl+BrBs/LPVg5JfwGf9OXtEh8b/nZmiaTO7Xd9nJ5NLkmocKqm3Q9fyw4uKP
X-Received: by 2002:a05:6402:51cc:b0:658:b76f:da7c with SMTP id 4fb4d7f45d1cf-65ea4ed5a89mr10428013a12.13.1772026942535;
        Wed, 25 Feb 2026 05:42:22 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13806sm4384331a12.19.2026.02.25.05.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 05:42:22 -0800 (PST)
Message-ID: <172a9083-8cd6-428f-bd3d-d831e610b37b@linaro.org>
Date: Wed, 25 Feb 2026 13:42:19 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/18] accel/qda: Introduce Qualcomm DSP Accelerator
 driver
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <vU2QyEVqOu-D3eGp7BZFICUeauxL32bwWzeidOAijoeVaJTk8KcRVsaQQD4MdFQEcaQTZ5RkzRsz9-Lhl1qsqg==@protonmail.internalid>
 <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/02/2026 19:08, Ekansh Gupta wrote:
> User-space staging branch
> ============
> https://github.com/qualcomm/fastrpc/tree/accel/staging

What would be really nice to see would be mesa integration allowing 
convergence of the xDSP/xPU accelerator space around something like a 
standard.

See: 
https://blog.tomeuvizoso.net/2025/07/rockchip-npu-update-6-we-are-in-mainline.html

---
bod
