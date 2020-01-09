Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8953C33CA3
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 14:41:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787932072A
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 14:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBGaU9mY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787932072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 588CC21135;
	Thu,  9 Jan 2020 14:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RkmQtHtASvvd; Thu,  9 Jan 2020 14:41:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8B9E720116;
	Thu,  9 Jan 2020 14:41:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 759C3C18DC;
	Thu,  9 Jan 2020 14:41:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA983C0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 14:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 90C9288159
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 14:41:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yv6AqDh4k3Ve for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 14:41:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1858188012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 14:41:07 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7461720673;
 Thu,  9 Jan 2020 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578580866;
 bh=DlrMPvVhccNEDW9koI+U3MM8MLRCHlA/GNRJ1PYg/fQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hBGaU9mYNlsPavcKzkYmo8SaTZNfzP/+FyxOm3wgOBXu17YOlpUXWG+DX8Km4vn61
 nhbPjGDttsPWISCNuaksOju0v0lwRPNIzEjOpQmHmWIn2zp2h5RLc3ywrmizM5H0fE
 JZIoKiMKQKpN+2PBhZR09JXUtzQDao5gIDDtK21A=
Date: Thu, 9 Jan 2020 14:41:01 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 00/13] iommu: Add PASID support to Arm SMMUv3
Message-ID: <20200109144100.GD12236@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20200109143618.GA942461@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200109143618.GA942461@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, guohanjun@huawei.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Thu, Jan 09, 2020 at 03:36:18PM +0100, Jean-Philippe Brucker wrote:
> On Thu, Dec 19, 2019 at 05:30:20PM +0100, Jean-Philippe Brucker wrote:
> > Add support for Substream ID and PASIDs to the SMMUv3 driver. Since v3
> > [1], I added review and tested tags where appropriate and applied the
> > suggested changes, shown in the diff below. Thanks all!
> > 
> > I'm testing using the zip accelerator on the Hisilicon KunPeng920 and
> > Zhangfei's uacce module [2]. The full SVA support, which I'll send out
> > early next year, is available on my branch sva/zip-devel at
> > https://jpbrucker.net/git/linux/
> 
> Is there anything more I should do for the PASID support? Ideally I'd like
> to get this in v5.6 so I can focus on the rest of the SVA work and on
> performance improvements.

Apologies, I'm just behind with review what with the timing of the new
year. You're on the list, but I was hoping to get Robin's TCR stuff dusted
off so that Jordan doesn't have to depend on patches languishing on the
mailing list and there's also the nvidia stuff to review as well.

Going as fast as I can!

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
