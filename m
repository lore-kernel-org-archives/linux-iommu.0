Return-Path: <SRS0=m57D=Z3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005AAC43603
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 15:57:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82D4206DB
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 15:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="amctlUXG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="AeHkPC+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82D4206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1DD3D88310;
	Thu,  5 Dec 2019 15:51:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id stlAxhsgXsDe; Thu,  5 Dec 2019 15:51:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4081D88307;
	Thu,  5 Dec 2019 15:51:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 225F1C1DD7;
	Thu,  5 Dec 2019 15:51:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89C61C077D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 15:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 72B9888A6C
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 15:51:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z7vxewcrhzGC for <iommu@lists.linux-foundation.org>;
 Thu,  5 Dec 2019 15:51:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a27-186.smtp-out.us-west-2.amazonses.com
 (a27-186.smtp-out.us-west-2.amazonses.com [54.240.27.186])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A6AD388A00
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575561093;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 bh=9pymZMREs0aDkOkin38Qg0017bN8aBp0lR9eje0eErE=;
 b=amctlUXGAZxpjae4TUyEVtgwImMpXn12737gkBKaUqf3io4zyPwrZrKKosbGXk6f
 LM911PLONNWjCwgQ/7Y/Wuo0jxjQFnREyiaBmn+usQE3hNu1ZIVwA0JO1ySYQu3kgks
 sWimSMvm0ISjiWA+dQ6EcrbqzjYWb1Sv4WrSE9KI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575561093;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
 bh=9pymZMREs0aDkOkin38Qg0017bN8aBp0lR9eje0eErE=;
 b=AeHkPC+xwvjazDYdiCFHp9ughXxxBSCbUxZhClO7TtxUCy/Hkn6or75WrbolNu++
 5tus1/3Ke5S3stlpnYzEnmfi+aaVAg3p1JJyDuIBhmfzelAd3RYpClZN88Jh/mi19EU
 XVeWaTaa4MBWVvW/ZVy+4r4kUtLOrkyRlHzW86PM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17A40C447B1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Thu, 5 Dec 2019 15:51:33 +0000
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/8] iommu/arm-smmu: Add split pagetables for Adreno
 IOMMU implementations
Message-ID: <0101016ed6c26259-e99e314e-eef4-47f7-8725-3704debbe329-000000@us-west-2.amazonses.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
References: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
 <0101016e95752703-78491f46-41db-441c-b0fb-9a760e4d56cb-000000@us-west-2.amazonses.com>
 <2a43c49e-064e-1e95-6726-8d1e761f6749@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a43c49e-064e-1e95-6726-8d1e761f6749@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SES-Outgoing: 2019.12.05-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Dec 04, 2019 at 04:44:59PM +0000, Robin Murphy wrote:
> On 22/11/2019 11:31 pm, Jordan Crouse wrote:
> >Add implementation specific support to enable split pagetables for
> >SMMU implementations attached to Adreno GPUs on Qualcomm targets.
> >
> >To enable split pagetables the driver will set an attribute on the domain.
> >if conditions are correct, set up the hardware to support equally sized
> >TTBR0 and TTBR1 regions and programs the domain pagetable to TTBR1 to make
> >it available for global buffers while allowing the GPU the chance to
> >switch the TTBR0 at runtime for per-context pagetables.
> >
> >After programming the context, the value of the domain attribute can be
> >queried to see if split pagetables were successfully programmed. The
> >domain geometry will be updated so that the caller can determine the
> >start of the region to generate correct virtual addresses.
> 
> Why is any of this in impl? It all looks like perfectly generic
> architectural TTBR1 setup to me. As long as DOMAIN_ATTR_SPLIT_TABLES is
> explicitly an opt-in for callers, I'm OK with them having to trust that
> SEP_UPSTREAM is good enough. Or, even better, make the value of
> DOMAIN_ATTR_SPLIT_TABLES not a boolean but the actual split point, where the
> default of 0 would logically mean "no split".

(apologies if you get multiple copies of this email, I have tickets in with the
CAF IT folks).

I made it impl specific because my impression from the previous conversations
was that setting up the T0 space but leaving TTBR0 un-programmed was a silly
thing that was unique to the Adreno GPU. I don't mind moving it to the generic
code since that saves us from some silly compatible string games.

I like the idea of DOMAIN_ATTR_SPLIT_TABLES returning the split point but would
we want to allow the user to try to specific a desired split point ahead of
time? It is my impression that we only have a handful of valid SEP values and
I'm not sure what the right response would be if the user specified an incorrect
one.

So far I've not found a use for anything except SEP_UPSTREAM but I have the
extreme luxury of a SMMU with an actual 49 bit IAS.

New patchset coming soon.

Thanks,
Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
