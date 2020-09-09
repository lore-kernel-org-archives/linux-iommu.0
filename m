Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CDC43461
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 11:46:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E4520C09
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 11:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ymg+boXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E4520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D53FC2E174;
	Wed,  9 Sep 2020 11:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F34mckkRovQn; Wed,  9 Sep 2020 11:46:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C375E2D268;
	Wed,  9 Sep 2020 11:46:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B51CDC0859;
	Wed,  9 Sep 2020 11:46:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7173CC0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 11:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 60173871DA
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 11:46:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VrAiRG2m6e6P for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 11:46:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8B9A7871D3
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 11:46:47 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089BhxnJ147470;
 Wed, 9 Sep 2020 11:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=tcZedx0yuWMLiD6V/QGIdkFT/KHg+esjT8634Ezn7JI=;
 b=ymg+boXSl/aD0vu6TvymAY7kF9D4iOa5IteWPGqTRViVtwQ9dYpEMYNzJI+CS9mumPoD
 YQcOO8K48XqGUQGOOxyTcga0Y/ItI5xbkmRrw9FZUWOttBOOAbDJtwnul1Hp1d3HpvVf
 4e+BDWJgCzs59tdFkmjm6E0iKWli/EBEzd59UIxd3Df7l7wcCAC+vs5ekpQogbJ8uYFe
 1kSq7GRNgTgjsAHeWdXJTIOueckjgfSzv+GdjfX4+CDm91myNGAeycDNVYKIrj+kRpdN
 UJqt9wg1Aspg1Uwa/qH/2OYrO6iA06N4ODlSsWKu6AIyMturQwEHHHusjRX5YgZ8NbcF WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 33c3an12by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 09 Sep 2020 11:46:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089BjTQU166858;
 Wed, 9 Sep 2020 11:46:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 33cmesqhj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Sep 2020 11:46:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 089BkiYj024495;
 Wed, 9 Sep 2020 11:46:44 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 09 Sep 2020 04:46:43 -0700
Date: Wed, 9 Sep 2020 14:46:38 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: suravee.suthikulpanit@amd.com
Subject: [bug report] iommu/amd: Restore IRTE.RemapEn bit after programming
 IRTE
Message-ID: <20200909114638.GA17539@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=3 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=601 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=629 suspectscore=3 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090105
Cc: iommu@lists.linux-foundation.org
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

Hello Suravee Suthikulpanit,

This is a semi-automatic email about new static checker warnings.

The patch 26e495f34107: "iommu/amd: Restore IRTE.RemapEn bit after
programming IRTE" from Sep 3, 2020, leads to the following Smatch
complaint:

    drivers/iommu/amd/iommu.c:3870 amd_iommu_deactivate_guest_mode()
    warn: variable dereferenced before check 'entry' (see line 3867)

drivers/iommu/amd/iommu.c
  3866		struct irq_cfg *cfg = ir_data->cfg;
  3867		u64 valid = entry->lo.fields_remap.valid;
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The patch adds a new dereference

  3868	
  3869		if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
  3870		    !entry || !entry->lo.fields_vapic.guest_mode)
                    ^^^^^^
before "entry" has been checked for NULL.

  3871			return 0;
  3872	

regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
