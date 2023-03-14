Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324715A3
	for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 06:46:12 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id br6so472918lfb.11
        for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678776370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhbXxJ4vpNqee73M6/vRlz+kqj3z39OL4xPkGR3We6k=;
        b=GoWSTZrQsLS4XERhO2xMfwRPzK1whV8/7rN0TtUVHDXr6O3pyEMAtvwjGOv+9k0X0b
         fY3z2pXoNlajopNs9VcuylCpda5CLsWW/4neKFcFVm2ODY+63VagW6eessvxkCtqesVQ
         VB+eCpTKR6i+TCPxyzXgoNWVwFnzIK34Ql+ePGeI4WNemHqDOofhVWXoMv/jIm8te4Xk
         6CjPrigAmIAWdgkr+k7dMYjGOs5FsqyEH+1sodzPTVFrCx4V9Q4rlrZ4lh1S720e91Ji
         BPH46ULT+WyKwZC7wq7xK0Hn7Z21UlMVjiRKiPJxDaMbD14Lr+ybYHCaNVj8Xj1D4MZ5
         KrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhbXxJ4vpNqee73M6/vRlz+kqj3z39OL4xPkGR3We6k=;
        b=zH9Q05DQQWssdV0AQuJPN/PqQ7xzanlEodFOm/V4tt872HQfsv+/cGUw8xL8sWJBH8
         Avtj95rjNpk3gA6bwy48EFt6GlMLDGMmJa8TsCuD4Rk15hOsgNczuV8VIWHZoO5DlBQT
         Ax1d29EtZzgXO4jSAai7egHU9tNdmtLrSkQzLQ40jfwRSTfOQTawsx3cIenkBoNj2WWw
         oDxL7H0c/E689hf/NYwyEyEONxWiW/1H3zeYLOE/zqreSbqYeZyBsI00wTMBocbieCKB
         5Dx+mQoN7Iv8WDqmh+uQVK4Ur4KLtK5+r+eyG/e5D+deVeZvWChgUXzVVq3Ysf5tvLBX
         MTMA==
X-Gm-Message-State: AO0yUKXQk6FLunGpGNMWfgWa/+MiqG+uNp/08JeOoIAFv0GPxKVKC979
	d6xb9iU0IJl8zfn8IMF/mRhX9w==
X-Google-Smtp-Source: AK7set+h2ndOB4p0HTaSRJEa23fwejgd1QQBXJIK8545r8GXILzHRgIM69D8cqAOd6eDDgave0Vz3Q==
X-Received: by 2002:ac2:4191:0:b0:4e8:401a:3e2b with SMTP id z17-20020ac24191000000b004e8401a3e2bmr448737lfh.5.1678776370465;
        Mon, 13 Mar 2023 23:46:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6932:5570:6254:9edd? ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004db45096c99sm272438lfc.85.2023.03.13.23.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 23:46:09 -0700 (PDT)
Message-ID: <4ac7e2e0-9b19-c911-7297-3510e55d6cfd@linaro.org>
Date: Tue, 14 Mar 2023 07:46:07 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?=
 <Jianjiao.Zeng@mediatek.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 =?UTF-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= <Chengci.Xu@mediatek.com>,
 =?UTF-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 =?UTF-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= <Mingyuan.Ma@mediatek.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
References: <20230307080555.14399-1-yong.wu@mediatek.com>
 <20230307080555.14399-2-yong.wu@mediatek.com>
 <388e2274-d46a-68a4-3e85-5bd597085041@linaro.org>
 <aba29e7fd9a461f2d94c83cf2c7496521433847d.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aba29e7fd9a461f2d94c83cf2c7496521433847d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/03/2023 03:41, Yong Wu (吴勇) wrote:
> Hi Krzysztof,
> 
> Thanks very much for your help review.
> 
> On Wed, 2023-03-08 at 11:35 +0100, Krzysztof Kozlowski wrote:
>> On 07/03/2023 09:05, Yong Wu wrote:
>>> From: "Chengci.Xu" <chengci.xu@mediatek.com>
>>>
>>> Add descriptions for mt8188 IOMMU which also use ARM Short-
>>> Descriptor
>>> translation table format.
>>>
>>> In mt8188, there are two smi-common HW and IOMMU, one is for
>>> vdo(video
>>> output), the other is for vpp(video processing pipe). They connects
>>> with different smi-larbs, then some setting(larbid_remap) is
>>> different.
>>> Differentiate them with the compatible string.
>>>
>>> Something like this:
>>>
>>>   IOMMU(VDO)          IOMMU(VPP)
>>>       |                   |
>>> SMI_COMMON_VDO      SMI_COMMON_VPP
>>>
>>> ---------------     ----------------
>>>   |     |    ...      |     |    ...
>>> larb0 larb2  ...    larb1 larb3  ...
>>>
>>> We also have an IOMMU that is for infra master like PCIe.
>>> And infra master don't have the larb and ports.
>>>
>>> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
>>> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Indeed, I missed broken checkpatch/DCO chain.
> 
> Just confirm what this means.
> 
> Do you mean MAINTAINERS need to be updated since we add a prefix
> "mediatek," for the header file?

No it means, run checkpatch.

Best regards,
Krzysztof

