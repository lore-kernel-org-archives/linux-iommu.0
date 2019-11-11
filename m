Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD03C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 15:11:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3D821655
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 15:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3D821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 37738CD4;
	Mon, 11 Nov 2019 15:11:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DAAFBCC0
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 15:11:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 487DE8AB
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 15:11:21 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id B286C1E6; Mon, 11 Nov 2019 16:11:19 +0100 (CET)
Date: Mon, 11 Nov 2019 16:11:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Fix QI_DEV_IOTLB_PFSID and
	QI_DEV_EIOTLB_PFSID macros
Message-ID: <20191111151118.GH18333@8bytes.org>
References: <20191108155803.15051-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191108155803.15051-1-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com
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

On Fri, Nov 08, 2019 at 04:58:03PM +0100, Eric Auger wrote:
> For both PASID-based-Device-TLB Invalidate Descriptor and
> Device-TLB Invalidate Descriptor, the Physical Function Source-ID
> value is split according to this layout:
> 
> PFSID[3:0] is set at offset 12 and PFSID[15:4] is put at offset 52.
> Fix the part laid out at offset 52.
> 
> Fixes: 0f725561e1684 ("iommu/vt-d: Add definitions for PFSID")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/linux/intel-iommu.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied for v5.4, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
