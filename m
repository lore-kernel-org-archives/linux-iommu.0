Return-Path: <SRS0=mxFs=VA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F1C0650E
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 16:57:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3FB218A0
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 16:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny058zpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3FB218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 29A5BC51;
	Wed,  3 Jul 2019 16:57:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 52E31AD1
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 16:57:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1119B834
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 16:57:32 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CDD9E21882;
	Wed,  3 Jul 2019 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562173052;
	bh=lF/LK5VWeXs45bSDLLs672rAdE+1FeG+kEPupm0/s3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ny058zpXJwWXcHe2EdpYuvfUSdtlDzRaNRpCbEn5o9ugeUjU8K2Hr9iOyrFoc75Xb
	eFQo4r/DnwimXsavr0PouTdSsiWUt6ABOsXy8QCzjKizuhRYLTI1J0HaftXe51UytU
	AJKBXuH1yjqrhMUPZutLzCTrcwxEzk6CbOT6xe8g=
Date: Wed, 3 Jul 2019 17:57:28 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, joro@8bytes.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Invalidate ATC when detaching a device
Message-ID: <20190703165728.2ykhtw2cnswxskss@willie-the-truck>
References: <20190703111920.23637-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190703111920.23637-1-jean-philippe.brucker@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Jul 03, 2019 at 12:19:20PM +0100, Jean-Philippe Brucker wrote:
> We make the invalid assumption in arm_smmu_detach_dev() that the ATC is
> clear after calling pci_disable_ats(). For one thing, only enabling the
> PCIe ATS capability constitutes an implicit invalidation event, so the
> comment was wrong. More importantly, the ATS capability isn't necessarily
> disabled by pci_disable_ats() in a PF, if the associated VFs have ATS
> enabled. Explicitly invalidate all ATC entries in arm_smmu_detach_dev().
> The endpoint cannot form new ATC entries because STE.EATS is clear.
> 
> Fixes: 9ce27afc0830 ("iommu/arm-smmu-v3: Add support for PCI ATS")
> Reported-by: Manoj Kumar <Manoj.Kumar3@arm.com>
> Reported-by: Robin Murphy <Robin.Murphy@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Hopefully Joerg can add this to his queue for 5.3.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
