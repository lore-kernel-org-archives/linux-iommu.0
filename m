Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1107AC433DB
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 19:30:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE6E61976
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 19:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE6E61976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63BCC837AC;
	Mon, 29 Mar 2021 19:30:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Sv5p_5tDZyL; Mon, 29 Mar 2021 19:30:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 585BE83578;
	Mon, 29 Mar 2021 19:30:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC45C000B;
	Mon, 29 Mar 2021 19:30:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C68E5C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 19:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A68DE40346
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 19:30:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AEB-pFln8UfZ for <iommu@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 19:30:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4DA840345
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 19:30:48 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id t20so4894923plr.13
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=obZ+GpJjqBDtqxvYFyMbZyPSIXXyagLFH5qtJ8HsExQ=;
 b=HHhQPWAK96gQvI6JJPOnIFVc/FznBCpCUgJanyhV1/94rYU1ByXo2ua2XSsY0qQgmp
 KIaZTSyo5SuA6seJ5a/O7TcMaCc8Ha00PbefwymFFN6Bh4SozydEAVhqPLhRmlGm00ka
 lScMH+FJN19u14o2jaisyvXsm3zBEVeZY+xULE8uu7a5h6oH+HAG77+RU3KPPteH9R6B
 WYiKhCcxB/ecADLL2AoxhTy/NQbZ1fI6E7lpLVdSZ9SlfLS0OYYmiVb21b6R9Bvt3FBZ
 41HDs14NdrUmwSNuMRWHhJisDMdHRjsyzIaX26cb0dW7YCSZj0e5a/nwIBZO9C/Xvcjp
 DOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=obZ+GpJjqBDtqxvYFyMbZyPSIXXyagLFH5qtJ8HsExQ=;
 b=YgKviGbFkWfTeTgLStcKbY2pwD0sWNwLIxIYA4+PhxxZeR5oeBI+y6Ntkev+lu5CNb
 rKkXtcGEhH2C7Op9T/QPN95hpjvyI0TGT4qzrgAlFnC6lLwQuN6gj16LoNm0HWNZ+c83
 U+oa8CgEdmWfqVdLCKklFOdVW+nFVJn2H22nyGdWFtueTGO9TrsOAFxS5KXMRNpNLWM+
 eCxNfIk5y2d80sG3iYQT329JzsHvrzqhFojZ5dro5Iou5k/31D101v0S0A2HKqy5jyDS
 v6Fy7q/AZderE5ojBOcNgsmh3BgX6gX0bvQjyqdPcJ+xM3nEBakvKllt46VntUY/+S1l
 FgKw==
X-Gm-Message-State: AOAM531cqa2uGEveEa/BRVKfsxmVnpt0aTybv+SDEEHLrh1II3iYdUR5
 DlZvuYaXUP/eLKeiUstGbUI=
X-Google-Smtp-Source: ABdhPJxy4vuS0N+tsZKwReXwZHG1+vd1B7r82n2+XtMrMVGst8TxZghuZ5z5ETykyH/7joqAlbYfUA==
X-Received: by 2002:a17:90b:10a:: with SMTP id
 p10mr668776pjz.148.1617046248127; 
 Mon, 29 Mar 2021 12:30:48 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
 by smtp.googlemail.com with ESMTPSA id t19sm18375620pfg.38.2021.03.29.12.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Mar 2021 12:30:47 -0700 (PDT)
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
To: Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20210319040333.183827-1-f.fainelli@gmail.com>
 <20210319130731.GB2624@lst.de>
 <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
 <alpine.DEB.2.21.2103191718210.439@sstabellini-ThinkPad-T480s>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3db926f4-6047-cc62-8654-a965b8570e75@gmail.com>
Date: Mon, 29 Mar 2021 12:30:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2103191718210.439@sstabellini-ThinkPad-T480s>
Content-Language: en-US
Cc: xen-devel@lists.xensource.com, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 opendmb@gmail.com, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

On 3/19/21 5:22 PM, Stefano Stabellini wrote:
> On Fri, 19 Mar 2021, Konrad Rzeszutek Wilk wrote:
>> On Fri, Mar 19, 2021 at 02:07:31PM +0100, Christoph Hellwig wrote:
>>> On Thu, Mar 18, 2021 at 09:03:33PM -0700, Florian Fainelli wrote:
>>>>  #ifdef CONFIG_ARM_LPAE
>>>> +	if (swiotlb_force == SWIOTLB_FORCE ||
>>>> +	    max_pfn > arm_dma_pfn_limit)
>>>
>>> Does arm_dma_pfn_limit do the right thing even with the weirdest
>>> remapping ranges?  Maybe a commen here would be useful.
>>>
>>>> +		swiotlb_init(1);
>>>> +	else
>>>> +		swiotlb_force = SWIOTLB_NO_FORCE;
>>>
>>> Konrad: what do you think of setting swiotlb_force to SWIOTLB_NO_FORCE
>>> and only switching it to SWIOTLB_NORMAL when swiotlb_init* is called?
>>> That kind makes more sense than forcing the callers to do it.
>>>
>>> While we're at it, I think swiotlb_force should probably be renamed to
>>> swiotlb_mode or somethng like that.
>>
>> swiotlb_mode sounds good.
>>
>> Also it got me thinking - ARM on Xen at some point was a bit strange, so not sure how
>> the logic works here, Stefano?
> 
> There is nothing strange in regards to swiotlb_force. swiotlb_force is only used
> in swiotlb-xen map_page to figure out whether:
> 
> - we actually have to use the swiotlb bounce buffer (this is the
>   swiotlb_xen == SWIOTLB_FORCE case)
> - or we can use the provided page directly for dma if other conditions
>   are met (dma_capable, !range_straddles_page_boundary, ...)
> 
> 
> I don't think that switching to "swiotlb_mode" would cause any issues.
> 

Should I toss this in Russell's patch tracker or do you need me to make
some changes to the patch?
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
