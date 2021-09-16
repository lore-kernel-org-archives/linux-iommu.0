Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA4FC433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 10:52:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9529611C4
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 10:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A9529611C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65311613C2;
	Thu, 16 Sep 2021 10:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s-2aFofTlVHX; Thu, 16 Sep 2021 10:52:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6AF92613A4;
	Thu, 16 Sep 2021 10:52:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42548C000F;
	Thu, 16 Sep 2021 10:52:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DB88C000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 10:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 252E4407B1
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 10:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sLNueq-Mf4kQ for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 10:52:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9299340774
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 10:52:27 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id e16so5529846pfc.6
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VNKbu9+xQ5ZpUtGvMTcqpK8Ho+xMSyVZ8+L+t3qGVwI=;
 b=XSZj6K6WXxfevgNkMQWTVWN/pRsGZ48Hpf1aapa7yFejBTCFdA6HUCPwkA38CUvHOb
 12EGRvxxebdCNuoE+ObAyvTNwWyxDdbNnDJYQNBCpkkMDkdT2sOdFGpKg9oYBfCBDwL0
 XflKHpxQXjZ521DE/0ZBRDz1uCKiQSaIrItzbkcc7HCVprwqAzWPmTfhfdTuxhcGIkae
 17ws4naiLQWag9g0raMGIBW/7G/5E7reQPZwNkqgzzUPtdDb0IjYRvViaMPYRdxPUde6
 Bl5njgBd1GAcMu72JAentZ78PNGD3qywdjPZPtQPg3O6M2RygtB2NwLk/e/0AhwfWnul
 yMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VNKbu9+xQ5ZpUtGvMTcqpK8Ho+xMSyVZ8+L+t3qGVwI=;
 b=pf4w5Bb4+i/hqapPSEs47yfVKbU6Ux7hLQVs4bj/KqhzZdDElK62JVRpMi2s6yyt76
 G8GX6qQWpTILE3CEYIE8HRNfI9mg1TScuTACA8p97/aQ96HxWVZ2ccgeW6qHMl1FU+tL
 afCRRlSHsQSWeeDFR816GmfiroX569BMhOnkZzI6ThebRHKEOw9XarxsNq6LAfsIfE4S
 k25RpzY1FweGbrXixZ0mwEJYDvK/C78GCcUze5CO5Wfr8hwZavLhdBngdaJ8VeBDR8MR
 FYRinB9YqU8ekxJgxQUp/Sp8uAympkpLno4GKdwfvSQsoxNBRqW97uwZ76TfxI9lIIU3
 Ziog==
X-Gm-Message-State: AOAM533XkUcWAovtlaFY9wAaRihR9+7u96EHbXVCnnloMxYoZtz66+Jm
 R0VO3AttG0Y1OgMtJV6YIZM=
X-Google-Smtp-Source: ABdhPJyl+TWhw4qIPd+GNTqUwBCT0hUxX1fvNVQYkrBsEjf+FvFMSf2MpaDHDZtEUEbJwfeL0pUlhg==
X-Received: by 2002:a63:4614:: with SMTP id t20mr4441488pga.372.1631789546934; 
 Thu, 16 Sep 2021 03:52:26 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 21sm2624212pfh.103.2021.09.16.03.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Sep 2021 03:52:26 -0700 (PDT)
Subject: Re: [PATCH V5 07/12] Drivers: hv: vmbus: Add SNP support for VMbus
 channel initiate message
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
 <20210914133916.1440931-8-ltykernel@gmail.com>
 <MWHPR21MB1593D9CB27D41B128BF21DC9D7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <15d177f8-5e20-8630-2b2c-8a00a5309a61@gmail.com>
Date: Thu, 16 Sep 2021 18:52:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593D9CB27D41B128BF21DC9D7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
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

On 9/15/2021 11:41 PM, Michael Kelley wrote:
>> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
>> index 42f3d9d123a1..560cba916d1d 100644
>> --- a/drivers/hv/hyperv_vmbus.h
>> +++ b/drivers/hv/hyperv_vmbus.h
>> @@ -240,6 +240,8 @@ struct vmbus_connection {
>>   	 * is child->parent notification
>>   	 */
>>   	struct hv_monitor_page *monitor_pages[2];
>> +	void *monitor_pages_original[2];
>> +	unsigned long monitor_pages_pa[2];
> The type of this field really should be phys_addr_t.  In addition to
> just making semantic sense, then it will match the return type from
> virt_to_phys() and the input arg to memremap() since resource_size_t
> is typedef'ed as phys_addr_t.
> 

OK. Will update in the next version.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
