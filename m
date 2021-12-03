Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E474DC433F5
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 11:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69B226071C;
	Fri,  3 Dec 2021 11:26:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MV8mRtZKgOys; Fri,  3 Dec 2021 11:26:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F91660730;
	Fri,  3 Dec 2021 11:26:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D786DC001E;
	Fri,  3 Dec 2021 11:26:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A43DCC0012
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 11:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9124F6078A
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 11:26:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y_zxjGDJa6oB for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 11:26:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14C5060730
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 11:26:05 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 gf14-20020a17090ac7ce00b001a7a2a0b5c3so4887526pjb.5
 for <iommu@lists.linux-foundation.org>; Fri, 03 Dec 2021 03:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Df2I2A2zVcIhvBHXD5z9iabD7nB5LthE/+eMaX0CJns=;
 b=LrhVabQro3+RJTAF2UUwo++Q3tHVPc9KkdjTXgZj5009TrrrQoEZbScehBEamrCUSN
 uAuPgOUZCbn39oord0X3XW7U/XIJ2WzNu0xdbBsMDjNH8DRAcaKxm/RnUdXTK7TPH9GB
 /3QVEkipv/oDwHi2iskl2LfbgoDlNjPpNEnAH9c0t4ds6OIO4vgwzDl9tD4vqPr3Jj1i
 soeN//lG51eXYc9/8Noh0CxgiHul5HzjoLY8pcB7lUlMXYr1yF0iF5iR8ZnAimEr0fEF
 u9pUnIeyp3+uCAIcJI0WC45iQsDzZ7vfXZh4Mm9tVdhmXvGp7nCrb22wqTAz0TVn9HBO
 JiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Df2I2A2zVcIhvBHXD5z9iabD7nB5LthE/+eMaX0CJns=;
 b=EwncO5m6nFHvboHIXn1XrCA141XaoqoNmh7yt66jiv8chKM43A8NaAninj99eqhqzg
 UxgB+MBVYuuSS2NSWsi8ITbsMS8eNE5dJGW6WCh7TpKDvK4A25RtXzzj4tXOA317KXy2
 S9K/P65BdimdPh6qeEqHmdJSiZGF0zlwCrq7JSckgdY0/1Q73g8rIqxYXASHeI/qNqnt
 kijJ/cSa+qf2gjeZvveYbx/eejH8eAXqcX/mAqu2nXqKOLsbsfHo321Pv30lrVEsNRiF
 2if8AikWI6ketgyapkKDtbtgZmoLlt/xKaB5uGL+yrQusR3128xqUS+n8HSD0lcXkdvp
 8fcw==
X-Gm-Message-State: AOAM530VgeCIMxK8aioZFH6QUD2+NcuwyO32N6noFkGdivS4PkELKbX5
 zOUfaWSZFPso+bfxm0FHfwY=
X-Google-Smtp-Source: ABdhPJzPvoKIz31xLOmSdpnjjIrMa2J9GjBdJxPwkC+KmRLj7Ds+PG6GrIFi6sWFBo0epAEx6rdfGQ==
X-Received: by 2002:a17:90b:190f:: with SMTP id
 mp15mr13348018pjb.210.1638530764387; 
 Fri, 03 Dec 2021 03:26:04 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 mp12sm5062949pjb.39.2021.12.03.03.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 03:26:04 -0800 (PST)
Message-ID: <4006e942-b6bf-ac21-c56b-4719e514dbd2@gmail.com>
Date: Fri, 3 Dec 2021 19:25:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>
References: <20211201160257.1003912-1-ltykernel@gmail.com>
 <20211201160257.1003912-4-ltykernel@gmail.com>
 <20211202144336.z2sfs6kw5kdsfqgv@liuwe-devbox-debian-v2>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20211202144336.z2sfs6kw5kdsfqgv@liuwe-devbox-debian-v2>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, michael.h.kelley@microsoft.com,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, hch@lst.de, hch@infradead.org,
 mingo@redhat.com, kuba@kernel.org, haiyangz@microsoft.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 arnd@arndb.de, konrad.wilk@oracle.com, jejb@linux.ibm.com, bp@alien8.de,
 xen-devel@lists.xenproject.org, tglx@linutronix.de, jgross@suse.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On 12/2/2021 10:43 PM, Wei Liu wrote:
> On Wed, Dec 01, 2021 at 11:02:54AM -0500, Tianyu Lan wrote:
> [...]
>> diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
>> index 46df59aeaa06..30fd0600b008 100644
>> --- a/arch/x86/xen/pci-swiotlb-xen.c
>> +++ b/arch/x86/xen/pci-swiotlb-xen.c
>> @@ -4,6 +4,7 @@
>>   
>>   #include <linux/dma-map-ops.h>
>>   #include <linux/pci.h>
>> +#include <linux/hyperv.h>
>>   #include <xen/swiotlb-xen.h>
>>   
>>   #include <asm/xen/hypervisor.h>
>> @@ -91,6 +92,6 @@ int pci_xen_swiotlb_init_late(void)
>>   EXPORT_SYMBOL_GPL(pci_xen_swiotlb_init_late);
>>   
>>   IOMMU_INIT_FINISH(pci_xen_swiotlb_detect,
>> -		  NULL,
>> +		  hyperv_swiotlb_detect,
> 
> It is not immediately obvious why this is needed just by reading the
> code. Please consider copying some of the text in the commit message to
> a comment here.
> 

Thanks for suggestion. Will update.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
