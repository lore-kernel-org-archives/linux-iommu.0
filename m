Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766AC41536
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 16:01:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AA061E16
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 16:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AA061E16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0060607B2;
	Wed, 12 May 2021 16:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p5E6VIQLOl2S; Wed, 12 May 2021 16:01:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF2C4608B0;
	Wed, 12 May 2021 16:01:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5C90C000E;
	Wed, 12 May 2021 16:01:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27533C0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 16:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08AFB608B0
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 16:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NUeUAORk0K2x for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 16:01:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62FD9607B2
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 16:01:14 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 pi6-20020a17090b1e46b029015cec51d7cdso1309613pjb.5
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5/MplZ6oYXtQw2JFwTKJsqNpcX+apjnkiw44w1Cqcuo=;
 b=EQwntmF6pP3DBJ88bmhariOI9t4IKKtCPxB2phWGOC74jrMotb3ZCiTXXW16g67V0h
 8HVeJ0GheMO0pRAFNX4jKbmzmE+Qf8EKG3s79mh2+TjoJ77eNPmt01t4bFBgCEpZMQYS
 LtqGvaxjzI7bnbkr39ucdoF9COsZV+kpDzrwJ3LopkNaVGle3wN8WsASeqDSWcrxUXNq
 l5Oqo36f1zOS36IgBY0vrE19xWxnxCnuQZW0ACKwM1vfnoNVDWJ5KT6c8CBkMQmT0Avv
 j0Aoqpt+TzspMyc0v3GAvNXVY/RSbD7UNpll9CI5ElGs5Xyk4zXN78+QI0vIQtbqXWFj
 2nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5/MplZ6oYXtQw2JFwTKJsqNpcX+apjnkiw44w1Cqcuo=;
 b=L5F4c5gRAfHk7DrmWSuvHQGMNDgDzTqYQ6eoFTzL+No/Ipyiq1+hb1E7v+F+ZsKo8P
 EsYjDahrDy4YcTNBpWQ7Ax0SQruZOVbSDx8G9LEzOn7D5FZ60GkqYQ5cIW4zXiE6X+dG
 bcu8/aWotYMlcabULjA+mnfJGl+CJIzaKhbmpjfcmvBGft5gOQzTdTi7gseF3s23b/QT
 tII7zivtsjRTVRIS4Ja/B+VSpE3v2eGtOxtzNK669U7wU/hJMFOcDzftlL606qNj9jjF
 rmMvlPDIDexiIfrWYIOdRynYxDFKlSSS7CbbOulWWytQSqZsTN6aEHu0Y/y0T9sdYcqh
 lIjQ==
X-Gm-Message-State: AOAM5317EmF1W578idgLfRX/8ftcEpPAV1C6XNH476eABBntdbqRz8zU
 wLvQ1LY3bTfcZqfALuuVul4=
X-Google-Smtp-Source: ABdhPJxtWg7IxeHd7M+hWJJqKPqAcUV/yJEzGw/b/vFIZdhJW26Hi6Inh2Unritq+GbozDcH9ke1gw==
X-Received: by 2002:a17:90a:7442:: with SMTP id
 o2mr2519021pjk.44.1620835273807; 
 Wed, 12 May 2021 09:01:13 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 i24sm238402pfd.35.2021.05.12.09.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 09:01:13 -0700 (PDT)
Subject: Re: [Resend RFC PATCH V2 10/12] HV/IOMMU: Add Hyper-V dma ops support
To: Christoph Hellwig <hch@lst.de>, konrad.wilk@oracle.com
References: <20210414144945.3460554-1-ltykernel@gmail.com>
 <20210414144945.3460554-11-ltykernel@gmail.com>
 <20210414154729.GD32045@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <a316af73-2c96-f307-6285-593597e05123@gmail.com>
Date: Thu, 13 May 2021 00:01:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210414154729.GD32045@lst.de>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, linux-mm@kvack.org,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, sunilmut@microsoft.com,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, mingo@redhat.com, kuba@kernel.org,
 jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de, vkuznets@redhat.com,
 martin.petersen@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com,
 davem@davemloft.net
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

Hi Christoph and Konrad:
      Current Swiotlb bounce buffer uses a pool for all devices. There
is a high overhead to get or free bounce buffer during performance test.
Swiotlb code now use a global spin lock to protect bounce buffer data.
Several device queues try to acquire the spin lock and this introduce
additional overhead.

For performance and security perspective, each devices should have a
separate swiotlb bounce buffer pool and so this part needs to rework.
I want to check this is right way to resolve performance issues with 
swiotlb bounce buffer. If you have some other suggestions,welcome.

Thanks.

On 4/14/2021 11:47 PM, Christoph Hellwig wrote:
>> +static dma_addr_t hyperv_map_page(struct device *dev, struct page *page,
>> +				  unsigned long offset, size_t size,
>> +				  enum dma_data_direction dir,
>> +				  unsigned long attrs)
>> +{
>> +	phys_addr_t map, phys = (page_to_pfn(page) << PAGE_SHIFT) + offset;
>> +
>> +	if (!hv_is_isolation_supported())
>> +		return phys;
>> +
>> +	map = swiotlb_tbl_map_single(dev, phys, size, HV_HYP_PAGE_SIZE, dir,
>> +				     attrs);
>> +	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
>> +		return DMA_MAPPING_ERROR;
>> +
>> +	return map;
>> +}
> 
> This largerly duplicates what dma-direct + swiotlb does.  Please use
> force_dma_unencrypted to force bounce buffering and just use the generic
> code.
> 
>> +	if (hv_isolation_type_snp()) {
>> +		ret = hv_set_mem_host_visibility(
>> +				phys_to_virt(hyperv_io_tlb_start),
>> +				hyperv_io_tlb_size,
>> +				VMBUS_PAGE_VISIBLE_READ_WRITE);
>> +		if (ret)
>> +			panic("%s: Fail to mark Hyper-v swiotlb buffer visible to host. err=%d\n",
>> +			      __func__, ret);
>> +
>> +		hyperv_io_tlb_remap = ioremap_cache(hyperv_io_tlb_start
>> +					    + ms_hyperv.shared_gpa_boundary,
>> +						    hyperv_io_tlb_size);
>> +		if (!hyperv_io_tlb_remap)
>> +			panic("%s: Fail to remap io tlb.\n", __func__);
>> +
>> +		memset(hyperv_io_tlb_remap, 0x00, hyperv_io_tlb_size);
>> +		swiotlb_set_bounce_remap(hyperv_io_tlb_remap);
> 
> And this really needs to go into a common hook where we currently just
> call set_memory_decrypted so that all the different schemes for these
> trusted VMs (we have about half a dozen now) can share code rather than
> reinventing it.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
