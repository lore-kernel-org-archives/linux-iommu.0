Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CA7E0
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 05:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656482312; x=1688018312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S274m18N48qoB/3JOPWD2zir1wX7NK811KrJ3AY/WxM=;
  b=l2lJPCXkCmXZR/L8K/5JF/DTyxOYCP+gPZQSehi90kyOG0janopi5Pm1
   XT8l/IZDn7SMfTiYIXz9il4e6D/q+z1nbsHw4mDaBfY9+La3gWWrLJpcw
   rFWT2PXqE8gp0E6LSZ4tqpinTXM7/gtLiizEHCdPoFNSAWBGcrT+cXxIX
   fh0rt+F7i3gK1WTfr4Mm4c6l22uh5g0f85RUPU6hAT5p3HcWuGAoOP9zo
   uiPGOhfk+sr69wpq/9ZX40Xe19H8ezp+xueAnWpmlX3NBMzYJyYe9A8U2
   TGkTV14xfN49WG84CTlxHdMEknfC4y4OCUh8IiJmwuN1Wq9OwQEI0PWzT
   A==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="316466594"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 13:58:25 +0800
IronPort-SDR: vxuuxyh4y35Nm3QJUYeu9CJuGnyuuQLdjbSvd1d+pqGDbFSrCNlF1z0aAaL5q4GdlMXbQ5vOgf
 0rA8Qu2xKrSVRECTZfyhgrBBZNG0MalEVJSeg6XquNnja9KTqmKJzv479ax2cFmnW4PapYzqCU
 emAJePiWFMz0rx5oa2PTRrVBBOHIoSbjDWMuTZmB1dvJPRo8wcSpH5u3Etpx9WvTu+KnQEVWD8
 JpES3C6GzEYutt0bE5C4+TEQQwdU30NwoEHfgDWmVxwFFIa8UMCN7pW6G/8ZwrVqXQ4gk807xR
 0bcDKJbECrEPG3dyggE+pW4n
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 22:16:04 -0700
IronPort-SDR: O2EShxbHSGr9kLq8g7LT9YqitFO296rEfZiS8ZiUwNt2DKNlQITt9Rv2Vxqc3qnUHE/xhSSeMh
 Rz7MnCrIwBO0mPvkVw8/EEnQb45lBGGbhyHo3Ju9m8v6HKULQhCEt88hy9AxPILNG25tf+8S3i
 OMf4JJzMRJsQZrzK70YOuitZ5yZ8yilhPmblvD4efAeJBLBKtHSE8RJHq9Lbmh+wBvHYG7PIcj
 8l3wDSx3YiphywOuN9UTtgiGu+jJgN4gEhVUV/07Pd4Gv9YZhD/ph6Gj3pzp7NQRMTBiLWRqIi
 TBo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 22:58:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXrNx33Hbz1Rwnm
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 22:58:25 -0700 (PDT)
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
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Klxi6mXBWf-Q for <iommu@lists.linux.dev>;
	Tue, 28 Jun 2022 22:58:24 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXrNt01D4z1RtVk;
	Tue, 28 Jun 2022 22:58:21 -0700 (PDT)
Message-ID: <da7027d9-bd81-cfb0-f70e-2405f40023fa@opensource.wdc.com>
Date: Wed, 29 Jun 2022 14:58:20 +0900
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
To: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
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
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629054027.GB16297@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <20220629055820.NjhoNmalxgrR_ZJZc-TyzXznJHKZGv7oddQh55z00gs@z>

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
