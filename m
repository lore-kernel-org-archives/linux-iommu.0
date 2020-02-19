Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B364AC18E00
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 20:06:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7826F24654
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 20:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="W6uQA22A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7826F24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1A31284B23;
	Wed, 19 Feb 2020 20:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BD6L-jP1VotS; Wed, 19 Feb 2020 20:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 13C0583773;
	Wed, 19 Feb 2020 20:06:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E59C4C1D81;
	Wed, 19 Feb 2020 20:06:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A89AC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 20:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 863DA2052B
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 20:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fd6qhWOL2gkb for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 20:06:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by silver.osuosl.org (Postfix) with ESMTPS id 3ED86203DA
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 20:06:36 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1582142799; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=//g+fSyDRPG/v+45Xg82m3qHmJx/MoVeSp+8QT8ucjw=;
 b=W6uQA22A896YX3ZlQsQ+onAyacK7k0D6tl8bNDfuns1Xunqa4DrbXeWDNKH9Hx9ChFCo+gwo
 s1ktLYmgLPzECfbalS5r/3PAYarTPUDS7Fb574HOqp/QKeWq/ABg04Pmm0ixlVrhv6grF1mb
 0Ys0wH8BsFzUYf3+2zxxF5y73ak=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4d9545.7eff56fb7df8-smtp-out-n02;
 Wed, 19 Feb 2020 20:06:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id CE1CEC447A0; Wed, 19 Feb 2020 20:06:28 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D272C43383;
 Wed, 19 Feb 2020 20:06:28 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 19 Feb 2020 12:06:28 -0800
From: isaacm@codeaurora.org
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
In-Reply-To: <20200219111501.GA19400@willie-the-truck>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
 <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
 <20200219111501.GA19400@willie-the-truck>
Message-ID: <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
 iommu@lists.linux-foundation.org, pratikp@codeaurora.org
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

On 2020-02-19 03:15, Will Deacon wrote:
> On Tue, Feb 18, 2020 at 05:57:18PM -0800, isaacm@codeaurora.org wrote:
>> On 2020-02-17 07:50, Robin Murphy wrote:
>> > On 17/02/2020 8:01 am, Christoph Hellwig wrote:
>> > > On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
>> > > > From: Liam Mark <lmark@codeaurora.org>
>> > > >
>> > > > Some devices have a memory map which contains gaps or holes.
>> > > > In order for the device to have as much IOVA space as possible,
>> > > > allow its driver to inform the DMA-IOMMU layer that it should
>> > > > not allocate addresses from these holes.
>> > >
>> > > Layering violation.  dma-iommu is the translation layer between the
>> > > DMA API and the IOMMU API.  And calls into it from drivers performing
>> > > DMA mappings need to go through the DMA API (and be documented there).
>> >
>> > +1
>> >
>> > More than that, though, we already have "holes in the address space"
>> > support for the sake of PCI host bridge windows - assuming this is the
>> > same kind of thing (i.e. the holes are between memory regions and
>> > other resources in PA space, so are only relevant once address
>> > translation comes into the picture), then this is IOMMU API level
>> To make sure that we're on the same page, this support alludes to the
>> handling in
>> dma-iommu.c that reserves portions of the IOVA space for the PCI host 
>> bridge
>> windows,
>> correct? If so, then yes, this is similar.
>> > stuff, so even a DMA API level interface would be inappropriate.
>> Does this mean that the driver should be managing the IOVA space and
>> mappings for this device using the IOMMU API? If so, is the rationale 
>> for
>> this because the device driver can have the information of what IOVA 
>> ranges
>> can and cannot be used? Shouldn't there be a generic way of informing 
>> an
>> IOMMU driver about these reserved ranges? Perhaps through a device 
>> tree
>> property, instead of deferring this type of management to the driver?
> 
> Before we dive into designing that, can you please clarify whether the
> reserved IOVA range applies to all DMA masters mastering through a
> particular SMMU, or whether it's just about one specific master? I was
> assuming the former, but wanted to be sure.
> 
This situation currently applies to one master.
> Thanks,
> 
> Will

Thanks,
Isaac
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
