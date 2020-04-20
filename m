Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DEFC3A5A0
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 18:36:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829112074F
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 18:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CFRYGaoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829112074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 617588773E;
	Mon, 20 Apr 2020 18:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sh1BNcSIXl-t; Mon, 20 Apr 2020 18:36:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E79C687691;
	Mon, 20 Apr 2020 18:36:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF3E7C1D74;
	Mon, 20 Apr 2020 18:36:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB8BDC0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BAA328773D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8zT1CIMQmXB8 for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 18:36:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0C25887691
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:36:40 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587407801; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7e3eo1fJ3V4W47xQX8u/gUmo/iNTfiSlIlfQaS2lzFU=;
 b=CFRYGaooNwQHUYztD/Tvxa9ccyjEnSUdkRqK6CvPc/7vdBA2o1Qeyk1mdJf4ymti/mA15dg0
 Xt8YfWcCznQ2LVgUbZgiIuPShLhInqEMb47MJk4oxchRRDcFu2TgPleH/lIthCk86lfz4nL9
 L+y6qRaOczUzjwr2HpUsxLnBdIk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9debb8.7f210799eb58-smtp-out-n04;
 Mon, 20 Apr 2020 18:36:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 6AAF1C433BA; Mon, 20 Apr 2020 18:36:40 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DF97EC433F2;
 Mon, 20 Apr 2020 18:36:39 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 21 Apr 2020 00:06:39 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv3 2/6] iommu/arm-smmu: Allow client devices to select
 direct mapping
In-Reply-To: <b69fc30c-e6fb-70bf-4d6e-0d9b39404bdd@arm.com>
References: <cover.1587400573.git.saiprakash.ranjan@codeaurora.org>
 <d36f9c9ef3ef8dc84da02dfb160cd6846d2869fc.1587400573.git.saiprakash.ranjan@codeaurora.org>
 <b69fc30c-e6fb-70bf-4d6e-0d9b39404bdd@arm.com>
Message-ID: <0702f3186327b419ee38e4775c040052@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Kaehlcke <mka@chromium.org>, Sibi Sankar <sibis@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On 2020-04-20 22:27, Robin Murphy wrote:
> On 2020-04-20 5:42 pm, Sai Prakash Ranjan wrote:
>> From: Jordan Crouse <jcrouse@codeaurora.org>
>> 
>> Some client devices want to directly map the IOMMU themselves instead
>> of using the DMA domain. Allow those devices to opt in to direct
>> mapping by way of a list of compatible strings.
> 
> Neat and tidy :)
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Strictly, I think patch #3/6 should really have come before this one
> (with the header change moved accordingly), but don't bother resending
> just for that.
> 

Thanks, I have sent the updated version with this change as well
in addition to the commit msg update for modem requesting direct
mapping.

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
