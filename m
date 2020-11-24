Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F0C56201
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 21:41:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148E220872
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 21:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1tXba02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148E220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A68C9869C5;
	Tue, 24 Nov 2020 21:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id krPTaDadF55D; Tue, 24 Nov 2020 21:41:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2128885044;
	Tue, 24 Nov 2020 21:41:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 001CDC163C;
	Tue, 24 Nov 2020 21:41:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8226DC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7E1978480D
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YWzR7Zp3KZ0c for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:41:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0500583742
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:41:41 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D752206E5;
 Tue, 24 Nov 2020 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606254100;
 bh=+vMKUYxY6UzZeaMV4tTptbnuBH+pFcgBeuyebDSordU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e1tXba023wgparbkUVCIGkU3HbmnA9eF45ngTS19osHG77VEduKCx6HiAL08Bda/U
 nqZxU/eoBGzISqdFtjL51f5MJ2PelJepwzGefLkYqhCOvSrSayYxXnmsh9OzcqTZ32
 L8B5BYC9upY1CXE9lMQfGFIVQdLkCgd8LgX23fPE=
Date: Tue, 24 Nov 2020 21:41:35 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv9 2/8] iommu/arm-smmu: Add domain attribute for pagetable
 configuration
Message-ID: <20201124214134.GB14252@willie-the-truck>
References: <cover.1606150259.git.saiprakash.ranjan@codeaurora.org>
 <122e7b3050c51ee2e3637fca0b3967b4c3dc2bac.1606150259.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <122e7b3050c51ee2e3637fca0b3967b4c3dc2bac.1606150259.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Nov 23, 2020 at 10:35:55PM +0530, Sai Prakash Ranjan wrote:
> Add iommu domain attribute for pagetable configuration which
> initially will be used to set quirks like for system cache aka
> last level cache to be used by client drivers like GPU to set
> right attributes for caching the hardware pagetables into the
> system cache and later can be extended to include other page
> table configuration data.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 20 ++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
>  include/linux/io-pgtable.h            |  4 ++++
>  include/linux/iommu.h                 |  1 +
>  4 files changed, 26 insertions(+)

Given that we're heading for a v10 to address my comments on patch 3,
then I guess you may as well split this into two patches so that I can
share just the atttibute with Rob rather than the driver parts.

Please keep it all as one series though, with the common parts at the
beginning, and I'll figure it out.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
