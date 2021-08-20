Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6249AC4338F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 18:04:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142E56115C
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 18:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 142E56115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2C8280DEE;
	Fri, 20 Aug 2021 18:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TCjywV0U9cU0; Fri, 20 Aug 2021 18:04:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2DB080D4E;
	Fri, 20 Aug 2021 18:04:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F475C001A;
	Fri, 20 Aug 2021 18:04:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFBE9C000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 18:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 945D54016D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 18:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OStDm5YxpN2c for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 18:04:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C36644056D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 18:04:27 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id x1so3830067plg.10
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QqX9IQo8g7WhG7Y3/RlQFVFx2KCstQLv7H4OsFNThv0=;
 b=QGQqGFLjVXsqVhcZsfR9+tjVsH1D3pSrX1tMNmqU0GIyCghQ/ePeqEBsaqliat+lBk
 sWM1blpaQD4n8UpkoQGp3GvRWRD5hog7rntjqP/tLitl0UO8N+cmjlpSE6BuDGlg1mOb
 ftTvn2OIVzMZD9A7EbVTeoquvRVhZ0TurG6rgOA49IykfcmSDWD+7KL1XF1ICKaePoh7
 eovukTIu5///DrcvTy6y4fU2ec67g3e7kh09QvOizKu6BPyJpz+gWDr2a4pZbE6eJ3jC
 tPpnVVUWuDkSNMXnx1AP93T+ZlOwsUj1K/EjlhTs/8P1XObwmDCUhDI36MeSDeyv+Lyx
 4pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QqX9IQo8g7WhG7Y3/RlQFVFx2KCstQLv7H4OsFNThv0=;
 b=kigxffDaejatMXY+ADyDr0ber4bflh7QHwae4OsrPxxqd1wTNmIWMG7UC3r/XJhoo6
 ysEdzlXEwkVsPdczgiH5oT/APkenW6iKVreFfXVFpKWmdbLgvB1CdBCpqZtEtCMW7JyM
 l0jEsCd8zhRVH42vJTTN2/4YjCKLL0IUZwRSpYXBCBbIE/b2CvM0bjgZOnde9ptD5np7
 AF8Ks6AqcisaKZlyWuJRwxdU0a/ieA7OrVBfj4hyBMOgGTuNp4rhQqg0htFKuxTzIqAL
 C6zVhRk+/0ZdKBGAz54LTN1dD4NViptqn91LGskFvvv7nbgbnZ2Cp9OL3LchgrdWnWfQ
 GEnQ==
X-Gm-Message-State: AOAM5310Pg3tY/pvfcStQ36Z5NQf2wKWY1opy9vWj7o34ZW86P69s8Qy
 qy8nlSfnYonYp/boc5/AsVI=
X-Google-Smtp-Source: ABdhPJyVf/JDbkxrxYIOEx8LcPerWBJMz+suKjnjDiwPFUPj971OZDtTnjV4pO5ZrAubU2bKD5IcXw==
X-Received: by 2002:a17:902:be0d:b0:12d:cb3c:3e7f with SMTP id
 r13-20020a170902be0d00b0012dcb3c3e7fmr17262258pls.0.1629482667216; 
 Fri, 20 Aug 2021 11:04:27 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 w14sm7846700pfn.91.2021.08.20.11.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 11:04:26 -0700 (PDT)
Subject: Re: [PATCH V3 13/13] HV/Storvsc: Add Isolation VM support for storvsc
 driver
To: Michael Kelley <mikelley@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
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
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "ardb@kernel.org" <ardb@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "rientjes@google.com" <rientjes@google.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "tj@kernel.org" <tj@kernel.org>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-14-ltykernel@gmail.com>
 <MWHPR21MB1593EEF30FFD5C60ED744985D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
 <a96626db-4ac9-3ce4-64e9-92568e4f827a@gmail.com>
 <CY4PR21MB158664748760672446BFA075D7C19@CY4PR21MB1586.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <939aa552-5c24-65ee-518d-1cf72867c15d@gmail.com>
Date: Sat, 21 Aug 2021 02:04:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CY4PR21MB158664748760672446BFA075D7C19@CY4PR21MB1586.namprd21.prod.outlook.com>
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



On 8/21/2021 12:08 AM, Michael Kelley wrote:
>>>>    	}
>>> The whole approach here is to do dma remapping on each individual page
>>> of the I/O buffer.  But wouldn't it be possible to use dma_map_sg() to map
>>> each scatterlist entry as a unit?  Each scatterlist entry describes a range of
>>> physically contiguous memory.  After dma_map_sg(), the resulting dma
>>> address must also refer to a physically contiguous range in the swiotlb
>>> bounce buffer memory.   So at the top of the "for" loop over the scatterlist
>>> entries, do dma_map_sg() if we're in an isolated VM.  Then compute the
>>> hvpfn value based on the dma address instead of sg_page().  But everything
>>> else is the same, and the inner loop for populating the pfn_arry is unmodified.
>>> Furthermore, the dma_range array that you've added is not needed, since
>>> scatterlist entries already have a dma_address field for saving the mapped
>>> address, and dma_unmap_sg() uses that field.
>> I don't use dma_map_sg() here in order to avoid introducing one more
>> loop(e,g dma_map_sg()). We already have a loop to populate
>> cmd_request->dma_range[] and so do the dma map in the same loop.
>>
> I'm not seeing where the additional loop comes from.  Storvsc
> already has a loop through the sgl entries.  Retain that loop and call
> dma_map_sg() with nents set to 1.  Then the sequence is
> dma_map_sg() --> dma_map_sg_attrs() --> dma_direct_map_sg() ->
> dma_direct_map_page().  The latter function will call swiotlb_map()
> to map all pages of the sgl entry as a single operation.

After dma_map_sg(), we still need to go through scatter list again to 
populate payload->rrange.pfn_array. We may just go through the scatter 
list just once if dma_map_sg() accepts a callback and run it during go
through scatter list.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
