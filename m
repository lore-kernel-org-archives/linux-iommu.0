Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21112C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 18:27:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17AC206A3
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 18:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZdtWjBrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17AC206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2536315DA;
	Wed, 24 Apr 2019 18:27:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0D12515D5
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 18:27:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A5238786
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 18:27:50 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3OINpqI077256; Wed, 24 Apr 2019 18:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=KBSDR6RWqPya7xUYiX+Qhe6fX2wumsafyUnxOMhrzC8=;
	b=ZdtWjBrWW1T1ii/DKxZ92QlWm+mSqiTHgpxDBM91XdHa4rPjH1vesiMI2s20vAhnWHO+
	m7ke8mXaBE2sczCRIpO0/782RMjEJOSIi0OP6G+iBBYITlVDk0Vtfic0hxP401bdEC3Z
	0FQ8l50cgDTSn4ZcG7DowoBAHz+eC95ATgyn+zjBBun5ZNw2WGnrHb5wfp8aYlSaTqhC
	9+V3nBQnRg19wODlXpxUBFsk5UMCwIAYv2pMMoSu9j6CG2Fzhj73Vc/yvysGM1X/M+93
	3ZLjXPTwOPnk4qIay1opZDaFRVt4PE8NaxUZlzoncnMwcSqZKnLPUcViy7n5Nu/r3yUQ
	tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2rytut44ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2019 18:27:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3OIQTAf076377; Wed, 24 Apr 2019 18:27:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2s0fv3qjgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2019 18:27:29 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3OIRRcv004972;
	Wed, 24 Apr 2019 18:27:27 GMT
Received: from char.us.oracle.com (/10.152.32.25)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 24 Apr 2019 11:27:27 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
	id C0D466A00FB; Wed, 24 Apr 2019 14:27:30 -0400 (EDT)
Date: Wed, 24 Apr 2019 14:27:30 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 08/10] iommu/vt-d: Check whether device requires
	bounce buffer
Message-ID: <20190424182730.GA17505@char.us.oracle.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
	<20190421011719.14909-9-baolu.lu@linux.intel.com>
	<20190422164755.GC31181@lst.de>
	<76e35340-32c3-ee0d-5232-bd8800248402@linux.intel.com>
	<20190423060858.GA12762@lst.de>
	<e11489cf-87cc-a956-7c6c-ffdd26a4e3ec@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e11489cf-87cc-a956-7c6c-ffdd26a4e3ec@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=927
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904240133
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=950
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904240133
Cc: kevin.tian@intel.com, mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	alan.cox@intel.com, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	pengfei.xu@intel.com, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424182730.VCD9cicTxAvyVDMxoXGoTtVuQxnaAixADlzInMuqgEY@z>

On Tue, Apr 23, 2019 at 03:35:51PM +0800, Lu Baolu wrote:
> Hi,
> 
> On 4/23/19 2:08 PM, Christoph Hellwig wrote:
> > > > Again, this and the option should not be in a specific iommu driver.
> > > > 
> > > 
> > > The option of whether bounce is ignored should be in the specific iommu
> > > driver.
> > 
> > Why?  As a user I could not care less which IOMMU driver my particular
> > system uses.
> > 
> 
> Looks reasonable to me. Let's listen to more opinions.

I agree with Christoph here.
> 
> Best regards,
> Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
