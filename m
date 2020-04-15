Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF8C3815B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 10:11:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D541A20768
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 10:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SsmiqoQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D541A20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A44D987E9E;
	Wed, 15 Apr 2020 10:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XE7JCnlFNuqA; Wed, 15 Apr 2020 10:11:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0E96D87E2E;
	Wed, 15 Apr 2020 10:11:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E777AC089E;
	Wed, 15 Apr 2020 10:11:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59F31C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 10:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4597C87E9E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 10:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v+ItkI-6ST+i for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 10:11:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6A07287E2E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 10:11:23 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1586945483; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=6Fmu2bYxuswkx5JslalXSUya4FFPt0PklF5SeocK9A0=;
 b=SsmiqoQt8Typ/VWlDeQf47CNwwXdAd710WmwZvUYL6J7fZLTZ2/AI1pZgoXGf0ZDQkocPA6P
 TzVUU50lXZtLZ/qdQwIhh2kJ1CCbcuYAfUKRWJlidI7SSHUtoFqKYCLA2kXNHSUFgw8cMFKZ
 EKuXOnjI6qtetsFggp37KplAF7k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96ddca.7f9317cfb378-smtp-out-n03;
 Wed, 15 Apr 2020 10:11:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id BBB51C44791; Wed, 15 Apr 2020 10:11:20 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DBE8FC433F2;
 Wed, 15 Apr 2020 10:11:19 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 15 Apr 2020 15:41:19 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>, Jordan Crouse
 <jcrouse@codeaurora.org>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
Message-ID: <44be117e4661f9ccb64480912644420f@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-arm-msm@vger.kernel.org,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi Joerg,

On 2020-04-13 20:42, Jordan Crouse wrote:
> On Thu, Apr 09, 2020 at 04:31:24PM -0700, Matthias Kaehlcke wrote:
>> On Tue, Feb 04, 2020 at 11:12:17PM +0530, Sai Prakash Ranjan wrote:
>> > Hello Robin, Will
>> >
>> > On 2020-01-22 17:18, Sai Prakash Ranjan wrote:
>> > > This series allows drm devices to set a default identity
>> > > mapping using iommu_request_dm_for_dev(). First patch is
>> > > a cleanup to support other SoCs to call into QCOM specific
>> > > implementation and preparation for second patch.
>> > > Second patch sets the default identity domain for drm devices.
>> > >
>> > > Jordan Crouse (1):
>> > >   iommu/arm-smmu: Allow client devices to select direct mapping
>> > >
>> > > Sai Prakash Ranjan (1):
>> > >   iommu: arm-smmu-impl: Convert to a generic reset implementation
>> > >
>> > >  drivers/iommu/arm-smmu-impl.c |  8 +++--
>> > >  drivers/iommu/arm-smmu-qcom.c | 55 +++++++++++++++++++++++++++++++++--
>> > >  drivers/iommu/arm-smmu.c      |  3 ++
>> > >  drivers/iommu/arm-smmu.h      |  5 ++++
>> > >  4 files changed, 65 insertions(+), 6 deletions(-)
>> >
>> > Any review comments?
>> 
>> Ping
>> 
>> What is the status of this series, is it ready to land or are any 
>> changes
>> needed?
>> 
>> Thanks
>> 
>> Matthias
> 
> I think this is up in the air following the changes that Joerg 
> suggested:
> https://lists.linuxfoundation.org/pipermail/iommu/2020-April/043017.html
> 

1st patch for generic reset in this series is independent and can be 
merged.
But seems like requesting direct mapping fails with the joerg's patch 
series.

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
