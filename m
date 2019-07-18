Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F2C76195
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 13:01:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D576C2173E
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 13:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D576C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8CAF9E57;
	Thu, 18 Jul 2019 13:01:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 211BFD88
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 13:01:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 93FF38DC
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 13:01:34 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x6ICvbKb059772
	for <iommu@lists.linux-foundation.org>; Thu, 18 Jul 2019 09:01:33 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2tts6hg8gp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Thu, 18 Jul 2019 09:01:33 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pasic@linux.ibm.com>;
	Thu, 18 Jul 2019 14:01:31 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 18 Jul 2019 14:01:26 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
	[9.149.105.61])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x6ID1O1I46399696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 18 Jul 2019 13:01:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3CC511C04C;
	Thu, 18 Jul 2019 13:01:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B18911C04A;
	Thu, 18 Jul 2019 13:01:24 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.219])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2019 13:01:24 +0000 (GMT)
Date: Thu, 18 Jul 2019 15:01:23 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 6/6] s390/mm: Remove sev_active() function
In-Reply-To: <20190718084456.GE24562@lst.de>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
	<20190718032858.28744-7-bauerman@linux.ibm.com>
	<20190718084456.GE24562@lst.de>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19071813-0028-0000-0000-00000385B410
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071813-0029-0000-0000-00002445DDD0
Message-Id: <20190718150123.4230a00c.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-18_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=986 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1907180135
Cc: linux-s390@vger.kernel.org, Mike Anderson <andmike@linux.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Alexey Dobriyan <adobriyan@gmail.com>
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

On Thu, 18 Jul 2019 10:44:56 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > -/* are we a protected virtualization guest? */
> > -bool sev_active(void)
> > -{
> > -	return is_prot_virt_guest();
> > -}
> > -
> >  bool force_dma_unencrypted(struct device *dev)
> >  {
> > -	return sev_active();
> > +	return is_prot_virt_guest();
> >  }
> 
> Do we want to keep the comment for force_dma_unencrypted?

Yes we do. With the comment transferred:

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
