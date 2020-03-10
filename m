Return-Path: <SRS0=VQ5+=43=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B3CC10F27
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 16:23:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E7920848
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 16:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E7920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 961D2885D6;
	Tue, 10 Mar 2020 16:23:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCPUUM-GF0gl; Tue, 10 Mar 2020 16:23:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0C32B885CC;
	Tue, 10 Mar 2020 16:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB043C07FE;
	Tue, 10 Mar 2020 16:23:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9FB9C0177
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 16:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A8D01885D4
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 16:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u9ZX6sgeqUYK for <iommu@lists.linux-foundation.org>;
 Tue, 10 Mar 2020 16:23:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 53CAE885CC
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 16:23:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BF8F2396; Tue, 10 Mar 2020 17:23:21 +0100 (CET)
Date: Tue, 10 Mar 2020 17:23:20 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 0/3] Request direct mapping for modem firmware subdevice
Message-ID: <20200310162320.GL3794@8bytes.org>
References: <20200309182255.20142-1-sibis@codeaurora.org>
 <20200310112332.GG3794@8bytes.org>
 <4ed6ddd667a3e6f670084a443d141474@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ed6ddd667a3e6f670084a443d141474@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ohad@wizery.com, devicetree@vger.kernel.org,
 linux-kernel-owner@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, agross@kernel.org
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

On Tue, Mar 10, 2020 at 07:30:50PM +0530, Sibi Sankar wrote:
> The accesses are initiated by the firmware
> and they access modem reserved regions.
> However as explained in ^^ any accesses
> outside the region will result in a violation
> and is controlled through XPUs (protection units).

Okay, this sounds like a case for arm_smmu_get_resv_region(). It should
return an entry for the reserved memory region the firmware needs to
access, so that generic iommu can setup this mapping.

Note that it should return that entry only for your device, not for all
devices. Maybe there is a property in DT or IORT you can set to
transport this information into the arm-smmu driver.

This is pretty similar to RMRR mapping on the Intel VT-d IOMMU or
Unity-mapped ranges in the AMD-Vi IOMMU.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
