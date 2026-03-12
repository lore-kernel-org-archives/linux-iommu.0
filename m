Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B138C2C2
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773292423; cv=none; b=uWptL2PIekEDGs0/QOrOlj+IIk2QyM1gQP4AQiRpKcNGZQsLzN/gKael0j5ZXLZfM6EOQR0yz8srCBveLWBE99XKN33MukVWHhasMGvfZxNuIIAZorEOOMcVi6gdfonQUVqRcx/uNWuMLq0pmSJ/Zlb9kajAl8Gw1BdWfzQk2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773292423; c=relaxed/simple;
	bh=ulOtfrRuKwOumKd3yHGCGZecNe3X7K5gURm2ZrnR0Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZHCQy09CD56iCdGZ4ehcQ505RsMMIxZKZ3JKms47D6bJGn/k0y3s3aHRy2asEsCRQ/c83lg3jyDoOGB3jUTmTNXOdP2OifvxVBgJvzxjSY8pZRh2iY5Vt8dIFLFLt80Ch9nqk0fou7OYiI1vCaqfdxH/2Ew3VakrJV4DxsjYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l7bg1NTL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7bg1NTL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWCXZ2279049;
	Thu, 12 Mar 2026 05:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dU+Dfu
	a6xrDvIyS/JfSm0GqfUTXQd6pQIGc/hC3ltQQ=; b=l7bg1NTLtyObCqSJTHyrS0
	Vd0QCbZ9TwmoJj9vtt1wEyItzFBXNhsE0XcbDIoCxTsDlmzG9TW3GP1+MyDkgjgt
	BFjxh25RG1U+UUKiIiOiviqqZaaxmW4eFVeWwyxYUPa35XS3VehohHtRc4NBDyno
	7qLgSOqixrHjNsCJb06ps2P8KQGy/mx88aEsxzHXfLyJWJEyjHieKPoUe/LGcuWH
	iS9Em9iKav25p3/ZpAnXboVqsj/UncKB12/1SLHqrMw5CxteQetnU5u2Lmtd1ogV
	svKuHzwsXXUXwl64oJX8tYDFGS1mAksEBmcFJ9AnzChSrskueztts2LGXvf5C+hw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91h34f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 05:13:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C4PluF025686;
	Thu, 12 Mar 2026 05:13:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha891dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 05:13:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62C5DZok31720162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 05:13:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 093135805C;
	Thu, 12 Mar 2026 05:13:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AC7158051;
	Thu, 12 Mar 2026 05:13:30 +0000 (GMT)
Received: from [9.43.77.98] (unknown [9.43.77.98])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 05:13:30 +0000 (GMT)
Message-ID: <086c2248-1956-4c52-a200-77eb75371d30@linux.ibm.com>
Date: Thu, 12 Mar 2026 10:43:28 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report]: iommu WARNING is observed on powerpc system during
 pci enumeration at boot up
To: Nicolin Chen <nicolinc@nvidia.com>, Nilay Shroff <nilay@linux.ibm.com>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, joerg.roedel@amd.com,
        jgg@nvidia.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
        sbhat@linux.ibm.com
References: <d5c834ff-4c95-44dd-8bef-57242d63aeee@linux.ibm.com>
 <aa8WDIhPyPU45VKB@Asurada-Nvidia>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <aa8WDIhPyPU45VKB@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9Fl9waEt0gvh8AfhfSzwftcrIh-BWwf8
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b24b82 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=voM4FWlXAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=dHd97Ep_pg48WIL5FZIA:9 a=QEXdDO2ut3YA:10
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAzNyBTYWx0ZWRfX1ZifoD+wPFAY
 QcsFMCRmfnd+1at1xE+5CcPVU4jOLLnGQiI0tcrrt+qWtO1XsV2KchUsDSfUpIPVZr6oJYOrV4h
 Wik3HxnPIBzlRw3mMKhZSRX8VwLB4eKfKhtrQ2rRE/NlFiipJVIBP2FK3HiYavdvqXYdMLqcFKl
 6IfIRqLWivuMFZC210hIrDIdMyqxPQpXIB4MM9b0Yih6QFo2jvktnD7k1naB01/GuMyCoF57SyO
 O9V00dStvuVkobJNcU6v7ZowXxOj/ZvLt0ctMlVXuKoJCehLFLX9mnvucmQBF7c3lbYDigXMNY+
 P8N/6LQ6CqAeznzX9dTpIUTP88AnF4tqLheUhLZ3Z+4qYiJGpSgRO7J4/9BRw1O0WW0Q/tupyBb
 zhwFPL1BoclLnIPZbgs8wjiMN4HY+c8nJcX9v6jWF/nEBa2QEUI7l6NzWETtJyMQbMYE088u38V
 aaSiAnShCHdIAEjTLlQ==
X-Proofpoint-ORIG-GUID: 9Fl9waEt0gvh8AfhfSzwftcrIh-BWwf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120037


On 3/10/26 12:18 AM, Nicolin Chen wrote:
> On Mon, Mar 09, 2026 at 11:27:42PM +0530, Nilay Shroff wrote:
>> Looking at the warning it seems that this is a regression caused due to
>> commit a75b2be249d6 ("iommu: Add iommu_driver_get_domain_for_dev() helper").
>>
>> Any help from the iommu expert would be appreciated. Though I am not expert,
>> it seems the following patch help fix this warning (I encourage the iommu
>> developers to confirm and/or take this forward) :
>>
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 0ce71310b7d9..d122e8447831 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -1159,7 +1159,7 @@ spapr_tce_platform_iommu_attach_dev(struct iommu_domain *platform_domain,
>>                                      struct device *dev,
>>                                      struct iommu_domain *old)
>>   {
>> -       struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +       struct iommu_domain *domain = iommu_driver_get_domain_for_dev(dev);
>>          struct iommu_table_group *table_group;
>>          struct iommu_group *grp;
>>
>>
>> Please let me know if any further information is needed.
> Yea, that should be the fix.
>
> Please submit a "PATCH rc" with:
Will pull this for my upcoming RC PR
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260310082129.3630996-1-nilay@linux.ibm.com/

Maddy
> Fixes: a75b2be249d6 ("iommu: Add iommu_driver_get_domain_for_dev() helper")
> Cc: stable@vger.kernel.org
>
> Thanks!
> Nicolin
