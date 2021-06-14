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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B035EC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 13:42:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD7A6128C
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 13:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD7A6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BB75606D8;
	Mon, 14 Jun 2021 13:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EuaFSnYYk2Dj; Mon, 14 Jun 2021 13:42:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 109D96058F;
	Mon, 14 Jun 2021 13:42:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0D0DC000D;
	Mon, 14 Jun 2021 13:42:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CE8BC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DC3B6060C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aLqsYv2K5Rly for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 13:42:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71C8A6058F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:42:14 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id m2so1949096pgk.7
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BOH7Vu+778+ln6ekCo+GQvvDaGAsmqLU6p5AWEG4zZQ=;
 b=UL15DRdkb+5FCOorYR2hP1xNvGKF+hhVpp6Zgl0ZEc/kynMSrJYTv2B24Mo4Twd4OC
 vrOGM4BGqqMhwnmUjnn22As3rfqICUuSLDNUfN4x055EQkDEP6U8uykZ1ageGPFza6dy
 jotUZIYfU7sXGQAZHr4kuOdz1HN1DauLgWNH57sKiZSzR0dkndXAb/EFiLKvDgTKoc5n
 CF/y9pIWqcDDuK8B74SpZxdcaDkimajNnHxGveNvr7r1vPb4MaK8pI1+WDcP5irZNQIO
 K/ubQwcXeNSCfSAQihAGciweSNRMmdfdrpjGhRR3Ol9hGp7Cim/3jPpHV8NR+c4DzoMz
 2CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BOH7Vu+778+ln6ekCo+GQvvDaGAsmqLU6p5AWEG4zZQ=;
 b=QL9PLfnmyOEktWGfPIySa1fcIaovJFVBFz/BhAtyHjDpNWVKjdfx9eOq/i/UXiHZoU
 TAst7SQJ48hJieWUMoFKao03EWhZQ53YXvWh+8P2/mTZyXqhT5WVA+9K/FNfSL7XoAkE
 lg47N0vYRtFLaHi2mrxFhQZEFkFqes4YHQL59SkyM23U/m72osZ1WpV3euMk8EPa4wQb
 hqQNY9HlH6wCEFNwk0jg+nX+6mf7aDvbW7OnMcz7RiI6wpHmF5DRA5eDavBouWkN0bN0
 6R+9QBseFo9GDkfnifLCYdl850KRgUocyNgJnNOW9CPzyuBrBZRSyNt4DWUUk9Q1FxMu
 esAQ==
X-Gm-Message-State: AOAM533/hhTfL/YniQPakPGwxTeSyIPD7tJUUHhVm459OCUTEeuCwa1j
 kDnsk1RfDYYLOgp1nqohgAY=
X-Google-Smtp-Source: ABdhPJzSD5SSODv3ZNJBk7/EJwQiektVm8x7/VFzAUKIi7xqvpG8L/erou4acHYRKMj3nTXmR0zAfQ==
X-Received: by 2002:a63:f13:: with SMTP id e19mr16837169pgl.112.1623678133793; 
 Mon, 14 Jun 2021 06:42:13 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 s13sm13014226pgi.36.2021.06.14.06.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jun 2021 06:42:13 -0700 (PDT)
Subject: Re: [RFC PATCH V3 08/11] swiotlb: Add bounce buffer remap address
 setting function
From: Tianyu Lan <ltykernel@gmail.com>
To: Christoph Hellwig <hch@lst.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-9-ltykernel@gmail.com>
 <20210607064312.GB24478@lst.de>
 <48516ce3-564c-419e-b355-0ce53794dcb1@gmail.com>
 <20210614071223.GA30171@lst.de>
 <3e64e59b-7440-69a5-75c5-43225f3d6c0a@gmail.com>
Message-ID: <ee3d79ea-f4f9-b886-e1ee-e26b42a88530@gmail.com>
Date: Mon, 14 Jun 2021 21:42:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3e64e59b-7440-69a5-75c5-43225f3d6c0a@gmail.com>
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

On 6/14/2021 9:37 PM, Tianyu Lan wrote:
> 
> 
> On 6/14/2021 3:12 PM, Christoph Hellwig wrote:
>> On Mon, Jun 07, 2021 at 10:56:47PM +0800, Tianyu Lan wrote:
>>> These addresses in extra address space works as system memory mirror. 
>>> The
>>> shared memory with host in Isolation VM needs to be accessed via extra
>>> address space which is above shared gpa boundary.
>>
>> Why?
>>
> 
> The shared_gpa_boundary in the AMD SEV SNP spec is called virtual top of
> memory(vTOM). Memory addresses below vTOM are automatically treated as
> private while memory above vTOM is treated as shared. Using vTOM to
> separate memory in this way avoids the need to augment the standard x86
> page tables with C-bit markings, simplifying guest OS software.

Here is the spec link and vTOM description is in the page 14.
https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf

Thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
