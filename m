Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95097C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 17:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31DC1813C7;
	Thu, 30 Jun 2022 17:02:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31DC1813C7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=n8LZs4ep
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrvEKi9WlyZi; Thu, 30 Jun 2022 17:02:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F120581383;
	Thu, 30 Jun 2022 17:02:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F120581383
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF325C0021;
	Thu, 30 Jun 2022 17:02:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1C8DC0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 17:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D3668137E
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 17:02:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D3668137E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id idysSJB7Vtzo for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 17:02:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EE5E8135D
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EE5E8135D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 17:02:32 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id e132so3497123pgc.5
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=XWkDP+ftLDbtk7OocZFgBK5F1p4Vc5nVr5Aln5Bk0dQ=;
 b=n8LZs4epo5UQ4J+3zuY7BUPjc4xUXA5d75K4z0momEv9N2Xnjov8J9gGiRdXoZSw+a
 6NtaahIysIS6pe67AF+pd02MuWdfRsIPS87b9idHjXHB4s9qXq1N9s/K9a928WA13DLy
 hSLunucs/qAhoLDf8VwPCY/1b8VXIamidzzdwOHAZQkHwy3CzGsKWcDVOTJGKjtCqGmY
 Z3SxNKybvr9SGYe7fEOMXpjxv1O8TU5KELQOyVx7afeHuSSaVXRLUieqswFuXLZNFca5
 4p9+C8qUzny199h/ejCsCs2gFTFlYnZkbFPRfnWY93w/c8AUKw6qZkz/B4bH3jdfO0gY
 VkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XWkDP+ftLDbtk7OocZFgBK5F1p4Vc5nVr5Aln5Bk0dQ=;
 b=LUhCDQIPspK+SpUX6GoVC9O7EKa2y2y2ybVJOGGUq+Pm+p+s8xk651k4jDu+KfbcU8
 g/2uwjrttYjkW62dj+Q1RfI+1vSudlJaG+xCvkH6GvBGjj5sQqdkYphzifhABEwOceWL
 EnBqZtN2adBNkkh9jOYyzBJSIusefdajidGNs44op+uIZmv9LqSThlZqWyMatbAkW4IE
 c/uyDeIk1/H+q8Tm3NvYN5FQ2CGwR0dzQGJGX9eCDwNgrSk5InC8PqLKFOej1mytOp0K
 dhlkTCc7vU+zEnKCZLY5R3eQlQkpgve2FnH3uBWv0rqm4EgGIaprgg0nsUEAFQGaRY1T
 aiPA==
X-Gm-Message-State: AJIora/Bz2DxvxNPaPkClb6V2jcZ1I07RG9YImBTE1boOxN+DT1P7gu+
 qUDCG5S/+KjVDmkAr0LtmaY=
X-Google-Smtp-Source: AGRyM1unLh5+2f3N8WdaNvFePkaneEkCPbeaBgJSIjnjZNxgOeXkifHqiBLyurLiV39500WbhCEqGA==
X-Received: by 2002:a63:5304:0:b0:3db:2e57:6f34 with SMTP id
 h4-20020a635304000000b003db2e576f34mr8330163pgb.88.1656608551924; 
 Thu, 30 Jun 2022 10:02:31 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a170902a9c100b0016a1e2c2efcsm13681071plr.223.2022.06.30.10.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jun 2022 10:02:31 -0700 (PDT)
Message-ID: <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
Date: Fri, 1 Jul 2022 01:02:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number of
 lapic entry in MADT
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
 <YrxcCZKvFYjxLf9n@infradead.org>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YrxcCZKvFYjxLf9n@infradead.org>
Cc: linux-hyperv@vger.kernel.org, rafael@kernel.org,
 dave.hansen@linux.intel.com, pavel@ucw.cz, hpa@zytor.com, kys@microsoft.com,
 wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>, corbet@lwn.net,
 damien.lemoal@opensource.wdc.com, x86@kernel.org,
 michael.h.kelley@microsoft.com, mingo@redhat.com, andi.kleen@intel.com,
 parri.andrea@gmail.com, len.brown@intel.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, keescook@chromium.org,
 paulmck@kernel.org, linux-pm@vger.kernel.org, kirill.shutemov@intel.com,
 bp@alien8.de, songmuchun@bytedance.com, tglx@linutronix.de,
 vkuznets@redhat.com, rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thomas.lendacky@amd.com, akpm@linux-foundation.org, robin.murphy@arm.com
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

On 6/29/2022 10:04 PM, Christoph Hellwig wrote:
> On Mon, Jun 27, 2022 at 11:31:50AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> When initialize swiotlb bounce buffer, smp_init() has not been
>> called and cpu number can not be got from num_online_cpus().
>> Use the number of lapic entry to set swiotlb area number and
>> keep swiotlb area number equal to cpu number on the x86 platform.
> 
> Can we reorder that initialization?  Because I really hate having
> to have an arch hook in every architecture.

How about using "flags" parameter of swiotlb_init() to pass area number
or add new parameter for area number?

I just reposted patch 1 since there is just some coding style issue and 
area number may also set via swiotlb kernel parameter. We still need 
figure out a good solution to pass area number from architecture code.



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
