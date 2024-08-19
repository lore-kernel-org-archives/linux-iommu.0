Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE0174EDB
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079741; cv=none; b=WUGgEXEYHvzNPNU08qnqgNP3s2cwqqpX0ahXIYobyh3Pdh12qbG63JD8oLL6AkNcBxu3RX+r88WO4SzHC9yev5tCr3tTSbgFk2mZ54Rk8aM+J89rURm7zeSyDWFpVLKsSyLD6NWtPEQeFcpUhMvykRYtayqG0w6sjlW3K2XEOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079741; c=relaxed/simple;
	bh=EN08TFaSVBCQMLBeFx4mFOBoH9BoUxUimX0KlSPHLS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjTqAKG3FAY4LyHbh5HBrHxFEWjCXVph1t8lCuomP5xu8dlBfCLqNKeKCXOdKUM0tdyROUQte3kpzNySU1irZu6Dx1X9DvDGNy88uXb2sQ9zO58SRnYKljtnDCR8HCWFwprlvpcnPyuhJ4L8rSVtiAy/THIbg/h14EgDJuQGn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=bvW12yFd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="bvW12yFd"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36d2a601c31so2596744f8f.0
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1724079737; x=1724684537; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUK8OL34DJRMcxB19xg1k7/qsStJR02DDbFs+v32ruE=;
        b=bvW12yFdql4nRXfKpXGW4rkp/y7lT88LRe75Ri7pBzmShTeAjMrfmc5QhyPxLHhj8v
         ki1f6p29bGJUHneZvOQplYX1G8rrm/hZkvkgSu76SwGjmMpodPA6Uf9PTeeO7u5SLhGA
         bdGwc/sWL35yAI22IXQXuM69CXvagVZpR1OhVXIrD0crFuh+NvKjMIOfWBVh8FMFEKgM
         oMSvl2w2deLZFcMy0DnoTYG/RcQJ4wEDWmGYnePdpMZiX/imS7aygPxGULY7bNPHf2oY
         M/3567DBE6WkWGsBbBz9RwpEyjGYxezxM4G8WIJ87AF/D+30xvX7lhEP627U7tIU6eAI
         uEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724079737; x=1724684537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUK8OL34DJRMcxB19xg1k7/qsStJR02DDbFs+v32ruE=;
        b=P+6Zp0ptYp0E/3xzXVdC1F3lbnkMipjIkhmEKCgMPucZ1ukK8Hti/RydtXbzPkXijI
         D4yPHKAHnrPdgZ353ejnWoA2TLNdT+oibtbZSg7hXrJ4530Fsvj2E08VzCfP7D1v5ikc
         i4OqPdDjaiT+jxNUEv+T7CF6Ra7biYYoAD+Rjlh/xtPwzAdXVqxEI0x/J+EqrOeAXKgX
         qPTxK/9HMIIwe/nsxx/Qsc2FBiZYxfPXKQs3LTG7pa2REyDqid+9K2GFnklJDAJEWWXw
         jyTiwSPfxJTSnC+7YwasIUK/fijks6c0kYbBcE0rexjFBkRVFuyE41/20jyQd/lV9kg2
         kW5g==
X-Forwarded-Encrypted: i=1; AJvYcCVzGV6L44SeqT/yZtDgkJVBbjJiqZMYAlxxSt8vx4rreklpSLDoqVci7jIdN1PSwKvNDaNB6a3m3vEwzagZKJ1mSwgRiF4=
X-Gm-Message-State: AOJu0YySMfFQp2TleuEja97QLJV8LCfkhvriOT58D5nvwW+mrrix5XGV
	vHwEvHMsizFyIYLnIsZqvsic2A3yMp12pv6OXkrsT1ItfnctTheCtAf7YqLBR4E=
X-Google-Smtp-Source: AGHT+IHoBqukazpQ2b+gLTUJRvOUgCeOQ4+kudIq0jjRNmYddBHniXchx8b++5+6dBkpqdwg2at2Cg==
X-Received: by 2002:a5d:5e0f:0:b0:367:4d9d:56a5 with SMTP id ffacd0b85a97d-371983d5ea0mr5461777f8f.44.1724079737278;
        Mon, 19 Aug 2024 08:02:17 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2d7sm10875557f8f.10.2024.08.19.08.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 08:02:16 -0700 (PDT)
Message-ID: <67f9a762-6d14-4557-b1f6-22aabb33f927@freebox.fr>
Date: Mon, 19 Aug 2024 17:02:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add
 qcom,last-ctx-bank-reserved
To: Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <20240814-smmu-v1-0-3d6c27027d5b@freebox.fr>
 <20240814-smmu-v1-1-3d6c27027d5b@freebox.fr>
 <20240818152515.GA104481-robh@kernel.org>
 <30489eee-075b-461b-ab43-c8807d667630@freebox.fr>
 <17893776-9666-4bbe-b5fc-c3fe977d0337@arm.com>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <17893776-9666-4bbe-b5fc-c3fe977d0337@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 14:57, Robin Murphy wrote:

> Luckily, in this case it seems straightforward enough to be able to see 
> that if we have a "qcom,msm8996-smmu-v2" with 13 context banks then we 
> should just treat it as if it has 12 - it's also notable that it only 
> reports NUMSMRG=12, so we couldn't use more than that many S1 context 
> banks at once anyway.

This is what the hypervisor reports:

[    2.550974] arm-smmu 5100000.iommu: probing hardware configuration...
[    2.557309] arm-smmu 5100000.iommu: SMMUv2 with:
[    2.563815] arm-smmu 5100000.iommu:  stage 1 translation
[    2.568494] arm-smmu 5100000.iommu:  address translation ops
[    2.573791] arm-smmu 5100000.iommu:  non-coherent table walk
[    2.579434] arm-smmu 5100000.iommu:  (IDR0.CTTW overridden by FW configuration)
[    2.585088] arm-smmu 5100000.iommu:  stream matching with 12 register groups
[    2.592132] arm-smmu 5100000.iommu:  13 context banks (0 stage-2 only)
[    2.619316] arm-smmu 5100000.iommu:  Supported page sizes: 0x63315000
[    2.626225] arm-smmu 5100000.iommu:  Stage-1: 36-bit VA -> 36-bit IPA
[    2.632645] arm-smmu 5100000.iommu:  preserved 0 boot mappings


smmu->num_mapping_groups = 12
smmu->num_context_banks  = 13


Are you saying that

	smmu->num_context_banks > smmu->num_mapping_groups

does not make sense?


Would a well-placed

	if (smmu->num_context_banks > smmu->num_mapping_groups)
		smmu->num_context_banks = smmu->num_mapping_groups;

be a proper work-around?

(Probably in qcom_smmu_cfg_probe() so as to not interfere with other platforms.)


Maybe to limit the side effects even more:

	if (of_device_is_compatible(smmu->dev->of_node, "qcom,msm8998-smmu-v2") &&
		smmu->num_context_banks > smmu->num_mapping_groups))
		smmu->num_context_banks = smmu->num_mapping_groups;


Neither work-around would require changing the binding.

Is either work-around acceptable, Robin?

Regards

