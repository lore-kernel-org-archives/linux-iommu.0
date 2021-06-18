Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D358CC48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 06:56:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537AC6128C
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 06:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537AC6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C75C4044F;
	Fri, 18 Jun 2021 06:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qC6vkSOVtkSB; Fri, 18 Jun 2021 06:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C4ECA4049C;
	Fri, 18 Jun 2021 06:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FDABC000D;
	Fri, 18 Jun 2021 06:56:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B116AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 06:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9660E4049C
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 06:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 05vfeVeLE3aG for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 06:56:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BAE44044F
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 06:56:02 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15I6phG7006442; Fri, 18 Jun 2021 06:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=yx6GG+l+Z6/3Ar4goqVbFs0pV4F3wR1FKrKaVh9POAI=;
 b=gJHsbbC0x9Y30aLixGLPfQnIdbkxaIj4LvDDjwuT2qPHzkPN+E75nbT7wdCZ5PTtOzGm
 74Y1164bTwMJW9LdBSa3ww4L34daRPdQt3EIaGRnHF2lR99KqJ1aMPZrX3EqyEfhoH/Z
 X78gU++QDnJQjmeXTKFoVRX+s+tlYcDQ8BcnKmT4Pbp7HA9rRoRBUMcqyOudjGLEbZ1R
 sIHnhzpJd7b+u44LfKlcTiEQvkEDZf70sfxCJri5rqR/ZiLePL/Zsziy6w35rAwQpmEb
 xvQOeZzvP7scOz5eirQMHBO6ZD8t3OPTDiLW58jh61ngxsaqQNPWoQhJ2egAbZIxrqeY XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 39893qs70b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jun 2021 06:55:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15I6svDM187377;
 Fri, 18 Jun 2021 06:55:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 396war3mcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jun 2021 06:55:58 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15I6tw1T189635;
 Fri, 18 Jun 2021 06:55:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 396war3mcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jun 2021 06:55:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15I6tuDT021863;
 Fri, 18 Jun 2021 06:55:57 GMT
Received: from mwanda (/102.222.70.252)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 17 Jun 2021 23:55:56 -0700
Date: Fri, 18 Jun 2021 09:55:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: baolu.lu@linux.intel.com
Subject: [bug report] iommu/vt-d: Allocate/register iopf queue for sva devices
Message-ID: <YMxDc2Wtn+sMAYDj@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: xWvEjljHuOmnpG0F5c92qUu2yZNrVjJ5
X-Proofpoint-GUID: xWvEjljHuOmnpG0F5c92qUu2yZNrVjJ5
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

Hello Lu Baolu,

This is a semi-automatic email about new static checker warnings.

The patch 4c82b88696ac: "iommu/vt-d: Allocate/register iopf queue for 
sva devices" from Jun 10, 2021, leads to the following Smatch 
complaint:

    drivers/iommu/intel/iommu.c:5335 intel_iommu_enable_sva()
    warn: variable dereferenced before check 'info' (see line 5332)

drivers/iommu/intel/iommu.c
  5331		struct device_domain_info *info = get_domain_info(dev);
  5332		struct intel_iommu *iommu = info->iommu;
                                            ^^^^^^^^^^^
Dereferenced

  5333		int ret;
  5334	
  5335		if (!info || !iommu || dmar_disabled)
                    ^^^^^
Checked too late.  <dramatic prairie dog.gif>


  5336			return -EINVAL;
  5337	

regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
