Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B813C433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 13:56:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF1361241
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 13:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BF1361241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0369C403C1;
	Thu, 16 Sep 2021 13:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lZ4seoiFGy6m; Thu, 16 Sep 2021 13:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E4A140240;
	Thu, 16 Sep 2021 13:56:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E40BFC0011;
	Thu, 16 Sep 2021 13:56:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81367C000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 13:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63376607A9
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 13:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XJs2Y_ELAHW6 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 13:56:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63A0360737
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 13:56:26 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id g184so6225079pgc.6
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VQdB0cmtRyC2OUQYF1nmKrbKRoOhkmjS2WdWxiwvfV0=;
 b=CIfTuZFoNILRqkZ8DcW/GNbMyGgDnxBr4dVf4uWbZjU8pjj4lrHMRtQVPwcdxklAuQ
 JZziDYokWmjzVIErChST09t12g0u5Q0uRpqfgz1HLLBW1rjGMPZLz0kZ+aU/1VtdGCBf
 ScvmIZdC/KAH9/s5zwFCH/t+wJJgREk4jkxOEav0yNRvD2PeR9Mt0gXD43CEjS0rWa6X
 1ojan6I2m/RB70FhK0zBN0wx5wwjfaYXFG9iPhqmYChnfbWqL1/mqLAFucMtI4L4kMUT
 mDpT/XbuXdWRn1Ki+KD46f09IzCVvENPhyPuOqItQNeOtC2mXKgNu7d+59tp7LLGPGIj
 mQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VQdB0cmtRyC2OUQYF1nmKrbKRoOhkmjS2WdWxiwvfV0=;
 b=kApzJ58aMC+IekEov/F4I7hHGg1c5mkFuPHP25YJkSlHg4qkurcTpDMapDT79617c7
 ptDu8k6p2blNsG/Bmw4T7GY5y60zi1GeuER8ZGHyXyQPZq7D5NoiuhcTSHTaHLlopuYb
 TFzw3ls5lUo0YvqFq7o+HpmziXrt97zS2sLuQfF3AV+2kvbCLuWadDGApf5EIOrTdQ3Z
 zhmf0o1ClWqQkj7/D7yW9khoLJs5CBGt0CqkoBNlqLYsRI9G6446dXcce+brXap527m+
 pod67IhwOIQFg5um7OKpFSew1SgOFdBynTYDf/N+GuxalLzPTeirKKfWow0+7wA9q4MR
 /j7w==
X-Gm-Message-State: AOAM5309Dq9tIsCtED00OtNpUvuCu2SBCE0L37vS+LQTFWjUK5Qf045s
 1WZEJNSDSwHBpUnOsjOlhSg=
X-Google-Smtp-Source: ABdhPJwil566vQyG+FPIeqOpCAnK+VdYspH+w8JoanT8EwRLxY95XCPpJH9ls0yqVjdetF6RlrGZEg==
X-Received: by 2002:a65:44c4:: with SMTP id g4mr5187939pgs.254.1631800585774; 
 Thu, 16 Sep 2021 06:56:25 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 w11sm3376724pfj.65.2021.09.16.06.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Sep 2021 06:56:25 -0700 (PDT)
Subject: Re: [PATCH V5 12/12] net: netvsc: Add Isolation VM support for netvsc
 driver
To: Haiyang Zhang <haiyangz@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "tj@kernel.org" <tj@kernel.org>, "rientjes@google.com" <rientjes@google.com>
References: <20210914133916.1440931-1-ltykernel@gmail.com>
 <20210914133916.1440931-13-ltykernel@gmail.com>
 <MWHPR21MB15939A5D74CA1DF25EE816ADD7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <MN2PR21MB12959F10240EC1BB2270B345CADB9@MN2PR21MB1295.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <31da994f-a032-dd40-a90e-bfdaf313d45d@gmail.com>
Date: Thu, 16 Sep 2021 21:56:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <MN2PR21MB12959F10240EC1BB2270B345CADB9@MN2PR21MB1295.namprd21.prod.outlook.com>
Content-Language: en-US
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>
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

On 9/16/2021 12:46 AM, Haiyang Zhang wrote:
>>> +				memset(vmap_pages, 0,
>>> +				       sizeof(*vmap_pages) * vmap_page_index);
>>> +				vmap_page_index = 0;
>>> +
>>> +				for (j = 0; j < i; j++)
>>> +					__free_pages(pages[j], alloc_unit);
>>> +
>>> +				kfree(pages);
>>> +				alloc_unit = 1;
>> This is the case where a large enough contiguous physical memory chunk
>> could not be found.  But rather than dropping all the way down to single
>> pages, would it make sense to try something smaller, but not 1?  For
>> example, cut the alloc_unit in half and try again.  But I'm not sure of
>> all the implications.
> I had the same question. But probably gradually decrementing uses too much
> time?
> 

This version is to propose the solution. We may optimize this to try
smaller size until to single page if this is right direction.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
