Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0481C433DF
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 10:26:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89DA21D7D
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 10:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="LZc1Kh4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89DA21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87F7588E5F;
	Tue, 14 Jul 2020 10:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7FvachsK2Xhu; Tue, 14 Jul 2020 10:26:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 13EF1889BA;
	Tue, 14 Jul 2020 10:26:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE2C6C0888;
	Tue, 14 Jul 2020 10:26:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68E84C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 10:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E88688C73
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 10:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8DWnh8n6KusA for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 10:26:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 12D79889BA
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 10:26:35 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id x9so11798597ljc.5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wU3WsDZ5z/ReR22OZkjfVgyD9A9a3aDs09Gv8NCOr6k=;
 b=LZc1Kh4Tz6klVSWkSiiyfiAsLQCH3B4VewePqWJl5Efzr0SGRVu07nV/7Ah2EE7KQ3
 YHxqRE5Csr+LCs2H7PgFhO4r5fnYNloyJQvqjR9GjNpstK9WjahUj0bVPo5f8gBY9xG0
 sZSD3LJlrHatNM/jiCsnCM2QIUWr8J1dzMgbSQQIldDFDHrenn+OYkWdIC7c+t9jOANv
 IgI3E0cEdErqHQD1i9TJ5a7hcxaDR4Jz94wauTiSzDwPvrsmeR2pwXbLbIsUIFNYIMuI
 08GWBVOWoEFO17ZERdg8RgEOO0y33KAH5do2ahk43H3uQUiRmW/MDeqdpipZhg5CM1hU
 iDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wU3WsDZ5z/ReR22OZkjfVgyD9A9a3aDs09Gv8NCOr6k=;
 b=SYKamzI1CIv80Rk501+EEHbSgPqbC3kew8zPmxmldomSOfSvUxqVVO8tx3J4IQwHVo
 xyOJxYWnlNg+DTYVSjHYIHn8KfDJEmhG+ykJ11KVvVXnWlTHxnsRXrN48TXawrFZuvkp
 5LzjoC/ABEeS2469+1U2K+u1t9ioXUt8W2fPK2ChoJLUjMAj/I6PxSmtXIkHOehcsXn4
 0iV65cvfs8KqNlGqqj/cWlzqcAydi10r6/QrnIUc9V2wWOdDeLNoGtldlc+D5CAtUcfB
 IMVvq7iHLDc5dSFRjuTqIiWRr3Y8kpqLB6RYG6TbHy3cwRMZQ1kj242pvMcJQ0i08Y4G
 AYdQ==
X-Gm-Message-State: AOAM533AdgR0aDFTJPqLJPg39EYeCKT20SK5Tb3RDN46tmjlXASE5V1N
 sv4amIVYxw+6rzJaaZ31jwOR8Q==
X-Google-Smtp-Source: ABdhPJyBLUOuAlvhbf1rlm9S6PlB1T6KmXOMQPNV4ajT8nLWMAwHQA2bi1kdmYD2kprduz0zv2lW9Q==
X-Received: by 2002:a2e:99cf:: with SMTP id l15mr2027708ljj.294.1594722392984; 
 Tue, 14 Jul 2020 03:26:32 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
 by smtp.googlemail.com with ESMTPSA id f19sm4555276lja.84.2020.07.14.03.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 03:26:32 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Add system mmu support for Armada-806
To: Will Deacon <will@kernel.org>
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200714081949.GA4516@willie-the-truck>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <0d9d734a-84cf-2280-67b6-0c96247e1baf@semihalf.com>
Date: Tue, 14 Jul 2020 12:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714081949.GA4516@willie-the-truck>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, gregory.clement@bootlin.com,
 catalin.marinas@arm.com, hannah@marvell.com, linux-kernel@vger.kernel.org,
 nadavh@marvell.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 mw@semihalf.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

Hi Will,

On 14.07.2020 10:19, Will Deacon wrote:
> Hi Tomasz,
> 
> On Thu, Jul 02, 2020 at 10:16:29PM +0200, Tomasz Nowicki wrote:
>> There were already two versions of series to support SMMU for AP806,
>> including workaround for accessing ARM SMMU 64bit registers.
>> First [1] by Hanna Hawa and second [2] by Gregory CLEMENT.
>> Since it got stuck this is yet another try. I incorporated the V2 comments,
>> mainly by moving workaround code to arm-smmu-impl.c as requested.
>>
>> For the record, AP-806 can't access SMMU registers with 64bit width,
>> this patches split the readq/writeq into two 32bit accesses instead
>> and update DT bindings.
>>
>> The series was successfully tested on a vanilla v5.8-rc3 kernel and
>> Intel e1000e PCIe NIC. The same for platform devices like SATA and USB.
>>
>> [1]: https://lkml.org/lkml/2018/10/15/373
>> [2]: https://lkml.org/lkml/2019/7/11/426
> 
> Do you have a v4 of this series? It looks like there were a few comments
> left to address, but with that I can pick it up for 5.9.

Yes, I will send it out today.

Thanks,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
