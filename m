Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7E1C433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 07:33:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA4A20767
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 07:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgM48asA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA4A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1289588C13;
	Thu,  9 Jul 2020 07:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OenCS9NlGGgq; Thu,  9 Jul 2020 07:33:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 953B688C06;
	Thu,  9 Jul 2020 07:33:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A744C077B;
	Thu,  9 Jul 2020 07:33:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB54C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 07:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 232428846E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 07:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I9TR-8mgNV7F for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 07:32:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2F21F88462
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 07:32:14 +0000 (UTC)
Received: from localhost (unknown [122.182.251.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C24F220767;
 Thu,  9 Jul 2020 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594279934;
 bh=osjNtW7Vcsl6XAmexC2cVHsdXszVbxZeargjrRySMuA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FgM48asAEyYqqo3pNtHvbbzcmAGnCiHesy6730e5O/fCk7lM/Mi80rry/VUTwf9fP
 iCxgGhQv7KrE3E5FzDK+J74umYvxzhuYbw2wsqKAURVMoT3Xvwa/Bh2wzI0j2DeJog
 InFdiK7M+/Xf97CQNv+GgyzC6wUOhANqppmEsb/M=
Date: Thu, 9 Jul 2020 13:02:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 4/5] iommu/arm-smmu-qcom: Consstently initialize stream
 mappings
Message-ID: <20200709073204.GH34333@vkoul-mobl>
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
 <20200709050145.3520931-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709050145.3520931-5-bjorn.andersson@linaro.org>
Cc: Jonathan Marek <jonathan@marek.ca>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 08-07-20, 22:01, Bjorn Andersson wrote:
> Firmware that traps writes to S2CR to translate BYPASS into FAULT also
> ignores writes of type FAULT. As such booting with "disable_bypass" set
> will result in all S2CR registers left as configured by the bootloader.
> 
> This has been seen to result in indeterministic results, as these
> mappings might linger and reference context banks that Linux is
> reconfiguring.
> 
> Use the fact that BYPASS writes result in FAULT type to force all stream
> mappings to FAULT.

s/Consstently/Consistently in patch subject

-- 
~Vinod
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
