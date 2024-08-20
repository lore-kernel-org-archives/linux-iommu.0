Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40B14B96B
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186637; cv=none; b=DDkqr0jzwc0+wCCvsg7JmiTf+7NN9eOIbklaNMBmueyUuQZ3plJh1rmws4Wx/3JU/WtvtKeZAhsbTva/YMZtuim4vq6V5TG4CB+v5ZWKOZNREg68Y7orQFpR5AUUwJfEP+9dlpsff3KGp7mAJzyZ8CFrFz7rBUIrAeUMNKDuQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186637; c=relaxed/simple;
	bh=JLwJvZEJ4FQcJlsdkCdftpn7WlsfUPPZSu64ISMQJ9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhaplR2hu0wF1MfXJuN7AKr+3p27AvGdEDERy7rIOVOUtfhhGjfIIQkmajzbKvxwn8tXgYhBwuj0ubc0uVgiJR5E+8ULuxOYFn5Hv8E8mALSo1PP+V5sh/k8ispJgykl4I241lSZXAv22+6FKQy6Oyg3jpxxq2Q0L76i7WISRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeZva3mm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeZva3mm"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8643235f99so195058366b.3
        for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724186634; x=1724791434; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yY4vNetXYvsnkw2DFC8H1kH4gA8u7ARIbqvnE6sG1Cc=;
        b=UeZva3mmGw8I8+TMY+f6C52+aFl35Vc/yc86jvL1t03p4jjk6qxz0KvjREAi/K0mBA
         C2jv6ASHEf9KDgBp3EExGrO840phy7jZ1IJ7rUz22uKLEfIOLNgHImJrJ5NEuXe3+eEG
         +sT19kuqFTYLH2DhwXFd3BgSrdZpa8Q/Iasd/odzvn0ZSVLFrpbNPhkxxE/5E1miRXX+
         zV57n6QKovMBofci8wh6lpbD5raqZ8F16ywCpX85cqBkdQ1cEs5OBL5WELpSj6PV/4M1
         4y4vUtm0i+2Z27eWG9OEwqmQcjD8yNBc1g21SEJlYZ+fSaa5JJVCpkw1ge6+F8G/DG8g
         oSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724186634; x=1724791434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yY4vNetXYvsnkw2DFC8H1kH4gA8u7ARIbqvnE6sG1Cc=;
        b=G52K7CJsE+B5PK5jkgfM8H0VzDYDixrtA+7Uvs8Q48OAH2vDZB2y2N8cY+bb4jWMAM
         AdsdzclqeQ/yXGD0r8RT56seGqg8Ban2QY6Ff0HxEXtW3MqV5+Y2iuG3lncQhGi+yTeB
         5Ll5hKW9W2a2nQE01iwNHAO2k5+GTlo2krUfPwcTDSaMqbT3xHWM6JrgUpo3TG+/++i2
         skLyC9trOhPGrwfHMvCmB23pHiBRAgv4L0DN64/VUjj4OOvtdERjr/lofu4ihSnIfxno
         44k8ZngctyBxdZrOChOpFTT+z6u9D1nLer7w5abECAt6mMqWbT2Rygv/T49wSJdSkFiE
         R86A==
X-Forwarded-Encrypted: i=1; AJvYcCVE1Imfsbe0RcBFRvtjn+CmyZ9RykBOkF4VVfL/nuwd10C+i19IvMxZ6b6ftmzEdmixFtM1Cw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz31g7WS+RFdhzuhTw83dAYAExU7gbn2FOjgZBEDV6ls6Fin0gT
	xJDMGHuA4sHmzol9D1cyISC2UTgURmabq0Rw7yZziajzXg/Ijuxh
X-Google-Smtp-Source: AGHT+IFT9OxSMHaf7wcsfNkvmOqHVu8Tc7SNr/lwJLFjb8ZxbaJb78dYme0DOGlzA7c3aDg+TR3IWQ==
X-Received: by 2002:a17:907:944d:b0:a7d:e956:ad51 with SMTP id a640c23a62f3a-a866f2c3804mr11419766b.21.1724186634040;
        Tue, 20 Aug 2024 13:43:54 -0700 (PDT)
Received: from [192.168.1.19] (79-100-234-73.ip.btc-net.bg. [79.100.234.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c689dsm805712166b.37.2024.08.20.13.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 13:43:53 -0700 (PDT)
Message-ID: <c5141c18-3f7b-41ac-a064-9911873d0bf9@gmail.com>
Date: Tue, 20 Aug 2024 23:43:50 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: venus: firmware: Use
 iommu_paging_domain_alloc()
To: Lu Baolu <baolu.lu@linux.intel.com>, Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20240812072105.9578-1-baolu.lu@linux.intel.com>
 <20240812072105.9578-2-baolu.lu@linux.intel.com>
Content-Language: en-US, bg-BG
From: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <20240812072105.9578-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thank you for the patch!

On 12.08.24 г. 10:21 ч., Lu Baolu wrote:
> An iommu domain is allocated in venus_firmware_init() and is attached to
> core->fw.dev in the same function. Use iommu_paging_domain_alloc() to
> make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20240610085555.88197-10-baolu.lu@linux.intel.com
> ---
>   drivers/media/platform/qcom/venus/firmware.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index fe7da2b30482..66a18830e66d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.ced

Acked-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>

I'll take the patch through linux-media tree.

> @@ -316,10 +316,10 @@ int venus_firmware_init(struct venus_core *core)
>   
>   	core->fw.dev = &pdev->dev;
>   
> -	iommu_dom = iommu_domain_alloc(&platform_bus_type);
> -	if (!iommu_dom) {
> +	iommu_dom = iommu_paging_domain_alloc(core->fw.dev);
> +	if (IS_ERR(iommu_dom)) {
>   		dev_err(core->fw.dev, "Failed to allocate iommu domain\n");
> -		ret = -ENOMEM;
> +		ret = PTR_ERR(iommu_dom);
>   		goto err_unregister;
>   	}
>   

-- 
regards,
Stan
