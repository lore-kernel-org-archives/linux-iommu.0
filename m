Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA46C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 05:18:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB24660F9B
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 05:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB24660F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4025D4067C;
	Fri, 30 Jul 2021 05:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hv03gzEnhKJ; Fri, 30 Jul 2021 05:18:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1BF0140675;
	Fri, 30 Jul 2021 05:18:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC418C001A;
	Fri, 30 Jul 2021 05:18:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 036F2C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 05:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2D8183B29
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 05:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q_KIn0eCOiob for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 05:18:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F7A483B28
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 05:18:09 +0000 (UTC)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16U54E77176731; Fri, 30 Jul 2021 01:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=mRMfJDSaBEiYJwtsisL7fiThg4iCN4T1/5czZbY5axI=;
 b=FvJ6R+IRNlN3XBd8mh75U1wb7IFYE94aLjH21FjdyTNc2ng/V+THg3+abnCVvcN0ULgE
 leJjIs0OvxXLCDSh5TV45Xq91IKkKOB8vxuq9fnWD2kfHhJvZVsIfPyXKzcK8Fyg5B/Q
 cmAv66+1vp64SHxEPjxshxAuVKxUAjA+NCTeaFKOjTI5RK51A4FKFO4g1y5fjsvkelJO
 PZorV9RcMMW+Ltxf9dnoNPqdpgQbpn7CAVGYvHM98EzO4weCS03sZSLj8uQkNJv8KLa9
 zQEeGWgzS9Vjlb68N9BUcAvJbKEZEYiBK6NdL6Gb078pYx8cXHX/Vl2vj4kKzY8e+9jU Ww== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3a4abj12rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jul 2021 01:18:04 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16U5DNNP030427;
 Fri, 30 Jul 2021 05:18:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06fra.de.ibm.com with ESMTP id 3a235kjg2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jul 2021 05:18:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 16U5I0pV32702790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jul 2021 05:18:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37C3B11C05C;
 Fri, 30 Jul 2021 05:18:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 493CD11C052;
 Fri, 30 Jul 2021 05:17:58 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.3.232])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jul 2021 05:17:58 +0000 (GMT)
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [powerpc][next-20210727] Boot failure - kernel BUG at
 arch/powerpc/kernel/interrupt.c:98!
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20210729161335.GA22016@willie-the-truck>
Date: Fri, 30 Jul 2021 10:47:56 +0530
Message-Id: <3123C52D-1345-43E1-905A-FF6754E4453C@linux.vnet.ibm.com>
References: <1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com>
 <YQGVZnMe9hFieF8D@Ryzen-9-3900X.localdomain>
 <20210729161335.GA22016@willie-the-truck>
To: Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DiaWfTeMzTsWBpfNTQmvb1ps_L8keHyd
X-Proofpoint-ORIG-GUID: DiaWfTeMzTsWBpfNTQmvb1ps_L8keHyd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-30_03:2021-07-29,
 2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300030
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, Nathan Chancellor <nathan@kernel.org>,
 iommu@lists.linux-foundation.org, linux-next@vger.kernel.org,
 Claire Chang <tientzu@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> On 29-Jul-2021, at 9:43 PM, Will Deacon <will@kernel.org> wrote:
> 
> On Wed, Jul 28, 2021 at 10:35:34AM -0700, Nathan Chancellor wrote:
>> On Wed, Jul 28, 2021 at 01:31:06PM +0530, Sachin Sant wrote:
>>> next-20210723 was good. The boot failure seems to have been introduced with next-20210726.
>>> 
>>> I have attached the boot log.
>> 
>> I noticed this with OpenSUSE's ppc64le config [1] and my bisect landed on
>> commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()"). That
>> series just keeps on giving...
> 
> Yes, but look how handy our new print is!
> 
> [    0.010799] software IO TLB: tearing down default memory pool
> [    0.010805] ------------[ cut here ]------------
> [    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
> 
> Following Nick's suggestion, the diff below should help? I don't have a
> relevant box on which I can test it though.
> 

Thanks for the fix. This fixes the reported problem for me.
Tested successfully on both PowerVM LPAR as well as bare metal environment.

Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

> Will
> 
> --->8
> 
> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index 1d829e257996..87f001b4c4e4 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -63,6 +63,9 @@ void __init svm_swiotlb_init(void)
> 
> int set_memory_encrypted(unsigned long addr, int numpages)
> {
> +       if (!mem_encrypt_active())
> +               return 0;
> +
>        if (!PAGE_ALIGNED(addr))
>                return -EINVAL;
> 
> @@ -73,6 +76,9 @@ int set_memory_encrypted(unsigned long addr, int numpages)
> 
> int set_memory_decrypted(unsigned long addr, int numpages)
> {
> +       if (!mem_encrypt_active())
> +               return 0;
> +
>        if (!PAGE_ALIGNED(addr))
>                return -EINVAL;
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
