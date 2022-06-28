Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05C7A
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656407740; x=1687943740;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m7ZvDnvdd5GvaUmk2CDtIh9qIt0xOE1YKhnPo7clhXk=;
  b=HQkuBHE7M+I9y1CdI5DpSyxojxwNf1Yejtc7hd+OypbcbpAvMryZsKeE
   Ac5ojh+PyVftDdHJPY2mXHFLo0XoGlN71mKwYG0pADVH4iakdgV97fQnd
   N2pYVgCbDqTF2SAxmqi/3Z6D3pS8FwPF1wfnW627ezz+Kb/4KKmN/Vn8u
   lnwHgnYcJceeWbclqlUJR9YakvvoRXNdZfHgSVKidatgpNnE5lOU0LHw8
   P6Uq4Lej4R4w0O4DbebQ2mO4U1HmdqlW0sD/ZBBxUpzeHVStxa+YBKyhY
   gicgkk+u2H86x+SXGdQkJYZp8G8jDZprWcX3JguDIKjXana1TzhZrEwE7
   A==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; 
   d="scan'208";a="308600407"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 17:14:30 +0800
IronPort-SDR: hzlenmokkucRrncDa7+zZaKNL+3USGX8klfcVWTJSe/0UgdZUdzAQInNIxWXeSBJ3XXnhWA+FK
 UOv0WMmrPoz8QuHQ7OV7+Ct3rq3Y9ltjRhRgzIaR5lO03S0QcKddCJZCTNc65KI1NF4jxpcp74
 RztMe24apxXFF6TSBWfTxYirBPV7YzlksIvfSMAP47oCvAkZSbPJ6fFKdySqVfmyFERxWL9nb+
 U86ylY9ztL4TFRubW8yLm3uiKaCeRYwczIMdUbZgCZPnynJWk5DCCzKboRB4kx53lSXcghFSye
 3UgdNZJvpqJFfhJpOXSMPwCJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 01:36:52 -0700
IronPort-SDR: lsOprUbM3i0e0Ig8mUhEzBzp7i3mOCaT6qU372lqoMBR/IQ8oT5JjFO00PHwdjObXOQjJSdMU0
 ZuG1q32kC9Xy3nWYkcFZk+WqnFhIPNM0zdZ5kfDj2S/DRc+mBh1HVEiSZXeQprA4NbMcQJv20U
 W9B6D9HeVKIZ2AbWIT2lsHv/7axDTrqR/oXFHmOITPVG+NbcrC3Fp5Fn+EskRlYnRboVGuhEB7
 CBbDTHlHwyinURJdlvdV3lktOvKZ9cF828Sym7agLKE0QofW5xNTzQ4EpCLgPw8+NM439l/o+y
 D1o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 02:14:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXJnf07JRz1Rw4L
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 02:14:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656407669; x=1658999670; bh=m7ZvDnvdd5GvaUmk2CDtIh9qIt0xOE1YKhn
	Po7clhXk=; b=n1Hpc6gcPs/kxiOVTQwyRGR+uFdty2ur8mMpVtR58Kwy2fqXmbI
	HTEscATaBiYXrvQoDsewN6VCSm9M5MIlpqKcq/8hTcw3cjPO33agP8Xd57Tj6DFz
	4R0ljR0v+eB5w4pbvmsQ5m12TQNrFyNz/lIFaUH0ktaZyNqS0r6+dYb80iSY2vIS
	eAjGfzucNGjkx5UDxGIgv1ZF4t8Y8uxziilTeI0bERjb3d5G2iyT+xB/TWonmtz9
	zODt5GChELx+M4SuiD3Cm4Kcm8I7M51ZXMYbgEjMRtCnihX/D9URy755F6CYUCq9
	+ysvrOnAro+PSPbYDdtqx2RasqndSuvPycw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SW0wQqaZgHrK for <iommu@lists.linux.dev>;
	Tue, 28 Jun 2022 02:14:29 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXJnZ4JQfz1RtVk;
	Tue, 28 Jun 2022 02:14:26 -0700 (PDT)
Message-ID: <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
Date: Tue, 28 Jun 2022 18:14:25 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-scsi@vger.kernel.org, linuxarm@huawei.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <20220628091425.M8TE1aCq94xS09oT7FHYXlevnXccqpuLqgPz5ulzqgU@z>

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
