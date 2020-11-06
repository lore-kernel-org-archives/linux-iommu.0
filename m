Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51291C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 12:18:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C53120728
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 12:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C53120728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10D6786837;
	Fri,  6 Nov 2020 12:18:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t5KfmHdmPdy9; Fri,  6 Nov 2020 12:18:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5B1028681B;
	Fri,  6 Nov 2020 12:18:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39191C0893;
	Fri,  6 Nov 2020 12:18:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5D2EC0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 12:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 866CD2E0FA
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 12:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V1fODr8mkU65 for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 12:18:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id A0E4E2E0F9
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 12:18:54 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8FB55AC65;
 Fri,  6 Nov 2020 12:18:52 +0000 (UTC)
Date: Fri, 6 Nov 2020 13:18:50 +0100
From: "jroedel@suse.de" <jroedel@suse.de>
To: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
Subject: Re: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Message-ID: <20201106121850.GT22179@suse.de>
References: <MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104085306.GQ22179@suse.de>
 <MWHPR10MB13109574BDA0F1D8219A225C89EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104101454.GR22179@suse.de>
 <MWHPR10MB13108FAFDAD3D33132B6593489EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13106AFEA3B68E666DD9CA6089EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13107C8A602FD7EE065F4E3D89EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB1310AA6CDF577A1535600F7089EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201105123245.GS22179@suse.de>
 <MWHPR10MB1310C1E8308484E2F7F967E889ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR10MB1310C1E8308484E2F7F967E889ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Fri, Nov 06, 2020 at 05:51:18AM +0000, Merger, Edgar [AUTOSOL/MAS/AUGS] wrote:
> With Kernel 5.9.3 kernel-parameter pci=noats the system is running for
> 19hours now in reboot-test without the error to occur.

Thanks. So I guess the GPU needs a quirk to disable ATS on it. Can you
please send me the output of lspci -n -s "0b:00.0" (Given that 0b:00.0
ais your GPU)?

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
