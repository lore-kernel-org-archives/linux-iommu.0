Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE41879
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657536096; x=1689072096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M38FathVBz+QDBZGXrRIt275IISeBfhxZNFV9WnBgzI=;
  b=C1MAM/WsKF/gTK5G9wStOe/dbU/pnOvvl0S0D0TZowATMhX874HdW6NB
   aiLiRD/sLsZOLJ3yYzchg9tuXkvnheX7wBK/kCF8z8xZoZZgkeBI/t5UK
   6DDpwNReK3ZCK4TaD7q8Nj/b6Dvw3e4T7cc1DtQz+fEM38txS7gnmauR6
   vC9uk7RPbDrG9tmzoSN9eEPQGTHBJtR5P3i/2sqXH0PywskOdGaLeq8Lt
   DCq/mBeDL9gbJ08yZ8EHW5Mt/0WpEsTRs8tFGktO06hyvnv97GNuDuYwp
   yADm2xZ0pYOCBF0eVTbmaLsJGt59M70s8Rp1KwIgcaQfkaXXDv+vJ3lnq
   A==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650902400"; 
   d="scan'208";a="204006972"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 18:40:28 +0800
IronPort-SDR: 8sFfLGUCSYPtRKV1u8VVeObWr5l56EJuboOj4PAlQqaeMGnofN5qA+9FarZoXT50pgE9qSzH+8
 X6zGujGjkOehY8VzVwlqT9IRh43jlz3mQZqqQ6uLaVhn/q8+RUchLUfeUYHXxpSXHVZ0yMIVbj
 8lF2pLtGkYCSsuQcTw/T1ZMXZRIbAXYr9WhDgZPauxPx7qWBPbtsUK7eggf0QxCFEKZYnjfk1I
 czC4M686ILGqOClp31BY2TbAHJhvVQ3pte6h+m52X0kRBz3hEzHFTwbpzadoeeF3cWEwZiJ1DF
 1DssORE1vEC8mVu+7ufPgzJI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2022 03:02:05 -0700
IronPort-SDR: L7189X/c2N6RIQSI+yw+vAx0D/63dEG5NlLueof6yGJOoh+Tfnb71EW1XfYGOB7OMBt4VoP1f1
 owULSd5obUBzHx4s6WalxyOkWyA/S5xukeSMEiweIkNWN6QvAd3mT0sbPXwRq6d5ozOofTVqci
 f5x+Hmqwa4+7Jv6tdZphH0FPFvxVxygyDzyvT3VqT3yoiBVwOgp/cgHVSPf3KiqBBrrCWmrkSl
 eRdQiWJ+rrsB9X6uY/gT9jDLtzJP2jmXVLlr77GcMMgADYde6HC3u5OjuTUeTrAYfNeRNIk2CI
 jeA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2022 03:40:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LhL4q5zs5z1RwsC
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 03:40:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1657536026; x=1660128027; bh=M38FathVBz+QDBZGXrRIt275IISeBfhxZNF
	V9WnBgzI=; b=Jq8yiythf4/NGMPDez5TDXQRmsRywCxgvudQsGMOmYsnKVsSgRw
	Z4ASuw7usvOrTQKmaPKdWKF6TuTLFpxxEeOa6LGPkWFwal2t9Ftp2g6X1zVAH/Vf
	icYZ6ZMn/S+DdP4FS0n6P1h7o5igMr45a8B/bUdts7FCCnSxCl6n8LdMRPZFkYzX
	IOCwnB6HlRhrkluKixvZotg9Y8P5Z5MwHkQGLEYH2TlYfPYZFdopY6kOukm9SPHi
	MSfHEEhn41NkWpbh+5tU9s8JMTXgsxx5iFx7xwwiFZ2REAmup3MUsSbWP3LCpZFA
	oO4VfhLvJVEW9Wb6ZQS8VgdguaAlSHxUZuw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hCcenWC-frOg for <iommu@lists.linux.dev>;
	Mon, 11 Jul 2022 03:40:26 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LhL4m0m61z1RtVk;
	Mon, 11 Jul 2022 03:40:23 -0700 (PDT)
Message-ID: <62b801e8-66b6-0af7-b0c9-195823bf9f62@opensource.wdc.com>
Date: Mon, 11 Jul 2022 19:40:22 +0900
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
 <6367a264-a3d3-8857-9b5a-2afcd25580cb@opensource.wdc.com>
 <a415e4a1-72ce-53e1-437a-fc7e56e4b913@huawei.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a415e4a1-72ce-53e1-437a-fc7e56e4b913@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/11/22 16:36, John Garry wrote:
> On 11/07/2022 00:08, Damien Le Moal wrote:
>>> Ah, I think that I misunderstood Damien's question. I thought he was
>>> asking why not keep shost max_sectors at dma_max_mapping_size() and t=
hen
>>> init each sdev request queue max hw sectors at dma_opt_mapping_size()=
.
>> I was suggesting the reverse:)  Keep the device hard limit
>> (max_hw_sectors) to the max dma mapping and set the soft limit
>> (max_sectors) to the optimal dma mapping size.
>=20
> Sure, but as I mentioned below, I only see a small % of requests whose=20
> mapping size exceeds max_sectors but that still causes a big performanc=
e=20
> hit. So that is why I want to set the hard limit as the optimal dma=20
> mapping size.

How can you possibly end-up with requests larger than max_sectors ? BIO
split is done using this limit, right ? Or is it that request merging is
allowed up to max_hw_sectors even if the resulting request size exceeds
max_sectors ?

>=20
> Indeed, the IOMMU IOVA caching limit is already the same as default=20
> max_sectors for the disks in my system - 128Kb for 4k page size.
>=20
>>
>>> But he seems that you want to know why not have the request queue max
>>> sectors at dma_opt_mapping_size(). The answer is related to meaning o=
f
>>> dma_opt_mapping_size(). If we get any mappings which exceed this size
>>> then it can have a big dma mapping performance hit. So I set max hw
>>> sectors at this =E2=80=98opt=E2=80=99 mapping size to ensure that we =
get no mappings
>>> which exceed this size. Indeed, I think max sectors is 128Kb today fo=
r
>>> my host, which would be same as dma_opt_mapping_size() value with an
>>> IOMMU enabled. And I find that only a small % of request size may exc=
eed
>>> this 128kb size, but it still has a big performance impact.
>>>
>=20
> Thanks,
> John


--=20
Damien Le Moal
Western Digital Research
