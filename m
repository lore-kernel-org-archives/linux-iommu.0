Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E26C433EF
	for <iommu@archiver.kernel.org>; Sun,  5 Dec 2021 08:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 332DB403A1;
	Sun,  5 Dec 2021 08:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y3Eu6w5BjUEd; Sun,  5 Dec 2021 08:48:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C64D340384;
	Sun,  5 Dec 2021 08:48:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D247C002F;
	Sun,  5 Dec 2021 08:48:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B37CC0012
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DB134039C
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxX6FHnUaix2 for <iommu@lists.linux-foundation.org>;
 Sun,  5 Dec 2021 08:48:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83D8640384
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:48:37 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id gt5so5513872pjb.1
 for <iommu@lists.linux-foundation.org>; Sun, 05 Dec 2021 00:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=8ElIWeK3HZUhVw6Ru2fZxbGUFywB7lrb6pvwqCD90RQ=;
 b=bhv+ck/2NjW3XdA5BdRJjrWjIx7SyB0AZD+SN7/uKgD3cNgz6NnwAapRCo31zVSjzb
 NgZfsJ9/WQJJVn0VQnfOvhjrrQOUzDrWIZM6PBt02DsFfzOz0P0ty/E37M6lr8XytZ8A
 GgSWqw3N3Wxkk4kEV7dVoFtJ/fMVjrGspM0eMj7D7dAa6oC4rMqhk2Wmz428zuCyQ5ZD
 c+miU2npH6exTC0s6kc0N84Ux0N5mF2cpbZBZ2fD2HS6+BdfQnTvvbKBTj/M+EhVg9eP
 ySsd7Y2jJxO1lk6Nu30PxbFhUxeOGHSf8UIIB9fVS7RViOaS3EpL1I+yAKQTnYjJJO58
 teFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8ElIWeK3HZUhVw6Ru2fZxbGUFywB7lrb6pvwqCD90RQ=;
 b=AmcfJiI5FttwG8EV19t8XevmHlbg5TpNg0PFuwA8VeLu/urOBqos+Gt8GSyyaRI8An
 +8pJ2K9YUnU2/XhOUuREAyjzO/Iov5L9p8yLQ5pm5XK+tJdQeMYPiteK+W0+U+9habpz
 uUPxXhjmKPhQfJkpCnkCiljSmMfR/f1eJ449lLMHUX318teRMTOoyUK3JssdcQorB6OL
 V+zCQDLmtvaZtkrEo+w9BBbaRkX/Uffvp94Wg4XPm9AH7IxMAVf6pqSAXprdnw+mbG5D
 umJ6zj8trh3++lNgP8VBs6J+eeooVc6O38AjqfRFacTAQ7fjK4XZt66iYbWhylShZSYM
 BF8Q==
X-Gm-Message-State: AOAM531SJ5bl1YVgX5fjQ+EaomY6uN9qvlHpEvXd37wqRX3ml0SPcEvc
 0nNaiYRvZOSirdFQvx7Vsks=
X-Google-Smtp-Source: ABdhPJzbQjlNRx+yi2tFC2SlLvbS0vVoKxN+s/34myLn6vcm23U1Ad+X1dwpNWhVsnVmCKxk4h5fmA==
X-Received: by 2002:a17:902:b28a:b0:142:3e17:38d8 with SMTP id
 u10-20020a170902b28a00b001423e1738d8mr35656284plr.56.1638694116990; 
 Sun, 05 Dec 2021 00:48:36 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 m10sm6512901pgv.75.2021.12.05.00.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Dec 2021 00:48:36 -0800 (PST)
Message-ID: <125ffb7d-958c-e77a-243b-4cf38f690396@gmail.com>
Date: Sun, 5 Dec 2021 16:48:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Content-Language: en-US
To: Juergen Gross <jgross@suse.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 sstabellini@kernel.org, boris.ostrovsky@oracle.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, xen-devel@lists.xenproject.org,
 michael.h.kelley@microsoft.com
References: <20211205081815.129276-1-ltykernel@gmail.com>
 <20211205081815.129276-4-ltykernel@gmail.com>
 <a5943893-510a-3fc8-cbb7-8742369bf36b@suse.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <a5943893-510a-3fc8-cbb7-8742369bf36b@suse.com>
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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



On 12/5/2021 4:34 PM, Juergen Gross wrote:
> On 05.12.21 09:18, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> hyperv Isolation VM requires bounce buffer support to copy
>> data from/to encrypted memory and so enable swiotlb force
>> mode to use swiotlb bounce buffer for DMA transaction.
>>
>> In Isolation VM with AMD SEV, the bounce buffer needs to be
>> accessed via extra address space which is above shared_gpa_boundary
>> (E.G 39 bit address line) reported by Hyper-V CPUID ISOLATION_CONFIG.
>> The access physical address will be original physical address +
>> shared_gpa_boundary. The shared_gpa_boundary in the AMD SEV SNP
>> spec is called virtual top of memory(vTOM). Memory addresses below
>> vTOM are automatically treated as private while memory above
>> vTOM is treated as shared.
>>
>> Hyper-V initalizes swiotlb bounce buffer and default swiotlb
>> needs to be disabled. pci_swiotlb_detect_override() and
>> pci_swiotlb_detect_4gb() enable the default one. To override
>> the setting, hyperv_swiotlb_detect() needs to run before
>> these detect functions which depends on the pci_xen_swiotlb_
>> init(). Make pci_xen_swiotlb_init() depends on the hyperv_swiotlb
>> _detect() to keep the order.
> 
> Why? Does Hyper-V plan to support Xen PV guests? If not, I don't see
> the need for adding this change.
> 

This is to keep detect function calling order that Hyper-V detect 
callback needs to call before pci_swiotlb_detect_override() and 
pci_swiotlb_detect_4gb(). This is the same for why
pci_swiotlb_detect_override() needs to depend on the 
pci_xen_swiotlb_detect(). Hyper-V also has such request and so make xen 
detect callback depends on Hyper-V one.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
