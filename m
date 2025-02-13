Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3A19B5A9
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462592; cv=none; b=Q6wuwU5ig3YfTROyLDLfTYYVdAj7IfxShi3gPXlcWXOir90VF7MsugvDEZ3MWFRpuLQjLqTpjOAciKHcS+Xx6hhu+8SWl+q5ZtTx1v1+yL5i5E2uLAxm4wPVOlcs4qhq9R9V0Pjlaux6ZYa7NmhXpWgauh7v5Dd2mck322BZcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462592; c=relaxed/simple;
	bh=vhjnn9ZmXt1hoQyiEu6vq4PTI5mjWa2AhGOL54PAkso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfPdjON2jA+Agrt4SkwE771clkhlQ6pyCQKDqENF0lmxGvC1n6B1ZEqR9hBFLK1rlnzbCMrCREKYe9t03FFx6J2K7ku7tDU4P8mHoZ1MXLlD3Kb1nYxWwZ+UbjDncqV/zZM7AZP2faxUOPC2M51AeiUPXKM7W2NQ4QhJK2OCSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jo6yPq6m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jo6yPq6m"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DCO0SX010464;
	Thu, 13 Feb 2025 16:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cjRnvn
	gblq8qxw6Z/VjNGdj6ug9+CFN1Sfxk2C0sBr0=; b=Jo6yPq6m91PFOP46Es+r0Y
	KjqO7aD2Po4eEAaEM8Cx7fTdKGKlhQoW9NxC8Ap3uAF8P5t8sPPY034g2lDB/IRR
	Ix6rhK0e8ZKTPcOnSlIGFZyR/3MQHpGdWmVDGGcqRKmIpNN2C4KkXBPUPesX4/k3
	p/Qf5zW7GzjrVhUirUfhmT1VtR0KIYaijQA7npcBkml3T71eGg/yWytVAZ5IYne6
	lS6PQyI1EuJ9gwvycjogL4xfgRizOGJ5T7VNSq/dRAIinJ5hkKGZK36H94VXXEKz
	V6QdDsjdGKuRK8hs2hPpNnfK7JX5vsedK28dOLUVO51MKmvqwEP4EkhJdJTyC/nw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44s6ta3y4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 16:03:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51DFeuAj016712;
	Thu, 13 Feb 2025 16:03:02 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pk3kexh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 16:03:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51DG30jY25690876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 16:03:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7AA35805D;
	Thu, 13 Feb 2025 16:03:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A837F58043;
	Thu, 13 Feb 2025 16:02:59 +0000 (GMT)
Received: from [9.61.186.234] (unknown [9.61.186.234])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Feb 2025 16:02:59 +0000 (GMT)
Message-ID: <58c0a779-d122-446e-8824-33b48b45514f@linux.ibm.com>
Date: Thu, 13 Feb 2025 11:02:59 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] iommu/s390: implement iommu passthrough via
 identity domain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250212213418.182902-1-mjrosato@linux.ibm.com>
 <20250212213418.182902-5-mjrosato@linux.ibm.com>
 <20250213151037.GD3754072@nvidia.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20250213151037.GD3754072@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9K6jE52tY3x01arQjC3lvWWaxqjeP83y
X-Proofpoint-GUID: 9K6jE52tY3x01arQjC3lvWWaxqjeP83y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130117

On 2/13/25 10:10 AM, Jason Gunthorpe wrote:
> On Wed, Feb 12, 2025 at 04:34:18PM -0500, Matthew Rosato wrote:
>> Enabled via the kernel command-line 'iommu.passthrough=1' option.
>>
>> Introduce the concept of identity domains to s390-iommu, which relies on
>> the bus_dma_region to offset identity mappings to the start of the DMA
>> aperture advertized by CLP.
>>
>> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>  drivers/iommu/s390-iommu.c | 95 +++++++++++++++++++++++++++++---------
>>  1 file changed, 72 insertions(+), 23 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> This may want to be changed to use
> 
> https://lore.kernel.org/linux-iommu/2-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com/
> 
> Later on
> 

Thanks for reviewing again.  And ACK, I will look at this for follow-on
