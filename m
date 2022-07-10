Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B743C2B
	for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 23:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657494578; x=1689030578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mKne22iKALzQ3J0xLcJU8NPKnJVHQYik+HOhe8r31SI=;
  b=c4u5kN+uWsuROAU88rW3fuJLnFdeEIXFAC/o/wGtvvWvdsCiY9sLz2iQ
   G8ghkJzZIlJKwZV9J6YofexMuauOkPTJxwbBLBOp2iBbNPNSdxlTZKvmE
   6lothUfm0ZQ9AGJ4Z21a3MkSo1xvog7aJfCGYQi0skJ3LPDGJsCV+5jIw
   /Nu9Bi2qt63OxQMtQW/e/bftyLPXMLOAACzKtD6VJxgLRMCDfs/8/t569
   vy8fqab1i2Pd6AnpSaekDWjfcOHtCyCCbsvmNNZQSlHtSLcBTOK5NUzOK
   R1z0LwBa5ZUlKo6U3zIyBzNZL5XEPtCUYDFZRtmFiqBfazA8997kf2qIs
   w==;
X-IronPort-AV: E=Sophos;i="5.92,261,1650902400"; 
   d="scan'208";a="210242753"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 07:08:29 +0800
IronPort-SDR: H8t2SfafH5Uh9gxB4k3pxqpbusoKptDsUcUERuF0x2mk/okGo9Oubs+NP9uMkxmkAjLaUsCeYP
 bIrNEy8JQhPOzCUuW9KuuaZ/1Ptp/yT5K3nUHmg0QowA6suMVl2lOxKeyrxWRuIZoQu/1/a72F
 tjG1KMty1fCqupSrBEGS63lJVKIUBi8q7w92wvcTFwxj/Udxh1LqWISB92gAl70A0MRNb+qRh/
 zYenc0dFikv/ChJOICL1DolhqrVokY502hT+R089KZbIs+sZEfM5BUEKT/qiPMqNlmpWjbtUbx
 TmWgRVjjlpirhl7mxSwS+kyh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2022 15:25:30 -0700
IronPort-SDR: i4Slv0urNSHx7jslOJSjGhcKbL+9/YWetgwMJMymprcLrxoSBJ8Oxc+RhDLPP2CD2WtvNjMm/N
 ZgDcGwJPwY5ZeHZl3dqvlXbcumPv2GlbgWudVsa5xvItnAaAe+KSZCLonFEZVK6lZghuyk86Q7
 6diQ2dXn3TwjpYVRWTEndykITo/p0kcanUha1GW3tv7r09fThoyFHwlu8SMo2yYxD+UddMQunQ
 R3Rj4T06MTGNyy9xttyBJk/ysp5WQjQZgexJYvoXGW3njOOeIXFj7+Nbm7bflV0YzDx/QtjL8I
 fkA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2022 16:08:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Lh2kQ2R3Fz1RwqM
	for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 16:08:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1657494509; x=1660086510; bh=mKne22iKALzQ3J0xLcJU8NPKnJVHQYik+HO
	he8r31SI=; b=LFBrpQ2567/K4oU4UX1SyFMfJ8BAa4bdsk1UJ/NMSHvt37CYjOf
	1kbvpSo8/bCcW9xh3pjCSJKXmr8wvDZv/F8hxNeg7l97iwC8m6L2E7G+eKJF1Lt5
	tuHTFC7W6GUwcMXVmAQRGXBOUdnaBe2+GGkRBtMgeAxHuz3t0zjI6GvNFJO2Ip7O
	JEAGQxLI1dFWwGgeZXKVQ/AhQ47Ukri78yOLdbxnM9K3sBHTAoJ8M7KnTr8t/e4j
	+5SzXzsyZHnO99NQ/x7k8lv2NhJWaoJ9mbn6ecUdD/LZHdctnaPoKFR77Z78u8U+
	PSrqKxNyIHtWMXXPfCzy7HEip35NWR6kZYQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TXcOqGr7kL1a for <iommu@lists.linux.dev>;
	Sun, 10 Jul 2022 16:08:29 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Lh2kK2D3Hz1RtVk;
	Sun, 10 Jul 2022 16:08:25 -0700 (PDT)
Message-ID: <6367a264-a3d3-8857-9b5a-2afcd25580cb@opensource.wdc.com>
Date: Mon, 11 Jul 2022 08:08:23 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 0/5] DMA mapping changes for SCSI core
Content-Language: en-US
To: John Garry <john.garry@huawei.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
 m.szyprowski@samsung.com, robin.murphy@arm.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
 linux-scsi@vger.kernel.org, linuxarm@huawei.com
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
 <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
 <20220706134447.GA23753@lst.de> <yq1y1x47jgn.fsf@ca-mkp.ca.oracle.com>
 <5fd4814a-81b1-0e71-58e0-57a747eb684e@huawei.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5fd4814a-81b1-0e71-58e0-57a747eb684e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/9/22 01:17, John Garry wrote:
> On 07/07/2022 21:35, Martin K. Petersen wrote:
>> Christoph,
>>
>>> Yes, I've mostly been waiting for an ACK from Martin.
>> Sorry, I'm on vacation this week. The series looks OK to me although I
>> do agree that it would be great if the max was reflected in the queue'=
s
>> hard limit and opt in the soft limit.
>=20
> Ah, I think that I misunderstood Damien's question. I thought he was=20
> asking why not keep shost max_sectors at dma_max_mapping_size() and the=
n=20
> init each sdev request queue max hw sectors at dma_opt_mapping_size().

I was suggesting the reverse :) Keep the device hard limit
(max_hw_sectors) to the max dma mapping and set the soft limit
(max_sectors) to the optimal dma mapping size.

>=20
> But he seems that you want to know why not have the request queue max=20
> sectors at dma_opt_mapping_size(). The answer is related to meaning of=20
> dma_opt_mapping_size(). If we get any mappings which exceed this size=20
> then it can have a big dma mapping performance hit. So I set max hw=20
> sectors at this =E2=80=98opt=E2=80=99 mapping size to ensure that we ge=
t no mappings=20
> which exceed this size. Indeed, I think max sectors is 128Kb today for=20
> my host, which would be same as dma_opt_mapping_size() value with an=20
> IOMMU enabled. And I find that only a small % of request size may excee=
d=20
> this 128kb size, but it still has a big performance impact.
>=20
>>
>> Acked-by: Martin K. Petersen<martin.petersen@oracle.com>
>=20
> Thanks,
> John


--=20
Damien Le Moal
Western Digital Research
