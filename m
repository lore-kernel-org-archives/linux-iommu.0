Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C83C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 08:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 971E7414C8;
	Wed, 29 Jun 2022 08:24:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 971E7414C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=B2cz9Oqf;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=f4KMrv0T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yE8x_ec9NQF9; Wed, 29 Jun 2022 08:24:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 055E8414C1;
	Wed, 29 Jun 2022 08:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 055E8414C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC736C0032;
	Wed, 29 Jun 2022 08:24:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFDF7C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 08:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AAB7783F53
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 08:24:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAB7783F53
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com
 header.a=rsa-sha256 header.s=dkim.wdc.com header.b=B2cz9Oqf; 
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim
 header.b=f4KMrv0T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v7LjzXfAdFUp for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:24:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDD7E83F48
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDD7E83F48
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 08:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1656491086; x=1688027086;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AjhPOFbRCAVVpWITsrOe0anHqorsbYYstfbAHDzMisE=;
 b=B2cz9Oqfo1kjC/whxgl0Qv+1GaFoTmg095SijfJP9GU6qjsVageA5rw6
 U4mbusvloq43VumMMX/IScT9GYSBB64JilGCqzNz103T/ZysQfc+0L7z0
 e+AZ8ruc2FZFaNAAc28IeFGEfunwm6exguE0C74YBvhwhZivVAaRVyhL6
 hr3WYH+czGD+CQqrOdnRBqsFqXQUB0HaV+EZHnxClw2zAlaOYRBsD7Ouo
 33jZq80iFmwEkcRRBIv40Aonsb8VrRFJtVoWbmuXLDFaYjkC3Dg9bp9ps
 am/xXV4B5lv2jByouy3KPJ3SyNFZYOe+d2FXRtgBpThU7a/F0ea7uAJ3Q Q==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; d="scan'208";a="203040950"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 16:24:45 +0800
IronPort-SDR: 2FeBTJCFdi+aLIx85mE/iYe+AdxKnWGpt3XiS2gJjMPqWVLGGw0zflDVObHNUCR7sMLXxSdDEf
 zxHm/29GrHY0LOBN7k+pwqNmmI1SXaWKRLD0wEQQzkyBX2N7z+0EJiL20HGXzAtXYt2+6V0boe
 eoc4CpBef20G+z4H0bpdv7SR5royPRsu0W2Iz57NQfdqHixuxec5eCLZ+IXuhpoGZOaRb5lrQY
 KgiLnW5ZoJJbvwjophzi5K005aSLRNoZl+AVSfigG6jGzjjVzM4vnhcyBd5TFtAW+IQaDc3JH4
 DRyzSoTxyVeqMCR2yLu7b4SJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 29 Jun 2022 00:42:25 -0700
IronPort-SDR: JUf804PkA8j/CeOOjEv5Cn/IKmVXwgBk4TBqEGDKNa/R+2E0yGUuRIT+j40bW/FU587Z8Sql8I
 JBGaAF0i31ik2tWqhclOZ3+C4e17DcVzKYOrspLwTP4+U4Tt6RIOlfcOy2xbSmjFVOf9g5oP2t
 svkQ+KtjBzAa0xUQg5JFfHj3OBmy24XFYqMsAYItPQFhICaOfaNa6HD/ZQiLXa02H91bPAJGmP
 RRqEzfwOqjBeKgSz0a5s3zEj+lehppW8MoiY1aXBXx8BSNrE/V5r7wyGK2aijqPWDNARqsV9js
 3cI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 29 Jun 2022 01:24:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXvdn1g60z1Rw4L
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 01:24:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1656491084; x=1659083085; bh=AjhPOFbRCAVVpWITsrOe0anHqorsbYYstfb
 AHDzMisE=; b=f4KMrv0T558Vn290lglMeOnpRgM/tnLvwyasnRINiD6TD/Cc1Hc
 2yomsmv8LfVntiQ7GXFwUkCfRKRAY7qvGQbkr9P1QpY/SYkkhIoX2LD0FC1C2S7j
 5si/YK0AAM1giKgqSsMmuK7/eOFgxGgmu2nZwiCk1O/ge2rzdrkXU52ICY3spbY6
 al3z0VVWsrrfQhOpr1vl5fJenrtuK4YXLxrGgFIA4KlKFbVZ9jukOl66Ax7MYsR5
 h90n0fF4NTKu5YdmMllJMqVq5Okh07VYSGcgxkqxLsX07uF0iihUuG4Eot0/wlLO
 x+B//BwgzWidtwSG/6bzg0Q9vSt9imHiHdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id vXkiFLe6HpWZ for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 01:24:44 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXvdk2Vfxz1RtVk;
 Wed, 29 Jun 2022 01:24:42 -0700 (PDT)
Message-ID: <bf9d1cc7-c03d-f5a8-bb96-cfcd352ac36e@opensource.wdc.com>
Date: Wed, 29 Jun 2022 17:24:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
 <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
 <38ae1cc8-1411-bb54-e082-0f7b91cb9e63@huawei.com>
 <20220629054027.GB16297@lst.de>
 <da7027d9-bd81-cfb0-f70e-2405f40023fa@opensource.wdc.com>
 <65e05dd1-8e92-5f6b-d68e-72987fcebf59@huawei.com>
Organization: Western Digital Research
In-Reply-To: <65e05dd1-8e92-5f6b-d68e-72987fcebf59@huawei.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-doc@vger.kernel.org, robin.murphy@arm.com, linuxarm@huawei.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org, jejb@linux.ibm.com
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

On 6/29/22 16:43, John Garry wrote:
> On 29/06/2022 06:58, Damien Le Moal wrote:
>> On 6/29/22 14:40, Christoph Hellwig wrote:
>>> On Tue, Jun 28, 2022 at 12:33:58PM +0100, John Garry wrote:
>>>> Well Christoph originally offered to take this series via the dma-mapping
>>>> tree.
>>>>
>>>> @Christoph, is that still ok with you? If so, would you rather I send this
>>>> libata patch separately?
>>>
>>> The offer still stands, and I don't really care where the libata
>>> patch is routed.  Just tell me what you prefer.
> 
> Cheers.
> 
>>
>> If it is 100% independent from the other patches, I can take it.
>> Otherwise, feel free to take it !
>>
> 
> I'll just keep the all together - it's easier in case I need to change 
> anything.

Works for me.

> 
> Thanks!


-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
