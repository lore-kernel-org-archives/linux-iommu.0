Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0601C7618F
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 19:47:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDF821849
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 19:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDF821849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 68F9D1C8E;
	Thu, 18 Jul 2019 19:47:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 89FB11C78
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 19:47:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 37669891
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 19:47:26 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x6IJiKjF003629
	for <iommu@lists.linux-foundation.org>; Thu, 18 Jul 2019 15:47:24 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ttvv3dmgm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Thu, 18 Jul 2019 15:47:24 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <bauerman@linux.ibm.com>;
	Thu, 18 Jul 2019 20:47:23 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
	by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 18 Jul 2019 20:47:18 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x6IJlHl035455434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 18 Jul 2019 19:47:17 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35C1EAE064;
	Thu, 18 Jul 2019 19:47:17 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8940AE05C;
	Thu, 18 Jul 2019 19:47:13 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.186.82])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Jul 2019 19:47:13 +0000 (GMT)
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
	<20190712053631.9814-3-bauerman@linux.ibm.com>
	<alpine.DEB.2.21.1907121806160.1788@nanos.tec.linutronix.de>
User-agent: mu4e 1.2.0; emacs 26.2
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] DMA mapping: Move SME handling to x86-specific files
In-reply-to: <alpine.DEB.2.21.1907121806160.1788@nanos.tec.linutronix.de>
Date: Thu, 18 Jul 2019 16:47:09 -0300
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19071819-2213-0000-0000-000003B2DB12
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011453; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000287; SDB=6.01234063; UDB=6.00650301;
	IPR=6.01015390; 
	MB=3.00027784; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-18 19:47:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071819-2214-0000-0000-00005F4C56EA
Message-Id: <878ssv3z2a.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-18_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1907180202
Cc: linux-s390@vger.kernel.org, Mike Anderson <andmike@linux.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Christoph Hellwig <hch@lst.de>
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


Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, 12 Jul 2019, Thiago Jung Bauermann wrote:
>> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
>> index b310a9c18113..f2e399fb626b 100644
>> --- a/include/linux/mem_encrypt.h
>> +++ b/include/linux/mem_encrypt.h
>> @@ -21,23 +21,11 @@
>>  
>>  #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
>>  
>> -#define sme_me_mask	0ULL
>> -
>> -static inline bool sme_active(void) { return false; }
>>  static inline bool sev_active(void) { return false; }
>
> You want to move out sev_active as well, the only relevant thing is
> mem_encrypt_active(). Everything SME/SEV is an architecture detail.

I'm sure you saw it. I addressed sev_active in a separate patch.

Thanks for reviewing this series!

>> +static inline bool mem_encrypt_active(void) { return false; }
>
> Thanks,
>
> 	tglx


-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
