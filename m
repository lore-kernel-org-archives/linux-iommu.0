Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6CFCCA480
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 09:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E242D40576;
	Tue, 28 Jun 2022 09:14:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E242D40576
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=rsQtoky1;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=fonT/uY7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NGnrzaIoZbxy; Tue, 28 Jun 2022 09:14:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 92AC74049A;
	Tue, 28 Jun 2022 09:14:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92AC74049A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66CD3C0032;
	Tue, 28 Jun 2022 09:14:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD1FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70FED60D75
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70FED60D75
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com
 header.a=rsa-sha256 header.s=dkim.wdc.com header.b=rsQtoky1; 
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim
 header.b=fonT/uY7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C0HaB_oU5ArP for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 09:14:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D06A606C6
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D06A606C6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1656407669; x=1687943669;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=m7ZvDnvdd5GvaUmk2CDtIh9qIt0xOE1YKhnPo7clhXk=;
 b=rsQtoky1ku1M4BuqALGWc3TqBHwQ6KTAwrreYYTS6BAfikMvfnGqQnqs
 RvmuzNj1SwgpUvAzS8aVvjibgpUODsXbLz2dZT/AFNkjchpA5PqXQdzP+
 AZC+N2nPY0LiV4U1scYry+ZDWWy7GZE5m0XShHq5YO9GbW649pJFVRf0P
 xuGrTGgzMm21YMhsJmdN6E3cCQkSlK3eGsUg9cKIHAusov/uaOYoywqFP
 /vdZ57ypxHr7HNZ+D+AeKsYFIia4PfdjfLbCrIUGCLtKF+XxHBY2Fcr4d
 PJieoqTJn1c6FXqQlB5r/jdQ+2PalsoXgc6vO9VLKWmGkNdpmnYiQvB/w w==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; d="scan'208";a="209145117"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 17:14:29 +0800
IronPort-SDR: 2K6iPRjm3DXIHDLNBl4d8+AYs1rXokGS2zgMDDWDpK3VFAAVxhlUjfaAa8QXAAsWR0XBKcCNCy
 7+6Oa9gZ36puNlbKBTz0WRbr4kI29W6YOC/5PtwWqYJzaQjDA6QIBeNZkP8stvM9CsaZsddAoF
 FllC7W27GkJwew6eHZI2GUYNtKo+XIAnEB1HLJXnYABZ4ta9tD3P8GV0zcVeuQsKWnUzqvLWv0
 M+IbPVT74yeCHMRWA3Y3QEZlTYwjia0KcGIZ3zGA14vDyrMiojYWpkiuU8cfGZ2CJEXaoX2Sgp
 85Fldfo45XpertKUyFYSzVin
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Jun 2022 01:32:10 -0700
IronPort-SDR: 0kyUPb01qt6QPOAx2wqyLXgE4jqf/73ne4tULSPmx28OA5yu1rrmZQ7e06Pzk2ZeAPFWuJEhvR
 haGg1aTtVSJNcy/J4PaJpg4VN0uum1RlVzz2JgCGW4qHMZKcDnOVN5gVOHkUD0EFp6B761E0fV
 iFgdX6Rzy5w73Nizqb51cBUOD4GY6sGZgdo223KhWW6kxidmGWI7ZI7nln4yIbPWLjoChfL7Gb
 dwY9+pnuuAKQh1juNFPVZ42AtGAbMN0SdnexpWSP6VBtD4ProgWAr7ClI6bsLv8HfdpVi7LCOf
 Qvw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Jun 2022 02:14:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXJnd4Sfwz1Rwnm
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 02:14:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1656407668; x=1658999669; bh=m7ZvDnvdd5GvaUmk2CDtIh9qIt0xOE1YKhn
 Po7clhXk=; b=fonT/uY7iPNzTi3ZQtgIXYc1C2nSzN3i9+X+P29x59EXxdjpUaE
 D6Sw7APsvVE7Jg/+qJ3kMMxTcurmh9i+TVhHbGhJOJHMxgsVRnjqDQ1hHH61ZDqE
 olMV5nY6BxIQ1v9956RDQxPObZ2iTz2PB/L6jp5SiKoL8osveKfZyeBhOPF/S9aJ
 jsAP0UCOZbVBVpaL/SH/3Fp2zaozwb71DqJw2OtzEaNPTQ+2FqtHqb9jGZFACewu
 iitZYNmam4gs7SQk8cQeJAOAwRB285P2k62pEWk7Nwsf7zHcyXaSq33gUYGFIqjc
 C5muLk3LwxS2tb70g9gT5bewj0wNJ57IKOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id poVsxW1ACvax for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 02:14:28 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXJnZ4JQfz1RtVk;
 Tue, 28 Jun 2022 02:14:26 -0700 (PDT)
Message-ID: <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
Date: Tue, 28 Jun 2022 18:14:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
Organization: Western Digital Research
In-Reply-To: <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

On 6/28/22 16:54, John Garry wrote:
> On 28/06/2022 00:24, Damien Le Moal wrote:
>> On 6/28/22 00:25, John Garry wrote:
>>> ATA devices (struct ata_device) have a max_sectors field which is
>>> configured internally in libata. This is then used to (re)configure the
>>> associated sdev request queue max_sectors value from how it is earlier set
>>> in __scsi_init_queue(). In __scsi_init_queue() the max_sectors value is set
>>> according to shost limits, which includes host DMA mapping limits.
>>>
>>> Cap the ata_device max_sectors according to shost->max_sectors to respect
>>> this shost limit.
>>>
>>> Signed-off-by: John Garry<john.garry@huawei.com>
>>> Acked-by: Damien Le Moal<damien.lemoal@opensource.wdc.com>
>> Nit: please change the patch title to "ata: libata-scsi: Cap ..."
>>
> 
> ok, but it's going to be an even longer title :)
> 
> BTW, this patch has no real dependency on the rest of the series, so 
> could be taken separately if you prefer.

Sure, you can send it separately. Adding it through the scsi tree is fine too.

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
