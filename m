Return-Path: <SRS0=qkVD=5I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C87C4332B
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 09:43:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9159A206F8
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 09:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="K+8b7yzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9159A206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B5858204C5;
	Mon, 23 Mar 2020 09:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X0fQfJyLymsO; Mon, 23 Mar 2020 09:43:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CBF5B2011B;
	Mon, 23 Mar 2020 09:43:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6F92C1AE2;
	Mon, 23 Mar 2020 09:43:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C551C0177
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C53DB85B80
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YvRdJb3qoRzW for <iommu@lists.linux-foundation.org>;
 Mon, 23 Mar 2020 09:43:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 61C7085B78
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:43:28 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1584956610; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2HfQKcmZY8wkCxlBMQg4ncbqBdorw86rlxGU/P4LKZ0=;
 b=K+8b7yzAgfK+zLOFCCx5liS6SWqQ4Rdmj048I7m7EjSKZOhOypHH9BMx9zi/2czqWBy2wXPh
 imThDYZJigbbioHUXmjzy4Big8K/4kNDSG6xegpWRGHV112QnNd3pxhCBJMM6pswra861Aqv
 ZG159PLSrQBD1vVUybW0FxwhcTQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7884b9.7efc0c0ea2d0-smtp-out-n01;
 Mon, 23 Mar 2020 09:43:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 72DFDC432C2; Mon, 23 Mar 2020 09:43:21 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 47E68C43636;
 Mon, 23 Mar 2020 09:43:20 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 23 Mar 2020 15:13:20 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/3] Request direct mapping for modem firmware subdevice
In-Reply-To: <497e40b8-300f-1b83-4312-93a58c459d1d@arm.com>
References: <20200309182255.20142-1-sibis@codeaurora.org>
 <20200310112332.GG3794@8bytes.org>
 <4ed6ddd667a3e6f670084a443d141474@codeaurora.org>
 <20200310162320.GL3794@8bytes.org>
 <a50040a9-54fe-f682-dd7e-b2991b48d633@arm.com>
 <ff805c5c647326c5edaddf2efec5cb87@codeaurora.org>
 <497e40b8-300f-1b83-4312-93a58c459d1d@arm.com>
Message-ID: <defd76aa8551858eb568e0ca644d4f4f@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: ohad@wizery.com, devicetree@vger.kernel.org,
 linux-kernel-owner@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 agross@kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-msm-owner@vger.kernel.org
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

On 2020-03-12 17:35, Robin Murphy wrote:
> On 2020-03-12 6:28 am, Sai Prakash Ranjan wrote:
>> Hi Robin,
>> 
>> 
>> Are you talking about this one for SoC specific change - 
>> https://lore.kernel.org/patchwork/patch/1183530/
> 
> Exactly - this particular wheel needs no reinventing at all.
> 
> [ I guess I should go review those patches properly... :) ]
> 

It would be great if you could review the patch - 
https://lore.kernel.org/patchwork/patch/1183530/
Sibi has posted a v2 of this series based on that patch.

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
