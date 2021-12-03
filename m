Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D94C433FE
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 11:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F5A1402A8;
	Fri,  3 Dec 2021 11:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hrPGm87LOznh; Fri,  3 Dec 2021 11:23:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 634E14027C;
	Fri,  3 Dec 2021 11:23:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97FA8C001E;
	Fri,  3 Dec 2021 11:23:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65689C0012
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 11:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FCD880CE1
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 11:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U8G0eh1Rz8qI for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 11:23:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C26B980CE0
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 11:23:47 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id 8so2612519pfo.4
 for <iommu@lists.linux-foundation.org>; Fri, 03 Dec 2021 03:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=5qOEsIBGR+o+C/Sd/hZPIupqUBKJep0nylH6kuX0Ydw=;
 b=q0Pme1zsdQbsn/2lt0smQ5WZz4BXmeUPnOOQ1muby1YCdz5IT1U09UP1jUBBmxEyPL
 NOru1PSpvapDsmivD7kZ9TeY4nIh4h/PD8j+3/Qjz2xIc5mwaH978BhiApU+G+OBiI7v
 q/qNUWoMUpEW19dcyNf3m0rrPCJ/jIoQ8FNY77sy6LiOJroeLUPHkq2iJ8x4EVpI8qAR
 W8mXj1YcXAKXWrwiItNpeq0F/HQ8gvHL9KZdDyXlYDHHoBYGqS65rRws5i+e6DI7+Z4H
 wLyunjYStAzQIYUzq5SzqUYg0FmBREr2lO1ssgnjS7fDp96JlKgzobkXt7gXkITr/9HS
 GSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5qOEsIBGR+o+C/Sd/hZPIupqUBKJep0nylH6kuX0Ydw=;
 b=jVgumV6riqJYZrniA5dnsW2uAmQsyUlvzyGoqhTk/Ezkozq5EX1K6ndgKpyMfn/2fk
 9GnylD8mn0noJUmw653PMeGe1wbCscUNsn7qJyliL27YoAK9yAGAP5EFeIWLgStV1wXv
 VLNgymg+ZuHhs69Wly2UMSEGU3EvPd7KF+keFeBSwp8CSWwbcyterHdDn/8L71aXSBIs
 pYtckarrz8/sBXlIYalUr2yrT6MwPtvnbejnyvaZulPETT35kDTM41PEPR0Yc3DKx4eb
 SsNjUrPusDrbMqn6h14mT+1hYO1Q2x7Eaaa6kQV/vztr1P0Q36ddos++OWkcjoazpJHy
 DQqQ==
X-Gm-Message-State: AOAM530cRwNkGrmPycif+fK54KimuCGrY5dn11aoXVSc8tm0LdV+qLUg
 3XtL1bANJIiQ3mjNJw1CwTo=
X-Google-Smtp-Source: ABdhPJxsVhY/s/+3W38Gewn81IUYDNoXcMk2IwynUbTteHgWiue1YzqLNGeWHF+qlwyyWcrcPKXfoQ==
X-Received: by 2002:a63:2fc5:: with SMTP id v188mr4006669pgv.190.1638530626460; 
 Fri, 03 Dec 2021 03:23:46 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 s19sm3163132pfu.104.2021.12.03.03.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 03:23:46 -0800 (PST)
Message-ID: <03718701-d27b-7da9-2849-46af3efaaa98@gmail.com>
Date: Fri, 3 Dec 2021 19:23:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>
References: <20211201160257.1003912-1-ltykernel@gmail.com>
 <20211201160257.1003912-3-ltykernel@gmail.com>
 <20211202143946.7o7ncwcjq3t6xcrq@liuwe-devbox-debian-v2>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20211202143946.7o7ncwcjq3t6xcrq@liuwe-devbox-debian-v2>
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

On 12/2/2021 10:39 PM, Wei Liu wrote:
>> +static bool hyperv_cc_platform_has(enum cc_attr attr)
>> +{
>> +#ifdef CONFIG_HYPERV
>> +	if (attr == CC_ATTR_GUEST_MEM_ENCRYPT)
>> +		return true;
>> +	else
>> +		return false;
> This can be simplified as
> 
> 	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
> 
> 
> Wei.

Hi Wei:	
	Thanks for your review. Will update.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
