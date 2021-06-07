Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14EDC47094
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 15:00:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978EE61108
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 15:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978EE61108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FBA740360;
	Mon,  7 Jun 2021 15:00:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sqnTBuu1D6Rl; Mon,  7 Jun 2021 15:00:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87C6A4035C;
	Mon,  7 Jun 2021 15:00:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D6C4C000D;
	Mon,  7 Jun 2021 15:00:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0821CC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 15:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F08A540301
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 15:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id brLhg51ddb9w for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 15:00:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CB054028F
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 15:00:01 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id o9so11172419pgd.2
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LBQFfB81E+P58yjRe+k2+cx97sDCbuPy/V/8bIJeXkc=;
 b=d1nEfDWwq7FWKqIFyB7wcvXzmP+qszgIuZNrjkwP3x1/yDu+sQSJ4TgOka8JMFwdpz
 FbG95ETwwZelyW9y9nYy/fBdQQ5EpoXh41Gbn4eQmQTaoxF5map34fNshbDgQ+GKj1eQ
 M2HNtozQY8mDF7hXNffuvHHSZK/H+HS3mDWozeDZ1wrNV7N6DSSxBit7yoz2Djn0vKsu
 PTtFJD9Ofb3TtKRa65oNYY7gKKMzGB1TuT8lxEnUuKWvE9MiqzfZDCghwXldP+Yap8sq
 BhmGax5uZd/Z3aYrXJPVjrW6XKPjEpwSZcuA8L3oguKgjEhjLQ9bi63V9oWBmfiZKAst
 VQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LBQFfB81E+P58yjRe+k2+cx97sDCbuPy/V/8bIJeXkc=;
 b=P32KOjZXE4/rCimecXO9c1eX3EHgXAwz9jkxFNbNODnCo0Jhqb/xLYvK9yUuxeJJxx
 9mgq/KqYAaPV4EPH8yP+D7QS3ieWtAz8VUTrT36AfISZtRRJfJ4WsIuEeRoKLdyp/+C9
 lWG03o5FkugIyWlf8HY8U7e0EQW0gvuC3mZg46PImLFuZBlms7t2Twe65J9mq9Wl1qb6
 bDFPZytbFUh/s5T6capK2D2DDKQOYu1p1eG8gCeUNsECUv3QVDGAxTnuI+7wqapWhKHv
 HKowq1wKtnmt/LTfIeFJj7xnHoDq8UBZHXi/STpQPkAUm36QEtM6ou0LGSMfDLumgqPY
 uZ6A==
X-Gm-Message-State: AOAM5333UeQjwqwtWJYJ1nXWu5/Cvfkdid/6KCn4FmJALESLtKhcorMr
 zd564NSAPZs0URVWoyRBP9Y=
X-Google-Smtp-Source: ABdhPJxA6AxF//BtD4CX3ss9LWnlUG4jgLj+0PRFw+NP8biHDKV1XDA0j2C9BbRScevume4H06cdTA==
X-Received: by 2002:a63:7d2:: with SMTP id 201mr18504206pgh.14.1623078000846; 
 Mon, 07 Jun 2021 08:00:00 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 x6sm8711203pfd.173.2021.06.07.07.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 08:00:00 -0700 (PDT)
Subject: Re: [RFC PATCH V3 11/11] HV/Storvsc: Add Isolation VM support for
 storvsc driver
To: Christoph Hellwig <hch@lst.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-12-ltykernel@gmail.com>
 <20210607064603.GD24478@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <26c771e5-a64e-f2cc-e245-fa5f130f4b18@gmail.com>
Date: Mon, 7 Jun 2021 22:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607064603.GD24478@lst.de>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, mingo@redhat.com,
 xen-devel@lists.xenproject.org, jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, kuba@kernel.org, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, sunilmut@microsoft.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, cai@lca.pw, akpm@linux-foundation.org,
 robin.murphy@arm.com, davem@davemloft.net, rppt@kernel.org
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



On 6/7/2021 2:46 PM, Christoph Hellwig wrote:
> On Sun, May 30, 2021 at 11:06:28AM -0400, Tianyu Lan wrote:
>> +				for (i = 0; i < request->hvpg_count; i++)
>> +					dma_unmap_page(&device->device,
>> +							request->dma_range[i].dma,
>> +							request->dma_range[i].mapping_size,
>> +							request->vstor_packet.vm_srb.data_in
>> +							     == READ_TYPE ?
>> +							DMA_FROM_DEVICE : DMA_TO_DEVICE);
>> +				kfree(request->dma_range);
> 
> Unreadably long lines.  You probably want to factor the quoted code into
> a little readable helper and do the same for the map side.

Good suggestion. Will update.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
