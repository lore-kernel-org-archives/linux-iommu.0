Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB02166F0C
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067471; cv=none; b=hp+yxiYb8IgJTKD/QLKbAwRV4gvNUSHBUDj+HaT2DR39Z2KfFxBzdW9YYkik/OtjrlqZSgv3Lo/PneuBAUbFJ8NjKnRjlvu2f/yFJFteKC8slky3aWLidB3hpyhfVK+IwpGsLf6vVW1rxCtx2/s7dT0nkwaD5D2zmPjw3tnvpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067471; c=relaxed/simple;
	bh=8/9B3QlhBwbDoJsFPD/l/32vonkGRYcKYIBM9WTI8Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z75/s1rpoJ4Z15p4KzKB7r3lu8ufxhzW5MhYCbX06zedZU69cF3r5WjjhWPTkRv+WFoMtB04BDQ9g8u9JpPpT+8Q2/xHimUn6606UPRYoV280jsx6CH4QyeFIa289/2ddS3ULgmWOxJRIJicXI/dFtDWX00OFMYZdNJ1T/bLxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=ZMTug0/0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="ZMTug0/0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso21765145e9.1
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 04:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1724067466; x=1724672266; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIDiWquIQ0tXErhdx+a7t4j4cfeeG9QXueTzJmbscTA=;
        b=ZMTug0/0OiEByJlDKTil3jU+aUoc3VbFsdJqZubvL7ZBpm/DKpLcKO/gbDy8Ghdf4J
         gIljCHJrm7Qk1igtPGRaAPj5HbQ3hGgAzs2i+gAz4a17WEj/JYY78/RTQY4QqUNh8jok
         Pie9KMCkGEnt6Nn7iEPb+gs3RbzcyV3Euj/Ju95UpqcJ/ibjBgxbFs58XAih16vz+Abz
         PDtZN7b/qpwlO2cVmpmdSTjB4M9ZxJi1rPjKiDfxRywNyfJ8kQLi/+MVm+ebs1d5oxhS
         bJPcvKErIkZHtSP1fCXBPKrq/1oeWsWPUBEM8a3o+cK9XJurDZs3QTsMbcLQYYa7QUaM
         nCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067466; x=1724672266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIDiWquIQ0tXErhdx+a7t4j4cfeeG9QXueTzJmbscTA=;
        b=h7mLyxAyG4Zc91UsCswGMTQjsW2qbDxuAvlX9jBprbWXJsZ/8co7jImJQH7fmNzMCI
         sFR1c2qvNvzbeH7xT62ehrACXMxqBIrzfSkgz5bXJAU4WLx8TB6T8dXZOuHaYL9SLpCc
         s/1QGYwu4+NoF6zRQUXSBBNLDfPHdtCqS7q4jp95xKlSDBs3pNxRgoZBDpwySEFqMiIF
         /EG+u6+OAIr+4ddmNjCp+/CtdCHJ1doo9RcgvqXkUiGoRFYub1NEZelk1eTvNX6VmKRF
         C7se6fWu3tFQ3U9hJvvrdR0hSMXiPlRSfcCTrIM5O/3Lahzmp+A/OfVAWMMCQRQM455d
         Qr9g==
X-Forwarded-Encrypted: i=1; AJvYcCWwy5qSFxzpQGdh4kajjMYNNe9tRNG2yEkz/DN87smOe/mGE5omSC5IlJVNZt5PS4Xw09w3vVad5JQJwtwi7OlCkv9J2JI=
X-Gm-Message-State: AOJu0YxgI4dzaMBK9E19H9VOhG7Af71EwTSP+vvYw26Ndcnfd172vi5O
	VP9tm2Dce/jRlr3F2ucWvA6sRTOKpYHY14wT0/tztYXEzz6uD8yELUfloh6xwSQ=
X-Google-Smtp-Source: AGHT+IFOJqjoHU776vMvmeNPhV5ABeHBYFbyd6hV4KkeFyukt8jo0BTVCxoIlRPdXMWDFe8ccG01ag==
X-Received: by 2002:a05:600c:468e:b0:426:5b19:d2b3 with SMTP id 5b1f17b1804b1-429e23b4b0cmr98450015e9.14.1724067465664;
        Mon, 19 Aug 2024 04:37:45 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896a9csm10335771f8f.79.2024.08.19.04.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:37:45 -0700 (PDT)
Message-ID: <30489eee-075b-461b-ab43-c8807d667630@freebox.fr>
Date: Mon, 19 Aug 2024 13:37:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add
 qcom,last-ctx-bank-reserved
To: Rob Herring <robh@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Marijn Suijten <marijn.suijten@somainline.org>
References: <20240814-smmu-v1-0-3d6c27027d5b@freebox.fr>
 <20240814-smmu-v1-1-3d6c27027d5b@freebox.fr>
 <20240818152515.GA104481-robh@kernel.org>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <20240818152515.GA104481-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2024 17:25, Rob Herring wrote:

> On Wed, Aug 14, 2024 at 03:59:55PM +0200, Marc Gonzalez wrote:
>
>> On qcom msm8998, writing to the last context bank of lpass_q6_smmu
>> (base address 0x05100000) produces a system freeze & reboot.
>>
>> Specifically, here:
>>
>> 	qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
>> 	arm_smmu_cb_write(smmu, qsmmu->bypass_cbndx, ARM_SMMU_CB_SCTLR, 0);
>>
>> and here:
>>
>> 	arm_smmu_write_context_bank(smmu, i);
>> 	arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_CB_FSR_FAULT);
>>
>> It is likely that FW reserves the last context bank for its own use,
>> thus a simple work-around would be: DON'T USE IT in Linux.
>>
>> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
>> ---
>>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index 280b4e49f2191..f9b23aef351b0 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -204,6 +204,12 @@ properties:
>>        access to SMMU configuration registers. In this case non-secure aliases of
>>        secure registers have to be used during SMMU configuration.
>>  
>> +  qcom,last-ctx-bank-reserved:
>> +    type: boolean
>> +    description:
>> +      FW reserves the last context bank of this SMMU for its own use.
>> +      If Linux tries to use it, Linux gets nuked.
> 
> How is this Qualcomm specific? Presumably any implementation could do 
> this if there's no way to properly partition things. Robin?

Obviously, there is nothing Qualcomm specific about reserving   
an SMMU context bank for the FW / hypervisor, other than it
appears that qcom is the first to do it; or at least the
LPASS SMMU on qcom msm8998 is the first known SMMU where such
a work-around is required.

What is the correct nomenclature?

Can we just drop the vendor prefix if a property is generic
across vendors? But does it require a subsystem prefix like
"iommu" in order to not clash with generic props in other subsystems?

> Also, this property isn't very flexible. What happens when it is not the 
> last bank or more than 1 bank reserved? This should probably be a mask 
> instead.

OK, I'm getting conflicting requests here.

Bjorn has recommended dropping the property altogether:

> It also seems, as the different SMMUs in this platform behave
> differently it might be worth giving them further specific compatibles,
> in which case we could just check if it's the qcom,msm8998-lpass-smmu,
> instead of inventing a property for this quirk.


I'll send a patch series in line with Bjorn's request.

Regards

