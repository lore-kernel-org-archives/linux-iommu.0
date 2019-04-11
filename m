Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74928C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 14:51:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4470C2077C
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 14:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4470C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25BFD2878;
	Thu, 11 Apr 2019 14:51:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8E4532788
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 14:50:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 31E67F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 14:50:39 +0000 (UTC)
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id B5F3C212CF;
	Thu, 11 Apr 2019 16:50:37 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 9B60C211C7;
	Thu, 11 Apr 2019 16:50:37 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] dt-bindings: arm-smmu: Add qcom,msm8998-smmu-v2
	binding
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <edade219-aa77-e7f0-af68-1c192632b2ca@free.fr>
	<f5029889-6aaa-1315-0225-9b0e46e0697c@free.fr>
Message-ID: <9bac2350-46ef-dcc5-2c6c-5cf41ccf1dbf@free.fr>
Date: Thu, 11 Apr 2019 16:50:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f5029889-6aaa-1315-0225-9b0e46e0697c@free.fr>
Content-Language: en-US
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ;
	Thu Apr 11 16:50:37 2019 +0200 (CEST)
Cc: Jeffrey Hugo <jhugo@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Evan Green <evgreen@chromium.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Manu Gautam <mgautam@codeaurora.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411145037.dU0bDKkiU6TQRWmCxqQCAzVGyM2nzE8ksZ9ju7GSCr0@z>

+robh, +mrutland for DT

On 01/04/2019 17:44, Marc Gonzalez wrote:

> Unused at the moment, just future-proofing the DTS.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 3133f3ba7567..75d8487fd86f 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -25,6 +25,7 @@ conditions.
>                    Qcom SoCs must contain, as below, SoC-specific compatibles
>                    along with "qcom,smmu-v2":
>                    "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
> +                  "qcom,msm8998-smmu-v2", "qcom,smmu-v2",
>                    "qcom,sdm845-smmu-v2", "qcom,smmu-v2".
>  
>                    Qcom SoCs implementing "arm,mmu-500" must also include,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
