Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEFCC3A5A2
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 15:14:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8B62086A
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 15:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8B62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7A979CF6;
	Fri, 20 Sep 2019 15:14:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 079ABCF3
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 15:14:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8C49683A
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 15:14:43 +0000 (UTC)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x8KFEE2U022014; Fri, 20 Sep 2019 11:14:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2v4y8angeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 20 Sep 2019 11:14:37 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8KFECYs021796;
	Fri, 20 Sep 2019 11:14:36 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
	[169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2v4y8angdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 20 Sep 2019 11:14:36 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x8KFB389010798; Fri, 20 Sep 2019 15:14:35 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
	(b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma04dal.us.ibm.com with ESMTP id 2v3vbutjsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 20 Sep 2019 15:14:35 +0000
Received: from b03ledav004.gho.boulder.ibm.com
	(b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x8KFEVa758786272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 20 Sep 2019 15:14:31 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39C9078060;
	Fri, 20 Sep 2019 15:14:31 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FC877805C;
	Fri, 20 Sep 2019 15:14:29 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.141.73])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Fri, 20 Sep 2019 15:14:29 +0000 (GMT)
Subject: Re: [PATCH v4 3/4] vfio: zpci: defining the VFIO headers
To: Cornelia Huck <cohuck@redhat.com>
References: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
	<1567815231-17940-4-git-send-email-mjrosato@linux.ibm.com>
	<20190919172009.71b1c246.cohuck@redhat.com>
	<0a62aba7-578a-6875-da4d-13e8b145cf9b@linux.ibm.com>
	<20190920160258.70631905.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Openpgp: preference=signencrypt
Message-ID: <86647083-7f94-44aa-8856-103836906f36@linux.ibm.com>
Date: Fri, 20 Sep 2019 11:14:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920160258.70631905.cohuck@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-09-20_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1908290000 definitions=main-1909200142
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, walling@linux.ibm.com,
	alex.williamson@redhat.com, kvm@vger.kernel.org,
	sebott@linux.ibm.com, pmorel@linux.ibm.com,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
	pasic@linux.ibm.com, borntraeger@de.ibm.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	gerald.schaefer@de.ibm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 9/20/19 10:02 AM, Cornelia Huck wrote:
> On Thu, 19 Sep 2019 16:55:57 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> On 9/19/19 11:20 AM, Cornelia Huck wrote:
>>> On Fri,  6 Sep 2019 20:13:50 -0400
>>> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>>   
>>>> From: Pierre Morel <pmorel@linux.ibm.com>
>>>>
>>>> We define a new device region in vfio.h to be able to
>>>> get the ZPCI CLP information by reading this region from
>>>> userland.
>>>>
>>>> We create a new file, vfio_zdev.h to define the structure
>>>> of the new region we defined in vfio.h
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>> ---
>>>>  include/uapi/linux/vfio.h      |  1 +
>>>>  include/uapi/linux/vfio_zdev.h | 35 +++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 36 insertions(+)
>>>>  create mode 100644 include/uapi/linux/vfio_zdev.h
> 
>>>> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
>>>> new file mode 100644
>>>> index 0000000..55e0d6d
>>>> --- /dev/null
>>>> +++ b/include/uapi/linux/vfio_zdev.h
>>>> @@ -0,0 +1,35 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>>> +/*
>>>> + * Region definition for ZPCI devices
>>>> + *
>>>> + * Copyright IBM Corp. 2019
>>>> + *
>>>> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
>>>> + */
>>>> +
>>>> +#ifndef _VFIO_ZDEV_H_
>>>> +#define _VFIO_ZDEV_H_
>>>> +
>>>> +#include <linux/types.h>
>>>> +
>>>> +/**
>>>> + * struct vfio_region_zpci_info - ZPCI information.  
>>>
>>> Hm... probably should also get some more explanation. E.g. is that
>>> derived from a hardware structure?
>>>   
>>
>> The structure itself is not mapped 1:1 to a hardware structure, but it
>> does serve as a collection of information that was derived from other
>> hardware structures.
>>
>> "Used for passing hardware feature information about a zpci device
>> between the host and guest" ?
> 
> "zPCI specific hardware feature information for a device"?
> 
> Are we reasonably sure that this is complete for now? I'm not sure if
> expanding this structure would work; adding another should always be
> possible, though (if a bit annoying).
> 

I think trying to make the structure expandable would be best...  If we
allow arbitrary-sized reads of the info, and only add new fields onto
the end it should be OK, no? (older qemu doesn't get the info it doesn't
ask for / understand)....  But I guess that's not compatible with having
util_str[] size being defined dynamically.  Another caveat would be if
CLP_UTIL_STR_LEN were to grow in size in the future, and assuming
util_str[] was no longer at the end of the structure, I guess the
additional data would have to end up in a
util_str2[CLP_UTIL_STR_LEN_NEW-CLP_UTIL_STR_LEN_OLD]...  To explain what
I mean, something like:

struct vfio_region_zpci_info {
	<..>
	__u8 util_str[CLP_UTIL_STR_LEN_OLD];
	/* END OF V1 */
	__u8 foo;
	/* END OF V2 */
	__u8 util_str2[CLP_UTIL_STR_LEN_NEW-CLP_UTIL_STR_LEN_OLD];
	/* END OF V3 */
} __packed;


>>
>>>> + *
>>>> + */
>>>> +struct vfio_region_zpci_info {
>>>> +	__u64 dasm;
>>>> +	__u64 start_dma;
>>>> +	__u64 end_dma;
>>>> +	__u64 msi_addr;
>>>> +	__u64 flags;
>>>> +	__u16 pchid;
>>>> +	__u16 mui;
>>>> +	__u16 noi;
>>>> +	__u16 maxstbl;
>>>> +	__u8 version;
>>>> +	__u8 gid;
>>>> +#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1
>>>> +	__u8 util_str[];
>>>> +} __packed;
>>>> +
>>>> +#endif  
>>>
>>>   
>>
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
