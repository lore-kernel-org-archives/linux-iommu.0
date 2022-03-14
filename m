Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699A7C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 19:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AC2A409A2;
	Mon, 14 Mar 2022 19:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m2HSjR2EGtuq; Mon, 14 Mar 2022 19:52:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C67E740894;
	Mon, 14 Mar 2022 19:52:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89917C001D;
	Mon, 14 Mar 2022 19:52:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05E39C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E03D16058D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sg33cVg_8v5T for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 19:52:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92C6B60C03
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:52:50 +0000 (UTC)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EJlVow009230; 
 Mon, 14 Mar 2022 19:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Nz145SLyNi28nDypmA/G+HJQLmQB+0wmYqr6hIhwoeo=;
 b=Xl6RztJu3Wk/XCcQ9rhrBfHBcvmqiy4Txi/m07WzBWDFp4/Q4klXql9AxKZf+4cdw0v+
 gzsB6DpqGCNPmmOtoR5MfqD8wHtqHsXqMUP8O68pq0gh6ClXPIHVJ4JwoWN5/onN2F3G
 zdscp8TsabO9vPRZ8ZYbwibj6YuQBSvsnYwif4GYS13jexouscyAJB/YBrjvaqJURvVO
 Usx3zOJoPm0e7gG/mtEqZmvM2wpnkTdaNAwTPgkNFLR8i2OiJkx1IpOF/LPJkQkWi4aU
 E/RkK2PsXPERG4ZWUzxVoi/H36SCNJQSyUaA8QkungXdE0Rut5xFXeNqVfrSq3OjhBSW FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6mer52x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:52:45 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJlocI010076;
 Mon, 14 Mar 2022 19:52:44 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6mer52m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:52:44 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJl9Jg010220;
 Mon, 14 Mar 2022 19:52:43 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma05wdc.us.ibm.com with ESMTP id 3erk59rb4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:52:43 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22EJqfYf28443130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 19:52:41 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B87A46E053;
 Mon, 14 Mar 2022 19:52:41 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0CA76E050;
 Mon, 14 Mar 2022 19:52:38 +0000 (GMT)
Received: from [9.211.32.184] (unknown [9.211.32.184])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 14 Mar 2022 19:52:38 +0000 (GMT)
Message-ID: <681190b6-487f-ca4a-ba67-0ade2b20501b@linux.ibm.com>
Date: Mon, 14 Mar 2022 15:52:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 00/32] KVM: s390: enable zPCI for interpretive execution
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 21ijjdY1juiR5jFmwFjvzgJY7ymU_E62
X-Proofpoint-ORIG-GUID: _BV1xKNxlXflt-dk1w49L0lWqpgQQT-R
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=593 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140116
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 linux-kernel@vger.kernel.org, vneethv@linux.ibm.com, agordeev@linux.ibm.com,
 imbrenda@linux.ibm.com, will@kernel.org, frankja@linux.ibm.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, pasic@linux.ibm.com, jgg@nvidia.com,
 gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 gor@linux.ibm.com, schnelle@linux.ibm.com, hca@linux.ibm.com,
 alex.williamson@redhat.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
 cohuck@redhat.com, oberpar@linux.ibm.com, iommu@lists.linux-foundation.org,
 svens@linux.ibm.com, pbonzini@redhat.com
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

On 3/14/22 3:44 PM, Matthew Rosato wrote:
> Note: A few patches in this series are dependent on Baolu's IOMMU domain ops
> split, which is currently in the next branch of linux-iommu. This series
> applies on top:
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> 
> Enable interpretive execution of zPCI instructions + adapter interruption
> forwarding for s390x KVM vfio-pci.  This is done by introducing a new IOMMU
> domain for s390x (KVM-managed), indicating via vfio that this IOMMU domain
> should be used instead of the default, with subsequent management of the
> hardware assists being handled via a new KVM ioctl for zPCI management.
> 
> By allowing intepretation of zPCI instructions and firmware delivery of
> interrupts to guests, we can significantly reduce the frequency of guest
> SIE exits for zPCI.  We then see additional gains by handling a hot-path
> instruction that can still intercept to the hypervisor (RPCIT) directly
> in kvm via the new IOMMU domain, whose map operations update the host
> DMA table with pinned guest entries over the specified range.
> 
>  From the perspective of guest configuration, you passthrough zPCI devices
> in the same manner as before, with intepretation support being used by
> default if available in kernel+qemu.
> 
> Will reply with a link to the associated QEMU series.

QEMU series:
https://lore.kernel.org/kvm/20220314194920.58888-1-mjrosato@linux.ibm.com/

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
