Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC38C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 13:37:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1EC61153
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 13:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1EC61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0334E6082B;
	Mon, 14 Jun 2021 13:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kzCPDrVupjA; Mon, 14 Jun 2021 13:37:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ECCA7606D8;
	Mon, 14 Jun 2021 13:37:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC619C000D;
	Mon, 14 Jun 2021 13:37:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DBFFC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30AC9607E7
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:37:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8NiaeQHhx2EW for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 13:37:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89784606D8
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:37:16 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id v12so6555991plo.10
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L2zqO1GmHtYJk6YxBI1sWe6jLyKPpb1AfJC8K4R6e5k=;
 b=Cxb1/imPkH0J0mCr4lfArmxBVSP9MZn7j5y/xPOvK408iNpZ/trCx7iTSB97b+6h2r
 GH8FYPrOC4Fgm9Z7GYXw2Q6TAfu1pePiEZj/1/rkvJ46B3Wt5yANQsUnBs0W0Zpx2yUg
 FUCFHCSdOksAFWye+3qd6MfK6evFhwMm5txRVoHom2eNUq2iAZevoB1ovrJLeR2+pngA
 zIKmOSyFmyM+dI38qtVe8XxjSsIv9gPiitEg81toKRhlb1r2KrcyYfURTl4AM29GboLz
 j4D3UMpwPezOe7xh7mP/Tz2Ele5K3oJYUbWnr9/m79e2/FDBSwGRnqztvf0n1OEzcoie
 ma5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L2zqO1GmHtYJk6YxBI1sWe6jLyKPpb1AfJC8K4R6e5k=;
 b=sZD+lS9FLAoRquvkxK7whZOW4y9WzPBafs+YJZ1Cu0wzwOs/eHO/m8nYdCpkHfTlQW
 HhORLnAH/4NQVI45y9APvLDA9V/o9nPaPvtD1PNJKCUaKzjmdEWQV9vUPmobxIUz/hGw
 fYpBB/LCUE8IK5Od8g2MbaDc/rQ6tEKLphHts1qLjrFvRBwJScU7C1zgiCv5ZltW2rVY
 /hlkab7G0j3GaQyF1Ilzq4NW5D5zlD6BWtfKi5BNygJomKwH1V55zGScEfdfDemFHTTg
 kmbm3FejedGM+twidTcPnC7ISfrmjBiInRwr3hWVgoHqWgWjptG7mYVUEoh0WDgo/V57
 GmFQ==
X-Gm-Message-State: AOAM530vNtQ82ad5J8sqOFQYNBnEbqYM0GwBVO4CyyF80X81eftCDqRU
 RsYENLwDYuNG4XPFQDfMsK4=
X-Google-Smtp-Source: ABdhPJzc3ULYnZUK4PYU2Lj8UKWkUEgb6rd9+REx3GFM6TekjZ3ClxH5FkBxfIYNNF665iBfi2dSTw==
X-Received: by 2002:a17:902:b585:b029:f6:5cd5:f128 with SMTP id
 a5-20020a170902b585b02900f65cd5f128mr16662490pls.43.1623677835908; 
 Mon, 14 Jun 2021 06:37:15 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 125sm12375806pfg.52.2021.06.14.06.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jun 2021 06:37:15 -0700 (PDT)
Subject: Re: [RFC PATCH V3 08/11] swiotlb: Add bounce buffer remap address
 setting function
To: Christoph Hellwig <hch@lst.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-9-ltykernel@gmail.com>
 <20210607064312.GB24478@lst.de>
 <48516ce3-564c-419e-b355-0ce53794dcb1@gmail.com>
 <20210614071223.GA30171@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <3e64e59b-7440-69a5-75c5-43225f3d6c0a@gmail.com>
Date: Mon, 14 Jun 2021 21:37:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614071223.GA30171@lst.de>
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



On 6/14/2021 3:12 PM, Christoph Hellwig wrote:
> On Mon, Jun 07, 2021 at 10:56:47PM +0800, Tianyu Lan wrote:
>> These addresses in extra address space works as system memory mirror. The
>> shared memory with host in Isolation VM needs to be accessed via extra
>> address space which is above shared gpa boundary.
> 
> Why?
> 

The shared_gpa_boundary in the AMD SEV SNP spec is called virtual top of
memory(vTOM). Memory addresses below vTOM are automatically treated as
private while memory above vTOM is treated as shared. Using vTOM to
separate memory in this way avoids the need to augment the standard x86
page tables with C-bit markings, simplifying guest OS software.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
