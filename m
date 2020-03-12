Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D7C10DCE
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 06:29:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035C620650
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 06:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="JP241TvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035C620650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 072968927F;
	Thu, 12 Mar 2020 06:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qh67IhQh4aKw; Thu, 12 Mar 2020 06:28:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D9A189005;
	Thu, 12 Mar 2020 06:28:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C6E7C18D3;
	Thu, 12 Mar 2020 06:28:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94C94C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 06:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7EBA885F0B
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 06:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lcNTYL8cQ-6A for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 06:28:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id ADC5C85E13
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 06:28:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1583994536; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=1U9Dhk5Hq6bAWxKppOxTuYI7ucms9N1Z1Z8GWTVbRSk=;
 b=JP241TvOKHdyXXedu2s96jIY4NlI7uzhtuBuYIS9KuqOTGiD68HgTF90X9EehJwaMHh/p82C
 Moj9zYAKmJtto0Uq28HM6Ljoh86E1cZ+IdcrAvprb/TciKwsPcOBBFntdOYeC3B66g3BsLjE
 colsP6nfS/azyWboPWvg53WjwOs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e69d68f.7fa82e80fa08-smtp-out-n02;
 Thu, 12 Mar 2020 06:28:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 14474C4478C; Thu, 12 Mar 2020 06:28:31 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FDDEC433CB;
 Thu, 12 Mar 2020 06:28:30 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 12 Mar 2020 11:58:30 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/3] Request direct mapping for modem firmware subdevice
In-Reply-To: <a50040a9-54fe-f682-dd7e-b2991b48d633@arm.com>
References: <20200309182255.20142-1-sibis@codeaurora.org>
 <20200310112332.GG3794@8bytes.org>
 <4ed6ddd667a3e6f670084a443d141474@codeaurora.org>
 <20200310162320.GL3794@8bytes.org>
 <a50040a9-54fe-f682-dd7e-b2991b48d633@arm.com>
Message-ID: <ff805c5c647326c5edaddf2efec5cb87@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: ohad@wizery.com, devicetree@vger.kernel.org,
 linux-kernel-owner@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, Sibi Sankar <sibis@codeaurora.org>, agross@kernel.org
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

Hi Robin,

On 2020-03-10 22:14, Robin Murphy wrote:
> On 10/03/2020 4:23 pm, Joerg Roedel wrote:
>> On Tue, Mar 10, 2020 at 07:30:50PM +0530, Sibi Sankar wrote:
>>> The accesses are initiated by the firmware
>>> and they access modem reserved regions.
>>> However as explained in ^^ any accesses
>>> outside the region will result in a violation
>>> and is controlled through XPUs (protection units).
>> 
>> Okay, this sounds like a case for arm_smmu_get_resv_region(). It 
>> should
>> return an entry for the reserved memory region the firmware needs to
>> access, so that generic iommu can setup this mapping.
>> 
>> Note that it should return that entry only for your device, not for 
>> all
>> devices. Maybe there is a property in DT or IORT you can set to
>> transport this information into the arm-smmu driver.
>> 
>> This is pretty similar to RMRR mapping on the Intel VT-d IOMMU or
>> Unity-mapped ranges in the AMD-Vi IOMMU.
> 
> Yup, a way to describe boot-time memory regions in IORT is in the
> process of being specced out; the first attempt at an equivalent for
> DT is here:
> 
> https://lore.kernel.org/linux-iommu/20191209150748.2471814-1-thierry.reding@gmail.com/
> 
> If that's not enough and the SMMU still needs to treat certain Stream
> IDs specially because they may be untranslatable (due to having direct
> access to memory as a side-channel), then that should be handled in
> the SoC-specific corner of the SMMU driver, not delegated to
> individual endpoint drivers.
> 

Are you talking about this one for SoC specific change - 
https://lore.kernel.org/patchwork/patch/1183530/

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
