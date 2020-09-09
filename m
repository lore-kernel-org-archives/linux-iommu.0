Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F53C433E2
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 20:24:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777D721D7D
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 20:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BLGPrA5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777D721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B4388754C;
	Wed,  9 Sep 2020 20:24:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FNUO8vh2CoM0; Wed,  9 Sep 2020 20:24:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9304187532;
	Wed,  9 Sep 2020 20:24:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84843C0052;
	Wed,  9 Sep 2020 20:24:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4C77C0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 20:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A1EF686FE8
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 20:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XifrS04BngK7 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 20:24:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 90BF086FD9
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 20:24:07 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089KO0bS120929;
 Wed, 9 Sep 2020 20:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fuLAuhbpfmFs/3j/V19/yC2IatnQWH1x+Opbcu/Itxg=;
 b=BLGPrA5BY1+YVwPSmuOVfbHOwiwt55XUKiImOJVkJVzsv7pKDNImhy+gxwMoYbagEJ7h
 808e3KcCMwliSK5gVb1ANZ2S1jgANswM2wdtICwJUWPropJch6Zk7zARpSLJhFBpuQ48
 cVrzaQc5gRYS2h6px9JPx5K/RPVs6Zj810hvmB1gO/JKJrcwCVg1pZyeQDwTBU9rfk6m
 Ttmvnl7PYGwUmWT/oX6y8O8nEk52S+EMXR+hjpF/P+QnQc0CV+Yiq73oM5YDDhtklkRY
 IWPgPgZ4qxlI61chxB8sNOIvL9e5mezZvee6LIeOBZERWZk6x7rEECm+fyl4ZBUkE9s3 Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33c3an428n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 09 Sep 2020 20:24:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089KJclV132477;
 Wed, 9 Sep 2020 20:23:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 33dacm1g0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Sep 2020 20:23:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 089KNp2n028951;
 Wed, 9 Sep 2020 20:23:51 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 09 Sep 2020 13:23:50 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 68A046A0109; Wed,  9 Sep 2020 16:25:10 -0400 (EDT)
Date: Wed, 9 Sep 2020 16:25:10 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/3] swiotlb: Use %pa to print phys_addr_t variables
Message-ID: <20200909202510.GA16663@char.us.oracle.com>
References: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CMBer5VBWz0ruUUtVM9V4p0bYaTnV_bJnrORzug2=0Aw@mail.gmail.com>
 <20200909155913.GF1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200909155913.GF1891694@smile.fi.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090182
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <bhelgaas@google.com>, Fabio Estevam <festevam@gmail.com>,
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

On Wed, Sep 09, 2020 at 06:59:13PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 02, 2020 at 11:02:46PM -0300, Fabio Estevam wrote:
> > On Wed, Sep 2, 2020 at 2:31 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > There is an extension to a %p to print phys_addr_t type of variables.
> > > Use it here.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > v2: dropped bytes replacement (Fabio)
> > 
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> Thanks!
> 
> Guys, can this series be applied?

Sure.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
