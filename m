Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4387C
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 19:51:01 +0000 (UTC)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IYSeV028868;
	Wed, 6 Jul 2022 18:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=V/RKn4cwO8Jde9mbP6eJbdj72qAcC8xBRDOOWhNiMSQ=;
 b=pUw4L9rTo/LcMp9rbfH5fVTlVoZPIp2IpjUUFCXGswZVBnMVRknIQWCdfywOivE7pwU/
 amOiqGfhXKw53yx3Xc+dIp6/NP7oHWKsbNUeiaog+z2orlR0oBcl7EaKxtFNHe+/C1CM
 cL33+GW86PUOpuIX8JmVtR9AnblimvI0TEaXupudK67nNhwqG/7RocOXX123ITXehd3A
 vIXzfs+DP/asTrOpSRMXWY9l4Te9pqbEk1Ph1vQJyuat0Ynxm8mrpE7csbXme3VhP7Wg
 ZM2GjUQ2CrK5zvQrRP6JctuvGNjjLI8nO6GdmAN4CfmbUKxhhMwnVZT8xml8dbyXJYMR Ug== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3h5fst04wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Jul 2022 18:55:15 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id B307B80022C;
	Wed,  6 Jul 2022 18:55:13 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id CF5F2809A09;
	Wed,  6 Jul 2022 18:55:11 +0000 (UTC)
Date: Wed, 6 Jul 2022 13:55:10 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
        Kevin Tian <kevin.tian@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] iommu/vt-d: Reset DMAR_UNITS_SUPPORTED
Message-ID: <YsXajixg7mN8PLtX@swahl-home.5wahls.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
X-Proofpoint-GUID: 7ym3B4n5N3oaqW6wr62eHBRkqpjXsZps
X-Proofpoint-ORIG-GUID: 7ym3B4n5N3oaqW6wr62eHBRkqpjXsZps
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_11,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 mlxlogscore=773 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060073

On Sat, Jun 25, 2022 at 08:51:58PM +0800, Lu Baolu wrote:
> Hi folks,
> 
> This is a follow-up series of changes proposed by this patch:
> 
> https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/
> 
> It removes several static arrays of size DMAR_UNITS_SUPPORTED and sets
> the DMAR_UNITS_SUPPORTED to 1024.
> 

After Kevin Tian's comments, for the whole series:

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise
