Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E720E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 08:15:15 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id 19so4904921ljz.4
        for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=e+ERE0KIoScFnNn+zM8jJN/meHoLJnU/KJ0nScp1cAM=;
        b=ej3ctc4UQJ654wtTtLiTxBvgpCnZNLjLyuOrdNOd4+CszA6zehRmllfuaZyRbmchIW
         fBkyZGtvSC/ZH5Cqqs/qqQpp5QGpdeDQkpQ3unibnm79+FkU37BUoMSM6Ow9yQOMOSa3
         xX9sIIHxstIPDfNtEeikuNKW5bG/+RBrTvUU5nCWNiqxnbZQSm8p0/mFvaYqqug9jkMg
         gVul9xFyT+rmkbxV7/ysJLSv25941FpziMavn0n4MR+pUtrdUHj3UnzY9u+7RshYbrxe
         9IPYQ3QcGDIcPrhE8EkFnx0ht343qSG0X68toTsNL/ymMAY7OaTaenZ51p7VM0UWbSsw
         hRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=e+ERE0KIoScFnNn+zM8jJN/meHoLJnU/KJ0nScp1cAM=;
        b=nxV3/eZ6ut5meFFUppMZT0gZMBYdwG746syyxjI811nZNVGOTt5/zHhamGxFMk8g8K
         /hY7IZ4qHJW8U9Nq8DbGKKP0TNeHF7B61ukqez86yGcjR9TznGd1hmBAy/Pxbv5r8PWC
         SmOmgXGc24Sm2FvnXVHTFh/oqkwqRsvIHc8DfYtdwpaidsUfwKKBFgyw91fRBaxKNSCN
         0778Snuy9mgngBOxUapVKfouCqNw5CO6ww72iUuTCbsmzzEEQ5uDzOOUDjUitb7BPslT
         hyYooSgZ677lC8oQHdc5PXMJB/uMjEilH0LZhvrsuswtbKQMFmtA652wEdecWE5FJyzT
         XjFg==
X-Gm-Message-State: AJIora+7F2MCHDXo1WzRpoifrmikDbNZz7tpU6goLKdeyPLM4A4fPRXz
	i42AsMShbl6xPUsTVmEoCsPg/g==
X-Google-Smtp-Source: AGRyM1sMtUQaH6P6ehwbJuYCX/2dAmVEbQZVwJArYB54qbYI9BEIAead4/d8WxFm00HQoj3oVBoAyQ==
X-Received: by 2002:a2e:8719:0:b0:25d:7650:6c06 with SMTP id m25-20020a2e8719000000b0025d76506c06mr6336445lji.330.1657872913617;
        Fri, 15 Jul 2022 01:15:13 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id p22-20020a2eba16000000b0025d87966100sm632898lja.140.2022.07.15.01.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 01:15:13 -0700 (PDT)
Message-ID: <631560b2-58f7-064a-020b-d8029f04e451@linaro.org>
Date: Fri, 15 Jul 2022 10:15:10 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 05/19] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-6-tinghan.shen@mediatek.com>
 <c2e9f890-98c2-8f09-952d-495f2b57a254@linaro.org>
In-Reply-To: <c2e9f890-98c2-8f09-952d-495f2b57a254@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2022 10:07, Krzysztof Kozlowski wrote:
> On 14/07/2022 14:28, Tinghan Shen wrote:
>> Extract duplicated properties and support more levels of power
>> domain nodes.

Can you guys stop cc-ing all the non-working @mediatek.com emails? Every
time I got a bunch of bounced:

550 Relaying mail to weiyi.lu@mediatek.com is not allowed

and other like that.

Really, it's being since some time and it became extra annoying.

Best regards,
Krzysztof
