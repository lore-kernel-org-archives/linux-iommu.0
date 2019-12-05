Return-Path: <SRS0=m57D=Z3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A072EC43603
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 02:44:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCF6214B2
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 02:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCF6214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DD60E88720;
	Thu,  5 Dec 2019 02:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0EycTTnF3iFy; Thu,  5 Dec 2019 02:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42CA7886BB;
	Thu,  5 Dec 2019 02:44:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26E9AC1DD6;
	Thu,  5 Dec 2019 02:44:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47888C077D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 02:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 32F69886C6
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 02:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f1a1y5BJrAZG for <iommu@lists.linux-foundation.org>;
 Thu,  5 Dec 2019 02:44:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DB444886BB
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 02:44:49 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 18:44:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="385998475"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga005.jf.intel.com with ESMTP; 04 Dec 2019 18:44:47 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20191202063422.3lyfoerkejig4num@cantor>
 <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
 <20191202071406.jpq5qobbtnwhktlc@cantor>
 <20191202161332.ctc3y5cvdgqwnz7l@cantor>
 <14bbe41c-61e9-d2b6-31cb-67c0b1ad11da@linux.intel.com>
 <20191203095636.epmuinnrpykecfda@cantor>
 <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
 <20191204205300.4jiexjqfpnqlcagu@cantor>
 <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
 <20191205022551.janpwjvr4kei5r7c@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d5981dee-d37b-a725-ed94-8864f3dd7602@linux.intel.com>
Date: Thu, 5 Dec 2019 10:44:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205022551.janpwjvr4kei5r7c@cantor>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

On 12/5/19 10:25 AM, Jerry Snitselaar wrote:
>>
>> It seems that iommu pci bus probe didn't enumerate device [01:00.2] and
>> [02:00.0], the corresponding context entries were not setup. Hence dma
>> fault generated when devices access the memory.
>>
>> Do these two devices show in "lspci" output? How do these devices get
>> enumerated by the system?
>>
>> Best regards,
>> baolu
>>
> 
> They are there in the output, but it seems out of order:


[   23.446201] pci 0000:01:00.0: Adding to iommu group 25
[   23.448949] pci 0000:01:00.0: Using iommu dma mapping
[   23.450807] pci 0000:01:00.1: Adding to iommu group 25
[   23.452666] pci 0000:01:00.1: DMAR: Device uses a private identity 
domain.
[   23.455063] pci 0000:01:00.2: Adding to iommu group 25
[   23.456881] pci 0000:01:00.4: Adding to iommu group 25
[   23.458693] pci 0000:01:00.4: DMAR: Device uses a private identity 
domain.

Oh, yes!

So device 01:00.0 01:00.1 01:00.2 01:00.4 share a single group. The
default domain for this group has been set to DMA although iommu=pt has
been set. As the result, .0 .2 use DMA, but .1, .4 use IDENTITY. This is
not a valid configuration since all devices in a group should use a same
domain.

Do you mind posting the "lspci -vvv" output of these devices? I want to
figure out why these devices request different domain type.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
