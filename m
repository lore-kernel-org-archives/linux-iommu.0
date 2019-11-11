Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23219C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 15:22:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F011821655
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 15:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F011821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B5AABD07;
	Mon, 11 Nov 2019 15:22:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6DEFFC51
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 15:22:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 02D528B2
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 15:22:06 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 36D8F1E6; Mon, 11 Nov 2019 16:22:05 +0100 (CET)
Date: Mon, 11 Nov 2019 16:22:03 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Subject: Re: [PATCH 1/1] iommu/amd: Fix the overwritten exclusion range with
	multiple IVMDs
Message-ID: <20191111152203.GJ18333@8bytes.org>
References: <20191104055852.24395-1-ahuang12@lenovo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104055852.24395-1-ahuang12@lenovo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

Hi Adrian,

On Mon, Nov 04, 2019 at 01:58:52PM +0800, Adrian Huang wrote:
> 	2) When set_device_exclusion_range() parses the IVMD of devce id
> 	   '4200', the exclusion range of the amd_iommu struct becomes:
> 
> 		iommu->exclusion_start = 0x9F58D000;
> 		iommu->exclusion_length = 0x8040000;
> 
> 	3) When parsing the second IVMD (device id '4300') in
> 	   set_device_exclusion_range(), the exclusion range of the
> 	   amd_iommu struct becomes:
> 
> 		iommu->exclusion_start = 0x9754D000;
> 		iommu->exclusion_length = 0x8040000;
> 
> 	   This overwrites the first IVMD configuration, which leads to
> 	   the failure of the first RAID controller.

Okay, I think this is clearly a BIOS bug as the BIOS should not define
two different exclusion ranges in the IVRS table.

So there are a couple of options here:

	1) Bail out and disable the IOMMU as the BIOS screwed up

	2) Treat per-device exclusion ranges just as r/w unity-mapped
	   regions.


I think option 2) is the best fix here.


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
