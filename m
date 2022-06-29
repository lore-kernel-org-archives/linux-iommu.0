Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335687EB
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656491157; x=1688027157;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AjhPOFbRCAVVpWITsrOe0anHqorsbYYstfbAHDzMisE=;
  b=pEJnFIjL3pjHB2NyPag4vUqDgYCdpyf79znCPORrXBWC/hhc4IKw6XQf
   7ipUzOxgj0IF10g2CrJ/f3Be1eA7+ba+x1HW+IX0i5+pte7xb5O/P8ZiO
   7XUsHo+GM/FdoJcSYR8lcX55kL6ABIGsEyx5lNq/TuopfiGdh6UC8Bemq
   4FT5MsNzdHeJkEfbfm0+RPRld9/WFlttg01yTqwolkQPQ/isDnEpjAcqe
   KwI8x+OLZpyiE0fcAeCfVYG9LNekW9/35LdanTHjA1/AHaTFU4nQlrUWw
   MAjAM4WgNpbFWihrRnPl5sjn92EWjjDrLsLveTHq02awnlGLHQHiu7mls
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="205096302"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 16:24:46 +0800
IronPort-SDR: ZquWzYQOzsxUAZQEaMqQIhv5sYST5GCziCtv0Fb/BX2dL9qj5Zb+5UWlJrZd0eRxwGl5Mk7WVK
 GqhfU6rz1ipbGjqEoTHpHPjWH7OKYOe75ipWw2Rb1UCMfpjkyASxBW/2S5z6hJVDk0xImscXrs
 oiS9hnhw/gJL4H3ngk1QWyBrRoSxuV/fmKdfS/jqbXpeGRtTaUjh0AAHdti4P76xskSIeG/2VJ
 yGdMRrnKaoRESWKP3aAZqYwKFXDBgs1Kwdf2Igf+DXupcusSQUZpZUF5BxMFUk0ZP2+d7jDtUR
 GiJeQH8WHgwrS5rNcE2KTpli
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 00:42:25 -0700
IronPort-SDR: /wYpezuHB2qFBbqkLFX4skeMQMhbRW4HkOYNw8jC7Yf+jgZIT2UZngKF2AQX20S8TRLCjStMJZ
 rI76CJ+BTxxvEXNnmUo77LGCFu8JcegbiSDB4DWtJdDypnebDPH3sBTQYuqPZ7tXeiOCi5AEnc
 P9MJfWivPeWULPQAsV6g4tOEmUtX7enbh1l06cMzUEwBvDqVZMHKxP6NraVm1ZA5shLZOFlL/F
 DyK1WqWRnklNJoXgH29bcIHnQQBn9/KTGSCABxZo0mb99bv3WLn04Fe/zWIg4ID0o++Q7SAAPS
 MsU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 01:24:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXvdn4v5lz1Rw4L
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 01:24:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656491085; x=1659083086; bh=AjhPOFbRCAVVpWITsrOe0anHqorsbYYstfb
	AHDzMisE=; b=VKSw9+hNpxOTYZUR7tp/8337L+N6pO5KNYt3jMgLrlUq4Zs3t5I
	jMl5A44R6tUpillWJfxuun6t8WIj6/nJeyHYBNFgXxJrJCS2yPH1HUfJQ6zQaKEX
	2OJ0kO8NkQPLXmQpu+1+y3ksuL1tk/v2rgilcySdSzmeYNVz2077MvsGBM8rFh6E
	unedqEh92R/EwjK9+mTcw4E/KYfLdMBZlp79jM4ilUQ2e6nUukZVNKRJBt/KiwQl
	POgm07sKDuOab4D41/qR63zekUxDhZOyXSYxMteQI1XCQrp7x2kDND7Rg6e6tFBC
	vPCH1LMqtUTVo5PNfQH7asnVf4zCjXIoDPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8zOFYZ6cGSFA for <iommu@lists.linux.dev>;
	Wed, 29 Jun 2022 01:24:45 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXvdk2Vfxz1RtVk;
	Wed, 29 Jun 2022 01:24:42 -0700 (PDT)
Message-ID: <bf9d1cc7-c03d-f5a8-bb96-cfcd352ac36e@opensource.wdc.com>
Date: Wed, 29 Jun 2022 17:24:41 +0900
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
To: John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-scsi@vger.kernel.org, linuxarm@huawei.com,
 joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
 <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
 <38ae1cc8-1411-bb54-e082-0f7b91cb9e63@huawei.com>
 <20220629054027.GB16297@lst.de>
 <da7027d9-bd81-cfb0-f70e-2405f40023fa@opensource.wdc.com>
 <65e05dd1-8e92-5f6b-d68e-72987fcebf59@huawei.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <65e05dd1-8e92-5f6b-d68e-72987fcebf59@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <20220629082441.U_Kdq7KNBnXAXQBLAl49Ao7soGKQIC5GMIPkBgjejIw@z>

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
