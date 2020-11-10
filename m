Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC77DC388F7
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 21:26:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9D3207D3
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 21:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KQwSFc1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9D3207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 083F32309D;
	Tue, 10 Nov 2020 21:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lx-gMTKVaYUb; Tue, 10 Nov 2020 21:26:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0727E20026;
	Tue, 10 Nov 2020 21:26:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA486C088B;
	Tue, 10 Nov 2020 21:26:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AE2AC016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 21:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0DCCE862F4
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 21:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cWSELAqb28C7 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 21:26:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7F67485BBD
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 21:26:10 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AALNsqL062598;
 Tue, 10 Nov 2020 21:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9Nj2D+m80kZDJqrKbN/4/Is2vNJ6uqoCfmj84gGzeI0=;
 b=KQwSFc1LoGQ1VzaMRiggNXYjNGFOkFbtnIpoHJ63adZBDFwbB47VyCf6DN+tnopZ6tC+
 Ys3WhPIB7S4McHQMXEQ/TepCswb5N1BFbWjHrxa03JjMciQwnjLGGGyrlV53U9+z0dhb
 f3F77ISWqoiBoSQLLZ/m8/dJ3McQblbRZ9l/mnOEBiiEDYqqJ9Ns9zBPT1S6rci/9SBu
 QNDx37w7jRZCsXJG4ySSpIDFhgsG1sNZe/fNCo+y6IMeCl3O6VL0jWad0tcMUszF1FTg
 Ueya8AfybJ2HPRbcLnuZJBCKzrfT6slqP45OamdgZvhtcAVS1LgCt3H+vS4V2OPQqEF2 Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 34nh3ax8mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Nov 2020 21:26:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AALOqFA194731;
 Tue, 10 Nov 2020 21:26:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 34p5g0w6vj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Nov 2020 21:26:07 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AALPx9D001394;
 Tue, 10 Nov 2020 21:26:01 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Nov 2020 13:25:59 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 650FC6A0109; Tue, 10 Nov 2020 16:27:51 -0500 (EST)
Date: Tue, 10 Nov 2020 16:27:51 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH for-5.10] swiotlb: remove the tbl_dma_addr argument to
 swiotlb_tbl_map_single
Message-ID: <20201110212751.GA16458@char.us.oracle.com>
References: <20201023063309.3472987-1-hch@lst.de>
 <20201103094643.GA18936@lst.de>
 <20201104140438.GA16892@char.us.oracle.com>
 <20201110091421.GA23707@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110091421.GA23707@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100146
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 Stefano Stabellini <sstabellini@kernel.org>
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

On Tue, Nov 10, 2020 at 10:14:21AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 04, 2020 at 09:04:38AM -0500, Konrad Rzeszutek Wilk wrote:
> > On Tue, Nov 03, 2020 at 10:46:43AM +0100, Christoph Hellwig wrote:
> > > ping?
> > 
> > Hopefully this goes through. I am in the process of testing it but ran
> > into testing issues that I believe are unrelated.
> 
> Did you manage to make any progress?  This fixes an issue with the

YES!!
> new support for systems with DMA offsets in 5.10..

OK. Sending the git pull request in a minute or two.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
