Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771F2C48BE8
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 14:31:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E49261483
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 14:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E49261483
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E4E15402E6;
	Tue, 15 Jun 2021 14:31:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ceRjXBfzDtrA; Tue, 15 Jun 2021 14:31:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E137A4037A;
	Tue, 15 Jun 2021 14:31:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA8F0C000D;
	Tue, 15 Jun 2021 14:31:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 209BEC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 14:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A2DB607C9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 14:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w28PurqkIdiq for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 14:31:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EA99606BB
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 14:31:45 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id s14so13388380pfd.9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=09f7flVgvhf5eQwpZCIbvOGTARFj7yeM2HilMpzlWLk=;
 b=jk2oxSkqx62fHfzZ2Td3CQMKVDfVLX5soiM/JukpALSNJHJr6bPDtlz3KWKAxXo94O
 s/hllSh2es9DhRUKAKUitklZDcf/EnVOKXhkOj9PYfOCpVShjA/ALCwL9qmhEU6/Uawa
 XK557NRD7ifNeZzvRQOvgq1OjZVLzX0tIkT8t770jqHE0cKYFvqhPHbZNRgnhaDUZKFF
 qX9q9wmOAxzVgsgD1wpLoriKUlqy7RCPkNZ1jG4aLxQucHRt8DEitzL0SOUV96Pc1UDE
 2mXJY2Jw/0wFzqk5I0o9iVdLMmeZJJ8WeATZpVLS5cPgmlZCB/DeT8DlSYdBw+t/FiNV
 Ts4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=09f7flVgvhf5eQwpZCIbvOGTARFj7yeM2HilMpzlWLk=;
 b=PszFA09KnIF8s0jqp8bY0OTwnuuTikhO+2RzDHIuL+4/we8qL1DtX6uuzfM3n1FV8j
 Vygba+7DlVnDFsJOeeDQ7pf3dGcCBvIuwR+yymTXNBwoaLDxPF/MALtdbzkA04tHWtHt
 G90BwkTkcN2KHWxjZ/y92BnfTnPydQcMAftpRxNM1NbYJmy6jKggMnLyGaiLaNrYZ0lN
 svKPVQUCMmJnHeVXAeomoQGboAsyxlNilIwvUL6n5aLL/E9OK9t1LUvmP1WhuqUkt32g
 gd4o1sKzOvSm5JsygDJKZlW0oXx5YhbQBYGPruhflm6CHGEX+98UypvuJLo5Jm2lc68M
 i60A==
X-Gm-Message-State: AOAM5325TMt328KrBCH/SWwddrXnnGKqnBLUMEEgyATn45vW4Ydg4RzG
 7i4ae3DswhhANPQXWWJ4ueQ=
X-Google-Smtp-Source: ABdhPJyHvlYi58GrVtZOOV1UUSDfdDdKTtRA2DlWTeNf7j5KzC+iOROVnZire7W4JyUnDsrG1dvTzA==
X-Received: by 2002:a65:550e:: with SMTP id f14mr22678348pgr.160.1623767504841; 
 Tue, 15 Jun 2021 07:31:44 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 fy16sm2711030pjb.49.2021.06.15.07.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 07:31:44 -0700 (PDT)
Subject: Re: [RFC PATCH V3 10/11] HV/Netvsc: Add Isolation VM support for
 netvsc driver
To: Christoph Hellwig <hch@lst.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-11-ltykernel@gmail.com>
 <20210607065007.GE24478@lst.de>
 <279cb4bf-c5b6-6db9-0f1e-9238e902c8f2@gmail.com>
 <20210614070903.GA29976@lst.de>
 <e10c2696-23c3-befe-4f4d-25e18918132f@gmail.com>
 <20210614153339.GB1741@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <7d86307f-83ff-03ad-c6e9-87b455c559b8@gmail.com>
Date: Tue, 15 Jun 2021 22:31:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614153339.GB1741@lst.de>
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

On 6/14/2021 11:33 PM, Christoph Hellwig wrote:
> On Mon, Jun 14, 2021 at 10:04:06PM +0800, Tianyu Lan wrote:
>> The pages in the hv_page_buffer array here are in the kernel linear
>> mapping. The packet sent to host will contain an array which contains
>> transaction data. In the isolation VM, data in the these pages needs to be
>> copied to bounce buffer and so call dma_map_single() here to map these data
>> pages with bounce buffer. The vmbus has ring buffer where the send/receive
>> packets are copied to/from. The ring buffer has been remapped to the extra
>> space above shared gpa boundary/vTom during probing Netvsc driver and so
>> not call dma map function for vmbus ring
>> buffer.
> 
> So why do we have all that PFN magic instead of using struct page or
> the usual kernel I/O buffers that contain a page pointer?
> 

These PFNs originally is part of Hyper-V protocol data and will be sent
to host. Host accepts these GFN and copy data from/to guest memory. The 
translation from va to pa is done by caller that populates the 
hv_page_buffer array. I will try calling dma map function before 
populating struct hv_page_buffer and this can avoid redundant 
translation between PA and VA.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
