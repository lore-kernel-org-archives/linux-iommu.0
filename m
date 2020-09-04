Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52433C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 10:06:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6A8206D4
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 10:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6A8206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C10A085566;
	Fri,  4 Sep 2020 10:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27OrxoFg7yBj; Fri,  4 Sep 2020 10:06:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2894886C92;
	Fri,  4 Sep 2020 10:06:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D4B9C0052;
	Fri,  4 Sep 2020 10:06:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 035FEC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D2F6B204D0
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:06:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fYPvzrAvJwEA for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 10:05:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 95D1820407
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:05:59 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id DE4873D5; Fri,  4 Sep 2020 12:05:57 +0200 (CEST)
Date: Fri, 4 Sep 2020 12:05:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Message-ID: <20200904100556.GU6714@8bytes.org>
References: <20200824105415.21000-1-joro@8bytes.org>
 <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
 <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
 <MN2PR12MB448849D3AD019749DB64A146F7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828152943.GY3354@suse.de>
 <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "jroedel@suse.de" <jroedel@suse.de>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Fri, Aug 28, 2020 at 03:47:07PM +0000, Deucher, Alexander wrote:
> Ah, right,  So CZ and ST are not an issue.  Raven is paired with Zen based CPUs.

Okay, so for the Raven case, can you add code to the amdgpu driver which
makes it fail to initialize on Raven when SME is active? There is a
global checking function for that, so that shouldn't be hard to do.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
