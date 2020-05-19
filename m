Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF6DC433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 12:10:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25538207D8
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 12:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25538207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C21F5860C5;
	Tue, 19 May 2020 12:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pOKxRNPBiSrr; Tue, 19 May 2020 12:10:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C8E19860C4;
	Tue, 19 May 2020 12:09:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADA55C0881;
	Tue, 19 May 2020 12:09:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1413C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 12:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EDAE3864F5
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 12:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RpeuXd6vm2nj for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 12:09:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 13331875BD
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 12:09:16 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5AC77386; Tue, 19 May 2020 14:09:13 +0200 (CEST)
Date: Tue, 19 May 2020 14:09:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix pointer cast warnings on 32 bit
Message-ID: <20200519120911.GH18353@8bytes.org>
References: <20200519013423.11971-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200519013423.11971-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
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

On Tue, May 19, 2020 at 09:34:23AM +0800, Lu Baolu wrote:
> Pointers should be casted to unsigned long to avoid "cast from pointer
> to integer of different size" warnings.
> 
> drivers/iommu/intel-pasid.c:818:6: warning:
>     cast from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/iommu/intel-pasid.c:821:9: warning:
>     cast from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/iommu/intel-pasid.c:824:23: warning:
>     cast from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/iommu/intel-svm.c:343:45: warning:
>     cast to pointer from integer of different size [-Wint-to-pointer-cast]
> 
> Fixes: d64d47f4f5678 ("iommu/vt-d: Add nested translation helper function")
> Fixes: a3bea1a35c083 ("iommu/vt-d: Add bind guest PASID support")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 8 ++++----
>  drivers/iommu/intel-svm.c   | 3 ++-
>  2 files changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.

Btw, I think the PASID and Intel SVM code is pretty useless on 32 bit
anyway, no? It only supports 4 and 5 level page-tables, not the 2 and
3-level variants on 32-bit. Can you make it 64-bit only?


Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
