Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A59C4321E
	for <iommu@archiver.kernel.org>; Sat,  4 Dec 2021 07:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77EAF40265;
	Sat,  4 Dec 2021 07:42:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F9boUr8qEU70; Sat,  4 Dec 2021 07:42:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F414340146;
	Sat,  4 Dec 2021 07:42:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C42F7C006E;
	Sat,  4 Dec 2021 07:42:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22A04C0012
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 07:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F246483449
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 07:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55T6q4ks_n-u for <iommu@lists.linux-foundation.org>;
 Sat,  4 Dec 2021 07:42:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 588E48343E
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 07:42:49 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id iq11so4009633pjb.3
 for <iommu@lists.linux-foundation.org>; Fri, 03 Dec 2021 23:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=k/XW81IzuVveDnfkiaihrgRy1fm8QRuVkAriBYUSktQ=;
 b=aeetCr9E159DG34hEjAeWGhArTHlrTQp+RvPNuwjMb9u/3PFY53wzhtHubgWJQvDgG
 Jozxdg5UENxD6v0AUKHmjx4efncr1d3uH51laaSKr9cPyQcT+BdlVcFvxfS2q7alc9M+
 IQoElcNzWMNvIxf21BBZKf234HszCsVWMj7scSChzf64nuKTXacuscJrUCAKLRq29Wrh
 e5337Xbg+LNRcQZd6EO7eqCabhSTi7bBHidYnjemVzHYg6jyVwVpnU2LRvbC5rtLuJMX
 22ZzHU6J0KwMuux99RJ5m0Zk9mxBVsGjyiM9lko2MTYAamfaDiH1DIbBhIO1ffuEquNb
 e04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=k/XW81IzuVveDnfkiaihrgRy1fm8QRuVkAriBYUSktQ=;
 b=rn2Iha1A7LPAoUwVuEEabqkKJaa+uW+62NT3PkZQwzFrSOGIY19h/43qrJItxEOAiJ
 /350HMK8MXeakK7CZlgK1lvgApsdCiHszj/n/Qy0xdcgYUIBzhXQLbDmzMeiVVi6gPEe
 iwwqhmUF+g9hNN18TCBlnM2JgNHG7V2qwaFmQJQsMuLofratxnNC8y/EQNSJ06IZU1Li
 PlLB4x3DhFV6oYWXUdpxesVZtGLzB2I3VqJFMImQqJ65REiDzb+1e/smJOr1Nht5qd1R
 KPZnD0U3cPl4qf6JccXnLk//LMYbK+TWSah+m5rDtT6gQZA2fF42PziEGvT1j9t+4jVk
 IGLw==
X-Gm-Message-State: AOAM533Nm0JNoxva6eIduSk4sJRSa4Alk2MY7jnkMcF5c7xxQa8vrLjB
 ueGRU4rQcflh71LfFFtXYLk=
X-Google-Smtp-Source: ABdhPJwRWGj4ETvjt39e2arm3ZwL48sLjKr/6To2ton+oBAvgGlhyx9UEyFTCkGwPmBxwIqCiR8C4Q==
X-Received: by 2002:a17:902:714f:b0:142:892d:a46 with SMTP id
 u15-20020a170902714f00b00142892d0a46mr28039873plm.39.1638603768758; 
 Fri, 03 Dec 2021 23:42:48 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 mz7sm7286643pjb.7.2021.12.03.23.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 23:42:48 -0800 (PST)
Message-ID: <448de4ec-b73e-597f-16fe-623123c04d1e@gmail.com>
Date: Sat, 4 Dec 2021 15:42:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 5/5] hv_netvsc: Add Isolation VM support for netvsc
 driver
Content-Language: en-US
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@infradead.org" <hch@infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20211201160257.1003912-1-ltykernel@gmail.com>
 <20211201160257.1003912-6-ltykernel@gmail.com>
 <MWHPR21MB15934DE25012A8565256336ED76A9@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <MWHPR21MB15934DE25012A8565256336ED76A9@MWHPR21MB1593.namprd21.prod.outlook.com>
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

On 12/4/2021 2:59 AM, Michael Kelley (LINUX) wrote:
>> +
>> +/*
>> + * hv_map_memory - map memory to extra space in the AMD SEV-SNP Isolation VM.
>> + */
>> +void *hv_map_memory(void *addr, unsigned long size)
>> +{
>> +	unsigned long *pfns = kcalloc(size / HV_HYP_PAGE_SIZE,
> This should be just PAGE_SIZE, as this code is unrelated to communication
> with Hyper-V.
>

Yes, agree. Will update.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
