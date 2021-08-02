Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E68CC43216
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 13:32:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5072A60FA0
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 13:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5072A60FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19C58400C5;
	Mon,  2 Aug 2021 13:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zfbri06Q9ygG; Mon,  2 Aug 2021 13:32:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BBFBE40004;
	Mon,  2 Aug 2021 13:32:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85581C0010;
	Mon,  2 Aug 2021 13:32:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4120C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B8A2401CE
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HxJnQkkJt8Nt for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 13:32:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23EDB40004
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:32:50 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id k1so19584830plt.12
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Zaf+5dU3RLSl9eL+MQvIjvf9i9eq7xHute6xnxP/ss8=;
 b=lzLycDZx+VgbDgddV/I+3isOD43Vy0BkIdAf1yHmxOpy7/nQ2h/20I3MZKvLheRAfo
 bQGladbLi22o2mpFkEByG5LNltJK09xhP1gfAPOR8XF9Vgo3NEVD/jyTJznRBYBCRjq7
 mmnAa6JV8TPX7L6HR2Yw9fBKonGL4iSYr9ttnd9k3KcVWf/HnsrrQ0l71AwCJ07/uolw
 qMzfDw7EEeP/xzHEQK5KLJHSpIyFcZ1xwGqJvKS7M/hpYiX31RexDYDQYOH3f8znEAYa
 +gp0X5yO6CkoB7PtXKHyTPRWGAPzTrwFvh3JsjSYhcxB6xBY5Zyqb4DJ96A4xrQjjHm+
 1kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zaf+5dU3RLSl9eL+MQvIjvf9i9eq7xHute6xnxP/ss8=;
 b=kvkeO3W003k4lPKK7l/qceMapg6UvNPi3Q1X4L9zmuAL6pKVTCBpsHOH8V/lrPnXMA
 ezBka/B4fX2HhhLf7nq0hgBDeg+Ya5hqWY4HvIe9weooM0N9G/ElQlxwV3uTvvFBVV1z
 qNYoPiyPJReiLdsPgfTabASgKQDOFtkY21XZw9CglCBYYggNHPpiarqTVNQ1z1GhhFMZ
 BwEvxFyRB2VforzAzTYUatf2MAHiilpVGLN+e6518XU8eXzN7YGE7TO5T8FSLDTMJeVV
 1cED/By2PRi9zmxcfr65l1h82FFyOTMwxWeEpG/856z73cPYYxOKIReQj/sdLQQ0OsMJ
 lwhA==
X-Gm-Message-State: AOAM531WBibRz2nrhfps5aNrrjqaIBj45QEy6/SQQ8nybDUL2KgVfFZ6
 XIZW2YwNFk0FAvdojuA8cvQ=
X-Google-Smtp-Source: ABdhPJw26TcdJx7nJdP8OVOffK3BNROQGPQJnGpjzP8q2wSE+WsIrRM3Kk21HhrucVZR9IjyKRevpw==
X-Received: by 2002:a65:6a01:: with SMTP id m1mr1550797pgu.201.1627911169578; 
 Mon, 02 Aug 2021 06:32:49 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 f5sm11780560pfn.134.2021.08.02.06.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Aug 2021 06:32:49 -0700 (PDT)
Subject: Re: [PATCH 06/13] HV: Add ghcb hvcall support for SNP VM
To: Joerg Roedel <joro@8bytes.org>
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-7-ltykernel@gmail.com> <YQfnlBwyZUJyixQX@8bytes.org>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <436a4eda-bed2-9107-e297-3dee381354ff@gmail.com>
Date: Mon, 2 Aug 2021 21:32:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQfnlBwyZUJyixQX@8bytes.org>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, david@redhat.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, vkuznets@redhat.com,
 hpa@zytor.com, anparri@microsoft.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, sfr@canb.auug.org.au,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 aneesh.kumar@linux.ibm.com, x86@kernel.org, decui@microsoft.com, hch@lst.de,
 michael.h.kelley@microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, akpm@linux-foundation.org,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, ardb@kernel.org, robin.murphy@arm.com, davem@davemloft.net,
 rppt@kernel.org
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

On 8/2/2021 8:39 PM, Joerg Roedel wrote:
> On Wed, Jul 28, 2021 at 10:52:21AM -0400, Tianyu Lan wrote:
>> +	hv_ghcb->ghcb.protocol_version = 1;
>> +	hv_ghcb->ghcb.ghcb_usage = 1;
> 
> The values set to ghcb_usage deserve some defines (here and below).
> 

OK. Will update in the next version.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
