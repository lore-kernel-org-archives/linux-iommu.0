Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A238EC43466
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 15:48:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D1B221E2
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 15:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="St93hJRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D1B221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 36B8E858B6;
	Mon, 21 Sep 2020 15:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNeh04HHv4p7; Mon, 21 Sep 2020 15:48:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B2391857BF;
	Mon, 21 Sep 2020 15:48:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C6ECC0889;
	Mon, 21 Sep 2020 15:48:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C073C0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 15:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7A54A86764
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 15:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YfiE3S1k3kcx for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 15:48:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C923986763
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YXCybLJtp8QhoH5bVAnUYgHMbmYcosVGHwR4wq6l5Ao=; b=St93hJRc+SEcyj37x2nLj0G6VG
 zDBVVnNbISQItuHlUKeyIXeAssJO4Sdbnj0qAWb+FVK62eXcLLT/NXDkzmgBcwkEtuaUYAqjOb0eI
 FMzMcJU5tlKk9twO2PdwCMoGtiIVIOGSofO7UFhzG2PfIiCq6rqQ8zimZYr3zzda2A+ikgD2HOEtE
 qcfcgbO+tRxCF82Kol5EwCfUVxBO3aOxMsP7vKwJV+P8JOFUOwF4UP8asTLLfxBagM3QUMzBMUyN/
 E4+PZXjVtNrVNBueFvekvYvE/m7N+6FujV6vs4TKhtwkt0FonYqvLYnY1NfkXNKZLEzULxP/SY0vB
 RVPt82qw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kKO2z-0000C3-Dr; Mon, 21 Sep 2020 09:48:10 -0600
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com>
 <fe94760f-3c10-4222-ec87-291c01325fef@linux.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e95a55ea-b03f-4b3c-327a-b48d364577e9@deltatee.com>
Date: Mon, 21 Sep 2020 09:48:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <fe94760f-3c10-4222-ec87-291c01325fef@linux.intel.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Intel-gfx@lists.freedesktop.org,
 ashok.raj@intel.com, hch@infradead.org, dwmw2@infradead.org, murphyt7@tcd.ie,
 joro@8bytes.org, baolu.lu@linux.intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [Intel-gfx] [PATCH v3 0/6] Convert the intel iommu driver to the
 dma-iommu api
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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



On 2020-09-20 12:36 a.m., Lu Baolu wrote:
> Hi Logan,
> 
> On 2020/9/19 4:47, Logan Gunthorpe wrote:
>> Hi Lu,
>>
>> On 2020-09-11 9:21 p.m., Lu Baolu wrote:
>>> Tom Murphy has almost done all the work. His latest patch series was
>>> posted here.
>>>
>>> https://lore.kernel.org/linux-iommu/20200903201839.7327-1-murphyt7@tcd.ie/
>>>
>>> Thanks a lot!
>>>
>>> This series is a follow-up with below changes:
>>>
>>> 1. Add a quirk for the i915 driver issue described in Tom's cover
>>> letter.
>>> 2. Fix several bugs in patch "iommu: Allow the dma-iommu api to use
>>> bounce buffers" to make the bounce buffer work for untrusted devices.
>>> 3. Several cleanups in iommu/vt-d driver after the conversion.
>>>
>>
>> I'm trying to test this on an old Sandy Bridge, but found that I get
>> spammed with warnings on boot. I've put a sample of a few of them below.
>> They all seem to be related to ioat.
>>
>> I had the same issue with Tom's v2 but never saw this on his v1.
> 
> Have you verified whether this could be reproduced with the lasted
> upstream kernel (without this patch series)?

Yes. Also, it's hitting a warning in the dma-iommu code which would not
be hit without this patch set.

Thanks,

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
