Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FDDC3A5A4
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 12:42:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2FE21721
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 12:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="BZpl7Ngf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2FE21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C95D36069;
	Fri, 30 Aug 2019 12:42:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5A07D496B
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 12:41:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E41661FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 12:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jLbS4wyC9BOXRvnGDvAgUlr1i1hEqcJjCnRO9VKhPUc=;
	b=BZpl7Ngf+S2Bt6nSPZh/NN47MA
	CZo5IsxbxOIhPbRsCUEEAISIcFO9gYpQ5qCF2AiymXNKNbg9f4BeKsz6+6KLYQKq45AcyCuJ7j/RF
	M5527anW5eKFWCBEMx8mneRbUBEDSHZ9Mv8tf0bfNx/s65Gf8jmvMppB5Vz72aX+gMlW/dLe+Jtqd
	eVM48GhC4uk0sljorhX3Hd1lR2p0z3iVFGOHDp7eSEO1Jwr3J7ADSYKNRYlwNJXcFGb2W4xx7XzL7
	loNQMDQEi191AvmYShK+cStNx6k99tOI6d/n/q70xO2q7cwuFZ0IddHyhhx21Tr+rMzZKchGnUeF7
	DkDDuyJQ==;
Received: from [193.209.96.43] (helo=[10.21.26.179])
	by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
	id 1i3fh8-0001wS-Ip; Fri, 30 Aug 2019 15:07:58 +0300
Subject: Re: [PATCH 2/7] dt-bindings: arm-smmu: Add binding for nvidia, smmu-v2
To: Krishna Reddy <vdumpa@nvidia.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
	<1567118827-26358-3-git-send-email-vdumpa@nvidia.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <86cc6861-08e6-7e16-cb85-93de0aa62087@kapsi.fi>
Date: Fri, 30 Aug 2019 15:07:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567118827-26358-3-git-send-email-vdumpa@nvidia.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, praithatha@nvidia.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	talho@nvidia.com, yhsu@nvidia.com, linux-tegra@vger.kernel.org,
	treding@nvidia.com, avanbrunt@nvidia.com,
	linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 30.8.2019 1.47, Krishna Reddy wrote:
> Add binding doc for Nvidia's smmu-v2 implementation.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 3133f3b..0de3759 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,6 +17,7 @@ conditions.
>                           "arm,mmu-401"
>                           "arm,mmu-500"
>                           "cavium,smmu-v2"
> +                        "nidia,smmu-v2"

nvidia

Mikko

>                           "qcom,smmu-v2"
>   
>                     depending on the particular implementation and/or the
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
