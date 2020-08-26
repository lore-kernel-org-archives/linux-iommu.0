Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512BC433E3
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 11:00:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4EA2071E
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 11:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fq2ISN5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4EA2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D76186B2F;
	Wed, 26 Aug 2020 11:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YyrO+sLLmBX1; Wed, 26 Aug 2020 11:00:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EED2A86B2D;
	Wed, 26 Aug 2020 11:00:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D457EC0890;
	Wed, 26 Aug 2020 11:00:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9840CC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 85CCD203B8
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wtraWX7C5NQO for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 11:00:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by silver.osuosl.org (Postfix) with ESMTPS id AB18E1FEDF
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:00:17 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QB01qb030251;
 Wed, 26 Aug 2020 11:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/fCtBAfUW9DNJUfT9YZ2XuOf8t/lJOxdFK2upLxSyFk=;
 b=fq2ISN5JKb5GnTBZyyPq3NdLSmJTI/PZFQKX2oBj/LK1JWBJNo1u80XccBy7q1FkU1Qn
 QbAlTwB3C+KDuHb3m1dh4Ccw1bancmQzeyYIUzr1HFLlG3gSM9uEB5v9ne2cw1Jk3ZuB
 ylWSIs8recNuMed8oX01uw01QLRAdltaZQhkDGvfYzaERxU0VLBoFw7a+MT0ACMKB7im
 ebMwWc8EHQCFGVQw3uvw40QqWTBIwSFD5hae0NL1edDRdHH4KVVLPox34PotvXzFO3BM
 12wfy1pCSAHSe0uAF+K+edaS9a53aeJk+wRsxZONxtt8tnURMjkO5bVlvTG8DsikrXtp jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 333dbrypp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Aug 2020 11:00:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAtLoB081719;
 Wed, 26 Aug 2020 11:00:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 333r9kred8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2020 11:00:10 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QB07uK028348;
 Wed, 26 Aug 2020 11:00:07 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Aug 2020 04:00:07 -0700
Date: Wed, 26 Aug 2020 13:59:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: FelixCuioc <FelixCui-oc@zhaoxin.com>
Subject: Re: [PATCH 3/3] iommu/vt-d:Add mutex_unlock() before returning
Message-ID: <20200826105959.GB5493@kadam>
References: <20200826102752.3776-1-FelixCui-oc@zhaoxin.com>
 <20200826102752.3776-4-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826102752.3776-4-FelixCui-oc@zhaoxin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260089
Cc: kbuild-all@lists.01.org, CobeChen-oc@zhaoxin.com, kbuild@lists.01.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 TonyWWang-oc@zhaoxin.com, David Woodhouse <dwmw2@infradead.org>
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

On Wed, Aug 26, 2020 at 06:27:52AM -0400, FelixCuioc wrote:
> In the probe_acpi_namespace_devices function,when the physical
> node of the acpi device is NULL,the unlock function is missing.
> Add mutex_unlock(&adev->physical_node_lock).
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>

Oh...  Crap.  I wondered why I was being CC'd on this patchset.  Just
fold this into the ealier patch.  Don't worry about the Reported-by.

regards,
dan carpenter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
