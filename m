Return-Path: <SRS0=VQ5+=43=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D2CC10F27
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 16:44:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41BC222C3
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 16:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41BC222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7CB9B885FE;
	Tue, 10 Mar 2020 16:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WNmkw5pK+01z; Tue, 10 Mar 2020 16:44:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C745A885E4;
	Tue, 10 Mar 2020 16:44:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB07BC07FE;
	Tue, 10 Mar 2020 16:44:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6BE2C0177
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 16:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B1A1C21548
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 16:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q7yIp0cZ4fio for <iommu@lists.linux-foundation.org>;
 Tue, 10 Mar 2020 16:44:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id A779D2152C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 16:44:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E0AB1FB;
 Tue, 10 Mar 2020 09:44:24 -0700 (PDT)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A613F67D;
 Tue, 10 Mar 2020 09:44:19 -0700 (PDT)
Subject: Re: [PATCH 0/3] Request direct mapping for modem firmware subdevice
To: Joerg Roedel <joro@8bytes.org>, Sibi Sankar <sibis@codeaurora.org>
References: <20200309182255.20142-1-sibis@codeaurora.org>
 <20200310112332.GG3794@8bytes.org>
 <4ed6ddd667a3e6f670084a443d141474@codeaurora.org>
 <20200310162320.GL3794@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a50040a9-54fe-f682-dd7e-b2991b48d633@arm.com>
Date: Tue, 10 Mar 2020 16:44:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200310162320.GL3794@8bytes.org>
Content-Language: en-GB
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 10/03/2020 4:23 pm, Joerg Roedel wrote:
> On Tue, Mar 10, 2020 at 07:30:50PM +0530, Sibi Sankar wrote:
>> The accesses are initiated by the firmware
>> and they access modem reserved regions.
>> However as explained in ^^ any accesses
>> outside the region will result in a violation
>> and is controlled through XPUs (protection units).
> 
> Okay, this sounds like a case for arm_smmu_get_resv_region(). It should
> return an entry for the reserved memory region the firmware needs to
> access, so that generic iommu can setup this mapping.
> 
> Note that it should return that entry only for your device, not for all
> devices. Maybe there is a property in DT or IORT you can set to
> transport this information into the arm-smmu driver.
> 
> This is pretty similar to RMRR mapping on the Intel VT-d IOMMU or
> Unity-mapped ranges in the AMD-Vi IOMMU.

Yup, a way to describe boot-time memory regions in IORT is in the 
process of being specced out; the first attempt at an equivalent for DT 
is here:

https://lore.kernel.org/linux-iommu/20191209150748.2471814-1-thierry.reding@gmail.com/

If that's not enough and the SMMU still needs to treat certain Stream 
IDs specially because they may be untranslatable (due to having direct 
access to memory as a side-channel), then that should be handled in the 
SoC-specific corner of the SMMU driver, not delegated to individual 
endpoint drivers.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
