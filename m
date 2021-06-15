Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EBDC49361
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 15:25:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BB861603
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 15:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BB861603
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE397405E7;
	Tue, 15 Jun 2021 15:25:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DsuRgL1mWEvw; Tue, 15 Jun 2021 15:25:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8371F40482;
	Tue, 15 Jun 2021 15:25:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E7F4C000E;
	Tue, 15 Jun 2021 15:25:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DB16C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 15:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E95F40207
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 15:25:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eqjPv24TpwHk for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:25:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2886401FD
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 15:25:09 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id q15so11727410pgg.12
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=phyWWBHzkBpxWNeuQJLinu+go2K8vm0IQjBk4bPOC5o=;
 b=lLzyvAx1eLMBBQ9Nv6UWlyfS7bq09JfNMuTSA72Pidzs3ADzEJh5UZNx1+KXAA3QS7
 9qLwmHEZw5Xk+RHIQHD4WFV677p8Yi8BHKdEaKAbO078PZhHBwsAaiGPsQh7STbxJ28j
 3L9M/FShV9IoCoZ9A/Eh9ROBNoQr5F07JQAgtoeaUjtdIexg1Nk9GrQcrUXxHc9NNgOV
 D2nJiITYw2LCAuwzkpdFMOLcTULHsDylV5FWGHXPlqFv03pjAoTRz+TNqy9uLL90+fK0
 edPtBl2ZDPRtYC3zVnWadcZFdsLes9V2OCmaC/x9ZwogRVqJGjkXmr9UDyWpPbPkMxE8
 xgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=phyWWBHzkBpxWNeuQJLinu+go2K8vm0IQjBk4bPOC5o=;
 b=XvT517PzZWHMkirGHHAVw5beCpagd4titEx55TW8nP9AsCL0y7pXLKm2O4VbiV81wo
 IQsxJzcqxY0ljNKsW76dPwwDEGsst5uoL06D7FSSSZ8h+aQ3I+VJ9nVj43kkF94N1wyW
 r+3w/C58EicTaJ9AiPGFlwKFAv8KUvVp2rGcBWfCfuB+KBq9Dd4IaWosm3GR3l1Xeb9y
 v6vCY7Idg/40d7u5H/X2UjPDx+DGum+pTsmm5cwQk+wQD++r0G2x242/CfBxk4VWFWTU
 9KRBLy8OjqkZftntZyGSP0eU0Y/dNxkp1jnx9aCwyrJ1BySP8a/1M7VtlyLmMMMoSBJ6
 sZXA==
X-Gm-Message-State: AOAM5314LlNCn4xAvWYakYqEsnmBy6Z+Tu2mOod7WvFxpQfgX6G6McAH
 XvGqSOSnnRUq1DyKw6aPjCo=
X-Google-Smtp-Source: ABdhPJwV2uWurEEhhhqeCwFEjPg+6PpMse5GS6lAolB+VF7P2QpHJP+RpOWgZ5BBFF0RzwB+7lXyqg==
X-Received: by 2002:a65:6481:: with SMTP id e1mr85503pgv.140.1623770709416;
 Tue, 15 Jun 2021 08:25:09 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 u2sm15258266pfg.67.2021.06.15.08.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 08:25:09 -0700 (PDT)
Subject: Re: [RFC PATCH V3 08/11] swiotlb: Add bounce buffer remap address
 setting function
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-9-ltykernel@gmail.com>
 <20210607064312.GB24478@lst.de>
 <94038087-a33c-93c5-27bf-7ec1f6f5f0e3@arm.com> <20210614153252.GA1741@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <9e347c4c-d4b9-129c-10d2-0d7ff1b917cc@gmail.com>
Date: Tue, 15 Jun 2021 23:24:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614153252.GA1741@lst.de>
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
 hannes@cmpxchg.org, cai@lca.pw, akpm@linux-foundation.org, davem@davemloft.net,
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

On 6/14/2021 11:32 PM, Christoph Hellwig wrote:
> On Mon, Jun 14, 2021 at 02:49:51PM +0100, Robin Murphy wrote:
>> FWIW, I think a better generalisation for this would be allowing
>> set_memory_decrypted() to return an address rather than implicitly
>> operating in-place, and hide all the various hypervisor hooks behind that.
> 
> Yes, something like that would be a good idea.  As-is
> set_memory_decrypted is a pretty horribly API anyway due to passing
> the address as void, and taking a size parameter while it works in units
> of pages.  So I'd very much welcome a major overhaul of this API.
> 

Hi Christoph and Robin:
	Thanks for your suggestion. I will try this idea in the next version. 
Besides make the address translation into set_memory_
decrypted() and return address, do you want to make other changes to the 
API in order to make it more reasonable(e.g size parameter)?

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
