Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC833E9
	for <iommu@lists.linux.dev>; Thu, 21 Jul 2022 11:36:56 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id bv24so1858848wrb.3
        for <iommu@lists.linux.dev>; Thu, 21 Jul 2022 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3dGL++LPAmS2eym62mLHBoZzYDfysbltWj55S2SeBfY=;
        b=OHDVersEmMfP4wtrsESwOSLR0aXXXw6yByDlyUpqK4xliNb3B7DOAzxYpfWP2/eeOd
         FwQhuWP/+lA8XforgHtSjTZswnB5XirsvXBoHyLx/KQDRYyM0PwywNGlhp7U5gPIbdtT
         Ew5EFum/cqwspvE8JKTDPDmYYPeS7kMdkG2b5MaB1zyrdW6Y8Pu4iK6hMS5NaGEPaG7c
         q3DqmtqYJbb1NHptUKaKSkzlUfjaNYcLayRBwgGPUhPsZhN9VPegQWrfe1zmsBT7FT9f
         bVwJ5nheZYjKGhAnvcLyZXAdreOVxU08zCrQ32KargN2WtmgUzm3lPn0oepQ4+cNyCqX
         uybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3dGL++LPAmS2eym62mLHBoZzYDfysbltWj55S2SeBfY=;
        b=Ses4wgUswM/ylckdZmNsiLIADsdhT/l/T1H87YkC+/ovybxr/zgsl8P+qqawWEZyjG
         718nYMS8yUbaVmPQVc/Y06KFSl8sLavXO10PECriGnhSONxdyrqitFSzuz8kvfNB8Hqv
         fRrvwpCJuytOFgnAZoSSgUE6bRO1DcsCDXO+n10DUTymYEq+AaSN8+RIRujaR1kODYrP
         c/KEpsXLD6tVWUikzM9GphfXNUiVCATaKURLg3kp1Oinbpit5QJF9jj4KAiTHAnbNR5I
         w27XNf0DXDqyP+9TVCoDKJDX3er071ZYSfHbubK+3lnukMH+Aeth2U2USJY3GXrWewr2
         JdUw==
X-Gm-Message-State: AJIora8Pnx6FlFhOpYgBmyrbHvgTWQ1XAeDuEMWB1JmJ4P6Rj117zdqZ
	n6Y2RA7LMvU6gmfRZW1MW9Go2Q==
X-Google-Smtp-Source: AGRyM1viD12dLSWjZcRDX0xi2VY77xaUB6/V11P01gxqkWTXqVJej7u3/DmQVUgKdZEduGu4KbPfHw==
X-Received: by 2002:a5d:45c5:0:b0:21e:5755:d443 with SMTP id b5-20020a5d45c5000000b0021e5755d443mr1440971wrs.45.1658403414416;
        Thu, 21 Jul 2022 04:36:54 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003a2c7bf0497sm1685064wmo.16.2022.07.21.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 04:36:53 -0700 (PDT)
Date: Thu, 21 Jul 2022 12:36:51 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tinghan Shen <tinghan.shen@mediatek.com>,
	Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <Ytk6U4fncRJOaAq3@google.com>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-7-tinghan.shen@mediatek.com>
 <YtgDu70Lpl/uPOkf@google.com>
 <68a30bbd-5f9d-17d2-59fa-7b0da06ee877@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68a30bbd-5f9d-17d2-59fa-7b0da06ee877@linaro.org>

On Wed, 20 Jul 2022, Krzysztof Kozlowski wrote:

> On 20/07/2022 15:31, Lee Jones wrote:
> > On Wed, 20 Jul 2022, Tinghan Shen wrote:
> > 
> >> The System Control Processor System (SCPSYS) has several power
> >> management related tasks in the system. Add the bindings for it.
> >>
> >> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > 
> > Why have you ignored my review comments from v2?
> 
> If you refer whether the binding is needed at all, then the answer is
> yes, because this is not simple syscons but a device with children,
> which we want to parse/match.

This part is fine.

> Anyway Tinghan should respond to you about way how he proceeds...

This would be nice, yes.

I was referring to the submit line, which nearly made me miss it, again.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
