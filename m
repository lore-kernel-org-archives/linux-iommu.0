Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AEDC10DCE
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 12:56:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16033206E7
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 12:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i8e0TI74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16033206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C6C9086D62;
	Thu, 12 Mar 2020 12:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fTrX9bO7OHMF; Thu, 12 Mar 2020 12:56:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E0D486C39;
	Thu, 12 Mar 2020 12:56:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F942C089F;
	Thu, 12 Mar 2020 12:56:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C01EC0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 12:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 895AB26977
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 12:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aAs9z+cgsbzC for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 12:55:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by silver.osuosl.org (Postfix) with ESMTPS id CE96826904
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 12:55:58 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CCt0ch169005;
 Thu, 12 Mar 2020 12:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=3IjLRGnSKTeS7BpHqOkLjutlfOlpel0LUZcJRVn7ZeE=;
 b=i8e0TI74kE05+c3jiSSg+MONAyxbNXf9Zzk0Dt3z0i9oZQhoz68GlK6iO+EAYj8srjst
 E002iailVehaK/xFUQDh6+ajFcS+FHcDyXNSXZu84jWiBQzUxLDu2NJ6Ms9Y+j46B+jK
 sjBw4OJXMoTfrHjzrJpjTnZAGXHror3hkWZZjIal+bhvZfBjMEK2zL8L2LHOqrV6JUu5
 mzlNvcEZOHUvkU+/Dn/ovWp/d1OH8XNazvjRSPA/Sw5wpXPEzkEOL8boneyvggTj35Ap
 iLR4boF1GxwCIJmemEqZmfOx4+ZXqnC7Sadj6P4AZ2AlzYW5mQvhxgGMekHp1YIdw0R8 pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2ym31usduj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 12:55:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CCrMY3119204;
 Thu, 12 Mar 2020 12:55:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yp8p79dvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 12:55:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CCtjWP002515;
 Thu, 12 Mar 2020 12:55:45 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 05:55:44 -0700
Date: Thu, 12 Mar 2020 15:55:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Unlock on error paths
Message-ID: <20200312125539.GG11561@kadam>
References: <20200312113730.GF20562@mwanda>
 <0f0dcaca-5c33-c78c-6d38-2bbae26cbff2@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f0dcaca-5c33-c78c-6d38-2bbae26cbff2@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120070
Cc: kernel-janitors@vger.kernel.org, Megha Dey <megha.dey@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org
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

On Thu, Mar 12, 2020 at 08:02:41PM +0800, Lu Baolu wrote:
> On 2020/3/12 19:37, Dan Carpenter wrote:
> > There were a couple places where we need to unlock before returning.
> > 
> > Fixes: 91391b919e19 ("iommu/vt-d: Populate debugfs if IOMMUs are detected")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   drivers/iommu/intel-iommu-debugfs.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
> > index 8d24c4d85cc2..6a495b103972 100644
> > --- a/drivers/iommu/intel-iommu-debugfs.c
> > +++ b/drivers/iommu/intel-iommu-debugfs.c
> > @@ -289,11 +289,12 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
> >   		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
> >   		if (!(sts & DMA_GSTS_TES)) {
> >   			seq_puts(m, "DMA Remapping is not enabled\n");
> > -			return 0;
> > +			goto unlock;
> >   		}
> >   		root_tbl_walk(m, iommu);
> >   		seq_putc(m, '\n');
> >   	}
> > +unlock:
> >   	rcu_read_unlock();
> >   	return 0;
> > @@ -444,7 +445,7 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
> >   		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
> >   		if (!(sts & DMA_GSTS_IRES)) {
> >   			seq_puts(m, "Interrupt Remapping is not enabled\n");
> > -			return 0;
> > +			goto unlock;
> >   		}
> >   		if (iommu->ir_table) {
> > @@ -475,6 +476,7 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
> >   		}
> >   		seq_putc(m, '\n');
> >   	}
> > +unlock:
> >   	rcu_read_unlock();
> >   	return 0;
> > 
> 
> Thanks a lot for the catch. I think it could be further cleanup. How
> about below changes?

Obviously that solves the issues with forgetting to drop the lock but
I'm not qualified to comment on the rest.  (And I can't really review
it anyway because the patch was damaged in sending the email).

regards,
dan carepnter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
