Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEECC43217
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 11:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA409607CC;
	Thu,  9 Dec 2021 11:17:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nHI17IgXuDm7; Thu,  9 Dec 2021 11:17:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 77AC960658;
	Thu,  9 Dec 2021 11:17:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 557C8C0038;
	Thu,  9 Dec 2021 11:17:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62E8DC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 11:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 427206066D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 11:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e7dP4k3yjUGq for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 11:17:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAAA860658
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 11:17:17 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 gx15-20020a17090b124f00b001a695f3734aso4605879pjb.0
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=7++LgR6CHSvNByLY82LW9yKqPrn0areIcNLzqPnbuDs=;
 b=devInOcspgU9jMzUkwQ4cW9HzrPs8Huk68CilnEkO0UWTbHyLicW6H5aVikM64Gmnx
 WFs4Sp2hpBcuLpVmLGIsvEPCFunl7OLPuW8wpVIoJMvHPR4Y45nM/4sWIbLncBsa3Tps
 UCW7DSv0OKimSsiFG+nqvvCNykGnbOPOTWRktixpuBhEC7IcYt5V7AbFgEQKYZS5V8Nk
 pmC3XjlowIpRQL3uAPUUJXhKBDet1SCbmvvKnsJTSDwAU9fnFWxmbNzL8p1bq1OEnEl8
 /bcYeIiCEkI8oSLGwK1p0KxtDFemGjK9t+BFw0jb/uD2AVAmRJLTnu/+fy92lNKJGZJF
 R1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7++LgR6CHSvNByLY82LW9yKqPrn0areIcNLzqPnbuDs=;
 b=W6zSRZNqrjydcQ57H3QiZIfqRXKF3avofCOITxOJ/b2xnRIqSs4kys4favSc90DGKl
 WrWFlnW8IvSX1zoeSQF8tN+6WEQs/Ft124dcbjyKGUgMsGkSQ0vw6IKLMbfWW7r8sRQY
 7Kcnqs+OGBDH6CQNYFM7B5qDcsduf0d0Z1QEO+G4qGK4DK0zQ2v1DvzRBNDCOL+1INmj
 thFSbO1z+m61UdYTlIcNryREzONkbMhnFRQ6O+iQc0FV6irlwIpzhdA8a0BUIpYBUgjJ
 VlWAshiiRW1iXgZsNwQkoNjBzXXyAx4fGJSA8f1URVpgqkOzAz6wF+2BGtR+wOPwbSQ/
 XAhw==
X-Gm-Message-State: AOAM531+z63mR49rbXsW1rSubIZExWQaHctLPEQDJCbLVPGTTmGryUz9
 YyQ97MIt1uIO6Tihvvsb//o=
X-Google-Smtp-Source: ABdhPJw6mFG+w4KDhuIF/LkOsGARjWx+5UEh9URRd9WM7jkBUtu2M0tOhMtumtGVnqqsw5jUCAd09g==
X-Received: by 2002:a17:90b:3850:: with SMTP id
 nl16mr14999898pjb.10.1639048637182; 
 Thu, 09 Dec 2021 03:17:17 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 d10sm6777113pfl.139.2021.12.09.03.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 03:17:16 -0800 (PST)
Message-ID: <ff4497cc-741a-113c-c6eb-dd5966716863@gmail.com>
Date: Thu, 9 Dec 2021 19:17:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V6 4/5] scsi: storvsc: Add Isolation VM support for
 storvsc driver
Content-Language: en-US
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@infradead.org" <hch@infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "Michael Kelley (LINUX)" <mikelley@microsoft.com>
References: <20211207075602.2452-1-ltykernel@gmail.com>
 <20211207075602.2452-5-ltykernel@gmail.com>
 <BY5PR21MB1506535EF9222ED4300C38BBCE709@BY5PR21MB1506.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BY5PR21MB1506535EF9222ED4300C38BBCE709@BY5PR21MB1506.namprd21.prod.outlook.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>, "hch@lst.de" <hch@lst.de>
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



On 12/9/2021 4:00 PM, Long Li wrote:
>> @@ -1848,21 +1851,22 @@ static int storvsc_queuecommand(struct Scsi_Host
>> *host, struct scsi_cmnd *scmnd)
>>   		payload->range.len = length;
>>   		payload->range.offset = offset_in_hvpg;
>>
>> +		sg_count = scsi_dma_map(scmnd);
>> +		if (sg_count < 0)
>> +			return SCSI_MLQUEUE_DEVICE_BUSY;
> Hi Tianyu,
> 
> This patch (and this patch series) unconditionally adds code for dealing with DMA addresses for all VMs, including non-isolation VMs.
> 
> Does this add performance penalty for VMs that don't require isolation?
> 

Hi Long:
	scsi_dma_map() in the traditional VM just save sg->offset to
sg->dma_address and no data copy because swiotlb bounce buffer code
doesn't work. The data copy only takes place in the Isolation VM and
swiotlb_force is set. So there is no additional overhead in the 
traditional VM.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
