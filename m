Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB9EC433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 06:41:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6FC6529C
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 06:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6FC6529C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E6AA6F4E9;
	Tue,  9 Mar 2021 06:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tBNPQM01aCq7; Tue,  9 Mar 2021 06:41:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12AFC605CC;
	Tue,  9 Mar 2021 06:41:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3261C000A;
	Tue,  9 Mar 2021 06:41:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A11EC0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 309FB8354D
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id 83IxbF_PXSoK for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 06:40:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from z11.mailgun.us (z11.mailgun.us [104.130.96.11])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 9108B83542
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:40:56 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1615272058; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=EhG3KsTQoCjy4nAe8WbAaYFX/7mUkiPY+Ifi3+SDrmg=;
 b=eR5zvtrRyOrGFpCX+bHgdKf5ZRkuI47lsU+c5RbHRNbTfF7f80qnHT+QILqqt//fIXEO7Sml
 xwSq0q0XWvkQ/yuuRtOweIZWvVwe+ET9jpZnZYwY3ewC1WTE5kUAWZgA4fSSNooDTLgUhhBe
 23fQvnjT2/ZKm34VIJ1Myd85ivs=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6047186d2a5e6d1bfaf8bec3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 06:40:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 62037C43468; Tue,  9 Mar 2021 06:40:45 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D56AC433CA;
 Tue,  9 Mar 2021 06:40:44 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 09 Mar 2021 12:10:44 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] iommu/io-pgtable-arm: Add IOMMU_LLC page protection
 flag
In-Reply-To: <4988e2ef35f76a0c2f1fe3f66f023a3b@codeaurora.org>
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <3f589e7de3f9fa93e84c83420c5270c546a0c368.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210129090516.GB3998@willie-the-truck>
 <5d23fce629323bcda71594010824aad0@codeaurora.org>
 <20210201111556.GA7172@willie-the-truck>
 <CAF6AEGsARmkAFsjaQLfa2miMgeijo183MWDKGtW_ti-UCpzBqA@mail.gmail.com>
 <20210201182016.GA21629@jcrouse1-lnx.qualcomm.com>
 <7e9aade14d0b7f69285852ade4a5a9f4@codeaurora.org>
 <20210203214612.GB19847@willie-the-truck>
 <4988e2ef35f76a0c2f1fe3f66f023a3b@codeaurora.org>
Message-ID: <9362873a3bcf37cdd073a6128f29c683@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS , 
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Sean Paul <sean@poorly.run>,
 Kristian H Kristensen <hoegsberg@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi,

On 2021-02-05 17:38, Sai Prakash Ranjan wrote:
> On 2021-02-04 03:16, Will Deacon wrote:
>> On Tue, Feb 02, 2021 at 11:56:27AM +0530, Sai Prakash Ranjan wrote:
>>> On 2021-02-01 23:50, Jordan Crouse wrote:
>>> > On Mon, Feb 01, 2021 at 08:20:44AM -0800, Rob Clark wrote:
>>> > > On Mon, Feb 1, 2021 at 3:16 AM Will Deacon <will@kernel.org> wrote:
>>> > > > On Fri, Jan 29, 2021 at 03:12:59PM +0530, Sai Prakash Ranjan wrote:
>>> > > > > On 2021-01-29 14:35, Will Deacon wrote:
>>> > > > > > On Mon, Jan 11, 2021 at 07:45:04PM +0530, Sai Prakash Ranjan wrote:
>>> > > > > > > +#define IOMMU_LLC        (1 << 6)
>>> > > > > >
>>> > > > > > On reflection, I'm a bit worried about exposing this because I think it
>>> > > > > > will
>>> > > > > > introduce a mismatched virtual alias with the CPU (we don't even have a
>>> > > > > > MAIR
>>> > > > > > set up for this memory type). Now, we also have that issue for the PTW,
>>> > > > > > but
>>> > > > > > since we always use cache maintenance (i.e. the streaming API) for
>>> > > > > > publishing the page-tables to a non-coheren walker, it works out.
>>> > > > > > However,
>>> > > > > > if somebody expects IOMMU_LLC to be coherent with a DMA API coherent
>>> > > > > > allocation, then they're potentially in for a nasty surprise due to the
>>> > > > > > mismatched outer-cacheability attributes.
>>> > > > > >
>>> > > > >
>>> > > > > Can't we add the syscached memory type similar to what is done on android?
>>> > > >
>>> > > > Maybe. How does the GPU driver map these things on the CPU side?
>>> > >
>>> > > Currently we use writecombine mappings for everything, although there
>>> > > are some cases that we'd like to use cached (but have not merged
>>> > > patches that would give userspace a way to flush/invalidate)
>>> > >
>>> >
>>> > LLC/system cache doesn't have a relationship with the CPU cache.  Its
>>> > just a
>>> > little accelerator that sits on the connection from the GPU to DDR and
>>> > caches
>>> > accesses. The hint that Sai is suggesting is used to mark the buffers as
>>> > 'no-write-allocate' to prevent GPU write operations from being cached in
>>> > the LLC
>>> > which a) isn't interesting and b) takes up cache space for read
>>> > operations.
>>> >
>>> > Its easiest to think of the LLC as a bonus accelerator that has no cost
>>> > for
>>> > us to use outside of the unfortunate per buffer hint.
>>> >
>>> > We do have to worry about the CPU cache w.r.t I/O coherency (which is a
>>> > different hint) and in that case we have all of concerns that Will
>>> > identified.
>>> >
>>> 
>>> For mismatched outer cacheability attributes which Will mentioned, I 
>>> was
>>> referring to [1] in android kernel.
>> 
>> I've lost track of the conversation here :/
>> 
>> When the GPU has a buffer mapped with IOMMU_LLC, is the buffer also 
>> mapped
>> into the CPU and with what attributes? Rob said "writecombine for
>> everything" -- does that mean ioremap_wc() / MEMREMAP_WC?
>> 
> 
> Rob answered this.
> 
>> Finally, we need to be careful when we use the word "hint" as 
>> "allocation
>> hint" has a specific meaning in the architecture, and if we only 
>> mismatch on
>> those then we're actually ok. But I think IOMMU_LLC is more than just 
>> a
>> hint, since it actually drives eviction policy (i.e. it enables 
>> writeback).
>> 
>> Sorry for the pedantry, but I just want to make sure we're all talking
>> about the same things!
>> 
> 
> Sorry for the confusion which probably was caused by my mentioning of
> android, NWA(no write allocate) is an allocation hint which we can 
> ignore
> for now as it is not introduced yet in upstream.
> 

Any chance of taking this forward? We do not want to miss out on small 
fps
gain when the product gets released.

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
