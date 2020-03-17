Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192EAC18E5B
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 15:52:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52C620663
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 15:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="b+GNoQbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52C620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AE354870F4;
	Tue, 17 Mar 2020 15:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CO15I9Tq53ay; Tue, 17 Mar 2020 15:52:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 342B3871CA;
	Tue, 17 Mar 2020 15:52:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19E00C18DA;
	Tue, 17 Mar 2020 15:52:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CE03C013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 15:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7DB8488A22
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 15:52:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7+DeklW8M6Sz for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 15:52:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 262AC87E0E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 15:52:35 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1584460358; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=F3ioMX8bj8P3wFuntkEmg3te9kA2v3f1KYJgn3TX8No=;
 b=b+GNoQbbZo4qOeRg2m1sr1c0v9bTRix6JtQUFfSgYXPoAY7dFgHyU3U2tkMe0oO3FQfMe1Jp
 goXl6fmlCiK/z34dqWq1H5QfhQT9HdpJ/9RO/WagbvcPh7OA4rXjCJU5qC9d5K5QlgdG2zdn
 jdMgSB/YsZQrUO45Lk08zV8lcDk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e70f236.7fc3b37cc570-smtp-out-n01;
 Tue, 17 Mar 2020 15:52:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 76A00C432C2; Tue, 17 Mar 2020 15:52:22 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: sibis)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id CBA72C433D2;
 Tue, 17 Mar 2020 15:52:21 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 17 Mar 2020 21:22:21 +0530
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org, robh+dt@kernel.org, joro@8bytes.org,
 robin.murphy@arm.com
Subject: Re: [PATCH v2 0/3] Request direct mapping for modem device
In-Reply-To: <20200317150910.26053-1-sibis@codeaurora.org>
References: <20200317150910.26053-1-sibis@codeaurora.org>
Message-ID: <fe9bb128563bea9798573ac9eec1d214@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: ohad@wizery.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dianders@chromium.org, iommu@lists.linux-foundation.org, agross@kernel.org
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

On 2020-03-17 20:39, Sibi Sankar wrote:
> The Q6 modem sub-system has direct access to DDR through memnoc and
> an indirect access routed through a SMMU which MSS CE (crypto engine
> sub-component of MSS) uses during out of reset sequence. Request direct
> mapping for the modem device since smmu is not expected to provide 
> access
> control/translation for these SIDs (sandboxing of the modem is achieved
> through XPUs engaged using SMC calls). This is done on platforms which
> don't have TrustZone (which programs the modem SIDs) to prevent the
> following global faults seen on Cheza/Trogdor:
> 
> Cheza:
> arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0 0x00000000,
> 			 GFSYNR1 0x00000781, GFSYNR2 0x00000000
> 
> Trogdor:
> arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0 0x00000000,
> 			 GFSYNR1 0x00000461, GFSYNR2 0x00000000
> 
> V2:
>  * Request direct mapping from SoC-specific corner of the SMMU
>    driver [Robin]
>  * Add iommu property to remoteproc modem node on Cheza
> 
> Depends on:
> https://lore.kernel.org/patchwork/cover/1183528/
> 
> Sibi Sankar (3):
>   dt-bindings: remoteproc: qcom: Add iommus property
>   remoteproc: qcom_q6v5_mss: Request direct mapping for modem device

iommu: arm-smmu-qcom: Request direct mapping for modem device

sry should have been ^^ instead


>   arm64: dts: qcom: sdm845-cheza: Add iommus property
> 
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 3 +++
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                 | 4 ++++
>  drivers/iommu/arm-smmu-qcom.c                              | 6 ++++++
>  3 files changed, 13 insertions(+)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
