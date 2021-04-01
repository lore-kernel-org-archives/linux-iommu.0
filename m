Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4492C433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 19:11:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792AC610C7
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 19:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792AC610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2677F4184E;
	Thu,  1 Apr 2021 19:11:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m4ok_pkvTbLt; Thu,  1 Apr 2021 19:11:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0101D40F94;
	Thu,  1 Apr 2021 19:11:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF708C000B;
	Thu,  1 Apr 2021 19:11:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A04AC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 19:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 188F940582
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 19:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FsNNkJSXR9Y4 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 19:11:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4414E4019B
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 19:11:36 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id f3so2212077pgv.0
 for <iommu@lists.linux-foundation.org>; Thu, 01 Apr 2021 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pOfInNzyAI5n5uuvyOU/R9wIOSoVssHANnSsxc40Tv0=;
 b=P4q0WGAaYPNzIS1QN5UUmz8y/nBzzUzx1osrwmAklYJAbmdWBPDi7NcJTPCw2pUfPb
 2LRLLWlFqBn8po5H6Bw2S6DhGIEjJFNL2ke755YcLkowpFnZCKOOCy2QwfQoHULoYbP9
 dmeXAJ6ttyVVMxGkeJPHmB7tnbDUEpziN7qfm+cQtV9eyPzJEzaiIH/WIyDFQ6y9JReX
 XbF6WEfDr5zzG3VmUVDxN24bnoqgupZqZqjJSDA2vEkTr52z+DIJzRgMndDU7YKNvlSg
 P9Jy4D9wApxjIB7EWfjBGTJD6w4cN+bX+GLsbeaIkjD7x9/IBurzXZ3UpDRr6MNThLKr
 GRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pOfInNzyAI5n5uuvyOU/R9wIOSoVssHANnSsxc40Tv0=;
 b=h4IPH3vQI66TsqbYUBHlPUc4VN0vPTodJro234u/QkmO0UfshBDt0H9UGgFJgGy3Df
 kc3z78W4pmg9bV0ZjSZh1ZrBnqUYoU7P0Ulmq2zjzosP1hDYQpB4FRO/7euVFZ/LIYDz
 u+GqxkSoXyAchdX3XPDUSS2cDT+HgBsXZ/VcROHDHWOztJjBZBLerpzyvPWym4w6oxaB
 L+TPhG+G6sjKrHZTBLR708dI82BCELDFsd2zw9pBmqJVNSleK+Hi2ih8A2p9YKJhKexq
 ibizZfJ+514NbyHFtZ8Dq8PhXu9mBSjy10LBqmXNL3u1pb8ZJCjtZZ7z6kBckk4j4eRZ
 KW6w==
X-Gm-Message-State: AOAM531LF4X58RVe9eK3iCZEFUtkR0L6FHf2vxikwbdXHi3guterOmfm
 vBe5muqScZybrrrPblMYLgU=
X-Google-Smtp-Source: ABdhPJx7UXDGtNgZqUZmzxM7QbPC+DD3Vbo36Tj6FNh5bPPsgp8IZ+Dmg8WbKqJ9Fmyyqo4cgsNKmA==
X-Received: by 2002:a63:dd14:: with SMTP id t20mr8795237pgg.258.1617304295360; 
 Thu, 01 Apr 2021 12:11:35 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
 by smtp.googlemail.com with ESMTPSA id a8sm6151272pfk.138.2021.04.01.12.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Apr 2021 12:11:34 -0700 (PDT)
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20210319040333.183827-1-f.fainelli@gmail.com>
 <20210319130731.GB2624@lst.de>
 <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
 <alpine.DEB.2.21.2103191718210.439@sstabellini-ThinkPad-T480s>
 <3db926f4-6047-cc62-8654-a965b8570e75@gmail.com>
 <20210330053607.GA4863@lst.de> <YGYD40RbKN9r8I8n@Konrads-MacBook-Pro.local>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c3811249-8e34-499f-e3f3-ed84319bcffa@gmail.com>
Date: Thu, 1 Apr 2021 12:11:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGYD40RbKN9r8I8n@Konrads-MacBook-Pro.local>
Content-Language: en-US
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 xen-devel@lists.xensource.com, Mike Rapoport <rppt@kernel.org>,
 opendmb@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/1/21 10:33 AM, Konrad Rzeszutek Wilk wrote:
> On Tue, Mar 30, 2021 at 07:36:07AM +0200, Christoph Hellwig wrote:
>> On Mon, Mar 29, 2021 at 12:30:42PM -0700, Florian Fainelli wrote:
>>> Should I toss this in Russell's patch tracker or do you need me to make
>>> some changes to the patch?
>>
>> Due to all the other changes in this area I don't think anything but
>> the swiotlb tree makes much sense here.
> 
> I've put them all on 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
> devel/for-linus-5.13

Thanks! Did you also want to queue up this one:

https://lore.kernel.org/lkml/20210323015350.399493-1-f.fainelli@gmail.com/
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
