Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FE6C433E2
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 16:19:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A30E2220D
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l8kxdOUE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="V1y8Xyda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A30E2220D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D7538879D2;
	Fri, 11 Sep 2020 16:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 35Xqj2J1TVhL; Fri, 11 Sep 2020 16:19:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2881E879CD;
	Fri, 11 Sep 2020 16:19:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12DA7C0052;
	Fri, 11 Sep 2020 16:19:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A77C1C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 16:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8E812878B8
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 16:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F6HgZhpCsMzv for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 16:19:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-56.smtp-out.us-west-2.amazonses.com
 (a27-56.smtp-out.us-west-2.amazonses.com [54.240.27.56])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D5E55878B7
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599841153;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
 bh=XBT+2F8Be9EUhOk79AkAkxBza69lSFrrfNDtXiYkez8=;
 b=l8kxdOUEkvAl1uoy37XpuXd+Mha1RHbu7Y47ng0vmCqJRoimc4+5s81GxQuIfiHM
 SzdxPYpKQ1thdr9iK2yF2yxIiQ8QmzVNML1L8z4SkUsnAlaxAe8Xtv1IyxH5ATouElf
 278uhytP9vCyZwnWcT3zU8HYtl5KcfcZWkspM8vc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599841153;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
 bh=XBT+2F8Be9EUhOk79AkAkxBza69lSFrrfNDtXiYkez8=;
 b=V1y8Xyda/l5I2jNaRPuWtM5S9XAngXU5nFKpBEReM/tR2VnBeMpKdysLmzbkRAWv
 s8y3H9yKf1ZQWJh5Md5kDYkOSvnwmUqCDfJbHmrMJcMo5wR81aZm+f+TGhIqmjlb5nw
 t8gJ0JZ9o4rOXVm34LS4kLtKDK4Mj5+NCr4or980=
MIME-Version: 1.0
Date: Fri, 11 Sep 2020 16:19:13 +0000
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv4 6/6] iommu: arm-smmu-impl: Remove unwanted extra blank
 lines
In-Reply-To: <c26b5317-f12d-8be9-be45-3307ce5efbfc@arm.com>
References: <cover.1599832685.git.saiprakash.ranjan@codeaurora.org>
 <010101747d912d9f-c8050b8d-1e81-4be0-ac35-b221f657b490-000000@us-west-2.amazonses.com>
 <c26b5317-f12d-8be9-be45-3307ce5efbfc@arm.com>
Message-ID: <010101747df6b0e2-0fe82769-ef8e-4c83-9524-282cb32fa47c-000000@us-west-2.amazonses.com>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, dri-devel@lists.freedesktop.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
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

On 2020-09-11 21:33, Robin Murphy wrote:
> On 2020-09-11 15:28, Sai Prakash Ranjan wrote:
>> There are few places in arm-smmu-impl where there are
>> extra blank lines, remove them
> 
> FWIW those were deliberate - sometimes I like a bit of subtle space to
> visually delineate distinct groups of definitions. I suppose it won't
> be to everyone's taste :/
> 

Ah ok, I thought it was not intentional, I can drop it.

>> and while at it fix the
>> checkpatch warning for space required before the open
>> parenthesis.
> 
> That one, however, was not ;)
> 

I'll keep this one.

> BTW am I supposed to have received 3 copies of everything? Because I 
> did...
> 

Ugh no, I just sent it once but something seems to have gone wrong.
Apologies again if you receive this message also multiple times.
I'll check further what's going wrong with my setup.

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
