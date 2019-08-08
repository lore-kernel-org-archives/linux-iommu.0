Return-Path: <SRS0=VhCt=WE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B951C0650F
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 16:30:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF0C2184E
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 16:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s33+JumS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF0C2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9FBA3C87;
	Thu,  8 Aug 2019 16:30:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 63C51C86
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 16:30:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 01A2782D
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 16:30:18 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id EEFD62173E;
	Thu,  8 Aug 2019 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565281818;
	bh=Y3uN9pTmCxlKNY3HVkEXKnwavVansgR7KsRQWoVVlDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s33+JumSJA00EXmPFAAKKQs8NHVtwqO70GPV4+ZAHCxRXirXPa9Ci667SaWUM58qB
	fWNjT3PmR2+LNeOfdGiZeCsqTHlKbypay+ukfl8+MEdgYLD7xS5EVftrIus8p96s6q
	iqobkqw+4VjylAwQNwkUEZLBU+s8VQjSeiy+T8Tc=
Date: Thu, 8 Aug 2019 17:30:14 +0100
From: Will Deacon <will@kernel.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v3 1/4] firmware: qcom_scm-64: Add atomic version of
	qcom_scm_call
Message-ID: <20190808163013.u5qbke54kj555oxn@willie-the-truck>
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-2-vivek.gautam@codeaurora.org>
	<20190618175536.GI4270@fuggles.cambridge.arm.com>
	<CAFp+6iEwN6jeEGNxKVU5_i5NxdEbuF2ZggegEJZ1Rq6F=H34jg@mail.gmail.com>
	<20190805222755.GB2634@builder>
	<CAFp+6iHhh9749dAV4YDeE_0w1nCiftecTBedW4Rf0aiaOJsN2A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFp+6iHhh9749dAV4YDeE_0w1nCiftecTBedW4Rf0aiaOJsN2A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	David Brown <david.brown@linaro.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	robh+dt <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Aug 08, 2019 at 05:05:21PM +0530, Vivek Gautam wrote:
> On Tue, Aug 6, 2019 at 3:58 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > Would you be able to respin this patch, so that we could unblock the
> > introduction of the display nodes in the various device?
> 
> Will pointed [1] to the restructuring of arm-smmu to support
> implementation specific details.
> That hasn't been posted yet, and I haven't yet been able to work on that either.
> I will be happy to respin this series with the comments addressed if
> Will is okay to pull changes to unblock sdm845 devices. :)
> 
> [1] https://lore.kernel.org/patchwork/patch/1087457/

Just checked with Robin, and he's planning to post something tomorrow.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
