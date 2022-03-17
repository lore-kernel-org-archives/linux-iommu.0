Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBB5C433F5
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 18:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0CB6D40497;
	Thu, 17 Mar 2022 18:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0_pqgIcGqFfE; Thu, 17 Mar 2022 18:52:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E3AE402A8;
	Thu, 17 Mar 2022 18:52:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51600C0012;
	Thu, 17 Mar 2022 18:52:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B321C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 18:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63F6A418BF
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 18:52:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2wOLsgBcQgzp for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 18:52:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6081416B7
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 18:52:20 +0000 (UTC)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HGA5i9001293; 
 Thu, 17 Mar 2022 18:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AQwtyhv7u4jjFpfrN5RAEteV2hqGptEPoejBb+YABXE=;
 b=rgUPGTIEIbdE4SFQusnyo0PLGn5H5QdjWIq+wdTNqYnVxKxoS/Fyw1wz4DKaUrCgHPbV
 4NJQlezP1RokvPtYLAT1n7SDet4P1x5+UQ9fcN0XjUbEeARReVtWNLojBgA1EJoUo8ML
 PL1yqaC+FVuc9hnJ6r4KAUuDdPyNpzbTMkyK4doFIjnyDJ2eOE25SkMcQpjfr4C4IPuq
 gEQyELT1susg4Cw76LfqRVKni9RUeFJAGhM2Ohla0CIXuLLfm6cjhShufl34cYKKqhVp
 p9fjvf4ICvxH1Znuu4JUh0cXiIpxwa5ouw2qA+IjNgtlJkI1Y7dxjLXlWbBMq+Mhuyy2 eA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3ev1vq3peq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Mar 2022 18:52:15 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22HIHWe4020959;
 Thu, 17 Mar 2022 18:52:15 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3ev1vq3peb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Mar 2022 18:52:15 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HIltAc002410;
 Thu, 17 Mar 2022 18:52:13 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04wdc.us.ibm.com with ESMTP id 3erk5a59u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Mar 2022 18:52:13 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22HIqCAc24903946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Mar 2022 18:52:12 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFFAC6A054;
 Thu, 17 Mar 2022 18:52:11 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9285C6A05D;
 Thu, 17 Mar 2022 18:52:09 +0000 (GMT)
Received: from [9.211.32.184] (unknown [9.211.32.184])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 17 Mar 2022 18:52:09 +0000 (GMT)
Message-ID: <494fe1b2-cf44-23a6-a494-52a44041ad79@linux.ibm.com>
Date: Thu, 17 Mar 2022 14:51:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 15/32] vfio: introduce KVM-owned IOMMU type
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-16-mjrosato@linux.ibm.com>
 <20220314213808.GI11336@nvidia.com>
 <decc5320-eb3e-af25-fd2b-77fabe56a897@linux.ibm.com>
 <20220315143858.GY11336@nvidia.com>
 <5a1c64ac-df10-fb66-ad6d-39adf786f32b@linux.ibm.com>
 <20220315172555.GJ11336@nvidia.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20220315172555.GJ11336@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kuQpxA9M7txDOpig1s9KywXmLwC1zk1i
X-Proofpoint-ORIG-GUID: mz6xbnGtBK1Vtsvhdc1q5_yO2bxU49u5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_07,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203170104
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 linux-kernel@vger.kernel.org, vneethv@linux.ibm.com, agordeev@linux.ibm.com,
 imbrenda@linux.ibm.com, will@kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 pasic@linux.ibm.com, gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, gor@linux.ibm.com, schnelle@linux.ibm.com,
 hca@linux.ibm.com, alex.williamson@redhat.com, freude@linux.ibm.com,
 pmorel@linux.ibm.com, cohuck@redhat.com, oberpar@linux.ibm.com,
 iommu@lists.linux-foundation.org, svens@linux.ibm.com, pbonzini@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 3/15/22 1:25 PM, Jason Gunthorpe wrote:
> On Tue, Mar 15, 2022 at 12:29:02PM -0400, Matthew Rosato wrote:
>> On 3/15/22 10:38 AM, Jason Gunthorpe wrote:
>>> On Tue, Mar 15, 2022 at 09:49:01AM -0400, Matthew Rosato wrote:
>>>
>>>> The rationale for splitting steps 1 and 2 are that VFIO_SET_IOMMU doesn't
>>>> have a mechanism for specifying more than the type as an arg, no?  Otherwise
>>>> yes, you could specify a kvm fd at this point and it would have some other
>>>> advantages (e.g. skip notifier).  But we still can't use the IOMMU for
>>>> mapping until step 3.
>>>
>>> Stuff like this is why I'd be much happier if this could join our
>>> iommfd project so we can have clean modeling of the multiple iommu_domains.
>>>
>>
>> I'd certainly be willing to collaborate so feel free to loop me in on the
>> discussions;
> 
> Sure, I have you on my list. I've been waiting for Eric to get a bit
> further along on his ARM work so you have something appropriate to
> look at.
> 
> In the mean time you can certainly work out the driver details as
> you've been doing here and hacking through VFIO. The iommu_domain
> logic is the big work item in this series, not the integration with
> the uAPI.
>

A subset of this series (enabling some s390x firmware-assist facilities) 
is not tied to the iommu and would still provide value while continuing 
to use vfio_iommu_type1 for all mapping -- so I think I'll look into a 
next version that shrinks down to that subset (+ re-visit the setup API).

Separate from that, I will continue looking at implementing the nested 
iommu_domain logic for s390, and continue to hack through VFIO for now. 
I'll use an RFC series when I have something more to look at, likely 
starting with the fully-pinned guest as you suggest; ultimately I'm 
interested in both scenarios (pinned kvm guest & dynamic pinning during 
shadow)

Thanks,
Matt
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
