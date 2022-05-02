Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47718C433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 10:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A956A414CA;
	Mon,  2 May 2022 10:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cx8ta_aD678U; Mon,  2 May 2022 10:54:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 480D340372;
	Mon,  2 May 2022 10:54:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25930C0039;
	Mon,  2 May 2022 10:54:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEF17C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 10:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C533B414C1
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 10:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aicATeSQG5I2 for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 10:54:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB43F40372
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 10:54:40 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 0B7F95E5; Mon,  2 May 2022 12:54:36 +0200 (CEST)
Date: Mon, 2 May 2022 12:54:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 10/37] iommu/amd: Introduce per PCI segment last_bdf
Message-ID: <Ym+4a1tBE5QIcurO@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <20220425113415.24087-11-vasant.hegde@amd.com>
 <YmpoBWi60jPh6V/o@8bytes.org>
 <bc60989b-9f90-697f-f2f2-bad42f27f73b@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc60989b-9f90-697f-f2f2-bad42f27f73b@amd.com>
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

Hi Vasant,

On Fri, Apr 29, 2022 at 08:15:49PM +0530, Vasant Hegde wrote:
> We still need to parse IVHD to find max devices supported by each PCI segment
> (same as the way its doing it today). Hence we need all these variables.

From what I have seen since a few years the IVRS tables enumerate the
whole PCI segment, up to device ff:1f.7. This results in the maximum
being allocated for all data structures anyway. Therefore we can
probably think about skipping the scan to find the largest bdf and just
assume it is ff:1f.7, saving us all the size-tracking variables?

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
