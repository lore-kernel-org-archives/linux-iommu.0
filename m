Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB80C433EF
	for <iommu@archiver.kernel.org>; Sun,  3 Jul 2022 18:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 513AA4090B;
	Sun,  3 Jul 2022 18:50:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 513AA4090B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CVxzasIg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L_rHc57KhyRE; Sun,  3 Jul 2022 18:50:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BF9E9408D7;
	Sun,  3 Jul 2022 18:50:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF9E9408D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87EE6C0032;
	Sun,  3 Jul 2022 18:50:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18EC5C002D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 18:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E77FB6068D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 18:50:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E77FB6068D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=CVxzasIg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z1SRO8cuE7jT for <iommu@lists.linux-foundation.org>;
 Sun,  3 Jul 2022 18:50:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 795B560B62
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 795B560B62
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 18:50:47 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id v9so8576481ljk.10
 for <iommu@lists.linux-foundation.org>; Sun, 03 Jul 2022 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=HodKenU2DqzSAsTr3GOaLCVqw1DOEowtMVHlqD3WUxM=;
 b=CVxzasIgMMg1pGWidgzNRAOOjqyXaih7Ino2F33/WtmphQ2G35DoChFRM2GMulF6qG
 RZeAkWgaTLNCKg04WDjgpCbQ20Rc+QdUSoL4H2KT/lPGaN3SWeahcaW/E92RnP/4/5mZ
 hEOElL2md1ExhXOjnTFhgp1nXv/pwQYqNUsr9glnz3YntmEndmlpmKHFSSgRXB9su2ed
 EHuUG7Cuba9c7Mhok5IO3HAh4jWKu2BLBrpxhwShteT5hzS4JqnHMj7tscuqtPZVBzu5
 BHoinNNJqzenJrVc2bLsA3h7Inj6bPR5xf0q3un0x/hCj1bUl/HihG7F6q+BmQ8veBuk
 uFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HodKenU2DqzSAsTr3GOaLCVqw1DOEowtMVHlqD3WUxM=;
 b=NmG2My/kV/yY8+JAfW/j1QVWO/6qclUQMXQEmG276eBwhVAtfSPvzYbygpCXKFt4lf
 bp8s2JgQde+FjYId8hpMF9tD/XGpOVQgPAsiCtrGetbZ75OWHgcuNOwNSPYyeTfDD3mo
 7toUjgB+q1dssatSZJ9B4OZ31WS0wRn/DbZ9LSOtk+VjZbe3wCfPb/WuFJiHcW1MyX+O
 UZtHleKkPszt1NJHu0H3DIjOYdo+Gbzdhkvh7Oo9lAKK34WMcHgtIMRD+IcJZ60kVuGx
 0N5WHQDwy8DewoAgLiFi3+4CqGqp2GzdgJBdaaIKJ1NYEcGkzwPMdI71qwMuzu7CU7Tt
 7okg==
X-Gm-Message-State: AJIora8AKDHrfZ5FYeUV1NiDOBSe1EFgFiKn1niivf5b1LGuBr2tXEZX
 Z4cMHKLBS5tktOGnLIUIIjF2gA==
X-Google-Smtp-Source: AGRyM1txR24cjSx2T6SRyTgRrItDfRouegXb2R0VU95rLF87PA/vOL7GYszMuNNu6gRD1E1tnL2ZSA==
X-Received: by 2002:a05:651c:11c1:b0:25a:8968:b834 with SMTP id
 z1-20020a05651c11c100b0025a8968b834mr13980932ljo.212.1656874245240; 
 Sun, 03 Jul 2022 11:50:45 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05651238c700b0047f66294ff4sm4808396lft.151.2022.07.03.11.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 11:50:44 -0700 (PDT)
Message-ID: <9afb1e98-706f-ed61-892c-e3cc321364b4@linaro.org>
Date: Sun, 3 Jul 2022 20:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] iommu/exynos: Set correct dma mask for SysMMU v5+
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <20220702213724.3949-2-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220702213724.3949-2-semen.protsenko@linaro.org>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Cho KyongHo <pullip.cho@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 02/07/2022 23:37, Sam Protsenko wrote:
> SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
> mask to avoid falling back to SWTLBIO usage in dma_map_single() because
> of failed dma_capable() check.
> 
> The original code for this fix was suggested by Marek.
> 
> Originally-by: Marek Szyprowski <m.szyprowski@samsung.com>

This is some tip specific tag, I don't think checkpatch allows it.
Either use suggesgted-by or co-developed-by + SoB.

> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/iommu/exynos-iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 71f2018e23fe..28f8c8d93aa3 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -647,6 +647,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (MMU_MAJ_VER(data->version) >= 5) {
> +		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
> +		if (ret) {
> +			dev_err(dev, "Unable to set DMA mask: %d\n", ret);

Missing cleanup: iommu_device_unregister
and probably also: iommu_device_sysfs_remove

> +			return ret;
> +		}
> +	}
> +
>  	/*
>  	 * use the first registered sysmmu device for performing
>  	 * dma mapping operations on iommu page tables (cpu cache flush)


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
