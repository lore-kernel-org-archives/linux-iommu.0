Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4477C2BA19
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 13:19:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E4B2064A
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 13:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E4B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8B1DA8685D;
	Tue, 14 Apr 2020 13:19:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwJB5Q7WXlGG; Tue, 14 Apr 2020 13:19:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF233864DF;
	Tue, 14 Apr 2020 13:19:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9AD8C1D7D;
	Tue, 14 Apr 2020 13:19:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C374C0172;
 Tue, 14 Apr 2020 13:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E96C187D73;
 Tue, 14 Apr 2020 13:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tCKHJPPX7GmK; Tue, 14 Apr 2020 13:17:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0417887D11;
 Tue, 14 Apr 2020 13:17:27 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7CE0145B; Tue, 14 Apr 2020 15:17:26 +0200 (CEST)
Date: Tue, 14 Apr 2020 15:17:24 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC PATCH 33/34] iommu: Remove add_device()/remove_device()
 code-paths
Message-ID: <20200414131724.GA14731@8bytes.org>
References: <20200407183742.4344-1-joro@8bytes.org>
 <CGME20200407183806eucas1p2cf45fbce5a43a6b4fe3a623b28da0606@eucas1p2.samsung.com>
 <20200407183742.4344-34-joro@8bytes.org>
 <1a88547f-ac90-825e-e529-a56c2c4e0391@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a88547f-ac90-825e-e529-a56c2c4e0391@samsung.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Marek,

On Fri, Apr 10, 2020 at 12:39:38PM +0200, Marek Szyprowski wrote:
> > +		if (!group->default_domain)
> > +			continue;
> 
> It doesn't look straight from the above diff, but this continue leaks 
> group->lock taken.

You are right, thanks for the review! I fixed it in v2.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
