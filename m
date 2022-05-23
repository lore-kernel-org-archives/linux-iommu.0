Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B53C4332F
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 07:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ED8260FDE;
	Mon, 23 May 2022 07:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GqGxs_mKyytz; Mon, 23 May 2022 07:33:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 618396101F;
	Mon, 23 May 2022 07:33:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26AE1C0032;
	Mon, 23 May 2022 07:33:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E469C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07CAD405B4
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=wdc.com header.b="QtTez3PU";
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.b="KZLz5DNG"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-8h0cLk4kGI for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 07:33:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE93F405B2
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653291181; x=1684827181;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OcwGBUpAAJiWZ5v/YJ1Btd+c99uDP5yJACtABgy45zE=;
 b=QtTez3PUT61jWRYi5Nn1szWNaaMCl3dl42GsBNBo089udSOFeKiEyE1Q
 bUAv5V/6UZozxlJnZWTXN3p7ac+rX5r1ECIr/OW/d5SjIukZyg4NUVo8n
 ipan7aRExneez5KEq+dPbG0y+recHQsSBAWiK9VLzqquNRPwFu6S69iBf
 vGLbXskhVAYx5KuGhd7AjxjJ0Ls54EktMBtTi3+zLDiG2m0xY8PMZepyk
 jsim6Xmsj1Z6Avl5xhtZfCpVaYUUtBTMqAgSCeyOPQX0cKzmepVAZuIZw
 QdcrLgTPMYxceUw119ngp9tFJkUPvDiQuM6Bg8hVwVdA0il3Q6kfyU3ak Q==;
X-IronPort-AV: E=Sophos;i="5.91,245,1647273600"; d="scan'208";a="305350460"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 15:33:00 +0800
IronPort-SDR: kdboF/86e5KhYnu4Bin2exian2RfDgLMyLfZJmjUwV58O7Z6Yv/1IRzZca6Hhkvg9PTaQqzlaZ
 LdJiduQLU/51FYEH83/VGIbKMptUFv+AY3/FYnnZ4de9INKHN+RBpEwkUKU/RaRMwi3aCcFtEG
 UL4zF7KyoYjvTraq12s/MdfZAJFBOiS9k2lTv5m31t/HvikzjbcVMNTGzDcSlYPaNcxATc+XU7
 Nno25s8i5+ZcOcsSaynugPZ9dC2lmyskjhxMq5JZ06jy4+RhUglRVHAnTdVwmoMbViJqZrA8aJ
 5DJiMcGxRoerj08v6lWc4mNv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2022 23:56:59 -0700
IronPort-SDR: 7bR+8J9i84ZWD5XtNAyBnqWwfreCOCTA2cPQQj900qB+u6RH/0ncAFSpp0a5nxlqpLP6sRNckC
 1T/R/MM+H3F0AMwMZoym1YFndtW2E6pdr5TulrAhqMI9OnVf46Nivtcpp9bn+nuuVRrp95AhXQ
 wKeU2KNVOS5mCBJo0Tva11hYerKJViRCBr+ixv/LFK4TN8jioR8aCoLLf0OjMluUeLJR/CbNb8
 B0kihg8qzJKfiYoDkFX21dsRnMCLMuTn6M71l9N4JwX1DGqFSnsQ/Cy+BCUumG2yLqTMZ9smjo
 yp8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 May 2022 00:33:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L68F76gWKz1SHwl
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 00:32:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653291178; x=1655883179; bh=OcwGBUpAAJiWZ5v/YJ1Btd+c99uDP5yJACt
 ABgy45zE=; b=KZLz5DNGE1EMHNc36tC3TAUZznz7ftzzJaC+XiqPThzU7wLVAYA
 WLfUP8He0YrJ1gLCARo0/rcSA1aAH7gEGyIPMYkb7xghe04wZPIdJhQ8Es8KrLsc
 voIAEVbQJRFEc+Kxs6E1ri4+rWS5+xkrOuLAP3jnkhTo70t8Wbl8uj/UZ/YY+Lgw
 O3NGzPEeIi8+9CqJe58gWphzlDmDbknR9HbRHwAwEsWnKFPHmcJ5tMuefSKLZ6Iq
 +s/9fC+dLrW26sIuZuoBl/X7bU4mDN/82cAyOB5T5dTmSEapTUa4mN1TpD3nXx76
 /vX5OQdlr//R6ve+zl4hlPdx4hHENJ++HSg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id PreCn14Tnycm for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 00:32:58 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com
 [10.89.85.73])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L68F40HYpz1Rvlc;
 Mon, 23 May 2022 00:32:55 -0700 (PDT)
Message-ID: <2b4426a6-88ac-1bce-ea80-52902897cd0f@opensource.wdc.com>
Date: Mon, 23 May 2022 16:32:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-3-git-send-email-john.garry@huawei.com>
 <250a10e6-40ae-e4e8-ae01-4f7144b089f8@opensource.wdc.com>
 <655b915c-e8d2-d65b-676a-a51e788f1695@huawei.com>
Organization: Western Digital Research
In-Reply-To: <655b915c-e8d2-d65b-676a-a51e788f1695@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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
From: Damien Le Moal via iommu <iommu@lists.linux-foundation.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/05/23 16:01, John Garry wrote:
> On 21/05/2022 00:33, Damien Le Moal wrote:
> 
> Hi Damien,
> 
>>> +unsigned long iova_rcache_range(void)
>> Why not a size_t return type ?
> 
> The IOVA code generally uses unsigned long for size/range while 
> dam-iommu uses size_t as appropiate, so I'm just sticking to that.

OK.

> 
>>
>>> +{
>>> +	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
>>> +}
>>> +
> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
