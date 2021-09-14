Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4EBC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 12:10:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945106103B
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 12:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 945106103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AD86607D3;
	Tue, 14 Sep 2021 12:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lMrfaMd1Q0ts; Tue, 14 Sep 2021 12:10:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8A4326058A;
	Tue, 14 Sep 2021 12:10:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62C6DC000F;
	Tue, 14 Sep 2021 12:10:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9321CC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 12:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74A23400E4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 12:10:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Dfd5iD8W-Wu for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 12:10:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40394400DE
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 12:10:24 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9BC6A2FF; Tue, 14 Sep 2021 14:10:19 +0200 (CEST)
Date: Tue, 14 Sep 2021 14:09:47 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
 (0xf77ef22294ada : 0x400f77ef22294ada).
Message-ID: <YUCRC0CI7rWXt4VA@8bytes.org>
References: <16533743-de8d-6355-211d-1b4f8949fcfb@molgen.mpg.de>
 <2f5b07e4-5492-330b-b057-55230639cd5e@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2f5b07e4-5492-330b-b057-55230639cd5e@molgen.mpg.de>
Cc: David Coe <david.coe@live.co.uk>, Robert Richter <rrichter@amd.com>,
 Alexander Monakov <amonakov@ispras.ru>, iommu@lists.linux-foundation.org,
 Dell.Client.Kernel@dell.com
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

On Tue, Sep 14, 2021 at 11:10:57AM +0200, Paul Menzel wrote:
> Linux 5.15-rc1 still warns about that (also with latest system firmware
> 1.1.50).

The reason is most likely that the latest firmware still reports a
different EFR feature set in the IVRS table than the IOMMU reports in
its EFR MMIO register.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
