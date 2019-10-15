Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453B8ECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 12:14:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21165205F4
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 12:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21165205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EE089E26;
	Tue, 15 Oct 2019 12:14:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A5809E18
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 12:14:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F01945D3
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 12:14:27 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 445092D9; Tue, 15 Oct 2019 14:14:26 +0200 (CEST)
Date: Tue, 15 Oct 2019 14:14:24 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: Re: iommu: amd: Fix incorrect PASID decoding from event log
Message-ID: <20191015121424.GM14518@8bytes.org>
References: <1571083556-105953-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1571083556-105953-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Oct 14, 2019 at 08:06:05PM +0000, Suthikulpanit, Suravee wrote:
> IOMMU Event Log encodes 20-bit PASID for events:
>     ILLEGAL_DEV_TABLE_ENTRY
>     IO_PAGE_FAULT
>     PAGE_TAB_HARDWARE_ERROR
>     INVALID_DEVICE_REQUEST
> as:
>     PASID[15:0]  = bit 47:32
>     PASID[19:16] = bit 19:16
> 
> Note that INVALID_PPR_REQUEST event has different encoding
> from the rest of the events as the following:
>     PASID[15:0]  = bit 31:16
>     PASID[19:16] = bit 45:42
> 
> So, fixes the decoding logic.
> 
> Fixes: d64c0486ed50 ("iommu/amd: Update the PASID information printed to the system log")
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Gary R Hook <gary.hook@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd_iommu.c       | 5 +++--
>  drivers/iommu/amd_iommu_types.h | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)

Applied for v5.4, thanks Suravee.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
