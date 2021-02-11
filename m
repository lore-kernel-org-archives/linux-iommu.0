Return-Path: <SRS0=8k88=HN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E397C433E6
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 10:29:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F215164E95
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 10:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F215164E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 73045821FC;
	Thu, 11 Feb 2021 10:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Ky2akgKV5-t; Thu, 11 Feb 2021 10:29:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BBE2486D42;
	Thu, 11 Feb 2021 10:29:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A357DC0891;
	Thu, 11 Feb 2021 10:29:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69C17C013A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 10:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4EB62866B0
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 10:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jo8vEl6ZW0nU for <iommu@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 10:29:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E8EAC86672
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613039344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uy1irgQ/ZwVow/3hF7bCH/moHa6j8udykjKdWqM+w4w=;
 b=MXByMtlNQth5K6gWLRzwyBrxRTTfxIuFefimLfDvVZu9ZTw5E/rNszSGl2Ywkes+iSvvei
 j1+KqBpT2VKSPDBFEC0tF1yF+kiSLtGZOB5s0wlEQjSoIFnB95nvv5NjdycA3c2EJfra7G
 qYbByPMMNzOlEZa+rqDQRjF1K8RkLus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-tBokRLcyOCuiMXeuiZATSA-1; Thu, 11 Feb 2021 05:29:02 -0500
X-MC-Unique: tBokRLcyOCuiMXeuiZATSA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA09FC7401;
 Thu, 11 Feb 2021 10:28:59 +0000 (UTC)
Received: from [10.36.114.52] (ovpn-114-52.ams2.redhat.com [10.36.114.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61FF96268D;
 Thu, 11 Feb 2021 10:28:53 +0000 (UTC)
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
 <20210208213023.GZ4718@ziepe.ca>
 <0868d209d7424942a46d1238674cf75d@hisilicon.com>
 <20210209135331.GF4718@ziepe.ca>
 <2527b4ac8df14fa1b427bef65dace719@hisilicon.com>
 <20210210180405.GP4718@ziepe.ca>
 <8a676b45ebaa49e8886f4bf9b762bb75@hisilicon.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Message-ID: <c15e0c20-8253-fa49-ff44-a19c455353e9@redhat.com>
Date: Thu, 11 Feb 2021 11:28:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <8a676b45ebaa49e8886f4bf9b762bb75@hisilicon.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "chensihang \(A\)" <chensihang1@hisilicon.com>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

>>
>> Again in proper SVA it should be quite unlikely to take a fault caused
>> by something like migration, on the same likelyhood as the CPU. If
>> things are faulting so much this is a problem then I think it is a
>> system level problem with doing too much page motion.
> 
> My point is that single one SVA application shouldn't require system
> to make global changes, such as disabling numa balancing, disabling
> THP, to decrease page fault frequency by affecting other applications.
> 
> Anyway, guys are in lunar new year. Hopefully, we are getting more
> real benchmark data afterwards to make the discussion more targeted.

Right, but I think functionality as proposed in this patch is highly 
unlikely to make it into the kernel. I'd be interested in approaches to 
mitigate this per process. E.g., temporarily stop the kernel from 
messing with THP of this specific process.

But even then, why should some random library make such decisions for a 
whole process? Just as, why should some random library pin pages never 
allocated by it and stop THP from being created or NUMA layout from 
getting optimized? This looks like a clear layer violation to me.

I fully agree with Jason: Why do the events happen that often such that 
your use cases are affected that heavily, such that we even need such 
ugly handling?

What mempinfd does is exposing dangerous functionality that we don't 
want 99.99996% of all user space to ever use via a syscall to generic 
users to fix broken* hw.

*broken might be over-stressing the situation, but the HW (SVA) 
obviously seems to perform way worse than ordinary CPUs.

-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
