Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED497C433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 11:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87B42418E1;
	Tue, 17 May 2022 11:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NuBy2W7RCtSW; Tue, 17 May 2022 11:10:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E44F418D3;
	Tue, 17 May 2022 11:10:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A33EC0039;
	Tue, 17 May 2022 11:10:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0DF1C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95B794025F
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wpMfJIb6QdJe for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 11:10:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67B38400B9
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:10:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id AB0C91F43AE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652785809;
 bh=qf8uzbZ1EqZKktmG/w8A35nbIzmMTkGNdHNjUDAKrE0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YSEpN29NXtz9y0X68InodlahgVwMXAbQqp76hpOV6ZqVaCMcmQ604Hsdc+EMgGSWp
 iHP21VfOdjsMU1q4z3olc5ksKIpVDuSNx5b9aEEkn+xSaDc1zsEJl8U+RYi2zn9jpe
 byljfm3THQOEyYqu66vH85Ci4JOmATN1oJW7XYCJHYhoshg/JkrBjoXEyLcWFdkxXX
 5dR6aWBFVpXtDo80jDCg5oYpCI1Er0M31yjCljsEj17+xl84lwResrSPnngcH1cR3f
 HaQGPDaasbSn3GpwwWP6Tsl/H+vf1lvUEF2O2fuHLT+AHtofAujWeTA5b7lMIk/kOh
 DIboZigcnu4hQ==
Message-ID: <0ab46d63-3b3a-c847-df21-40efbeb01486@collabora.com>
Date: Tue, 17 May 2022 13:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: Add bindings for MT6795 M4U
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
 <20220513151411.395744-2-angelogioacchino.delregno@collabora.com>
 <20220516160307.GA2732645-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220516160307.GA2732645-robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, paul.bouchara@somainline.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht, krzysztof.kozlowski+dt@linaro.org,
 marijn.suijten@somainline.org, matthias.bgg@gmail.com,
 martin.botka@somainline.org, phone-devel@vger.kernel.org, will@kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 16/05/22 18:03, Rob Herring ha scritto:
> On Fri, 13 May 2022 17:14:10 +0200, AngeloGioacchino Del Regno wrote:
>> Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/iommu/mediatek,iommu.yaml        |  3 +
>>   include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
>>   2 files changed, 99 insertions(+)
>>   create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>


Hello Rob,

I'm sad to say that, but I have to send a new version of this patch even though
you have acked it already... and I will have to drop your ack, as the changes to
the yaml patch will be a bit different, as we're adding support for a phandle
to mediatek,infracfg after some discussion about it on patch 2/2 of this series.

The mediatek,infracfg phandle addition will come as a different series, and this
patch (on v2) will add a conditional for:

   - if:

       properties:

         compatible:

           contains:

             enum:

               - mediatek,mt6795-m4u

     then:

       required:

         - mediatek,infracfg

Sorry about wasting your time on this v1.

Regards,
Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
