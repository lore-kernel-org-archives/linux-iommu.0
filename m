Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430837B71
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 14:00:06 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f6ef9a928fso51477045e9.3
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686060005; x=1688652005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwrMrJM0MbRtGcxqqd7/qoRa+Z48fgcXIKuxfVUvplM=;
        b=Qmkebezhd3bE3EvClEVx5a7mjquFqdwFKJ07a+K/AxFUAUuZLUzo+nJmpQh0A1yT2c
         Kseq4TT0aRD3LwDElehU16MKuowQDxTagXLfA+S2b9hCQkgoCb+B6EXJJDuZ0N5zENVv
         aQXBjdLHxHKnWazjp2gv4X85tqhJ8MXmp8xYbReBJ6riWDDaUmpesbk5nH+H+j9BLFr+
         QBZZfqfPTE/DJ+03sI6+cvdy0DPOJdkAiRf7xQfCvC0d7D9j5RW6ozVBibrWo1Toonq7
         jLK6vvN7LyMlsKZ7ADisxhcWO+C+lAzJonHXyuQXiB9TmJMl36QVEdRf39rfR+RLWvfZ
         /l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060005; x=1688652005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwrMrJM0MbRtGcxqqd7/qoRa+Z48fgcXIKuxfVUvplM=;
        b=DllzHaq+C3yd2FvqTXs0p1CcSAAviWyMpZO/ytO3bOuxS1l5UkYkO88HvEDWB9PIAN
         2cXd9pqzs1V3iJLSDzdzyxlZQAVsvRtPtS2F0C122LdN1ghOqw0/lI68Hr/2W3InCmLR
         e6Cu5oobJj5fNdcpG+JTx0+46JFqGSwtQ8Qe2mr5D1X7w9sqdkujzjpmQX2dv+KypWxm
         VJYaeRON2gua+BHG7ZuAMZxNXv61fN0kHYnsktTyxi+1bXrCcA7a5lIMvnYwRiRbmSw1
         Eua12nmjYrJHsXHFDBSI72TMqWXgsEQ0uiG56oFiIEbhNFS5TofEVqvwQBeG4ibVBWN1
         AJWA==
X-Gm-Message-State: AC+VfDwihiJq5j4nAGlN8G1STJlPLtp3+Mfhe+r+KKJHI6pj07J36jFI
	4sjIj+hBKF9d0ndrXy9EF024bQ==
X-Google-Smtp-Source: ACHHUZ4ccc0T1eCTcxB1MhwmrQqdwiijiuxyeqJgwleyD1UPH+KZBBX2FUY5GnJZiKflEDdNGeHzAA==
X-Received: by 2002:a5d:5102:0:b0:30e:4c8d:c6c with SMTP id s2-20020a5d5102000000b0030e4c8d0c6cmr1743312wrt.55.1686060004870;
        Tue, 06 Jun 2023 07:00:04 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d470e000000b002fed865c55esm12639517wrq.56.2023.06.06.07.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:00:04 -0700 (PDT)
Message-ID: <1dd3ee51-f1e8-2a4e-f0d5-dd61ee5206f2@baylibre.com>
Date: Tue, 6 Jun 2023 16:00:03 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 3/7] iommu/mediatek: Adjust mtk_iommu_config flow
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
 yf.wang@mediatek.com, jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
References: <20230602090227.7264-1-yong.wu@mediatek.com>
 <20230602090227.7264-4-yong.wu@mediatek.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230602090227.7264-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2023 11:02, Yong Wu wrote:
> If there are many ports in a infra master, current flow will update
> the INFRA register many times. This patch saves all ports to portid_msk
> in the front of mtk_iommu_config(), then update only once for the IOMMU
> configure. After this, we could avoid send too many SMC calls to ATF in
> MT8188.
> 
> Prepare for MT8188, also reduce the indention without functional change.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

