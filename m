Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D316C43217
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 14:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E0D182A26;
	Mon,  6 Dec 2021 14:14:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RjtH8TYyVHT2; Mon,  6 Dec 2021 14:14:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 12FBC81A9C;
	Mon,  6 Dec 2021 14:14:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD084C002F;
	Mon,  6 Dec 2021 14:14:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6523FC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 542C7607AA
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:14:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4QLHOTKqigkg for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 14:14:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7F7E6079A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:14:09 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id g19so10267625pfb.8
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=LG+zF8eXNnqFsGFKA2ZTnXSPUueJWK5YxbpbucSufXI=;
 b=mQqUkA3xIsQY4XmQYBzGNmYRws6Q0JrMJpuTq/VEAZ58elCNocHbrP8QMV+4phw9Ut
 vWKeJdfRRl2H6A3/U0ZfFrg46WCHuxCz5sAlIyGUXSN9dXWnqcoQP+R/jmprw5bfpFHj
 fKOmzAhbS2g+OM1Z5BI3nXKStQ11a7SSrQ5tFd6125uR6KPjsGJebIfx224pdX+EvGle
 FqorCYj7anmbSaX4e41EWyvuvtjfgov84k+oRDD0xrawuDr2dYvzxxLjG9dUVswmsHTE
 elai+rbP43KznXg+HMIMYpPzORZYpPi24LOHZHh8JFVSoiDVYRN7mdHXVcauIlegBAj5
 mHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=LG+zF8eXNnqFsGFKA2ZTnXSPUueJWK5YxbpbucSufXI=;
 b=XPuqfcII84MTfAC/IdcZ8cPqScnR98LUa5ckk2lCTCSQkvGMbDHTNV2ATBzpS4icn9
 Idh+PgNQsDeQZCjm6ONDKL/YyQ37wVMhb+9+jZWZyQZpPM7Q+hz/zqiagIw7xXdeRveX
 BO1VamhqS3TiRNbfN1ZX9rcB/04dnfHbqDyy6UKQ8DyJhzOktOnzJkxbZTK2v4byxN8o
 H0AOwYZkqWlRLwlDYp76aG/bxXs4IIllJfu35pBfsr9lx5mi/iiSJsjKEA2JwVbH3RNO
 aiSTlGUC8MphoPqYP+8CDflve5IHqms7qQIezhDZHPe3wgsUu1BTSD9ySRGJbJ0eA4bl
 LyyQ==
X-Gm-Message-State: AOAM530PcWcYO693426K8u1kXSh5ppYTpfQwrVTFITJRRNlu2KWbnf2o
 8mDLjkuXxQXixjBHMS/6wFs=
X-Google-Smtp-Source: ABdhPJySAj+QT4OHzaoYLk1cSWHqCc54qgRjOngjnxP5g2RiZmDR4g0TxiHn1EhVWrwC669mfsgWOQ==
X-Received: by 2002:a62:7e4c:0:b0:4a2:678e:8793 with SMTP id
 z73-20020a627e4c000000b004a2678e8793mr36890086pfc.75.1638800049309; 
 Mon, 06 Dec 2021 06:14:09 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 pi17sm14658528pjb.34.2021.12.06.06.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Dec 2021 06:14:08 -0800 (PST)
Message-ID: <4d9049eb-d3a8-3872-c4c3-4ad41d93b58c@gmail.com>
Date: Mon, 6 Dec 2021 22:13:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20211205081815.129276-1-ltykernel@gmail.com>
 <20211205081815.129276-3-ltykernel@gmail.com> <20211206140651.GA5100@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20211206140651.GA5100@lst.de>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, hch@infradead.org, mingo@redhat.com,
 kuba@kernel.org, haiyangz@microsoft.com, parri.andrea@gmail.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, jejb@linux.ibm.com, bp@alien8.de,
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

Hi Christoph:
	Thanks for your review.

On 12/6/2021 10:06 PM, Christoph Hellwig wrote:
> On Sun, Dec 05, 2021 at 03:18:10AM -0500, Tianyu Lan wrote:
>> +static bool hyperv_cc_platform_has(enum cc_attr attr)
>> +{
>> +#ifdef CONFIG_HYPERV
>> +	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
>> +#else
>> +	return false;
>> +#endif
>> +}
> 
> Can we even end up here without CONFIG_HYPERV?
> 

Yes, I will update in the next version.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
