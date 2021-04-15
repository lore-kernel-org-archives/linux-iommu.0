Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E4C43461
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 12:54:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5E5611AC
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 12:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5E5611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1BFA40129;
	Thu, 15 Apr 2021 12:54:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XKl_M7BCHKYq; Thu, 15 Apr 2021 12:54:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD2084016C;
	Thu, 15 Apr 2021 12:54:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADD7FC000C;
	Thu, 15 Apr 2021 12:54:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 842E6C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 12:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C25A84115
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 12:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e2ruGRcOBode for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 12:54:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA33B8404C
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 12:54:14 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 ot17-20020a17090b3b51b0290109c9ac3c34so14350878pjb.4
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nFBhJEMWSCHQ9ckRhICUqHp2tzOkLKl41yxYxmXNW8k=;
 b=hoY2qyhaWOmcHAUhxLhqdl2UUYQFP2mZvbngLFNzsYmVwketTssI/OEzMrR5vrSYcz
 bB1MpB5zVdkmSDk927+vAXQSP+0TkGL2CkD2Iz/SuAgoYQ8jb4Jx3FeGHZm0dL/1pLUR
 IacekCQbE4Ohc/0K1F8WUD5gcpaslZovW66owGnAmKU7W13oJtUNjHOJHB3Em8jD3BAD
 E7+lJL7tX79QdZ6BdhmHx9s05DEbvXfVc8/ZCXEYV43UxyAMj6uJu7EDF1XP1ExWTc2G
 vhQ5Nl/ZMybAB50qIqEc8UzgfsZAwuUYFBxAA0SRZr1gsyX7QYfAT1dj+b000dxnu9ot
 aGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nFBhJEMWSCHQ9ckRhICUqHp2tzOkLKl41yxYxmXNW8k=;
 b=kQkWrQPSJY29aYVsFUorDf6eMRMs7STZlHe4YjhTVKA+A1Z3fDzAzWB7X2U94ynVog
 sXljjA2Je90cZb0/nR28+gtfVgeRzgsF+70XQUWG54Di7Qg4boqN0Zs6LbVyd8iU903V
 XBS3ZigOaNViaxyPbsyMj5pAREPLqUarm4E3+29CI0Te3CC9QMSUPZ6LZCvnz7PY0EBU
 YS7Yay5TACsj6b7vFPEq6puBh/AgpQOJsDcq6M9szXP76Uu9hk3xTLNYm7M5j+50+2/3
 Zq0Vj9aFmZ8e0lo2NvFb4oHpysekq6LI0QN6s+zN7ZUoF8JSufVnElW0COXjxqUZGGAi
 T91A==
X-Gm-Message-State: AOAM531jJ+zU3pPdO4FNdYI0KHhuyImoqWhWfoq1G62DvpxG208bdVI3
 xZMn2JFfpMk8fIYu+dpWMUQ=
X-Google-Smtp-Source: ABdhPJwMxGoxf76RvLc0tJT4UxlfrSX+Msz1jyTk5WaW6qqtbrg+lXaAsPVl/Z3ij+VVeCxsB22jnQ==
X-Received: by 2002:a17:90a:2c4b:: with SMTP id
 p11mr3951409pjm.75.1618491254408; 
 Thu, 15 Apr 2021 05:54:14 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
 by smtp.gmail.com with ESMTPSA id h68sm2136897pfe.111.2021.04.15.05.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Apr 2021 05:54:13 -0700 (PDT)
Subject: Re: [Resend RFC PATCH V2 08/12] UIO/Hyper-V: Not load UIO HV driver
 in the isolation VM.
To: Stephen Hemminger <stephen@networkplumber.org>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
 <20210414144945.3460554-9-ltykernel@gmail.com> <YHcOL+HlEoh5jPb8@kroah.com>
 <20210414091738.3df4bed5@hermes.local>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <ce231753-2946-6b07-4b52-9ca07e9120ee@gmail.com>
Date: Thu, 15 Apr 2021 20:54:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414091738.3df4bed5@hermes.local>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, linux-mm@kvack.org,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, hch@lst.de,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, mingo@redhat.com, kuba@kernel.org,
 jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de, vkuznets@redhat.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org, sunilmut@microsoft.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net
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

Hi Stephen:
	Thanks for your review.


On 4/15/2021 12:17 AM, Stephen Hemminger wrote:
> On Wed, 14 Apr 2021 17:45:51 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>> On Wed, Apr 14, 2021 at 10:49:41AM -0400, Tianyu Lan wrote:
>>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>>
>>> UIO HV driver should not load in the isolation VM for security reason.
>>> Return ENOTSUPP in the hv_uio_probe() in the isolation VM.
>>>
>>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> This is debatable, in isolation VM's shouldn't userspace take responsibility
> to validate host communication. If that is an issue please participate with
> the DPDK community (main user of this) to make sure netvsc userspace driver
> has the required checks.
> 

Agree. Will report back to secure team and apply request to add change 
in userspace netvsc driver. Thanks for advise.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
