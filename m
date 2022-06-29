Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2C7C43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 05:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E9E440384;
	Wed, 29 Jun 2022 05:58:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E9E440384
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=HOYDLryi;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=rZSIxcVa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXtKflVwziff; Wed, 29 Jun 2022 05:58:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 749104035E;
	Wed, 29 Jun 2022 05:58:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 749104035E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D951C0039;
	Wed, 29 Jun 2022 05:58:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75170C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 05:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 570E581392
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 05:58:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 570E581392
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com
 header.a=rsa-sha256 header.s=dkim.wdc.com header.b=HOYDLryi; 
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim
 header.b=rZSIxcVa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3FUR40zbhWMu for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 05:58:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3644A826B4
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3644A826B4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 05:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1656482305; x=1688018305;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=S274m18N48qoB/3JOPWD2zir1wX7NK811KrJ3AY/WxM=;
 b=HOYDLryiGLMpCGUMYD27x/r+KMN3btvGMpH7fUS9gsMw6/LM4PkyOieC
 NU8z7sbYbtXhv5ISqHTxgqFe/O2GXUq7RnnoajBGZ75v69Caj7B8cxDnv
 7jywBubKdOmTOaPwzTKrGYrjsYIjc3kULh7OfST4Ozs34+PNT/nD9OofV
 bTB7lnsvpSsRYxJOWNZWt+K0zRL5ro/aiHZnAB3XS+m/N2Ad9xwTf6+5T
 mmbj4KJROyFhRaJwg1OcqTCwCh8Z1P62C8KlVphQGvx/IU+T+YHPmvkYP
 TYVw81RnxC+cs+tpDRy4t/I5mjFYoMDHvPR1yajwPszXktBx2BP+qwG2x g==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; d="scan'208";a="204357695"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 13:58:24 +0800
IronPort-SDR: ss0OvvYYZAqEnsYcXoivGq6TLMXRBCH3tD7PwCqBPgHghWWqY2IJpb3zgVaPhyNzcKxE4Ntwqv
 TcENl8w8cOdtTcE19kJvfzdFCRgOJPyHZ3pUmkgEBwY/q6Z0EhJ37E0ZrB7CZUmzzZVVHZuuA5
 GeKt7jRWHQir5yMq3TnQXR4m23PNWvbeWSXbhW5v9PlA40SNWBSt5E1jaMQAKZ+2KuDsC5f5kC
 41rP5t5BQrD4Sy3GGbnqUEbxu+vNP8KkoX61vZQp3U9I6LpMAynqg0Q3qV/NMGjXflGVErfJ1y
 opkK9mqLEaY3QG2c7q8+JswX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Jun 2022 22:20:46 -0700
IronPort-SDR: mhGSFAQTcdi6l4ELakQ7SYKD5r2+RBcpUP8dwKOo+pHuD+PQBlGEWSvEChOSJMv0jR8Lj/8Dpm
 jkdgAYeVrWhjweTpGHsDNvvH4vF6BsibaiRcY6j2yg8R5I2eZtUr1mp3CpLl0Tf4sSn9BSO0Yf
 JaZggpaLazy6GDnQci7oSzOUQyPjIwKejbbS8eAWf+WY2YTSQkz9fVmZgcX2cMBn17l+l7luuh
 d0CaOyXrzK9iSvJMXZ4DaxVSpjTxa75i4j6JdA6jUn29S+UHk2SFKBi6hoZ06ed2NUzCK6C1F6
 a3A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Jun 2022 22:58:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXrNx0N5Rz1Rw4L
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 22:58:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1656482304; x=1659074305; bh=S274m18N48qoB/3JOPWD2zir1wX7NK811Kr
 J3AY/WxM=; b=rZSIxcVazCAwPnit7YiDg5OgUpZgn7oq63L8f4Mx5qqJilG9g8G
 wV5uGQC6JZ3YwlD5RcmYm+uC8m3errnlZAgp6o7+Qhr7ybMyItuZdVnuPUQq8QEd
 alfGKsPbawfDl8vhSXqv7ElY5MHblK270Sv+iK4DJTeh1yOW4yY6pE1FPc0SsVS3
 eEbW6uvondPnaorxx3Tv8sUCSOfC7y2rkIguFVW4kiJALFQpstNM3YhM+lm0p4Sk
 NjgP4mO0z1H7lo92riFs/zobGTmMpBKf5xdH7qdMRzGY7ovcG58VHmy0idD2F4km
 cXLdBqiqjM+YDQfvAyxED73TZ7AcaTKdhxg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 6av0Kfj9WNz1 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 22:58:24 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXrNt01D4z1RtVk;
 Tue, 28 Jun 2022 22:58:21 -0700 (PDT)
Message-ID: <da7027d9-bd81-cfb0-f70e-2405f40023fa@opensource.wdc.com>
Date: Wed, 29 Jun 2022 14:58:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
 <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
 <38ae1cc8-1411-bb54-e082-0f7b91cb9e63@huawei.com>
 <20220629054027.GB16297@lst.de>
Organization: Western Digital Research
In-Reply-To: <20220629054027.GB16297@lst.de>
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

On 6/29/22 14:40, Christoph Hellwig wrote:
> On Tue, Jun 28, 2022 at 12:33:58PM +0100, John Garry wrote:
>> Well Christoph originally offered to take this series via the dma-mapping 
>> tree.
>>
>> @Christoph, is that still ok with you? If so, would you rather I send this 
>> libata patch separately?
> 
> The offer still stands, and I don't really care where the libata
> patch is routed.  Just tell me what you prefer.

If it is 100% independent from the other patches, I can take it.
Otherwise, feel free to take it !

-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
