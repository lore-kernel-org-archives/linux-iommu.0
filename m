Return-Path: <SRS0=Jh8h=VQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36C1C7618F
	for <iommu@archiver.kernel.org>; Fri, 19 Jul 2019 15:46:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD25021872
	for <iommu@archiver.kernel.org>; Fri, 19 Jul 2019 15:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD25021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 82C202854;
	Fri, 19 Jul 2019 15:46:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4F9752850
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Jul 2019 15:46:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CDB6F8B1
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Jul 2019 15:46:03 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x6JFgwF0010077
	for <iommu@lists.linux-foundation.org>; Fri, 19 Jul 2019 11:46:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2tugh38n31-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Fri, 19 Jul 2019 11:46:02 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <bauerman@linux.ibm.com>;
	Fri, 19 Jul 2019 16:46:01 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
	by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 19 Jul 2019 16:45:57 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
	[9.57.199.111])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x6JFjuRL50725240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 19 Jul 2019 15:45:56 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12A23AC059;
	Fri, 19 Jul 2019 15:45:56 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF03DAC05B;
	Fri, 19 Jul 2019 15:45:52 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.190.209])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jul 2019 15:45:52 +0000 (GMT)
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
	<680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com>
	<87a7db3z68.fsf@morokweng.localdomain>
	<879a196a-1d92-931d-88f4-6ce17a09cf20@amd.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: "Lendacky\, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v3 0/6] Remove x86-specific code from generic headers
In-reply-to: <879a196a-1d92-931d-88f4-6ce17a09cf20@amd.com>
Date: Fri, 19 Jul 2019 12:45:47 -0300
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19071915-0052-0000-0000-000003E33307
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011457; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000287; SDB=6.01234458; UDB=6.00650541;
	IPR=6.01015790; 
	MB=3.00027801; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-19 15:46:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071915-0053-0000-0000-000061C30B65
Message-Id: <87imrygh90.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-19_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1907190171
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Mike Anderson <andmike@linux.ibm.com>, Konrad
	Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"x86@kernel.org" <x86@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Ingo
	Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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


Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:

> On 7/18/19 2:44 PM, Thiago Jung Bauermann wrote:
>> 
>> Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:
>> 
>>> On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
>>>> Hello,
>>>>
>>>> This version is mostly about splitting up patch 2/3 into three separate
>>>> patches, as suggested by Christoph Hellwig. Two other changes are a fix in
>>>> patch 1 which wasn't selecting ARCH_HAS_MEM_ENCRYPT for s390 spotted by
>>>> Janani and removal of sme_active and sev_active symbol exports as suggested
>>>> by Christoph Hellwig.
>>>>
>>>> These patches are applied on top of today's dma-mapping/for-next.
>>>>
>>>> I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
>>>> been build tested.
>>>
>>> I'll try and get this tested quickly to be sure everything works for SME
>>> and SEV.
>
> Built and tested both SME and SEV and everything appears to be working
> well (not extensive testing, but should be good enough).

Great news. Thanks for testing!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
