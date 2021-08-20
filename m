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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86182C432BE
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 13:11:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F7360F91
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 13:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39F7360F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F24614011A;
	Fri, 20 Aug 2021 13:11:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UvwfMDv3OgjD; Fri, 20 Aug 2021 13:11:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E38B40107;
	Fri, 20 Aug 2021 13:11:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67036C0010;
	Fri, 20 Aug 2021 13:11:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B79F2C000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 13:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93517606EE
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 13:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UHCLUNA9o-mq for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 13:11:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C24C3606CF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 13:11:31 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id a21so8553653pfh.5
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DumM/jSCQ5pQ9eZgFpU+0KewnSiWRI7kODNq3MVNO9E=;
 b=Lxpe8djYypSrG+rDhdI8Zj8XoAi8qqQia8zhwT4UV3xhiowgSs10jy3AgDNzKEDEyF
 2GuLbi9GVVFcjh9UlMDL9KUW8QrzZktPvIUcY7JQUGRvDt+fa7vHuxhyvZAdvey3t4ob
 hD12I6HXHDrZkRjMhWqSXBvFA8t0l/nORUqxhobI5jL9kGkFeKuaLFh4hExMg94Nn/+Y
 ZX0iJa6zVUQl4P3W+vN6fOmLG2tonMXiCheuMNI43YhxqI96dxD+FKqPHJQaTLtG54GP
 oe6y5RcUvG1ZNewnn9OX4H8s3Nmh0Ni6Kg3bG+ljwBTTlaL4sNTRBPgI879siMp4TQte
 F+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DumM/jSCQ5pQ9eZgFpU+0KewnSiWRI7kODNq3MVNO9E=;
 b=jhJpJmffkccsw/o6KLqpfBsm6ijglitzj6hIlxur3xLqteLopU0jHEUGBPrhJ2nPib
 0D5JGyYHan3R6U89DgCKqQIWTjvOloY4hSrRf3B60rt2BRUF8mI3CpCh+4mIzoJb+1O8
 MLbxYC8epeByRzAFacY9DsyGLuVYVsTQEuOJ4DS203MIlfyd7RL35XCPebKD+5qUfOT8
 fR6Dkew3ann6qrFN7w/1R/oNYYz2a+UtHXtM+SYoVMjQE09Z6o9Ecdorsbn9zh5ViGR1
 iGQuBIms2ymkl3utGFG+BnSxLtTgMg0VCNfbD7q4kpd0jeG8U4R7aXzRNimgNnOJUSBK
 dqiA==
X-Gm-Message-State: AOAM530ei7Q9LFOWARXWHJHROY2MofdOjfh/2E7weh8Ow3nhc6vwFwui
 04szOlF+qnrogHbvIHxtjOc=
X-Google-Smtp-Source: ABdhPJxylFQdwesAZv+5jXWctSOyZLpktCQebAX+HYEeyV7Dv3stIO/u8x8uQwcYBOXvuYmq81vLhg==
X-Received: by 2002:aa7:95a6:0:b0:3e0:efe2:83ee with SMTP id
 a6-20020aa795a6000000b003e0efe283eemr19334679pfk.36.1629465090875; 
 Fri, 20 Aug 2021 06:11:30 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 z2sm8304603pgb.33.2021.08.20.06.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 06:11:30 -0700 (PDT)
Subject: Re: [PATCH V3 12/13] HV/Netvsc: Add Isolation VM support for netvsc
 driver
To: "hch@lst.de" <hch@lst.de>, Michael Kelley <mikelley@microsoft.com>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-13-ltykernel@gmail.com>
 <MWHPR21MB15936FE72E65A62FBA3EF4F2D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210820042151.GB26450@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <9e4d5de1-37b3-550d-9bca-4eb158e45b33@gmail.com>
Date: Fri, 20 Aug 2021 21:11:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820042151.GB26450@lst.de>
Content-Language: en-US
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "will@kernel.org" <will@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "x86@kernel.org" <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "ardb@kernel.org" <ardb@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, vkuznets <vkuznets@redhat.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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



On 8/20/2021 12:21 PM, hch@lst.de wrote:
> On Thu, Aug 19, 2021 at 06:14:51PM +0000, Michael Kelley wrote:
>>> +	if (!pfns)
>>> +		return NULL;
>>> +
>>> +	for (i = 0; i < size / HV_HYP_PAGE_SIZE; i++)
>>> +		pfns[i] = virt_to_hvpfn(buf + i * HV_HYP_PAGE_SIZE)
>>> +			+ (ms_hyperv.shared_gpa_boundary >> HV_HYP_PAGE_SHIFT);
>>> +
>>> +	vaddr = vmap_pfn(pfns, size / HV_HYP_PAGE_SIZE, PAGE_KERNEL_IO);
>>> +	kfree(pfns);
>>> +
>>> +	return vaddr;
>>> +}
>>
>> This function appears to be a duplicate of hv_map_memory() in Patch 11 of this
>> series.  Is it possible to structure things so there is only one implementation?  In
> 
> So right now it it identical, but there is an important difference:
> the swiotlb memory is physically contiguous to start with, so we can
> do the simple remap using vmap_range as suggested in the last mail.
> The cases here are pretty weird in that netvsc_remap_buf is called right
> after vzalloc.  That is we create _two_ mappings in vmalloc space right
> after another, where the original one is just used for establishing the
> "GPADL handle" and freeing the memory.  In other words, the obvious thing
> to do here would be to use a vmalloc variant that allows to take the
> shared_gpa_boundary into account when setting up the PTEs.

The buffer is allocated via vmalloc(). It needs to be marked as host
visible via hyperv hvcall before being accessed via address space above
shared_gpa_boundary. The hvcall is called in the vmbus_establish_gpadl().

> 
> And here is somthing I need help from the x86 experts:  does the CPU
> actually care about this shared_gpa_boundary?  Or does it just matter
> for the generated DMA address?  Does somehow have a good pointer to
> how this mechanism works?
> 

The shared_gpa_boundary is vTOM feature of AMD SEV-SNP. Tom Lendacky
introduced the feature in previous mail. I copy it here and please have
a look.

 From Tom Lendacky:
IIUC, this is using the vTOM feature of SEV-SNP. When this feature is
enabled for a VMPL level, any physical memory addresses below vTOM are
considered private/encrypted and any physical memory addresses above vTOM
are considered shared/unencrypted. With this option, you don't need a
fully enlightened guest that sets and clears page table encryption bits.
You just need the DMA buffers to be allocated in the proper range above 
vTOM.

See the section on "Virtual Machine Privilege Levels" in
https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
