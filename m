Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AA9C4727C
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 12:12:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EC820B1F
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 12:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EC820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8ECCF86A51;
	Thu,  1 Oct 2020 12:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u4UqbPgrLCxq; Thu,  1 Oct 2020 12:12:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8997A86A50;
	Thu,  1 Oct 2020 12:12:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D158C0889;
	Thu,  1 Oct 2020 12:12:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35F4AC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 12:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2B77D86B7D
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 12:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CtuEnPWC893q for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 12:12:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B12B98235D
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 12:12:15 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 806FD2C3; Thu,  1 Oct 2020 14:12:12 +0200 (CEST)
Date: Thu, 1 Oct 2020 14:12:11 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Subject: Re: [PATCH 1/1] iommu/amd: Fix the overwritten field in IVMD header
Message-ID: <20201001121210.GA30426@8bytes.org>
References: <20200926102602.19177-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200926102602.19177-1-adrianhuang0701@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

On Sat, Sep 26, 2020 at 06:26:02PM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> Commit 387caf0b759a ("iommu/amd: Treat per-device exclusion
> ranges as r/w unity-mapped regions") accidentally overwrites
> the 'flags' field in IVMD (struct ivmd_header) when the I/O
> virtualization memory definition is associated with the
> exclusion range entry. This leads to the corrupted IVMD table
> (incorrect checksum). The kdump kernel reports the invalid checksum:
> 
> ACPI BIOS Warning (bug): Incorrect checksum in table [IVRS] - 0x5C, should be 0x60 (20200717/tbprint-177)
> AMD-Vi: [Firmware Bug]: IVRS invalid checksum
> 
> Fix the above-mentioned issue by modifying the 'struct unity_map_entry'
> member instead of the IVMD header.
> 
> Cleanup: The *exclusion_range* functions are not used anymore, so
> get rid of them.
> 
> Fixes: 387caf0b759a ("iommu/amd: Treat per-device exclusion ranges as r/w unity-mapped regions")
> Reported-and-tested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  drivers/iommu/amd/init.c | 56 +++++++---------------------------------
>  1 file changed, 10 insertions(+), 46 deletions(-)

Applied for v5.9, thanks everyone.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
