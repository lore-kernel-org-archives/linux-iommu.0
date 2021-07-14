Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38185C11F69
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 10:29:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11E761374
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 10:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11E761374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0F3760A72;
	Wed, 14 Jul 2021 10:29:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DSUQ89AUuQP; Wed, 14 Jul 2021 10:29:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A774160744;
	Wed, 14 Jul 2021 10:29:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 830C8C001A;
	Wed, 14 Jul 2021 10:29:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2B06C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 10:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0CA14027A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 10:29:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xbFpBc4i2nHZ for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 10:29:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06C594023C
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 10:29:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51AFAD6E;
 Wed, 14 Jul 2021 03:29:19 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4FA73F774;
 Wed, 14 Jul 2021 03:29:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To: Joerg Roedel <joro@8bytes.org>
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org> <edd1de35-5b9e-b679-9428-23c6d5005740@arm.com>
 <YO65OOScL5vru1Kr@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <255adda2-3b5f-b080-4da1-f3c5d5a4f7a6@arm.com>
Date: Wed, 14 Jul 2021 11:29:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO65OOScL5vru1Kr@8bytes.org>
Content-Language: en-GB
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Saravana Kannan <saravanak@google.com>, Jonathan Corbet <corbet@lwn.net>,
 quic_c_gdjako@quicinc.com, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Sonny Rao <sonnyrao@chromium.org>,
 Vlastimil Babka <vbabka@suse.cz>, Randy Dunlap <rdunlap@infradead.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
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

On 2021-07-14 11:15, Joerg Roedel wrote:
> Hi Robin,
> 
> On Fri, Jul 09, 2021 at 02:56:47PM +0100, Robin Murphy wrote:
>> As I mentioned before, conceptually I think this very much belongs in sysfs
>> as a user decision. We essentially have 4 levels of "strictness":
>>
>> 1: DMA domain with bounce pages
>> 2: DMA domain
>> 3: DMA domain with flush queue
>> 4: Identity domain
> 
> Together with reasonable defaults (influenced by compile-time
> options) it seems to be a good thing to configure at runtime via
> sysfs.
> 
> We already have CONFIG_IOMMU_DEFAULT_PASSTHROUGH, which can probably be
> extended to be an option list:
> 
> 	- CONFIG_IOMMU_DEFAULT_PASSTHROUGH: Trusted devices are identity
> 					    mapped
> 
> 	- CONFIG_IOMMU_DEFAULT_DMA_STRICT: Trusted devices are DMA
> 					   mapped with strict flush
> 					   behavior on unmap
> 
> 	- CONFIG_IOMMU_DEFAULT_DMA_LAZY: Trusted devices are DMA mapped
> 					 with flush queues for performance

Indeed, I got focused on the sysfs angle, but rearranging the Kconfig 
default that way to match makes a lot of sense, and is another thing 
which should fall out really easily from my domain type rework, so I'll 
add that to my branch now before I forget again.

> Untrusted devices always get into the DMA domain with bounce pages by
> default.
> 
> The defaults can be changed at runtime via sysfs. We already have basic
> support for runtime switching of the default domain, so that can be
> re-used.

As mentioned yesterday, already done! I'm hoping to be able to post the 
patches next week after some testing :)

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
