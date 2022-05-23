Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F02C433FE
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 07:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C194F405C6;
	Mon, 23 May 2022 07:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OmljUB66PRYk; Mon, 23 May 2022 07:33:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A05E4405B2;
	Mon, 23 May 2022 07:33:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A213C0032;
	Mon, 23 May 2022 07:33:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34B9DC002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 137A783E48
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=wdc.com header.b="aL4u6Jd2";
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.b="fbzRa9DH"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L8oAY2Rs7ACT for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 07:33:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5C8283E3E
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653291195; x=1684827195;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=LJ8/2FSDHURz0Zuhe/Qx3SaImInSLYq6abN68q4sCnc=;
 b=aL4u6Jd2Ijq1Zc4sSmYOdw3jeMsXmkOMdbVvnQf4i5olBXBcxt1HBq/f
 lg+nBQyfY+PzWsXiXSpk8Tu0geSW86v5Mmoc0af5vRVtV8Kwee69OPJ+h
 myAtHUJXfhotgw/UPp8i2FLl6cNCjgxPM/K2hUuRhlLznw5SDxk66OACS
 F6jQULhuBFV5cELBVrmfDvPUrPBUGq+tsafdq4DEVlwpK0pG1W7p9COA/
 /PZlYAzQyW28fXdYh1CtSnzcEKdQbjKEdb6JV0rfFZAWH9VhRoQSwpgxO
 /FD7acJ2sty2RTzMiMXh7TeZX89mRHVPtOC3V+Bt4dlI7thJ5aUqquYWd A==;
X-IronPort-AV: E=Sophos;i="5.91,245,1647273600"; d="scan'208";a="201972797"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 15:33:13 +0800
IronPort-SDR: x0eoRw6DFzgfXJrBQKsrD9XVQR0FeYGHcN5cMTZM6Eqjok/Ie5bx5Ag0bupXnhCowfjMKnmqs3
 IYo339ygsTbX7PHrFp4j7n+2GvSRkPs2VSdr1SFtMj8aXRPGjhVow66V2wEiw6rrKK3VmTqzJy
 y0Vao81dbiTBYoFWsmI5JpUFI6dHM7VH2fROlw99SFWC8etw5tZ5IBp5gUUdSJwJNP5wB44K1+
 X8b02X0WpgMzCJjYSMWJIw0KLeIgYfravYHcwF2gjpRE0nFtAQaCHPnWolU6bYHoR+Amup5JEq
 WBe9GgtR29+bUWRBIKPU19RX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2022 23:57:11 -0700
IronPort-SDR: /tk5/W79pSc48Vw5BO8qsvUG+iq/4/vEEWiO7BjjD2Zyyrp/rxvgKl5Oj+TGR6La0kjXX+2P5b
 xSTNCCiMApv3ru+HXOv+V46Nhe98jkl+1xYhzPH1dykKVfSH/GvglKx0z0LiBzLq4MlI3IH19f
 RnL/nJQWFV6ibgx3QHcbSuj1QE1eLXBuBqteOlwinkeOq2dv8Bnq5g6mQWd1woP+j31SPqsf5O
 XsRniHkjLmuUG8YAsAmGOctCKpxfhHd1VwmTixvtu1gfvrAwK11x11KuwXbNIW1AYwMNKbYl0v
 sN0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 May 2022 00:33:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L68FM65Cfz1SVp7
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 00:33:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653291190; x=1655883191; bh=LJ8/2FSDHURz0Zuhe/Qx3SaImInSLYq6abN
 68q4sCnc=; b=fbzRa9DHE20CwXRkfGCjdgl4Zx6hwQ1fI7gSJy9Vj9vrbyA+aoA
 Rw4pr+X1sm88OhK0n/MDZUOKzRM6+1XUPow3v38BNiuuWUVEjPBAs9JimtP0J1oa
 5enJzvjcWir1XMEjtGp0JTqRmXwbjRULL5fIoXkiLjsspkVa4jgTQ05LmTmyHnhR
 tAowXU1Vzw58oSBt7G62IYzQ0lpP7zWaJj51+rCw1WCpuu18fMc5yugLgsQ/CeJU
 id9aSljXegV2ggC4TO5fIgUiEHK+NcWIdCLYtpiMwg5m/PynMdAGy7CWYAxCpc+z
 CjoJdVpQWLUB4jwo/6+Bk7Cb0jybiv+eikw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id XmXXcBQzevXS for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 00:33:10 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com
 [10.89.85.73])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L68FJ4nptz1Rvlc;
 Mon, 23 May 2022 00:33:08 -0700 (PDT)
Message-ID: <6175fe49-f3e2-bfcb-2b97-b58763f1cf0e@opensource.wdc.com>
Date: Mon, 23 May 2022 16:33:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-4-git-send-email-john.garry@huawei.com>
 <e65e7329-67e3-016f-e213-86e51b8021d6@opensource.wdc.com>
 <d5a31b82-4134-a7fb-1a51-446e32db2fd0@huawei.com>
Organization: Western Digital Research
In-Reply-To: <d5a31b82-4134-a7fb-1a51-446e32db2fd0@huawei.com>
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

On 2022/05/23 15:53, John Garry wrote:
> On 21/05/2022 00:30, Damien Le Moal wrote:
>>> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
>>> index f69b77cbf538..a3ae6345473b 100644
>>> --- a/drivers/scsi/hosts.c
>>> +++ b/drivers/scsi/hosts.c
>>> @@ -225,6 +225,11 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>>>   	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>>>   				   shost->can_queue);
>>>   
> 
> Hi Damien,
> 
>>> +	if (dma_dev->dma_mask) {
>>> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
>>> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
>>> +	}
>> Nit: you could drop the curly brackets here.
> 
> Some people prefer this style - multi-line statements have curly 
> brackets, while single-line statements conform to the official coding 
> style (and don't use brackets).

OK.

> 
> I'll just stick with what we have unless there is a consensus to change.
> 
> Thanks,
> John
> 
>>
>>> +
>>>   	error = scsi_init_sense_cache(shost);
>>>   	if (error)
>>>   		goto fail;
> 


-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
