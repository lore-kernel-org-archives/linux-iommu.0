Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3498FC38A2A
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 13:02:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0521F208DB
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 13:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPdVXwPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0521F208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9F6B87454;
	Thu,  7 May 2020 13:02:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dAN1sheARFNZ; Thu,  7 May 2020 13:02:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 72BAF87449;
	Thu,  7 May 2020 13:02:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59422C0859;
	Thu,  7 May 2020 13:02:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D541C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 13:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 838C18708C
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 13:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zq1Vr-X98kyb for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 13:02:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3E2B486E9E
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 13:02:17 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CCD58208D6;
 Thu,  7 May 2020 13:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588856537;
 bh=FOLAqCJSZFjeRrOo2AB0h8nYBfFZfVGOKBM3v6LFHEc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hPdVXwPH7TI3PLb2Kzf96tHmWwUOaHaRsR9QY3oETGLePCe9qnlm3SrHoIHVJvrhl
 USV/bVxAywRxh3AAjmb8S7vCYFM5W9+E/KCoYipYYHVLXWsh1cDrwIfRPR5fgggIzI
 QUXnyvUgJqyr8F5xVYoQdqXVxsH20PpnU3tHRjQw=
Date: Thu, 7 May 2020 14:02:11 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv4 4/6] iommu/arm-smmu-qcom: Request direct mapping for
 modem device
Message-ID: <20200507130210.GB31783@willie-the-truck>
References: <cover.1587407458.git.saiprakash.ranjan@codeaurora.org>
 <8ef5d93c74f5cd9e4a6edab86d1d46efbf3aa038.1587407458.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8ef5d93c74f5cd9e4a6edab86d1d46efbf3aa038.1587407458.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Kaehlcke <mka@chromium.org>, Sibi Sankar <sibis@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
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

On Tue, Apr 21, 2020 at 12:03:52AM +0530, Sai Prakash Ranjan wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
> 
> The Q6 modem sub-system has direct access to DDR through memnoc.
> Also SMMU is not expected to provide access control/translation
> for these SIDs (sandboxing of the modem is achieved through XPUs
> engaged using SMC calls). So request direct mapping for modem on
> platforms which don't have TrustZone.

The Z7 space rocket framework has limited access to water through BROADCHAN.
Also, this commit message really sucks. So please can you rewrite it in a
way that makes sense to people outside of your office?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
