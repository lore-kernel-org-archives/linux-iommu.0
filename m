Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53048C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 14:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F42C842C5;
	Tue, 15 Mar 2022 14:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jIa31zyvS6b; Tue, 15 Mar 2022 14:39:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D088081D7C;
	Tue, 15 Mar 2022 14:39:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E399C001A;
	Tue, 15 Mar 2022 14:39:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F7F7C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30B5C415FB
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QPmGY_wwCcMp for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 14:39:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80CA8403B8
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:39:42 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FETpll009276; 
 Tue, 15 Mar 2022 14:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HdrkUfe0/D5SVxX5k6mR556dpi7SYCIMHcWQB9GIKlo=;
 b=LbVoALjtgafgTI2BCQh6qHaf5siFetQrAIcatQeEdVxURph/o4sVEXrKHMx2c/8k3wrN
 EcbkMI6LjsH0SDP0gXkZb8Eizem2c5wugXoQjFuXP9dXKrDoHfIvmFk6m8eBtY7oUqPH
 1BfcQX9SS3i+K4bq6BCrde3+gtVMlZzGJLgdRV3sP8OP27KnHTsO84CpDigcQ827TfnE
 oqNRYDUI1VoOkj49rwl0X5g7BugVszAZ5jnEdDJh0q/MmOssk/bZUEOjWJbhXLmDAOET
 odCf/R2LpJprCYcxnXbe4rTc5xAFgB9qkKY7mbu0yBAhuwxVqw7GIB9i3Pda/Tu8lPh+ wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3etujssxng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 14:39:38 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22FEU8u7011563;
 Tue, 15 Mar 2022 14:39:37 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3etujssxn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 14:39:37 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FEdD3G010354;
 Tue, 15 Mar 2022 14:39:36 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04dal.us.ibm.com with ESMTP id 3erk59kb6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 14:39:36 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22FEdYfe12386602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Mar 2022 14:39:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3486EAC062;
 Tue, 15 Mar 2022 14:39:34 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2C1BAC060;
 Tue, 15 Mar 2022 14:39:19 +0000 (GMT)
Received: from [9.211.32.184] (unknown [9.211.32.184])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 15 Mar 2022 14:39:19 +0000 (GMT)
Message-ID: <35ccdbb0-eb21-0c25-638e-4d46fb12e7a9@linux.ibm.com>
Date: Tue, 15 Mar 2022 10:39:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 29/32] vfio-pci/zdev: add DTSM to clp group capability
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-30-mjrosato@linux.ibm.com>
 <20220314214928.GK11336@nvidia.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20220314214928.GK11336@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MRRtZXdh7x6rRNvT7Mp08XCMaAMnd3Gt
X-Proofpoint-ORIG-GUID: 5j6xI5tjpbzLXiLdvUu1mhlI6rdOOOoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=966 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150094
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

On 3/14/22 5:49 PM, Jason Gunthorpe wrote:
> On Mon, Mar 14, 2022 at 03:44:48PM -0400, Matthew Rosato wrote:
>> The DTSM, or designation type supported mask, indicates what IOAT formats
>> are available to the guest.  For an interpreted device, userspace will not
>> know what format(s) the IOAT assist supports, so pass it via the
>> capability chain.  Since the value belongs to the Query PCI Function Group
>> clp, let's extend the existing capability with a new version.
> 
> Why is this on the VFIO device?

Current vfio_pci_zdev support adds a series of capability chains to the 
VFIO_DEVICE_GET_INFO ioctl.  These capability chains are all related to 
output values associated with what are basically s390x query instructions.

The capability chain being modified by this patch is used to populate a 
response to the 'query this zPCI group' instruction.

> 
> Maybe I don't quite understand it right, but the IOAT is the
> 'userspace page table'?

IOAT = I/O Address Translation tables;  the head of which is called the 
IOTA (translation anchor).  But yes, this would generally refer to the 
guest DMA tables.

Specifically here we are only talking about the DTSM which is the 
formats that the guest is allowed to use for their address translation 
tables, because the hardware (or in our case the intermediary kvm iommu) 
can only operate on certain formats.

> 
> That is something that should be modeled as a nested iommu domain.
> 
> Querying the formats and any control logic for this should be on the
> iommu side not built into VFIO.

I agree that the DTSM is really controlled by what the IOMMU domain can 
support (e.g. what guest table formats it can actually operate on) and 
so the DTSM value should come from there vs out of KVM; but is there 
harm in including the query response data here along with the rest of 
the response information for 'query this zPCI group'?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
