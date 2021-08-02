Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE17C4320E
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:16:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118F061107
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 118F061107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF48760869;
	Mon,  2 Aug 2021 15:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dsFyKtn2KWeQ; Mon,  2 Aug 2021 15:16:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B3376081B;
	Mon,  2 Aug 2021 15:16:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D08BBC0010;
	Mon,  2 Aug 2021 15:16:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF415C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD654403D9
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IuvhOEZiTw6F for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 15:16:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35C33403D6
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:16:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1ECE60F51;
 Mon,  2 Aug 2021 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627917371;
 bh=acb2BeSUbe3rYtpwUGbc3ak3uXaBswP9iQL7oYaIehM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NIci1ZbRX6xJt6APvjh2SXYw+990LwdsEvp9Sur3D4C/Kv0dP6TdW6xc1oW8BMysR
 Fpzs6et64t1kV8YX17JjUGqbbrz2OwDP/aT80nH0EbPfeTRdGr6MFoTXvzMIIJuURH
 54fm68Csl08B/r8lGWZlrrKEo0XF/ycsxRvVgj/mY58JcrEfnWkCqtvfAJx5rJZzQi
 y7M1LPEXE2BTTDSGgyAatntwENL9rZIX6aXtSzKH5zNR3Pv3+eynHS+ywE57GM4dme
 OC223XFa1jmVCzaHsMQUD16ugQYux1BKIDGfHNwbOgjtq4k9FAO2CsVQCIdomVmLaK
 tO/B6M6stp4Ug==
Date: Mon, 2 Aug 2021 16:16:07 +0100
From: Will Deacon <will@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [Patch V2 0/2] iommu/arm-smmu: Fix races in iommu domain/group
 creation
Message-ID: <20210802151607.GF28735@willie-the-truck>
References: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 18, 2021 at 02:00:35AM +0530, Ashish Mhetre wrote:
> Multiple iommu domains and iommu groups are getting created for the devices
> sharing same SID. It is expected for devices sharing same SID to be in same
> iommu group and same iommu domain.
> This is leading to context faults when one device is accessing IOVA from
> other device which shouldn't be the case for devices sharing same SID.
> Fix this by protecting iommu domain and iommu group creation with mutexes.

Robin -- any chance you could take a look at these, please? You had some
comments on the first version which convinced me that they are needed,
but I couldn't tell whether you wanted to solve this a different way or not.

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
