Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80A5C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 15:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 808E560E29;
	Tue, 31 May 2022 15:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUrR5fgYtO4X; Tue, 31 May 2022 15:46:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 70CF460C21;
	Tue, 31 May 2022 15:46:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4291BC0032;
	Tue, 31 May 2022 15:46:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCAB3C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4BBF60E29
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:46:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j8sjUkvMekzV for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 15:46:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F15960C21
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:46:43 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 23DDEB8121D;
 Tue, 31 May 2022 15:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA6AC385A9;
 Tue, 31 May 2022 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654011998;
 bh=28hNyHGSDpZHs0jrlZm4DevaiKS1Dgov9Cghpq4OuQU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aNYFRHksLYtUcCAcZ7Buwq9ttW4S4yXcIn65uSfG/yW7ZUq04CMK8dwJoYjmXP2Dy
 rXfdQhC5MvbakIbjSye0D4OfqBhFz0k0NR/zTliFhCGaMqiy3MXwkUixzciVR56ag0
 mgO3/6kt6UHQ4Rnw5GnMOw7m1UBe0zJ6z+pmNro2OjVpor9BwZIV6ovTEbfP0wy7eE
 B7y9Bm2zHTBfEM3gvdPrtkDwQfdJv1Zz8VnYK/WEHqwb9D87bY1QR0uPAZc9vNbMRw
 G5CjSrSef4K/vaTzdrxxlVW82I6yhQ8vqEymj5K+2sLUgnLpmy9Mxf97Ie/yOQ5NgL
 CNQsT4KLKq9cg==
Date: Tue, 31 May 2022 16:46:31 +0100
From: Will Deacon <will@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
 specified
Message-ID: <20220531154631.GA25502@willie-the-truck>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220527212901.29268-2-konrad.dybcio@somainline.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, jamipkettunen@somainline.org,
 Rob Herring <robh+dt@kernel.org>, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>, martin.botka@somainline.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
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

On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> As specified in this driver, the context banks are 0x1000 apart.
> Problem is that sometimes the context number (our asid) does not
> match this logic and we end up using the wrong one: this starts
> being a problem in the case that we need to send TZ commands
> to do anything on a specific context.

I don't understand this. The ASID is a software construct, so it shouldn't
matter what we use. If it does matter, then please can you explain why? The
fact that the context banks are 0x1000 apart seems unrelated.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
