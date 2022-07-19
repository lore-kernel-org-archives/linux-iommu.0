Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988510E9
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658225281; x=1689761281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YauuOWB0eWlQxPIi0jYv3JHtwzs7d0w3Q3HbluMXv3M=;
  b=hh5vfWkYsAlvBRXkSabQXa8V+lwXjzUlfcwHj5tiTbSnqv6FnPK73jNz
   Lp8j++MbSQwRHNEEKcnQihV4IxO+YN2g57V5pb6DN5Z7G52xhB2jbfWTb
   mxUJgJ8tSlPnKiOcokzS3/0dzuEJm0bSbAH87N/tAMu3bMzkkd+G+Eph6
   bIzdLQi0HW4O3UQ3NGf3Bfv0JFzOOtkI+9wUIJXKnKLzzqhrCRJ460aRZ
   ewlpfTmLF2raG+QHHD6odmpwqgNqP5FVzoJlxJ7DWh/4xKXLDR5BxoBA5
   1MJkfWKinKKVasIwv4UMFPnk53hAtRix7fwFSWUobPPEKMSWFp3Sb8Snt
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650902400"; 
   d="scan'208";a="206973735"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 18:06:52 +0800
IronPort-SDR: VkGd+ayrIsAB63l7hHesDGER8E7hRtm95oAC30Syvy/YFlgI0hTxjNDXbltDgK1CiuPx0fEQlq
 5hn4fGiVsFtc8pxPiRFvkIjKIQIO6lr004fQOZAZQG7tCClPOF3HdjHqFBUH/zgpvAM0AcwHjx
 9tzGSDvH+fsxiztNZL//jEOt7hUBbbbIVfIclToiWIxiqXrpIGgo+XbzNl0TxsUKY7kibvPitb
 4Fq8/gOZ4XQkReTBF6SmPYLEnt63pl0bRo958HzGjnJfPDs+xbkqBqg4wU9aF+VtdXplk9MhAr
 2OqkbX9HvLHG62Seqg9OGewA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 02:23:20 -0700
IronPort-SDR: 6Ppc3i1N+nO+AXoYnZppTc9bN8Iw93AfpZmHCdy2jM0FXP59Kjp/Jn44QCH5LGIZMNIrgY/UP1
 oxoT4hQBB6hvj3W5RhD3wyQ8Th8LJC1SdEYnnP2n10ussLwA2it7voKkR/iv1PJtRJYYhX6ltJ
 UMv6g878yshtOYBq0ERHEqUZNwVsYWdzsRqK0JRwImK4Al9Y6RkTgDyXQ7kt8ngkOOhYDMYSmT
 hN6GJLLHjnCV/cbyBpyUHrYu7toipPr8I7xRm8P3bNAcLq2KJkvx+KfgNiqlYjVZ6qYPpE0LWg
 QyQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 03:06:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LnDyN3DjHz1Rwnl
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 03:06:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658225212; x=1660817213; bh=YauuOWB0eWlQxPIi0jYv3JHtwzs7d0w3Q3H
	bluMXv3M=; b=B6ldBGGeutES4yTjwz6A5Ffl19zIhBlH1DbbBAoNmfheZbw0yji
	7chlMDHEzqOxzbOV8IWyRcJawMMqNI1g4VBqN0WWBc3WF4Gi1gyXJ2Pvl6+RwjAs
	Kyqya3ZHk/GjSbTU/ypiuMcOa/6rbZ1r/f/P4lsgF0Dt1563M0DLdwLuj6FwS0hY
	EUT6hs+JMHcmLOL5cJjzDJ1xSNbmQq5HeEWj0kvY1MnyQSnWiIhl0vWKOBbP2xob
	v8XBMFyZW/IiPq+iDVyfzApkD9rRrxE/8ckO3vQkJt+yvfVBSlphcjbEcZVV1xP1
	+FKXBj1Sil53riIbMkhuvMODRX/I5pEomIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eAnuxsozCREX for <iommu@lists.linux.dev>;
	Tue, 19 Jul 2022 03:06:52 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LnDyL6sYDz1RtVk;
	Tue, 19 Jul 2022 03:06:50 -0700 (PDT)
Message-ID: <af41fbeb-c2b1-e4c8-8b75-fa03fb9eb993@opensource.wdc.com>
Date: Tue, 19 Jul 2022 19:06:49 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: sd: Add a comment about limiting max_sectors to
 shost optimal limit
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hch@lst.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <1658224264-49972-1-git-send-email-john.garry@huawei.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1658224264-49972-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/22 18:51, John Garry wrote:
> Add a comment about limiting the default the SCSI disk request_queue
> max_sectors initial value to that of the SCSI host optimal sectors limit.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 3eaee1f7aaca..ed9f43f9512e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3296,6 +3296,11 @@ static int sd_revalidate_disk(struct gendisk *disk)
>  				      (sector_t)BLK_DEF_MAX_SECTORS);
>  	}
>  
> +	/*
> +	 * Limit default to SCSI host optimal sector limit if set. There may be
> +	 * an impact on performance for when the size of a request exceeds this
> +	 * host limit.
> +	 */
>  	rw_max = min_not_zero(rw_max, sdp->host->opt_sectors);
>  
>  	/* Do not exceed controller limit */

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
