Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4701AC433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 15:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5474825C6;
	Wed,  1 Dec 2021 15:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qzxV7tFBU1CD; Wed,  1 Dec 2021 15:19:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5829A81D47;
	Wed,  1 Dec 2021 15:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FDC7C0012;
	Wed,  1 Dec 2021 15:19:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FEDEC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 15:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF86B4028B
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 15:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lR9SU4WTC7wR for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 15:19:42 +0000 (UTC)
X-Greylist: delayed 00:19:14 by SQLgrey-1.8.0
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it
 [IPv6:2001:4b7a:2000:18::166])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B359A4022D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 15:19:42 +0000 (UTC)
Received: from [192.168.1.101] (83.6.166.111.neoplus.adsl.tpnet.pl
 [83.6.166.111])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 91A103F6CF;
 Wed,  1 Dec 2021 16:00:23 +0100 (CET)
Message-ID: <bd109d31-4f87-1155-613b-7df4293b3163@somainline.org>
Date: Wed, 1 Dec 2021 16:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] iommu: arm-smmu-impl: Add SM8450 qcom iommu
 implementation
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
References: <20211201073943.3969549-1-vkoul@kernel.org>
 <20211201073943.3969549-3-vkoul@kernel.org>
From: Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211201073943.3969549-3-vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
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


On 01.12.2021 08:39, Vinod Koul wrote:
> Add SM8450 qcom iommu implementation to the table of
> qcom_smmu_impl_of_match table which brings in iommu support for
> SM8450 SoC
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

With deep pain, as we've had to deal with this for a few generations now..

Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>



Konrad

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
