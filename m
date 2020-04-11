Return-Path: <SRS0=UjaL=53=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550AEC2BA2B
	for <iommu@archiver.kernel.org>; Sat, 11 Apr 2020 09:20:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC2D20857
	for <iommu@archiver.kernel.org>; Sat, 11 Apr 2020 09:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="pqQVn2dU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC2D20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DDE6622763;
	Sat, 11 Apr 2020 09:20:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zURoCVu5TYkH; Sat, 11 Apr 2020 09:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 33BA6226D7;
	Sat, 11 Apr 2020 09:20:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB37C1D74;
	Sat, 11 Apr 2020 09:20:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B3D2C0177
 for <iommu@lists.linux-foundation.org>; Sat, 11 Apr 2020 09:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 618A122763
 for <iommu@lists.linux-foundation.org>; Sat, 11 Apr 2020 09:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 624KNvNcDKuy for <iommu@lists.linux-foundation.org>;
 Sat, 11 Apr 2020 09:20:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by silver.osuosl.org (Postfix) with ESMTPS id BEBED226D7
 for <iommu@lists.linux-foundation.org>; Sat, 11 Apr 2020 09:20:38 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1586596842; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=m64rlGIY/ze74hM+6TJxI24Fs9sSBQEMm8EnQhf5+Gs=;
 b=pqQVn2dUvba7tUcCvjBAf7pjQf8/06fSH3Z3jxbv7zxIVwGEevChe93V+9JGVr8siBlGPMti
 Z6FckJiviKuUQu3f9Ln7DHreI0t4G2LI88EoYufnUGj/e8coVvIUwoWAB4JCcFbp8uHV/a5F
 PgeEWB9IdjO7WmdwBW2j7Yywjyo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e918bce.7f4598998688-smtp-out-n02;
 Sat, 11 Apr 2020 09:20:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id A7084C4478C; Sat, 11 Apr 2020 09:20:13 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 01845C433CB;
 Sat, 11 Apr 2020 09:20:12 +0000 (UTC)
MIME-Version: 1.0
Date: Sat, 11 Apr 2020 14:50:12 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
In-Reply-To: <20200409233124.GW199755@google.com>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <7761534cdb4f1891d993e73931894a63@codeaurora.org>
 <20200409233124.GW199755@google.com>
Message-ID: <6714ba4f73f6518e5f2f427a0bcc6c53@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-arm-kernel@lists.infradead.org
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

Hi Matthias,

On 2020-04-10 05:01, Matthias Kaehlcke wrote:
> On Tue, Feb 04, 2020 at 11:12:17PM +0530, Sai Prakash Ranjan wrote:
>> Hello Robin, Will
>> 
>> On 2020-01-22 17:18, Sai Prakash Ranjan wrote:
>> > This series allows drm devices to set a default identity
>> > mapping using iommu_request_dm_for_dev(). First patch is
>> > a cleanup to support other SoCs to call into QCOM specific
>> > implementation and preparation for second patch.
>> > Second patch sets the default identity domain for drm devices.
>> >
>> > Jordan Crouse (1):
>> >   iommu/arm-smmu: Allow client devices to select direct mapping
>> >
>> > Sai Prakash Ranjan (1):
>> >   iommu: arm-smmu-impl: Convert to a generic reset implementation
>> >
>> >  drivers/iommu/arm-smmu-impl.c |  8 +++--
>> >  drivers/iommu/arm-smmu-qcom.c | 55 +++++++++++++++++++++++++++++++++--
>> >  drivers/iommu/arm-smmu.c      |  3 ++
>> >  drivers/iommu/arm-smmu.h      |  5 ++++
>> >  4 files changed, 65 insertions(+), 6 deletions(-)
>> 
>> Any review comments?
> 
> Ping
> 
> What is the status of this series, is it ready to land or are any 
> changes
> needed?
> 

I am wondering the same :)

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
