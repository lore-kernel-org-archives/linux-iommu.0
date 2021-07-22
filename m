Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15B3C19F2F
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 20:09:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEC460EB5
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 20:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CEC460EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FE1B404A1;
	Thu, 22 Jul 2021 20:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qd0ShsOzzXI3; Thu, 22 Jul 2021 20:09:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CF3E84041E;
	Thu, 22 Jul 2021 20:09:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0747C0010;
	Thu, 22 Jul 2021 20:09:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BECFC000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 20:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 491D3400CE
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 20:09:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id koB4Xxn318a9 for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 20:09:36 +0000 (UTC)
X-Greylist: delayed 00:46:28 by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 564DF4002B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 20:09:36 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16MJ300w186773; Thu, 22 Jul 2021 15:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Op/Bo1AO/LTdxBBrkjvePPmN6XyZKah3LgizjT4Ell4=;
 b=M8SJjOSzeg+gec1EhqvUJgmpfTDaDue6qpK52ivLGMGBOIyMTpqePqOuHgB2hiW3mfTy
 zf3jx8DdE+4+b5qmoTsNEpc22afQh3rDAsZNA8N4m2h0mMFOWzbqDPTdqtVX7kjtqK1I
 4C/ibnwvYX5m70VWNyF4/o5Ncn5b3mF93eB7wv+S9iaCLcrNUMOb3JH8Cxgghk2pyCZs
 Q3lV8Q1jbUjqgtk/GP0Ng+5bH/OiBJbCk2WSpXk8WgpX9toy5wquerXK0J3gJ3gBA/+l
 s6Nrw3KnY7+Xnz6GYUK4PNV/b3fo86Vyn0MPTed8F4CQij/+Hibpzq+yMXwzOXl6ty8a Pg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 39ycy9v6mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jul 2021 15:23:03 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16MJDCST021516;
 Thu, 22 Jul 2021 19:23:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04ams.nl.ibm.com with ESMTP id 39xhx48tr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jul 2021 19:23:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 16MJKU5u33947950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jul 2021 19:20:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B6B0AE045;
 Thu, 22 Jul 2021 19:22:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C99DAE053;
 Thu, 22 Jul 2021 19:22:59 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.166.24])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 22 Jul 2021 19:22:58 +0000 (GMT)
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
To: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20210720133826.9075-1-will@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
Date: Thu, 22 Jul 2021 21:22:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210720133826.9075-1-will@kernel.org>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RmyVFFKxtFiVcNLrl6GSKmkPY-rhkY0N
X-Proofpoint-ORIG-GUID: RmyVFFKxtFiVcNLrl6GSKmkPY-rhkY0N
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-22_09:2021-07-22,
 2021-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107220125
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

On 20.07.21 15:38, Will Deacon wrote:
> Hi again, folks,
> 
> This is version two of the patch series I posted yesterday:
> 
>    https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
> 
> The only changes since v1 are:
> 
>    * Squash patches 2 and 3, amending the commit message accordingly
>    * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
> 
> I'd usually leave it a bit longer between postings, but since this fixes
> issues with patches in -next I thought I'd spin a new version immediately.
> 
> Cheers,

FWIW, I just bisected virtio-errors with secure execution mode
qemu-system-s390x: virtio-serial-bus: Unexpected port id 4205794771 for device virtio-serial0.0

to
commit 903cd0f315fe426c6a64c54ed389de0becb663dc
Author: Claire Chang <tientzu@chromium.org>
Date:   Thu Jun 24 23:55:20 2021 +0800

      swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing

Unfortunately this patch series does NOT fix this issue, so it seems that even more
things are broken.

Any idea what else might be broken?
Shall we rather revert these patches from next until we have things under control?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
